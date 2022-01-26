local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_ilegal", src)

local compraitens = "https://discord.com/api/webhooks/850850571039932457/Y4eigOmwxQqWXYLQ3Z0L3bj1_Uqa28afmi9WzRRTjl0OkrsXuPSuFcqo9RB5lK7mwWAM"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-- [ COMPRAR ARRAY ] --
local forSale = {
    { item = "componenteeletronico", name = "Compon. Eletronico", price = 150000, amount = 1 },
    { item = "gatilho", name = "Gatilho", price = 15000, amount = 1 },
    { item = "capsulas", name = "Capsula", price = 75, amount = 1 },
}

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"ykz.permission") or vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission")--or vRP.hasPermission(user_id,"staff.permission")
end

-- [ COMPRAR ] --
RegisterServerEvent("ilegal-comprar")
AddEventHandler("ilegal-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(forSale) do
			if item == v.item then
				if item == "componenteeletronico" and vRP.hasPermission(user_id,"ykz.permission") then
					local qthcompra = vRP.prompt(source,"Coloque a quantidade:","")
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*parseInt(qthcompra) <= vRP.getInventoryMaxWeight(user_id) then
						if parseInt(qthcompra) > 0 then
							local ok = vRP.request(source,"Você deseja pagar em dinheiro limpo?",60)
							if ok then
								if vRP.tryPayment(user_id,parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)).." dólares</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU LIMPO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(v.price)*qthcompra) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)*parseInt(qthcompra)).." dólares</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU SUJO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Quantidade inválida.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "gatilho" and vRP.hasPermission(user_id,"bratva.permission") then
					local qthcompra = vRP.prompt(source,"Coloque a quantidade:","")
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*parseInt(qthcompra) <= vRP.getInventoryMaxWeight(user_id) then
						if parseInt(qthcompra) > 0 then
							local ok = vRP.request(source,"Você deseja pagar em dinheiro limpo?",60)
							if ok then
								if vRP.tryPayment(user_id,parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)).." dólares</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU LIMPO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(v.price)*qthcompra) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)*parseInt(qthcompra)).." dólares</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU SUJO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Quantidade inválida.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				elseif item == "capsulas" and vRP.hasPermission(user_id,"lost.permission") then
					local qthcompra = vRP.prompt(source,"Coloque a quantidade:","")
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*parseInt(qthcompra) <= vRP.getInventoryMaxWeight(user_id) then
						if parseInt(qthcompra) > 0 then
							local ok = vRP.request(source,"Você deseja pagar em dinheiro limpo?",60)
							if ok then
								if vRP.tryPayment(user_id,parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9)).." dólares em dinheiro limpo</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU LIMPO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(v.price)*qthcompra) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(qthcompra))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(qthcompra).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)*parseInt(qthcompra)).." dólares</b>.")
									SendWebhookMessage(compraitens,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[COMPROU]: "..vRP.itemNameList(v.item).."\n[QUANTIDADE]: "..parseInt(qthcompra).."\n[PAGOU SUJO]: $"..vRP.format(parseInt((parseInt(v.price)*parseInt(qthcompra))*0.9))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Quantidade inválida.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Estamos sem estoque desse item.")
				end
			end
		end
	end
end)