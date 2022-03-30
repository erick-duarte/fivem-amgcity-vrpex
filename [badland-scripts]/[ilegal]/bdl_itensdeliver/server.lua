local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_itensdeliver",src)

local itensilegais = "https://discord.com/api/webhooks/854364342840590366/L9RDBnWdUmOksXxEPmnd_k95U0hzuU2WXEkhfy1LUh19QGh-w4n45F7EhcWWPR9L5vtB"

local itempermitido = {}

-- [lockpick] --
local arameqtd = {}
-- [jammer] --
local componentesqtd = {}
-- [algema + placa] --
local aluminioqtd = {}
-- [capuz] --
local tecidoqtd = {}
local linhaqtd = {}
-- [colete + capuz] --
local placametalqtd = {}


local lockpick = false
local placa = false
local jammer = false
local algemas = false
local capuz = false
local colete = false

local itens = {
	{ item = "lockpick", posicao = 1},
	{ item = "placa", posicao = 2},
	{ item = "jammer", posicao = 3},
	{ item = "algema", posicao = 4},
    { item = "capuz", posicao = 5},
    { item = "colete", posicao = 6},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.ItemPermit(item)
    local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(itens) do
			if v.posicao == item then
				itempermitido[source] = v.item
				return true
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function src.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if itempermitido[source] == "lockpick" then
			arameqtd[source] = math.random(1,3)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("arame")*arameqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"arame",arameqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..arameqtd[source].."x Arame.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD ARAME]: "..arameqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				arameqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		elseif itempermitido[source] == "jammer" then
			componentesqtd[source] = math.random(1,3)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("componentes")*componentesqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"componentes",componentesqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..componentesqtd[source].."x Componentes.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD COMPONENTES]: "..componentesqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				componentesqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		elseif itempermitido[source] == "algema" then
			aluminioqtd[source] = math.random(1,3)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("aluminio")*aluminioqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"aluminio",aluminioqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..aluminioqtd[source].."x Aluminio.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD ALUMINIO]: "..aluminioqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				aluminioqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		elseif itempermitido[source] == "placa" then
			aluminioqtd[source] = math.random(1,3)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("aluminio")*aluminioqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"aluminio",aluminioqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..aluminioqtd[source].."x Aluminio.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD ALUMINIO]: "..aluminioqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				aluminioqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		elseif itempermitido[source] == "capuz" then
			tecidoqtd[source] = math.random(1,3)
			linhaqtd[source] = math.random(1,3)
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tecido")*tecidoqtd[source]+vRP.getItemWeight("linha")*linhaqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"tecido",tecidoqtd[source])
				vRP.giveInventoryItem(user_id,"linha",linhaqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..tecidoqtd[source].."x Tecido.")
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..linhaqtd[source].."x Linha.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD TECIDO]: "..tecidoqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD LINHA]: "..linhaqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				aluminioqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		elseif itempermitido[source] == "colete" then
			tecidoqtd[source] = math.random(1,3)
			linhaqtd[source] = math.random(1,3)
			placametalqtd[source] = 1
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tecido")*tecidoqtd[source]+vRP.getItemWeight("linha")*linhaqtd[source]+vRP.getItemWeight("placametal")*placametalqtd[source] <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,"tecido",tecidoqtd[source])
				vRP.giveInventoryItem(user_id,"linha",linhaqtd[source])
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..tecidoqtd[source].."x Tecido.")
				TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..linhaqtd[source].."x Linha.")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD TECIDO]: "..tecidoqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD LINHA]: "..linhaqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				local chances = math.random(1,10)
				if chances > 8 then
					vRP.giveInventoryItem(user_id,"placametal",placametalqtd[source])
					TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..placametalqtd[source].."x Placa de Metal.")
					SendWebhookMessage(itensilegais,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTD PLACA METAL]: "..placametalqtd[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
				tecidoqtd[source] = nil
				linhaqtd[source] = nil
				placametalqtd[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
				return false
			end
		end
	end
end






