local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

srcCocaina = {}
Tunnel.bindInterface("bdl_drugsfactory",srcCocaina)
vCLIENT = Tunnel.getInterface("bdl_drugsfactory")

local reactProgress = {}
local quantidade = {}

function srcCocaina.startPlanting(id,receive)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not reactProgress[id] then
			if receive == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"adubo",1) then
					reactProgress[id] = 0
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent("progress",source,8000,"plantando")
					vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
					Citizen.Wait(8000)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("cancelando",source,false)
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>Adubo</b>.")
				end
			end
		else
			if reactProgress[id] >= 100 then
				if receive == "cocaina" then
					local amount = 3
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("folha-coca")*amount <= vRP.getInventoryMaxWeight(user_id) then
						reactProgress[id] = nil
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("progress",source,9000,"colhendo")
						vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
						Citizen.Wait(9000)
						vRPclient._stopAnim(source,false)
						vCLIENT.returnPlanting(-1,reactProgress)
						TriggerClientEvent("cancelando",source,false)
						vRP.giveInventoryItem(user_id,"folha-coca",amount)
					end
				end
            end
        end
    end
end