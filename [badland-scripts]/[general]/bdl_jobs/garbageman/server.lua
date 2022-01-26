local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

garbage = {}
Tunnel.bindInterface("garbageman",garbage)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function garbage.payment()
	local source = source
	local user_id = vRP.getUserId(source)
	local payment = 20 + math.random(280,320)
	vRP.antiflood(source,"Emprego Lixeiro",2)
	if user_id then
		if AMGCoin.checkbeneficio(user_id,"boostemp") then
			local payment = payment*2
			vRP.giveMoney(user_id,payment)
			TriggerClientEvent("Notify",source,"sucesso","<b>Lixo coletado!</b> | Ganhos: <b>$"..payment.." dólares</b>.")
		else
			vRP.giveMoney(user_id,payment)
			TriggerClientEvent("Notify",source,"sucesso","<b>Lixo coletado!</b> | Ganhos: <b>$"..payment.." dólares</b>.")
		end
	end
end

function garbage.checkPlate(modelo)
	local source = source
	local user_id = vRP.getUserId(source)
	local veh,vhash,vplaca,vname = vRPclient.vehListHash(source,4)
	if veh and vhash == modelo then
		local placa_user_id = vRP.getUserByRegistration(vplaca)
		if user_id == placa_user_id then
			return true
		end
	end
end
