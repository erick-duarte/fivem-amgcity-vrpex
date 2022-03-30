local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

func = {}
Tunnel.bindInterface("nation_fuel", func)

RegisterServerEvent("nation_fuel:pagamento")
AddEventHandler("nation_fuel:pagamento",function(price,galao)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.tryPayment(user_id,price) then
			if galao then
				TriggerClientEvent('nation_fuel:galao',source)
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(price).." dólares</b> pelo <b>Galão</b>.")
			else
				TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(price).." dólares</b> em combustível.")
			end
		else
			TriggerClientEvent('nation_fuel:insuficiente',source)
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
		end
	end
end)

function func.GetUserMoney()
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getMoney(user_id)
	end
end