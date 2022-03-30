local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
amG = {}
Tunnel.bindInterface("amg_uber",amG)
amGCLIENT = Tunnel.getInterface("amg_uber")
local amGcfg = module('amg_scripts', 'amg_uber/config')

vRP.prepare("uber/selectTudo","SELECT * FROM amg_uber WHERE user_id = @user_id ")
vRP.prepare("uber/insertMotorista","INSERT INTO amg_uber (user_id, nota, corridas_avaliadas, corridas_navaliadas) VALUES(@user_id, @nota, @corridas_avaliadas, @corridas_navaliadas)")
vRP.prepare("uber/updateCorridaAvaliadas","UPDATE amg_uber SET nota = @nota, corridas_avaliadas = @corridas_avaliadas WHERE user_id = @user_id")
vRP.prepare("uber/updateCorridaNAvaliadas","UPDATE amg_uber SET nota = @nota, corridas_navaliadas = @corridas_navaliadas WHERE user_id = @user_id")

local idmotoristas = {}
-----------------------------------------------------------------------------------------------------------------------------------------
function amG.uberConfirmarPedido(distancia)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local valor = (distancia * amGcfg.taxaporkm ) + amGcfg.taxapadrao
		if vRP.request(source,"Valor aproximado $"..string.format("%.2f", valor)..". Confirmar pedido?", 1500) then
            return true, parseInt(valor)
        else
            return false, parseInt(0)
        end
	end
end

function amG.uberEnviarSolicitacao(riderX, riderY, riderZ, destX, destY, destZ, valor)
	local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local notaDriver = 0
    if #idmotoristas > 0 then
        TriggerClientEvent("Notify",source,"importante","Estamos localizando um motorista.")
        for k,v in pairs(idmotoristas) do
            --local idmotorista = idmotoristas[math.random(#idmotoristas)]
            local idmotorista = v
            local srcmotorista = vRP.getUserSource(idmotorista)
            local distancia, Px, Py, Pz = amGCLIENT.uberDistanciaRiderDiver(srcmotorista, riderX, riderY, riderZ)
            if parseInt(distancia) < 1000 then
                distancia = distancia.." mts"
            else
                distancia = distancia.." km"
            end
            if idmotorista and idmotorista ~= user_id then
                if vRP.request(srcmotorista,"Corrida solicitada. Passageiro: "..identity.firstname.." Distancia: "..distancia.."", 1500) then
                    local identdriver = vRP.getUserIdentity(idmotorista)
                    local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(srcmotorista,1.2)
                    local dbMotorista = vRP.query('uber/selectTudo', { user_id = idmotorista })
                    for k,v in pairs(dbMotorista) do
                        notaDriver = v.nota
                    end
                    if vname ~= nil then
                        TriggerClientEvent("Notify",source,"sucesso","Corrida aceita!<br><br>Motorista: "..identdriver.firstname.."<br>Placa: "..identdriver.registration.."<br>Veiculo: "..vRP.vehicleName(vname).."<br>Nota: "..notaDriver.."")
                    else
                        TriggerClientEvent("Notify",source,"sucesso","Corrida aceita!<br><br>Motorista: "..identdriver.firstname.."<br>Placa: "..identdriver.registration.."<br>Nota: "..notaDriver.."")
                    end
                    amGCLIENT.uberIniciarCorrida(srcmotorista, source, riderX, riderY, riderZ, destX, destY, destZ, valor)
                    return true  
                end
            end
        end
     else
         TriggerClientEvent("Notify",source,"negado","Infelizmente nao temos motorista no momento.")
     end    
end

function amG.uberNotificarPassageiro(srcrider)
	local source = source
	local user_id = vRP.getUserId(source)
    TriggerClientEvent("Notify",srcrider,"importante","O seu motorista chegou.")
end

function amG.uberReceberPagamento(srcrider, valor)
	local source = source
	local user_id = vRP.getUserId(source)
    local ruser_id = vRP.getUserId(srcrider)
    local banco = vRP.getBankMoney(ruser_id)
    local banconu = vRP.getBankMoney(user_id)
    if banco <= 0 or banco < tonumber(valor) or tonumber(valor) <= 0 then
        TriggerClientEvent("Notify",srcrider,"negado","Pagamento recusado. Voce nao possui dinheiro suficiente.")
        TriggerClientEvent("Notify",source,"negado","Pagamento recusado. O passageiro nao possui dinheiro suficiente.")
        --local value = vRP.getUData(parseInt(ruser_id),"vRP:multas")
		--local multas = json.decode(value) or 0
		--vRP.setUData(parseInt(ruser_id),"vRP:multas",json.encode((parseInt(valor)*2)+parseInt(multas)))
        --Citizen.Wait(3000)
        --TriggerClientEvent("Notify",srcrider,"importante","Voce foi multado no valor de $"..string.format("%.2f", parseInt(valor)*2).."")
        amGCLIENT.uberLimparVariaveis(srcrider)
        amGCLIENT.uberLimparVariaveis(source)
    else
        vRP.setBankMoney(ruser_id,banco-tonumber(valor))
        vRP.setBankMoney(user_id,banconu+tonumber(valor))
        TriggerClientEvent("Notify",srcrider,"sucesso","Corrida finalizada.<br><br>Voce pagou $ "..string.format("%.2f", valor).." pela corrida.")
        TriggerClientEvent("Notify",source,"sucesso","Corrida finalizada.<br><br>Voce recebeu $ "..string.format("%.2f", valor).." pela corrida.")
        amGCLIENT.uberLimparVariaveis(srcrider)
        amGCLIENT.uberLimparVariaveis(source)
        Citizen.Wait(5000)
        if vRP.request(srcrider,"Deseja avaliar o motorista?", 1500) then 
            local nota = vRP.prompt(srcrider, "Nota de 1 a 5","")
            if not tonumber(nota) or not parseInt(nota) > 0 and not parseInt(nota) < 6 or nota == nil or nota == '' then
                nota = 5
            end
            local dbMotorista = vRP.query('uber/selectTudo', { user_id = user_id })
            for k,v in pairs(dbMotorista) do
                local notatotal = v.nota * v.corridas_avaliadas
                local somanota = notatotal + nota
                local notaatualizada = somanota / (v.corridas_avaliadas + 1)
                vRP.execute('uber/updateCorridaAvaliadas', { user_id = user_id, nota = string.format("%.2f", notaatualizada), corridas_avaliadas = (v.corridas_avaliadas + 1), corridas_navaliadas = v.corridas_navaliadas })
            end
        else
            local dbMotorista = vRP.query('uber/selectTudo', { user_id = user_id })
            for k,v in pairs(dbMotorista) do
                vRP.execute('uber/updateCorridaNAvaliadas', { user_id = user_id, nota = v.nota, corridas_avaliadas = v.corridas_avaliadas, corridas_navaliadas = (v.corridas_navaliadas + 1) })
            end
        end
    end
end


RegisterCommand('uberstatus', function(source, args)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local dbMotorista = vRP.query('uber/selectTudo', { user_id = user_id })
    if #dbMotorista > 0 then
        for k,v in pairs(dbMotorista) do
            TriggerClientEvent("Notify",source,"sucesso","Dados de "..identity.firstname.."<br><br>Nota: "..v.nota.."<br>Corridas Avaliadas: "..v.corridas_avaliadas.."<br>Corridas N/Avaliadas: "..v.corridas_navaliadas.."<br>Total de corridas: "..(v.corridas_avaliadas + v.corridas_navaliadas).."")
        end
    else
        TriggerClientEvent("Notify",source,"importante","Seus dados nao foram localizados.")
    end
end)

RegisterCommand('uberon', function(source, args)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if user_id then
        if #idmotoristas > 0 then
            for i, v in ipairs(idmotoristas) do
                if v == user_id then
                    TriggerClientEvent("Notify",source,"importante","Voce já está online!")
                else
                    local dbMotorista = vRP.query('uber/selectTudo', { user_id = user_id })
                    if #dbMotorista > 0 then
                        table.insert(idmotoristas, user_id)
                        TriggerClientEvent("Notify",source,"sucesso","Uber online!")
                    else
                        vRP.execute("uber/insertMotorista", { user_id = user_id, nota = '5.0', corridas_avaliadas = 0, corridas_navaliadas = 0})
                        table.insert(idmotoristas, user_id)
                        TriggerClientEvent("Notify",source,"sucesso","Uber online!")
                    end
                end
            end
        else
            local dbMotorista = vRP.query('uber/selectTudo', { user_id = user_id })
            if #dbMotorista > 0 then
                table.insert(idmotoristas, user_id)
                TriggerClientEvent("Notify",source,"sucesso","Uber online!")
            else
                vRP.execute("uber/insertMotorista", { user_id = user_id, nota = '5.0', corridas_avaliadas = 0, corridas_navaliadas = 0})
                table.insert(idmotoristas, user_id)
                TriggerClientEvent("Notify",source,"sucesso","Uber online!")
            end
        end
    end
end)

RegisterCommand('uberoff', function(source, args)
    local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if user_id then
        for i, v in ipairs(idmotoristas) do 
            if v == user_id then
                table.remove(idmotoristas, i)
                TriggerClientEvent("Notify",source,"negado","Uber offline.")
            end
        end
    end
end)
