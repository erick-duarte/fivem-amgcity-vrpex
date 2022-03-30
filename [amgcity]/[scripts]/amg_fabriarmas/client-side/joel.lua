local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local amGcfg = module("amg_fabriarmas", "config")
vSERVER = Tunnel.getInterface("amg_fabriarmas")

src = {}
Tunnel.bindInterface("amg_fabriarmas", src)

local menuactive = false
local lociten = 0
onmenu = false

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
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

-------------------------------------------------------------------------------------------------------------------------------------------
----[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data ~= 'fechar' then
		ToggleActionMenu()
		vSERVER.fabricarArmas(string.sub(data, 10))
	else
		ToggleActionMenu()
		onmenu = false
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------
----[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000
		for k,v in pairs(amGcfg.localizacoes) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(v.x,v.y,v.z,x,y,z)

			if distance <= 5 and not onmenu then
				idle = 5
				DrawMarker(2, v.x,v.y,v.z,0,0,0,0,0,0,1.0,1.0,1.0,255,50,50,155,1,30,30,30)
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
				DrawText3D(v.x,v.y,v.z,"Pressione [~c~E~w~] para ~c~FABRICAR~w~ armas.")
			end
		end
		Citizen.Wait(idle)
	end
end)

function src.limparVariaveis()
	onmenu = false
end

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