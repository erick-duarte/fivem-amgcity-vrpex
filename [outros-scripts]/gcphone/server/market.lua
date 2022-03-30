
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

--------------  PROJETINHO FIVEM https://discord.gg/4mRG2Bp ----------------------
function MarketGetItem (accountId, cb)
  local xPlayer = vRP.getUserId(source)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM phone_shops
      ]===], {}, cb)
  end 


RegisterServerEvent('gcPhone:market_getItem')
AddEventHandler('gcPhone:market_getItem', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    MarketGetItem(nil, function (markets)
      TriggerClientEvent('gcPhone:market_getItem', sourcePlayer, markets)
    end)
end)

RegisterServerEvent('gcPhone:buyMarket')
AddEventHandler('gcPhone:buyMarket', function(itemName, amount, price)
	local _source = source
	local xPlayer = vRP.getUserId(_source)
	math.floor(amount)

	local sourceItem = vRP.tryGetInventoryItem(xPlayer,itemName,amount)


	-- is the player trying to exploit?
	if amount < 0 then
		print('gcPhone: attempted to exploit the shop!')
		return
	end

	-- get price
	local itemLabel = ''

	price = price * amount

	-- can the player afford this item?
	if vRP.getBankMoney(xPlayer) >= price then
		-- can the player carry the said amount of x item?

			vRP.tryFullPayment(xPlayer,price)
            local time = 10 -- 10 seconds
            while (time ~= 0) do -- Whist we have time to wait
               Wait( 1000 ) -- Wait a second
               time = time - 1
		       TriggerClientEvent('esx:showNotification', _source, "Time Remaining " .. time)
               -- 1 Second should have past by now
			end
		
			vRP.giveInventoryItem(xPlayer,itemName,amount)
			TriggerClientEvent("Notify",source,"sucesso","Você comprou um "..itemName.." por"..price.."Doláres")
	else
		local missingMoney = price - xPlayer.getBank()
		TriggerClientEvent('esx:showNotification', _source, "you do not have ~r~enough~s~ money, you\'re ~y~missing~s~ ~r~" .. missingMoney .. "$~s~!")
	end
end)


--====================================================================================
-- EXTRA LEAKS | https://discord.gg/extraleaks
--====================================================================================


--====================================================================================
-- EXTRA LEAKS | https://discord.gg/extraleaks
--====================================================================================
