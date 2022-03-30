local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_ilegal", src)

-- [ COMPRAR ARRAY ] --
local forSale = {
    { item = "blankcard", name = "Cartão em branco", price = 5000, amount = 1 },
    { item = "dinamite", name = "Dinamite", price = 3500, amount = 1 },
    { item = "furadeira", name = "Furadeira", price = 1500, amount = 1 },
    { item = "lockpick", name = "Lockpick", price = 2000, amount = 1 },
	{ item = "capuz", name = "Capuz", price = 2000, amount = 1 },
    { item = "colete", name = "Colete", price = 2000, amount = 1 },
    { item = "algema", name = "Algema", price = 2000, amount = 1 },
}
-- [ COMPRAR ] --
RegisterServerEvent("ilegal-comprar")
AddEventHandler("ilegal-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(forSale) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(v.price)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.amount))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.amount).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)).." dólares</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)