local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_gundeliver",src)

local itensarmas = "https://discord.com/api/webhooks/847649994517118986/CQH_NzqRg_3w5pI24MpkD0Agu9ZzUkLEo3NbXcTo45SMnqatAORw4fC1Ay_gyoLjdNwK"

--local gatilhoAmount = {}
--function src.gatilhoAmount()
--	local source = source
--	local gatchance = math.random(0,100)
--	if gatilhoAmount[source] == nil then
--		if gatchance > 50 then
--			gatilhoAmount[source] = math.random(1,2)
--		else
--			gatilhoAmount[source] = tonumber(0)
--		end
--	end
--end

local molaAmount = {}
function src.molaAmount()
	local source = source
	if molaAmount[source] == nil then
		molaAmount[source] = math.random(3,5)
	end
end

local placaAmount = {}
function src.placaAmount()
	local source = source
	if placaAmount[source] == nil then
		placaAmount[source] = math.random(8,12)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission") then
	if vRP.hasPermission(user_id,"bratva.permission") then
        return true
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
--	src.gatilhoAmount()
	src.molaAmount()
	src.placaAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placa-metal")*placaAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("molas")*molaAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
--		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placa-metal")*placaAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("gatilho")*gatilhoAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("molas")*molaAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"placa-metal",placaAmount[source])
--			vRP.giveInventoryItem(user_id,"gatilho",gatilhoAmount[source])
			vRP.giveInventoryItem(user_id,"molas",molaAmount[source])
--			TriggerClientEvent("Notify",source,"importante","Você pegou<br>"..placaAmount[source].."x Placa de Mental<br> "..gatilhoAmount[source].."x Gatilho<br> "..molaAmount[source].."x Molas.")
--			SendWebhookMessage(itensarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTH PLACA D/ METAL]: "..placaAmount[source].." \n[QTH GATILHO]: "..gatilhoAmount[source].."\n[QTH MOLAS]: "..molaAmount[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("Notify",source,"importante","Você pegou<br>"..placaAmount[source].."x Placa de Mental<br> "..molaAmount[source].."x Molas.")
			SendWebhookMessage(itensarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTH PLACA D/ METAL]: "..placaAmount[source].." \n[QTH MOLAS]: "..molaAmount[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			placaAmount[source] = nil
--			gatilhoAmount[source] = nil
			molaAmount[source] = nil
			return true
		end
	end
end
