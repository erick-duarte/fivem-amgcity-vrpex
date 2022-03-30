local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

API = {}
Tunnel.bindInterface("nation_bennys",API)

local using_bennys = {}
local empresas = {}

function API.checkPermission()
    local source = source
    return vRP.hasPermission(vRP.getUserId(source), config.permissao) or vRP.hasPermission(vRP.getUserId(source), 'founder.permission')
end

function API.getTypeVeh(vname)
    local source = source
    return vRP.vehicleType(tostring(vname))
end

function API.getSavedMods(vehicle_name, vehicle_plate)
    local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
    return json.decode(vRP.getSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name)) or {}) or {}
end

function API.checkPayment(amount)
    if not tonumber(amount) then
        return false
    end
    local source = source
    local user_id = vRP.getUserId(source)
    local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,1.2)
    local idclient = vRP.prompt(source, "Confirme o passaporte do cliente.","")
    if tonumber(idclient) and parseInt(idclient) > 0 and user_id ~= idclient then
        TriggerClientEvent("Notify",source,"importante","Aguarde a confirmação do cliente",7000)
        local nweclient = parseInt(idclient)
        local rsource = vRP.getUserSource(nweclient)
        if vRP.request(rsource,"Você confirma o valor ( $"..tonumber(amount).." ) e as modificações do seu veículo ( " ..vRP.vehicleName(vname).." ) ?", 1500) then
            if vRP.tryFullPayment(parseInt(nweclient), parseInt(amount)) then
                local empresa = vRP.query("empresa/selectEmpresa",{ cnpj = 1 })
                for k,v in pairs(empresa) do
                    if tonumber(amount) < parseInt(v.caixa) then
                        local attCaixa = parseInt(v.caixa) - tonumber(amount)
                        vRP.query("empresa/updateCaixa",{ caixa = parseInt(attCaixa), cnpj = 1 }) 
                        TriggerClientEvent("Notify",source,"sucesso","Modificações aplicadas!",7000)
                        TriggerClientEvent("Notify",rsource,"sucesso","Seu veículo está pronto. Obrigado por confiar na Bennys Motors.<br><br>Volte sempre.",7000)
                        vRP.execute("nation_bennys/insertPagamento",{ idmecanico = user_id, idcliente = nweclient, veiculo = vname, valor = tonumber(amount) })
                        os.execute("$(which bash) /amgcity/server-data/shellscript/bennysVendas.sh "..user_id.." "..nweclient.." "..vname.." "..tonumber(amount).."")
                        os.execute("$(which bash) /amgcity/server-data/shellscript/bennysBanco.sh 0 'Tunning' "..tonumber(amount).." "..v.caixa.." "..parseInt(attCaixa).."")
                        return true
                    else
                        TriggerClientEvent("Notify",source,"negado","A empresa não possui dinheiro.",7000)
                        return false
                   end
                end
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function API.repairVehicle(vehicle, damage)
    TriggerEvent("tryreparar", vehicle)
    return true
end

function API.removeVehicle(vehicle)
    using_bennys[vehicle] = nil
    return true
end

function API.checkVehicle(vehicle)
    if using_bennys[vehicle] then
        return false
    end
    using_bennys[vehicle] = true
    return true
end

function API.saveVehicle(vehicle_name, vehicle_plate, vehicle_mods)
    local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
    vRP.setSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name),json.encode(vehicle_mods))
    return true
end


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)

-- [[!-!]] vcux3MfIy8qDzcrMz8rKycbPzsvKzcnIyM7M [[!-!]] --