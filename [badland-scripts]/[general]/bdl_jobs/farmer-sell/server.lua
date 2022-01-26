local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

farms = {}
Tunnel.bindInterface("farmer-sell",farms)

function farms.sellFruits()
    local source = source
    local user_id = vRP.getUserId(source)
    local amountToSell = parseInt(vRP.getInventoryItemAmount(user_id,"blueberry"))
    if user_id then
        if vRP.getInventoryItemAmount(user_id,"blueberry") > 0 then
            vRP.antiflood(source,"Emprego Farmer",2)
            vRP.tryGetInventoryItem(user_id,"blueberry",amountToSell)
            if AMGCoin.checkbeneficio(user_id,"boostemp") then
                local pagamento = 50*amountToSell
                local pagamento = pagamento * 2
                vRP.giveMoney(user_id,pagamento)
                TriggerClientEvent("Notify",source,"sucesso","Você vendeu <b>"..amountToSell.."x</b> Blueberry(s).",5000)
            else
                vRP.giveMoney(user_id,50*amountToSell)
                TriggerClientEvent("Notify",source,"sucesso","Você vendeu <b>"..amountToSell.."x</b> Blueberry(s).",5000)
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você não possui nenhuma <b>Blueberry</b>.")
        end
    end
end