local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("bdl_itens")

local lociten = 0
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

	if data == "fabricar-lockpick" then
		ToggleActionMenu()
		if lociten == 1 or lociten == 7 then
			TriggerServerEvent("bdl_itens:factoryitens","lockpick")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end
		
	elseif data == "fabricar-placa" then
		ToggleActionMenu()
		if lociten == 2 or lociten == 8 then
			TriggerServerEvent("bdl_itens:factoryitens","placa")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end
		
	elseif data == "fabricar-jammer" then
		ToggleActionMenu()
		if lociten == 3 or lociten == 9 then
			TriggerServerEvent("bdl_itens:factoryitens","jammer")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end
		
	elseif data == "fabricar-algemas" then
		ToggleActionMenu()
		if lociten == 4 or lociten == 10 then
			TriggerServerEvent("bdl_itens:factoryitens","algemas")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end
		
	elseif data == "fabricar-capuz" then
		ToggleActionMenu()
		if lociten == 5 or lociten == 11 then
			TriggerServerEvent("bdl_itens:factoryitens","capuz")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end

	elseif data == "fabricar-colete" then
		ToggleActionMenu()
		if lociten == 6 or lociten == 12 then
			TriggerServerEvent("bdl_itens:factoryitens","colete")
		else
			TriggerEvent("Notify","negado","Você não pode fabricar esse item neste local.")
		end
		
	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local factory = {

	{ ['x'] = 1754.83, ['y'] = -1648.83, ['z'] = 112.66, ['posicao'] = 1 }, --fabricar lockpick
	{ ['x'] = 167.89, ['y'] = -2222.77, ['z'] = 7.24, ['posicao'] = 2 }, --fabricar placa de carro
	{ ['x'] = 2462.07, ['y'] = 1575.25, ['z'] = 33.12, ['posicao'] = 3 }, --fabricar Jammer
	{ ['x'] = 839.1, ['y'] = 2176.09, ['z'] = 52.3, ['posicao'] = 4 }, --fabricar algemas
	{ ['x'] = -35.99, ['y'] = 2870.93, ['z'] = 59.62, ['posicao'] = 5 }, --fabricar capuz
	{ ['x'] = 1667.06, ['y'] = 4968.73, ['z'] = 42.26, ['posicao'] = 6 }, --fabricar colete

	{ ['x'] = 1778.69, ['y'] = 3641.71, ['z'] = 34.5, ['posicao'] = 7 }, --fabricar lockpick
	{ ['x'] = 2055.41, ['y'] = 3196.51, ['z'] = 45.38, ['posicao'] = 8 }, --fabricar placa de carro
	{ ['x'] = 2521.48, ['y'] = 2629.66, ['z'] = 37.96, ['posicao'] = 9 }, --fabricar Jammer
	{ ['x'] = 2338.48, ['y'] = 3046.68, ['z'] = 48.16, ['posicao'] = 10 }, --fabricar algemas
	{ ['x'] = 960.22, ['y'] = -2449.16, ['z'] = 31.23, ['posicao'] = 11 }, --fabricar capuz
	{ ['x'] = 582.34, ['y'] = -2723.53, ['z'] = 7.19, ['posicao'] = 12 }, --fabricar colete

--	{ ['x'] = -158.37, ['y'] = -995.9, ['z'] = 254.14, ['posicao'] = 12 }, --teste

}

-- 1401.47, 1139.26, 109.75
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
			
			if distance <= 20 and not onmenu then
				idle = 5
				DrawMarker(2, factory.x, factory.y, factory.z,0,0,0,0,0,0,1.0,1.0,1.0,255,50,50,155,1,30,30,30)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.checkPermission() then
							lociten = factory.posicao
							ToggleActionMenu()
						end
					end
				end
			end
			if distance <= 1.5 and not onmenu then
				idle = 5
				DrawText3D(factory.x,factory.y,factory.z,"Pressione [~c~E~w~] para ~c~FABRICAR~w~ itens.")
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