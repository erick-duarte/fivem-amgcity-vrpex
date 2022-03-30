local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista",emP)
AMGCoin = Proxy.getInterface("AMG_Coin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Emprego Motorista",2)
	if user_id then
		if AMGCoin.checkbeneficio(user_id,"boostemp") then
			local pagamento = math.random(265,300)+bonus
			local pagamento = pagamento*2
			vRP.giveMoney(user_id,pagamento)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..pagamento.." dólares.",3000)
		else
			local pagamento = math.random(265,300)+bonus
			vRP.giveMoney(user_id,pagamento)
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..pagamento.." dólares.",3000)
		end
	end
end