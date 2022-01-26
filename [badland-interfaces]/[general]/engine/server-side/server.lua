-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("engine",cRP)
vCLIENT = Tunnel.getInterface("engine")
local vehicles = {}
vRP._prepare("engine/get_all","SELECT vehicle,combustivel FROM vrp_estoque")

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	vehicles = vRP.query("engine/get_all")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentFuel(price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryPayment(user_id,parseInt(price)) then
			TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(parseInt(price)).." dólares</b> em combustível.")
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			return false
		end
	end
end


function cRP.checkMoney(vehFuel, typeFuel)
	local source = source
	local user_id = vRP.getUserId(source)
	local getwalletmoney = vRP.getMoney(user_id)
	local priceFuel = 0
	
	if typeFuel == 1 then
		priceFuel = 70
	elseif typeFuel == 2 then
		priceFuel = 35
	else
		priceFuel = 40
	end 

	local priceTotalFuel = priceFuel * (100 - parseInt(vehFuel))

	if getwalletmoney > priceTotalFuel then
		return true
	else
		return false
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:tryFuel")
AddEventHandler("engine:tryFuel",function(vehicle,fuel)
	vehFuels[vehicle] = fuel
	TriggerClientEvent("engine:syncFuel",-1,vehicle,fuel)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("engine:syncFuelPlayers",source,vehFuels)
	vCLIENT.loadVehiclesClient(source,vehicles)
end)