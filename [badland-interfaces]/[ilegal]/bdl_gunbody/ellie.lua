local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

src = {}
Tunnel.bindInterface("bdl_gunbody", src)

local fabricacaocorpo = "https://discord.com/api/webhooks/847463394096447488/D_niGfMN7ijgI9TDaDpYn8LhJ2GLwT7tZ2pjYAxxHXrmkAffUq6aRrNusYZW9xxhvcQ5"

local itemName = {
	{ item = "parafal" },
	{ item = "ak103" },
	{ item = "ak47" },
--[[{ item = "ak74" },
	{ item = "mp5" }, ]]--
	{ item = "tec9" },
--[[{ item = "m1911" },
	{ item = "hk110" } ]]--
	{ item = "fiveseven" }
}

RegisterServerEvent("bdl_gunbody:bodyfactory")
AddEventHandler("bdl_gunbody:bodyfactory",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
	vRP.antiflood(src,"Fabricação corpo armamento",5)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "parafal" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-parafal") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 15 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 3 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",15) and vRP.tryGetInventoryItem(user_id,"molas",3) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-parafal",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>Parafal</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU CORPO]: "..vRP.itemNameList("corpo-parafal").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
					elseif item == "ak103" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-ak103") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 15 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 3 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",15) and vRP.tryGetInventoryItem(user_id,"molas",3) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-ak103",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>AK-103</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU CORPO]: "..vRP.itemNameList("corpo-ak103").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
					elseif item == "ak47" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-ak47") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 10 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 3 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",10) and vRP.tryGetInventoryItem(user_id,"molas",3) then
										TriggerClientEvent("progress",src,20000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(20000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-ak47",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>AK-47</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU CORPO]: "..vRP.itemNameList("corpo-ak47").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
--[[				elseif item == "ak74" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-ak74") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 25 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 4 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",25) and vRP.tryGetInventoryItem(user_id,"molas",4) then
										TriggerClientEvent("progress",src,230000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(230000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-ak74",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>AK-74</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "mp5" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-mp5") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 20 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 6 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",20) and vRP.tryGetInventoryItem(user_id,"molas",6) then
										TriggerClientEvent("progress",src,190000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(190000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-mp5",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>MP-5</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end ]]--
						
					elseif item == "tec9" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-tec9") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",5) and vRP.tryGetInventoryItem(user_id,"molas",2) then
										TriggerClientEvent("progress",src,15000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(15000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-tec9",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>TEC-9</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU CORPO]: "..vRP.itemNameList("corpo-tec9").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
--[[				elseif item == "m1911" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-m1911") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 15 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",15) and vRP.tryGetInventoryItem(user_id,"molas",2) then
										TriggerClientEvent("progress",src,160000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(160000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-m1911",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>M1911</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "hk110" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-hk110") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 10 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",10) and vRP.tryGetInventoryItem(user_id,"molas",2) then
										TriggerClientEvent("progress",src,130000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(130000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-hk110",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>HK110</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
					end ]]--
					elseif item == "fiveseven" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("corpo-fiveseven") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"placa-metal") >= 5 then
								if vRP.getInventoryItemAmount(user_id,"molas") >= 2 then
									if vRP.tryGetInventoryItem(user_id,"placa-metal",5) and vRP.tryGetInventoryItem(user_id,"molas",2) then
										TriggerClientEvent("progress",src,10000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(10000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"corpo-fiveseven",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou o corpo de uma <b>Five Seven</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaocorpo,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU CORPO]: "..vRP.itemNameList("corpo-fiveseven").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Molas</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
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