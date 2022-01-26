local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_ammodeliver",src)

local itensmunicao = "https://discord.com/api/webhooks/847649065591767080/tzR2JPN0BYK1YWDxSSscog1QMO2gjjJVC0JnW4ApJfiuPR8rn8lyCxtDKpriC8iFaHgO"

--local capsulaAmount = {}
--function src.capsulaAmount()
--	local source = source
--	if capsulaAmount[source] == nil then
--		capsulaAmount[source] = math.random(20,25)
--	end
--end

local polvoraAmount = {}
function src.polvoraAmount()
	local source = source
	if polvoraAmount[source] == nil then
		polvoraAmount[source] = math.random(25,30)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission") then
	if vRP.hasPermission(user_id,"lost.permission") then
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
	src.polvoraAmount()
--	src.capsulaAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*polvoraAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
--		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsulas")*capsulaAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*polvoraAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
--			vRP.giveInventoryItem(user_id,"capsulas",capsulaAmount[source])
			vRP.giveInventoryItem(user_id,"polvora",polvoraAmount[source])
--			TriggerClientEvent("Notify",source,"importante","Você pegou<br>"..capsulaAmount[source].."x Capsulas<br> "..polvoraAmount[source].."x Polvoras.")
			TriggerClientEvent("Notify",source,"importante","Você pegou<br> "..polvoraAmount[source].."x Polvoras.")
			SendWebhookMessage(itensmunicao,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTH POLVORA]: "..polvoraAmount[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--			SendWebhookMessage(itensmunicao,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[QTH CAPSULAS]: "..capsulaAmount[source].." \n[QTH POLVORA]: "..polvoraAmount[source].."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--			capsulaAmount[source] = nil
			polvoraAmount[source] = nil
			return true
		end
	end
end
