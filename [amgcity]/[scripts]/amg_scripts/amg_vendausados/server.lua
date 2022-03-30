local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

usadosAMG = {}
Tunnel.bindInterface("amg_vendausados",usadosAMG)

vendausadosCLIENT = Tunnel.getInterface("amg_vendausados")

local amGcfg = module("amg_scripts", "amg_vendausados/config")
local comprador = {}
local syncHashVeh = {}

vRP._prepare("vendausados/getVendas","SELECT * FROM amg_vendausados")
vRP._prepare("vendausados/selectTotalVendas","SELECT * FROM amg_vendausados WHERE dono = @dono")
vRP._prepare("vendausados/selectDonoVeiculo","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vendausados/insertVehVenda","INSERT INTO amg_vendausados(dono, dono_nome, telefone, modelo, placa, preco, slot) VALUES(@dono, @dono_nome, @telefone, @modelo, @placa, @preco, @slot)")
vRP._prepare("vendausados/insertVehVenda2","UPDATE vrp_user_vehicles SET venda = 1 WHERE user_id = @user_id and vehicle = @vehicle")

-- executa quando a cidade ou scrit é reiniciado
vRP._prepare("vendausados/updateLimparVenda","UPDATE vrp_user_vehicles SET venda = 0 WHERE user_id = @user_id and vehicle = @vehicle")
vRP._prepare("vendausados/deleteTodasVenda","DELETE FROM amg_vendausados")

vRP._prepare("vendausados/deleteVenda","DELETE FROM amg_vendausados WHERE slot = @slot")
vRP._prepare("vendausados/updateTransferirVeiculo","UPDATE vrp_user_vehicles SET user_id = @tuser_id, venda = 0 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vendausados/selectDinheiro","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP._prepare("vendausados/updateSetDinheiroBanco","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")

vRP._prepare("vendausados/createDatabase",[[
    CREATE TABLE IF NOT EXISTS amg_vendausados(
        id INTEGER AUTO_INCREMENT,
        dono INTEGER,
        dono_nome VARCHAR(255),
        telefone VARCHAR(20),
        modelo VARCHAR(255),
        placa VARCHAR(20),
        preco INTEGER,
        slot INTEGER,
        CONSTRAINT pk_vendas PRIMARY KEY(id)
    )
]])

async(function()
    vRP.execute("vendausados/createDatabase")
--    Citizen.Wait(500)
--    usadosAMG.deletarVendas()
end)

function usadosAMG.deletarVendas()
    local todasVendas = vRP.query('vendausados/getVendas')
    if #todasVendas > 0 then
        for k,v in pairs(todasVendas) do
            vRP.execute('vendausados/updateLimparVenda',{ user_id = v.dono, vehicle = v.modelo })
            Citizen.Wait(100)
        end
        vRP.execute('vendausados/deleteTodasVenda')
    end
end

function updateTable(t1, t2)
    for k,v in pairs(t2) do
      t1[k] = v
    end
end

function usadosAMG.syncHashVehServer(vslot, sync)
    local source = source
    local user_id = vRP.getUserId(source)
    syncHashVeh[user_id.."-"..vslot] = sync
    vendausadosCLIENT.syncHashVehClient(-1, syncHashVeh)
end

function usadosAMG.entrarVenda(k)
    comprador[source] = k
end

function usadosAMG.sairVenda(k)
    comprador[source] = nil
end

function usadosAMG.spawnarCarro(source, veiculo, all)
    local source = source
    local user_id = vRP.getUserId(source)
    print(veiculo.dono,veiculo.modelo, all)
    local data = vRP.getSData("custom:u"..veiculo.dono.."veh_"..veiculo.modelo)
    local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(veiculo.dono), vehicle = veiculo.modelo })
    local custom = json.decode(data)
    if all then 
        vendausadosCLIENT.spawnVeiculo(-1, vehicle[1].porta0,vehicle[1].porta1,vehicle[1].porta2,vehicle[1].porta3,vehicle[1].porta4,vehicle[1].porta5, custom, veiculo, all)
    else
        vendausadosCLIENT.spawnVeiculo(source, vehicle[1].porta0,vehicle[1].porta1,vehicle[1].porta2,vehicle[1].porta3,vehicle[1].porta4,vehicle[1].porta5, custom, veiculo, all)
    end
end

function usadosAMG.colocarVenda(k)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local verificar_possui = vRP.query("vendausados/selectTotalVendas", {dono = user_id})
    if #verificar_possui < amGcfg.limiteVendas then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,1)
        if vRP.vehicleType(tostring(vname)) ~= "vips" and vRP.vehicleType(tostring(vname)) ~= "work" then
            local verificar_dono = vRP.query("vendausados/selectDonoVeiculo", {user_id = user_id, vehicle = vname})
            if #verificar_dono ~= 0 then
                local amount = vRP.prompt(source, "Preço de venda","")
                if parseInt(amount) > 0 then
                    local veiculo = {
                        dono = user_id,
                        dono_nome = identity.name .. " " ..identity.firstname,
                        telefone = identity.phone,
                        modelo = vname,
                        preco = parseInt(amount),
                        slot = k,
                        placa = identity.registration
                    }
                    vRP.execute("vendausados/insertVehVenda", veiculo)
                    vRP.execute("vendausados/insertVehVenda2", { user_id = user_id, vehicle = vname } )
                    TriggerClientEvent("Notify",source,"sucesso","Você colocou seu veículo a venda.",5000)
                    amGcfg.esposicaoVendas[k].ocupado = true
                    updateTable(amGcfg.esposicaoVendas[k], veiculo)
                    for uid,src in pairs(vRP.getUsers()) do
                        vendausadosCLIENT.setVendas(src, amGcfg.esposicaoVendas)
                    end
                    vendausadosCLIENT.despawnVeiculo(source)
                    usadosAMG.spawnarCarro(nil ,veiculo, true)
                else
                    TriggerClientEvent("Notify",source,"negado","Valor inválido.",5000)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Este veículo não pertence há você.",5000)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não pode vender veículos <b>VIP's</b> e de <b>Trabalhos</b>",5000)
        end 
    else
        TriggerClientEvent("Notify",source,"negado","Você atingiu o limite de vendas.",5000)
    end
end

RegisterCommand('comprarcarro',function(source,args,rawCommand)
    local inVehicle = vendausadosCLIENT.IsInVehicle(source)
    if inVehicle then 
        local k = comprador[source]
	    local tuser_id = vRP.getUserId(source)
	    local id_dono = amGcfg.esposicaoVendas[k].dono
        local preco_db = amGcfg.esposicaoVendas[k].preco
        local modelo_db = amGcfg.esposicaoVendas[k].modelo
        local online = vRP.getUserSource(id_dono)
        if tuser_id ~= id_dono then
            local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = parseInt(tuser_id) })
            local maxgars = vRP.query("creative/get_users",{ user_id = parseInt(tuser_id) })
            if vRP.hasPermission(tuser_id,"bronze.pass") then
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 2 then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        elseif vRP.hasPermission(tuser_id,"prata.pass") then
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 4 then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        elseif vRP.hasPermission(tuser_id,"ouro.pass") then
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 6 then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        elseif vRP.hasPermission(tuser_id,"platina.pass") then
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 8 then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        elseif vRP.hasPermission(tuser_id,"usadosAMG.pass") then
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        else
	        	if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) then
	        		TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
	        		return
	        	end
	        end
            local verificar_dono = vRP.query("vendausados/selectDonoVeiculo", {user_id = tuser_id, vehicle = modelo_db})
            if #verificar_dono == 0 then
                if vRP.tryPayment(tuser_id, parseInt(preco_db)) then
                    amGcfg.esposicaoVendas[k].ocupado = false
                    for uid,src in pairs(vRP.getUsers()) do
                        vendausadosCLIENT.setVendas(src, amGcfg.esposicaoVendas)
                    end
                    vRP.execute('vendausados/updateTransferirVeiculo', {user_id = id_dono, tuser_id = tuser_id, vehicle = modelo_db})
                    vRP.execute('vendausados/deleteVenda', {slot = k})
                    local data = vRP.getSData("custom:u"..id_dono.."veh_"..modelo_db)
                    local custom = json.decode(data)
                    vRP.setSData("custom:u"..tuser_id.."veh_"..modelo_db, json.encode(custom))
        		    vRP.setSData("custom:u"..id_dono.."veh_"..modelo_db, json.encode())
                    if online then
                        local banco = vRP.getBankMoney(id_dono)
                        vRP.setBankMoney(id_dono, preco_db+tonumber(banco))
                        TriggerClientEvent("Notify",online,"importante","Seu veiculo foi vendido por <b>$"..preco_db.."</b>",5000)
                    else
                        local bank =  vRP.scalar('vendausados/selectDinheiro', {user_id = id_dono})
                        vRP.execute('vendausados/updateSetDinheiroBanco', {user_id = id_dono, bank = preco_db+tonumber(bank)})
                    end

                    for uid,src in pairs(vRP.getUsers()) do
                        vendausadosCLIENT.despawnVeiculo(src, true, syncHashVeh[uid.."-"..k])
                    end

                    TriggerClientEvent("Notify",source,"sucesso","Compra realizada com sucesso, o veiculos já está na sua garagem.",5000)

                else
                    TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro",5000)
                end
            else
                TriggerClientEvent("Notify",source,"negado","Voce ja possui este veiculo.",5000)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não pode comprar seu proprio veiculo. Use o <b>/removervenda</b>",5000)
        end
    end
    CancelEvent()
end)

RegisterCommand('removervenda',function(source,args,rawCommand)
    local inVehicle = vendausadosCLIENT.IsInVehicle(source)
    if inVehicle then
        local k = comprador[source]
        local nuser_id = vRP.getUserId(source)
        local id_dono = amGcfg.esposicaoVendas[k].dono
        local modelo_db = amGcfg.esposicaoVendas[k].modelo
        if nuser_id == id_dono then
            vRP.execute("vendausados/deleteVenda", {slot = k})
            vRP.execute('vendausados/updateLimparVenda',{ user_id = id_dono, vehicle = modelo_db })
            amGcfg.esposicaoVendas[k].ocupado = false
            for uid,src in pairs(vRP.getUsers()) do
                vendausadosCLIENT.setVendas(-1, amGcfg.esposicaoVendas)
            end
            for uid,src in pairs(vRP.getUsers()) do
                vendausadosCLIENT.despawnVeiculo(src, true, syncHashVeh[uid.."-"..k])
            end
            TriggerClientEvent("Notify",source,"sucesso","Você removeu seu carro a venda.",5000)
        else
            TriggerClientEvent("Notify",source,"negado","Este veículo não pertence há você.",5000)
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
--egisterCommand('testet',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    Citizen.Wait(500)
    vendausadosCLIENT.setVendas(source, amGcfg.esposicaoVendas)
    local Svendas = vRP.query('vendausados/getVendas')
    for k,v in pairs(Svendas) do
        amGcfg.esposicaoVendas[v.slot].ocupado = true
        updateTable(amGcfg.esposicaoVendas[v.slot], v)
        vendausadosCLIENT.setVendas(source, amGcfg.esposicaoVendas)
        usadosAMG.spawnarCarro(source, v, false)
        --local data = vRP.getSData("custom:u"..v.dono.."veh_"..v.modelo)
        --local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(v.dono), vehicle = v.modelo })
        --local custom = json.decode(data)
        --vendausadosCLIENT.spawnVeiculo(source, vehicle[1].porta0,vehicle[1].porta1,vehicle[1].porta2,vehicle[1].porta3,vehicle[1].porta4,vehicle[1].porta5, custom, v, false)
    end
end)