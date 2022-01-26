local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("bdl_gunbody")

onmenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		TriggerEvent("bdl:triggerhud")
		onmenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		TriggerEvent("bdl:triggerhud")
		SetNuiFocus(false)
		onmenu = false
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	
	if data == "corpo-parafal" then
		ToggleActionMenu()
		TriggerServerEvent("bdl_gunbody:bodyfactory","parafal")

	elseif data == "corpo-ak103" then
		ToggleActionMenu()
		TriggerServerEvent("bdl_gunbody:bodyfactory","ak103")
		
	elseif data == "corpo-ak47" then
		ToggleActionMenu()
		TriggerServerEvent("bdl_gunbody:bodyfactory","ak47")
		
--[[elseif data == "fabricar-ak74" then
		TriggerServerEvent("bdl_gunbody:bodyfactory","ak74")
		
	elseif data == "fabricar-mp5" then
		TriggerServerEvent("bdl_gunbody:bodyfactory","mp5") ]]--
		
	elseif data == "corpo-tec9" then
		ToggleActionMenu()
		TriggerServerEvent("bdl_gunbody:bodyfactory","tec9")
		
--[[	elseif data == "fabricar-m1911" then
		TriggerServerEvent("bdl_gunbody:bodyfactory","m1911")
		
	elseif data == "fabricar-hk110" then
		TriggerServerEvent("bdl_gunbody:bodyfactory","hk110") ]]--

	elseif data == "corpo-fiveseven" then
		ToggleActionMenu()
		TriggerServerEvent("bdl_gunbody:bodyfactory","fiveseven")
		
	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local factory = {
	{ ['x'] = 1402.3, ['y'] = 1139.89, ['z'] = 109.75 },
--	{ ['x'] = 1002.75, ['y'] = -128.01, ['z'] = 74.07 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(factory) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(v.x,v.y,v.z,x,y,z)
			local factory = factory[k]
			
			if distance <= 15 and not onmenu then
				idle = 5
				DrawMarker(27, factory.x, factory.y, factory.z-0.98,0,0,0,0.0,0,0,0.8,0.8,0.4,45,45,45,90,0,0,0,1)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.checkPermission() then
							ToggleActionMenu()
						end
					end
				end
			end
			if distance <= 1.5 and not onmenu then
				idle = 5
				DrawText3D(factory.x,factory.y,factory.z,"Pressione [~c~E~w~] para ~c~FABRICAR~w~ corpo do armamentos.")
			end
		end
		Citizen.Wait(idle)
	end
end)

-- [ FUNÇÃO DO TEXTO 3D ] --
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end