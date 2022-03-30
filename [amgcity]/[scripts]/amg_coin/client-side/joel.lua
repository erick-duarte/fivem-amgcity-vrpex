local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPex = Tunnel.getInterface("AMG_Coin")

andamento = false
onMenu = false
local timermenu = 0
-- [ TOGGLEMENU ] --
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
		onMenu = true
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		TriggerEvent("bdl:triggerhud")
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("Notify","importante","<b>AMG Coin</b> fechado, aguarde alguns minutos.",5000)
		onMenu = false
		timermenu = 60
	end
end

-- [ CALLBACK ] --
RegisterNUICallback("ButtonClick",function(data,cb)

	if data == "comprar-boostemp" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","boostemp")

	elseif data == "comprar-30desconc" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","desconc30")

	elseif data == "comprar-15descvip" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","descvip15")

	elseif data == "comprar-100kmoney" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","money100k")

	elseif data == "comprar-50descvip" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","descvip50")

	elseif data == "comprar-vipbronze" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","vipbronze")

	elseif data == "comprar-vipouro" then
		ToggleActionMenu()
		TriggerServerEvent("AMG_Coin:compras","vipouro")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	end

end)

-- [ TABELA DE LOCALIDADE ] --
local lojas = {
	{ ['x'] = -1082.32, ['y'] = -247.68, ['z'] = 37.77 }
}

-- [ THREAD DO COINS ] --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60*60000)
		vRPex.amgCoin()
	end
end)

-- [ THREAD DO MENU ] --
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local sleep = 1000

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) <= 2 then
				sleep = 5
				if not onMenu and timermenu <= 0 then
					DrawText3D(lojas.x, lojas.y, lojas.z, "[~g~E~w~] Para ~b~ABRIR~w~ o menu.")
				end
			end
			
			if distance <= 4 then
				sleep = 5
				if not onMenu and timermenu <= 0 then
					DrawMarker(20, lojas.x, lojas.y, lojas.z-0.75,0,0,0,0.0,0,0,0.5,0.5,0.4,75,255,0,90,0,0,0,1)
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							ToggleActionMenu()
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timermenu > 0 then
			timermenu = timermenu - 1
		end
	end
end)

-- [ FUNÇÃO DO TEXTO 3D ] --
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