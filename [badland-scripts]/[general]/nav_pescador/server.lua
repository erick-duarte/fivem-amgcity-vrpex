local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "dourado", venda = 230 },
	{ item = "corvina", venda = 230 },
	{ item = "salmao", venda = 230 },
	{ item = "pacu", venda = 230 },
	{ item = "pintado", venda = 230 },
	{ item = "pirarucu", venda = 230 },
	{ item = "tilapia", venda = 230 },
	{ item = "tucunare", venda = 230 },
	{ item = "lambari", venda = 500 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("pescador-vender")
AddEventHandler("pescador-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local quantidade = 0
--	vRP.antiflood(source,"Emprego Pescador",2)
	if data and data.inventory then
		for k,v in pairs(valores) do
			if item == v.item then
				for i,o in pairs(data.inventory) do
					if i == item then
						quantidade = o.amount
					end
				end
				if parseInt(quantidade) > 0 then
					if AMGCoin.checkbeneficio(user_id,"boostemp") then
						if vRP.tryGetInventoryItem(user_id,v.item,quantidade) then
							vRP.giveMoney(user_id,parseInt(v.venda*quantidade)*2)
							TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..v.item.."</b> por <b>$"..parseInt(v.venda*quantidade*2).." dólares</b>.",3000)
						end
					else
						if vRP.tryGetInventoryItem(user_id,v.item,quantidade) then
							vRP.giveMoney(user_id,parseInt(v.venda*quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..quantidade.."x "..v.item.."</b> por <b>$"..v.venda*quantidade.." dólares</b>.",3000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..v.item.."s</b> em sua mochila.",3000)
				end
			end
		end
	end
end)
