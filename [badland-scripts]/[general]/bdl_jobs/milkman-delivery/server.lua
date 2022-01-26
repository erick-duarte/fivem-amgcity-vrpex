local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

milkd = {}
Tunnel.bindInterface("milkman-delivery",milkd)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local amount = {}

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function milkd.startPayments()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(3,6)
	end
	local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Emprego milkman",2)
	if user_id then
		local data = vRP.getUserAptitudes(user_id)
		if data then
			if vRP.tryGetInventoryItem(user_id,"garrafaleite",amount[source]) then
				local price = math.random(530,550)
				if AMGCoin.checkbeneficio(user_id,"boostemp") then
					local pagamento = parseInt(price*amount[source])
					pagamento = pagamento*2
					vRP.giveMoney(user_id,pagamento)
					TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
					TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, recebido <b>$"..vRP.format(pagamento).." dólares</b>.",8000)

					amount[source] = nil
					return true
				else
					vRP.giveMoney(user_id,parseInt(price*amount[source]))
					TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
					TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, recebido <b>$"..vRP.format(parseInt(price*amount[source])).." dólares</b>.",8000)

					amount[source] = nil
					return true
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..amount[source].."x Garrafas de Leite</b>.",8000)
			end
		end
		return false
	end
end