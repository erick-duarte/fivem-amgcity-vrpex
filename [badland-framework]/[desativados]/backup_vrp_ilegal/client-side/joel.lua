local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPex = Tunnel.getInterface("vrp_ilegal")

systemX = 36.3
systemY = -1021.08
systemZ = 29.29

onMenu = false
-- 36.3, -1021.08, 29.29
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		onMenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		onMenu = false
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end


RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "blankcard" then
        TriggerServerEvent("ilegal-comprar","blankcard")
		
	elseif data == "dinamite" then
		TriggerServerEvent("ilegal-comprar","dinamite")
		
	elseif data == "furadeira" then
		TriggerServerEvent("ilegal-comprar","furadeira")
		
	elseif data == "lockpick" then
		TriggerServerEvent("ilegal-comprar","lockpick")
		
	elseif data == "capuz" then
		TriggerServerEvent("ilegal-comprar","capuz")
		
	elseif data == "colete" then
		TriggerServerEvent("ilegal-comprar","colete")
		
	elseif data == "algema" then
		TriggerServerEvent("ilegal-comprar","algema")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local distance2 = Vdist(systemX,systemY,systemZ,x,y,z)
        if distance2 <= 4 then
            sleep = 5
            if not onMenu then
                DrawMarker(30, systemX,systemY,systemZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,180,0,90,0,0,0,1)
                if distance2 <= 2 then
                    DrawText3D(systemX,systemY,systemZ, "[~y~E~w~] Para ~y~ABRIR~w~ a loja.")
                    if distance2 <= 1.1 then
                        if IsControlJustPressed(0,38) then
                            ToggleActionMenu()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end