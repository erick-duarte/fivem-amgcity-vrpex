local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "hospital" then
		vRP.teleport(279.81,-585.9,43.31)
	elseif data == "beach" then
		vRP.teleport(-2028.32,-460.09,11.51)
	elseif data == "paleto" then
		vRP.teleport(-772.93,5592.99,33.49)
	elseif data == "sandys" then
		vRP.teleport(320.03,2625.36,44.48)
	elseif data == "airport" then
		vRP.teleport(-1037.69,-2737.12,20.17)
	elseif data == "lsgarage" then
		vRP.teleport(98.91,-1077.29,29.24)
	end
	ToggleActionMenu()
	TriggerEvent("ToogleBackCharacter")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu',function()
	ToggleActionMenu()
end)

--RegisterCommand('testelogin',function()
--	ToggleActionMenu()
--end)