-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("bdl_dealership",src)
vSERVER = Tunnel.getInterface("bdl_dealership")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealerOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealers = {
	{ ['x'] = -56.85, ['y'] = -1096.84, ['z'] = 26.43 },
}

local nearestConce = {
	test_locais = {
		{ coords = vec3(837.72,53.18,66.53), h = 324.02 },
	}
}

local veiculosvip = {
	{ nome = "bmwm3f80" },
	{ nome = "bmwm4gts" },
	{ nome = "nissangtr" },
	{ nome = "nissanskyliner34" },
    { nome = "lancerevolutionx" },
    { nome = "hondafk8" },
    { nome = "lamborghinihuracan" },
	{ nome = "taco" },
	{ nome = "agua" },
	{ nome = "cola" },
	{ nome = "sprunk" },
	{ nome = "energetico" },
    { nome = "leite" },
    { nome = "barracho" },
    { nome = "patriot" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN DEALER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(dealers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 10.5 then
					sleep = 5
					if not dealerOpen then
						DrawMarker(36,v.x,v.y,v.z,0,0,0,0,0,0,1.0,1.0,1.0,255,50,50,155,1,30,30,30)
						if distance <= 1.5 and IsControlJustPressed(0,38) then
							SetNuiFocus(true,true)
							TriggerEvent('bdl:triggerhud')
							TransitionToBlurred(1000)
							SendNUIMessage({ action = "showMenu" })
							dealerOpen = true
							vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dealerClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	TransitionFromBlurred(1000)
	TriggerEvent('bdl:triggerhud')
	dealerOpen = false
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTIMPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestImport",function(data,cb)
	local veiculos = vSERVER.Import()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTOFFROAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestOffRoad",function(data,cb)
	local veiculos = vSERVER.OffRoad()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVANS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVans",function(data,cb)
	local veiculos = vSERVER.Vans()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVips",function(data,cb)
	local veiculos = vSERVER.Vips()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	local veiculos = vSERVER.Possuidos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyDealer",function(data)
	if data.name ~= nil then
		vSERVER.buyDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TESTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local tempotest = 0
local myCoords = nil
local veh = nil
RegisterNUICallback("testDrive",function(data)
	if data.name ~= nil then
		SetNuiFocus(false,false)
		SendNUIMessage({ action = "hideMenu" })
		TransitionFromBlurred(1000)
		TriggerEvent('bdl:triggerhud')
		vRP._DeletarObjeto()
		vRP._stopAnim(false)
		local count = 0
		local mhash = loadModel(data.name)
		for _,spawn in ipairs(nearestConce.test_locais) do
			local spawnCoords = spawn.coords
        	local closestVehicleOnSpot = GetClosestVehicle(spawnCoords.x,spawnCoords.y,spawnCoords.z,3.001,0,71)
        	if DoesEntityExist(closestVehicleOnSpot) then
        	    count = count + 1
        	    if count >= #nearestConce.test_locais then
					TriggerEvent("Notify","sucesso","Todas as vagas estão ocupadas no momento.")
        	        return
        	    end
        	else
        	    DoScreenFadeOut(1000)
        	    Wait(1000)
        	    myCoords = GetEntityCoords(PlayerPedId())
				Wait(1000)
        	    SetEntityCoords(PlayerPedId(), spawnCoords)
        	    veh = createVehicle(mhash,spawnCoords)
        	    SetEntityHeading(veh, spawn.h)
        	    SetPedIntoVehicle(PlayerPedId(), veh, -1)
        	    SetVehicleDoorsLocked(veh,4)
        	    DoScreenFadeIn(1000)
				tempotest = 40
				dealerOpen = false
				inTest = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if inTest then
			if tempotest > 0 then
				tempotest = tempotest - 1
				if not IsPedInAnyVehicle(PlayerPedId(),false) then
					TriggerEvent("Notify","sucesso","Test Drive finalizado com sucesso.")
					inTest = false
					DoScreenFadeOut(1000)
                	Wait(1000)
                	SetEntityAsNoLongerNeeded(veh)
                	SetEntityAsMissionEntity(veh,true,true)
                	DeleteVehicle(veh)
                	SetEntityCoords(PlayerPedId(), myCoords)
                	Wait(1000)
                	DoScreenFadeIn(1000)
                	if GetEntityHealth(PlayerPedId()) < 102 then
                	    vRP.killGod()
                	    vRP.setHealth(150)
                	end
				end
			else
				TriggerEvent("Notify","sucesso","Test Drive finalizado com sucesso.")
				inTest = false
				DoScreenFadeOut(1000)
                Wait(1000)
                SetEntityAsNoLongerNeeded(veh)
                SetEntityAsMissionEntity(veh,true,true)
                DeleteVehicle(veh)
                SetEntityCoords(PlayerPedId(), myCoords)
                Wait(1000)
                DoScreenFadeIn(1000)
                if GetEntityHealth(PlayerPedId()) < 102 then
                    vRP.killGod()
                    vRP.setHealth(150)
                end
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if inTest then
			if tempotest > 0 then
				tempo = 1
				drawTxt("TEMPO PARA FINALIZAR O TESTDRIVE "..tempotest.." SEGUNDOS",4,0.5,0.93,0.50,255,255,255,120)
			end
		end
		Citizen.Wait(tempo)
	end
end)

-- CARREGAR O MODEL DO VEÍCULO --
function loadModel(model)
    local mhash = GetHashKey(model)
    local timeout = 5000
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        timeout = timeout - 1
        if timeout <= 0 then
            return false
        end
        Citizen.Wait(1)
    end
    return mhash
end

--- CRIA O VEÍCULO DO TEST DRIVE
function createVehicle(mhash, spawnCoords)
    local vehicle = CreateVehicle(mhash, spawnCoords, 0.0, true, true)
	SetVehicleNumberPlateText(vehicle,"TESTDRIV")
    if DoesEntityExist(vehicle) then
        local netveh = VehToNet(vehicle)
        NetworkRegisterEntityAsNetworked(vehicle)
        while not NetworkGetEntityIsNetworked(vehicle) do
            NetworkRegisterEntityAsNetworked(vehicle)
            Citizen.Wait(1)
        end
        if NetworkDoesNetworkIdExist(netveh) then
            SetEntitySomething(vehicle, true)
            if NetworkGetEntityIsNetworked(vehicle) then
                SetNetworkIdExistsOnAllMachines(netveh, true)
            end
        end
        SetVehicleIsStolen(vehicle, false)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetEntityInvincible(vehicle, false)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehRadioStation(vehicle, "OFF")
        SetModelAsNoLongerNeeded(mhash)
    end
    return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellDealer",function(data)
	if data.name ~= nil then
		vSERVER.sellDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dealership:Update")
AddEventHandler("dealership:Update",function(action)
	SendNUIMessage({ action = action })
end)

function DrawText3D(x,y,z, text)
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

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end