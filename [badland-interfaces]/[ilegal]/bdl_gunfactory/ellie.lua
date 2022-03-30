local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

src = {}
Tunnel.bindInterface("bdl_gunfactory", src)

local fabricacaoarmamento = "https://discord.com/api/webhooks/847545163970904074/X9IeAaC1MzCE_eL3p8lIwxkEEu_Zy1KS3fiMaJrTHSy3LZKALKypK9yoE9kYqhFaE_yT"

local itemName = {
	{ item = "parafal" },
	{ item = "ak103" },
	{ item = "ak47" },
--[[{ item = "ak74" },
	{ item = "mp5" }, ]]--
	{ item = "tec9" },
--[[{ item = "m1911" },
	{ item = "hk110" }]]--
	{ item = "fiveseven" }
}

RegisterServerEvent("bdl_gunfactory:weaponfactory")
AddEventHandler("bdl_gunfactory:weaponfactory",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
	vRP.antiflood(src,"Fabricação de armamento",5)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "parafal" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SPECIALCARBINE") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpoparafal") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 10 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"corpoparafal",1) and vRP.tryGetInventoryItem(user_id,"placametal",8) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",2) then
												--TriggerClientEvent("progress",src,180000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(180000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_SPECIALCARBINE",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>Parafal</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
													SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU ARMA]: "..vRP.itemNameList("wbody|WEAPON_SPECIALCARBINE").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de Parafal</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end

					elseif item == "ak103" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpoak103") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 10 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"corpoak103",1) and vRP.tryGetInventoryItem(user_id,"placametal",8) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",2) then
												--TriggerClientEvent("progress",src,180000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(180000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE_MK2",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>AK-103</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
													SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU ARMA]: "..vRP.itemNameList("wbody|WEAPON_ASSAULTRIFLE_MK2").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de AK-103</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "ak47" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_ASSAULTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpoak47") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 5 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"corpoak47",1) and vRP.tryGetInventoryItem(user_id,"placametal",6) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",2) then
												--TriggerClientEvent("progress",src,160000,"fazendo")
												TriggerClientEvent("progress",src,20000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(160000,function()
												SetTimeout(20000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_ASSAULTRIFLE",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>AK-47</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
													SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU ARMA]: "..vRP.itemNameList("wbody|WEAPON_ASSAULTRIFLE").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de AK-47</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
--[[				elseif item == "ak74" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpoak74") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 6 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
											if vRP.tryGetInventoryItem(user_id,"corpoak74",1) and vRP.tryGetInventoryItem(user_id,"placametal",6) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
												--TriggerClientEvent("progress",src,170000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(170000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_COMPACTRIFLE",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>AK-74u</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de AK-74u</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "mp5" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SMG") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpomp5") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 4 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
											if vRP.tryGetInventoryItem(user_id,"corpomp5",1) and vRP.tryGetInventoryItem(user_id,"placametal",4) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",2) then
												--TriggerClientEvent("progress",src,140000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(140000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_SMG",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>MP-5</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de MP-5</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end ]]
						
					elseif item == "tec9" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_MACHINEPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpotec9") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 3 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
											if vRP.tryGetInventoryItem(user_id,"corpotec9",1) and vRP.tryGetInventoryItem(user_id,"placametal",4) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
												--TriggerClientEvent("progress",src,140000,"fazendo")
												TriggerClientEvent("progress",src,15000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(140000,function()
												SetTimeout(15000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_MACHINEPISTOL",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>TEC-9</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
													SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU ARMA]: "..vRP.itemNameList("wbody|WEAPON_MACHINEPISTOL").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de TEC-9</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
--[[				elseif item == "m1911" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpom1911") >= 1 then
								if vRP.getInventoryItemAmount(user_id,"placametal") >= 2 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
											if vRP.tryGetInventoryItem(user_id,"corpom1911",1) and vRP.tryGetInventoryItem(user_id,"placametal",2) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
												--TriggerClientEvent("progress",src,100000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												---SetTimeout(100000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>M1911</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de M1911</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "hk110" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpohk110") >= 1 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
											if vRP.tryGetInventoryItem(user_id,"corpohk110",1) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
												--TriggerClientEvent("progress",src,80000,"fazendo")
												TriggerClientEvent("progress",src,25000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(80000,function()
												SetTimeout(25000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_SNSPISTOL",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>HK-110</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de HK-110</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end ]]

					elseif item == "fiveseven" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"corpofiveseven") >= 1 then
									if vRP.getInventoryItemAmount(user_id,"gatilho") >= 1 then
										if vRP.getInventoryItemAmount(user_id,"molas") >= 1 then
											if vRP.tryGetInventoryItem(user_id,"corpofiveseven",1) and vRP.tryGetInventoryItem(user_id,"gatilho",1) and vRP.tryGetInventoryItem(user_id,"molas",1) then
												--TriggerClientEvent("progress",src,80000,"fazendo")
												TriggerClientEvent("progress",src,10000,"fazendo")
												vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
												inProgress[src] = true
												TriggerClientEvent("F6Cancel",src,true)
												--SetTimeout(80000,function()
												SetTimeout(10000,function()
													vRPclient._stopAnim(src,false)
													vRP.giveInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",1)
													TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>Five Seven</b>.")
													inProgress[src] = false
													TriggerClientEvent("F6Cancel",src,false)
													SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU ARMA]: "..vRP.itemNameList("wbody|WEAPON_PISTOL_MK2").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
												end)
											end
										else
											TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Gatilho</b> o suficiente.")
									end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Corpo de Five Seven</b>.")
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

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission") then
	if vRP.hasPermission(user_id,"bratva.permission") then	
		return true
	end
end