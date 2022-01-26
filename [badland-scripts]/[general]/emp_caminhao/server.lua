local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_caminhao",emP)
AMGCoin = Proxy.getInterface("AMG_Coin")

function emP.addEmprego()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.addUserGroup(user_id,"Caminhoneiro")
	end
end

function emP.removeEmprego()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.addUserGroup(user_id,"Desempregado")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(mod)
    local source = source
    local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Emprego Caminhao",2)
    if user_id then
		if AMGCoin.checkbeneficio(user_id,"boostemp") then
        	local valorpago = math.random(7500,8000)
			local valorpago = valorpago*2
        	vRP.giveMoney(user_id,valorpago)
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..valorpago.." dólares",3000)
		else
			local valorpago = math.random(7500,8000)
        	vRP.giveMoney(user_id,valorpago)
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..valorpago.." dólares",3000)
		end
    end
end