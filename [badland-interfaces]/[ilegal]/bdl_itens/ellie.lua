local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

src = {}
Tunnel.bindInterface("bdl_itens", src)

local fabricacaoitens = "https://discord.com/api/webhooks/848271541341782067/xMpZ2dQ3iaO7f7Mt7b_2549kDjAn-zPIgZD5o7X8YnH5BkPB0E5E_ZRnmjm6o_JPgoYk"

local itemName = {
	{ item = "lockpick" },
	{ item = "jammer" },
	{ item = "algema" },
	{ item = "capuz" },
	{ item = "colete" },
	{ item = "placa" }
}

RegisterServerEvent("bdl_itens:factoryitens")
AddEventHandler("bdl_itens:factoryitens",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "lockpick" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lockpick") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"arame") >= 30 then
								vRP.antiflood(src,"Fabricação de itens",5)
								if vRP.tryGetInventoryItem(user_id,"arame",30) then
									TriggerClientEvent("progress",src,35000,"fazendo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(35000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveInventoryItem(user_id,"lockpick",1)
										TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>LockPick</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
										SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("lockpick").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Arames</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end

					elseif item == "jammer" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("jammer") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"componentes") >= 30 then
								vRP.antiflood(src,"Fabricação de itens",5)
								if vRP.tryGetInventoryItem(user_id,"componentes",30) then
									TriggerClientEvent("progress",src,35000,"fazendo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(35000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveInventoryItem(user_id,"jammer",1)
										TriggerClientEvent("Notify",src,"sucesso","Você fabricou um <b>Jammer</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
										SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("jammer").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Componentes</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "algema" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("algema") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"aluminio") >= 30 then
								vRP.antiflood(src,"Fabricação de itens",5)
								if vRP.tryGetInventoryItem(user_id,"aluminio",30) then
									TriggerClientEvent("progress",src,35000,"fazendo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(35000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveInventoryItem(user_id,"algema",1)
										TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>Algema</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
										SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("algema").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Aluminio</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end

					elseif item == "capuz" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capuz") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"tecido") >= 20 then
								if vRP.getInventoryItemAmount(user_id,"linha") >= 5 then
									vRP.antiflood(src,"Fabricação de itens",5)
									if vRP.tryGetInventoryItem(user_id,"tecido",20) and vRP.tryGetInventoryItem(user_id,"linha",5) then
										TriggerClientEvent("progress",src,35000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										--SetTimeout(140000,function()
										SetTimeout(35000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"capuz",1)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou um <b>Capuz</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
											SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("capuz").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end)
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Linha</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Tecidos</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end

					elseif item == "colete" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"tecido") >= 50 then
								if vRP.getInventoryItemAmount(user_id,"linha") >= 10 then
									if vRP.getInventoryItemAmount(user_id,"placametal") >= 2 then
										vRP.antiflood(src,"Fabricação de itens",5)
										if vRP.tryGetInventoryItem(user_id,"tecido",50) and vRP.tryGetInventoryItem(user_id,"linha",10) and vRP.tryGetInventoryItem(user_id,"placametal",2) then
											TriggerClientEvent("progress",src,50000,"fazendo")
											vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
											inProgress[src] = true
											TriggerClientEvent("F6Cancel",src,true)
											SetTimeout(50000,function()
												vRPclient._stopAnim(src,false)
												vRP.giveInventoryItem(user_id,"colete",1)
												TriggerClientEvent("Notify",src,"sucesso","Você fabricou um <b>Colete</b>.")
												inProgress[src] = false
												TriggerClientEvent("F6Cancel",src,false)
												SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("colete").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
											end)
										end
									else
										TriggerClientEvent("Notify",src,"negado","Você não tem <b>Placa de Metal</b> o suficiente.")
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Linha</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Tecidos</b>.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end

					elseif item == "placa" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placa") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"aluminio") >= 20 then
								if vRP.tryGetInventoryItem(user_id,"aluminio",20) then
									TriggerClientEvent("progress",src,35000,"fazendo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(35000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveInventoryItem(user_id,"placa",1)
										TriggerClientEvent("Notify",src,"sucesso","Você fabricou uma <b>Placa clonada</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
										SendWebhookMessage(fabricacaoitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: "..vRP.itemNameList("placa").." \n[QUANTIDADE]: 1 "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Aluminio</b>.")
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
	if not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") and not vRP.hasPermission(user_id,"bennys.permission") then	
		return true
	end
end