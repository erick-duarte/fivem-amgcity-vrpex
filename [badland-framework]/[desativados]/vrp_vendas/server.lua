local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp_vendas", "cfg/config")

vRPvd = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
VDclient = Tunnel.getInterface("vrp_vendas")
Gclient = Tunnel.getInterface("vrp_adv_garages")
Tunnel.bindInterface("vrp_vendas",vRPvd)
Proxy.addInterface("vrp_vendas",vRPvd)

local syncVeh = {}

-- vRP
vRP._prepare("vRP/vendas",[[
    CREATE TABLE IF NOT EXISTS vrp_vendas(
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

vRP._prepare("vRP/inserir_venda","INSERT INTO vrp_vendas(dono, dono_nome, telefone, modelo, placa, preco, slot) VALUES(@dono, @dono_nome, @telefone, @modelo, @placa, @preco, @slot)")
vRP._prepare("vRP/get_venda","SELECT * FROM vrp_vendas WHERE dono = @dono")
vRP._prepare("vRP/get_vendas","SELECT * FROM vrp_vendas")
vRP._prepare("vRP/remover_venda","DELETE FROM vrp_vendas WHERE slot = @slot")
vRP._prepare("vRP/mover_veiculo","UPDATE vrp_user_vehicles SET user_id = @tuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("vRP/get_dinheiro","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP._prepare("vRP/set_banco","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")
vRP._prepare("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")
vRP._prepare("vRP/sell_get_vehicles","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

vRP._prepare("vRP/set_spawnado","UPDATE vrp_vendas SET spawnado = 1 WHERE dono = @user_id AND modelo = @vehicle")


async(function()
    vRP.execute("vRP/vendas")
    vRPvd.carregarVendas()
end)

local vendas = cfg.vendas

local comprador = {}

function updateTable(t1, t2)
    for k,v in pairs(t2) do
      t1[k] = v
    end
end

function vRPvd.carregarVendas()
    local Svendas = vRP.query('vRP/get_vendas')
    for k,v in pairs(Svendas) do
        vendas[v.slot].ocupado = true
        updateTable(vendas[v.slot], v)
    end
end

-- Function para colocar o carro a venda
function vRPvd.colocarVenda(k)
    local inVehicle = VDclient.IsInVehicle(source)
    if inVehicle == true then
        local source = source
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        local verificar_possui = vRP.query("vRP/get_venda", {dono = user_id})
        if #verificar_possui < cfg.limite_venda then
            local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,1)
            local modelo = vname
            if vRP.vehicleType(tostring(modelo)) ~= "vips" and vRP.vehicleType(tostring(modelo)) ~= "work" then
                local verificar_dono = vRP.query("vRP/sell_get_vehicles", {user_id = user_id, vehicle = modelo})
                if #verificar_dono ~= 0 then
                    local amount = vRP.prompt(source, "Preço de venda","")
                    local amount = parseInt(amount)
                    if amount > 0 then
                        local veiculo = {
                            dono = user_id,
                            dono_nome = identity.name .. " " ..identity.firstname,
                            telefone = identity.phone,
                            modelo = modelo,
                            preco = amount,
                            slot = k,
                            placa = identity.registration
                        }
                        vRP.execute("vRP/inserir_venda", veiculo)
                        TriggerClientEvent("Notify",source,"sucesso","Você colocou seu veículo a venda.",5000)
                        vendas[k].ocupado = true
                        updateTable(vendas[k], veiculo)
                        for uid,src in pairs(vRP.getUsers()) do
                            VDclient.setVendas(-1, vendas)
                        end
                        -- Seta a venda
                        local a_venda = json.decode(vRP.getSData("a_venda:u"..user_id))
                        if not a_venda then a_venda = {} end
                        a_venda[string.lower(modelo)] = true
                        vRP.setSData("a_venda:u"..user_id, json.encode(a_venda))
                        -- Retira o veiculo do player
                        VDclient.despawnVeiculo(source)
                        -- Spawna ele
                        vRPvd.spawnarCarro(user_id, veiculo)
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
    else
        TriggerClientEvent("Notify",source,"negado","Você está fora ou sem veiculo.",5000)
    end
end

function vRPvd.entrarVenda(k)
    comprador[source] = k
end

function vRPvd.sairVenda(k)
    comprador[source] = nil
end

-- Function para spawnar o carro
function vRPvd.spawnarCarro(user_id , veiculo)
--    local source = vRP.getUserSource(user_id)
    local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getSData("custom:u"..veiculo.dono.."veh_"..veiculo.modelo)
    local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(veiculo.dono), vehicle = veiculo.modelo })
    local custom = json.decode(data)
    VDclient.spawnVeiculo(source, vehicle[1].porta0,vehicle[1].porta1,vehicle[1].porta2,vehicle[1].porta3,vehicle[1].porta4,vehicle[1].porta5, custom, veiculo)
end

RegisterCommand('comprarcarro',function(source,args,rawCommand)
    local inVehicle = VDclient.IsInVehicle(source)
    if inVehicle then 
        local k = comprador[source]
	    local tuser_id = vRP.getUserId(source)
	    local id_dono = vendas[k].dono
        local preco_db = vendas[k].preco
        local modelo_db = vendas[k].modelo
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
		    elseif vRP.hasPermission(tuser_id,"amg.pass") then
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
            if vRP.tryPayment(tuser_id, preco_db) then
                vendas[k].ocupado = false
                for uid,src in pairs(vRP.getUsers()) do
                    VDclient.setVendas(src, vendas)
                end
                vRP.execute('vRP/mover_veiculo', {user_id = id_dono, tuser_id = tuser_id, vehicle = modelo_db})
                vRP.execute('vRP/remover_venda', {slot = k})
                local data = vRP.getSData("custom:u"..id_dono.."veh_"..modelo_db)
                local custom = json.decode(data)
                vRP.setSData("custom:u"..tuser_id.."veh_"..modelo_db, json.encode(custom))
        		vRP.setSData("custom:u"..id_dono.."veh_"..modelo_db, json.encode())
                if online then
                    local banco = vRP.getBankMoney(id_dono)
                    vRP.setBankMoney(id_dono, preco_db+tonumber(banco))
                    TriggerClientEvent("Notify",online,"importante","Seu veiculo foi vendido por <b>$"..preco_db.."</b>",5000)
                else
                    local bank =  vRP.scalar('vRP/get_dinheiro', {user_id = id_dono})
                    vRP.execute('vRP/set_banco', {user_id = id_dono, bank = preco_db+tonumber(bank)})
                end
                VDclient.despawnVeiculo(source)

                for z,w in pairs(syncVeh) do
                    print(z)
                    print(w)
                    if k == z then   
                        VDclient.despawnVeiculo2(source,wheel)
                    end
                end

                TriggerClientEvent("Notify",source,"sucesso","Compra realizada com sucesso, o veiculos já está na sua garagem.",5000)
                local a_venda = json.decode(vRP.getSData("a_venda:u"..id_dono))
                a_venda[string.lower(modelo_db)] = nil
                vRP.setSData("a_venda:u"..id_dono, json.encode(a_venda))
            else
                TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro",5000)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não pode comprar seu proprio veiculo. Use o <b>/removervenda</b>",5000)
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você precisa está dentro do veículo para compra-lo")
    end
    CancelEvent()
end)

RegisterCommand('removervenda',function(source,args,rawCommand)
    local inVehicle = VDclient.IsInVehicle(source)
    if inVehicle then 
        local k = comprador[source]
        local nuser_id = vRP.getUserId(source)
        local id_dono = vendas[k].dono
        local modelo_db = vendas[k].modelo
        if nuser_id == id_dono then
            vRP.execute("vRP/remover_venda", {slot = k})
            vendas[k].ocupado = false
            for uid,src in pairs(vRP.getUsers()) do
                VDclient.setVendas(src, vendas)
            end
            VDclient.despawnVeiculo(source)
            TriggerClientEvent("Notify",source,"sucesso","Você removeu seu carro a venda.",5000)
        
            local a_venda = json.decode(vRP.getSData("a_venda:u"..id_dono))
            a_venda[string.lower(modelo_db)] = nil
            vRP.setSData("a_venda:u"..id_dono, json.encode(a_venda))
        else
            TriggerClientEvent("Notify",source,"negado","Este veículo não pertence há você.",5000)
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você precisa está dentro do veículo para remover a venda.",5000)
    end
end)

-- Quando o player spawnar irá carregar os veiculos
local first_spawn = true
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    local source = source
    local user_id = vRP.getUserId(source)
    VDclient.setVendas(source, vendas)
    for k,v in pairs(vendas) do
        vRPvd.spawnarCarro(source, v)
    end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function vRPvd.restartScript()
    local source = source
    local user_id = vRP.getUserId(source)
    VDclient.setVendas(source, vendas)
    for k,v in pairs(vendas) do
        print(v)
        vRPvd.spawnarCarro(user_id, v)
    end
end

function vRPvd.syncServerVehHash(sync)
    print("chegou aqui")
    local source = source
    local user_id = vRP.getUserId(source)
    syncVeh = sync
    print(json.encode(syncVeh))
    VDclient.syncClientVehHash(-1, syncVeh)
end
