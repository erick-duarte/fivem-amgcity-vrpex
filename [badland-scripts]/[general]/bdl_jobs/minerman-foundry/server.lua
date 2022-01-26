local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")
inProgress = {}

vRPex = {}
Tunnel.bindInterface("minerman-foundry", vRPex)

local itemName = {
	{ item = "ferro" },
	{ item = "bronze" },
	{ item = "ouro" },
	{ item = "diamante" },
}

RegisterServerEvent("bdlCraftMac:fundir")
AddEventHandler("bdlCraftMac:fundir",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	vRP.antiflood(source,"Emprego minerman",2)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "ferro" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ferro") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"ferro") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"ferro",5) then
									TriggerClientEvent("progress",src,25000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(25000,function()
										vRPclient._stopAnim(src,false)
										if AMGCoin.checkbeneficio(user_id,"boostemp") then
											vRP.giveMoney(user_id,1000*2)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$2.000</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										else
											vRP.giveMoney(user_id,1000)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$1.000</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem ferro o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "bronze" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("bronze") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"bronze") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"bronze",5) then
									TriggerClientEvent("progress",src,25000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(25000,function()
										vRPclient._stopAnim(src,false)
										if AMGCoin.checkbeneficio(user_id,"boostemp") then
											vRP.giveMoney(user_id,1500*2)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$3.000</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										else
											vRP.giveMoney(user_id,1500)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$1.500</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem bronze o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "ouro" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ouro") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"ouro") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"ouro",5) then
									TriggerClientEvent("progress",src,25000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(25000,function()
										vRPclient._stopAnim(src,false)
										if AMGCoin.checkbeneficio(user_id,"boostemp") then
											vRP.giveMoney(user_id,2500*2)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$5.000</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										else
											vRP.giveMoney(user_id,2500)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$2.500</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem ouro o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "diamante" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("diamante") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"diamante") >= 2 then
								if vRP.tryGetInventoryItem(user_id,"diamante",2) then
									TriggerClientEvent("progress",src,25000,"Garimpando")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(25000,function()
										vRPclient._stopAnim(src,false)
										if AMGCoin.checkbeneficio(user_id,"boostemp") then
											vRP.giveMoney(user_id,6500*2)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$13.000</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										else
											vRP.giveMoney(user_id,6500)
											TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$6.500</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem diamante o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					end
				else
					TriggerClientEvent("Notify",src,"negado","Termine a produção em progresso para iniciar outra.")
				end
			end
		end
	end
end)