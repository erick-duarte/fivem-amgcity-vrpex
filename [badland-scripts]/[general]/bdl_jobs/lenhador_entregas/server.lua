local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emPLenEnt = {}
Tunnel.bindInterface("lenhador_entregas",emPLenEnt)
AMGCoin = Proxy.getInterface("AMG_Coin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emPLenEnt.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(4,6)
	end
end

function emPLenEnt.checkPayment()
	emPLenEnt.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Emprego lenhador",2)
	if user_id then
--		pagamento = 800*quantidade[source]
		local pagamento = 480*quantidade[source]
		if vRP.tryGetInventoryItem(user_id,"tora",quantidade[source]) then
			if AMGCoin.checkbeneficio(user_id,"boostemp") then
				pagamento = pagamento*2
				vRP.giveMoney(user_id,pagamento)
				TriggerClientEvent("Notify",source,"sucesso","Você vendeu "..quantidade[source].."x <b>Toras de Madeira</b> por $"..pagamento.." dólares.")
				quantidade[source] = nil
				return true
			else
				vRP.giveMoney(user_id,pagamento)
				TriggerClientEvent("Notify",source,"sucesso","Você vendeu "..quantidade[source].."x <b>Toras de Madeira</b> por $"..pagamento.." dólares.")
				quantidade[source] = nil
				return true
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Toras de Madeira</b>.")
		end
	end
end

--function emP.addEmprego()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		vRP.addUserGroup(user_id,"Lenhador")
--	end
--end
--
--function emP.removeEmprego()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		vRP.addUserGroup(user_id,"Desempregado")
--	end
--end