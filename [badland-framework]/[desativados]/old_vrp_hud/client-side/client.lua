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
Tunnel.bindInterface("vrp_hud",cRP)
vSERVER = Tunnel.getInterface("vrp_hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ped = 0
local voice = 2
local armour = 0
local street = ""
local health = 200
local talking = false
local x,y,z = 0.0,0.0,0.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stress = 0
local hunger = 100
local thirst = 100
local showHud = true
local showMovie = false
local radioDisplay = ""
local direction = "Norte"
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATE
-----------------------------------------------------------------------------------------------------------------------------------------
local hour = 0
local minute = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local beltSpeed = 0
local entVelocity = 0
local beltLock = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATETIMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
function calculateTimeDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if hour <= 9 then
		hour = "0"..hour
	end

	if minute <= 9 then
		minute = "0"..minute
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETALKING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vrp_hud:VoiceTalking",function(status)
	talking = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("progress")
AddEventHandler("progress",function(progressTimer)
	SendNUIMessage({ progress = true, progressTimer = parseInt(progressTimer - 500) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATE - 100
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if showHud then
			health = GetEntityHealth(ped) - 100
            x,y,z = table.unpack(GetEntityCoords(ped))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADUPDATE - 500
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if showHud then

			ped = PlayerPedId()
			armour = GetPedArmour(ped)
--			heading = GetEntityHeading(ped)
			street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))

--			if heading >= 315 or heading < 45 then
--				direction = "Norte"
--			elseif heading >= 45 and heading < 135 then
--				direction = "Oeste"
--			elseif heading >=135 and heading < 225 then
--				direction = "Sul"
--			elseif heading >= 225 and heading < 315 then
--				direction = "Leste"
--			end

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:update")
AddEventHandler("vrp_hud:update", function(rHunger, rThirst)
  hunger, thirst = rHunger, rThirst
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if showHud then
			updateDisplayHud(PlayerPedId())
			SendNUIMessage({ hud = true, movie = false })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------
function updateDisplayHud(ped)
--	print(health)
	calculateTimeDisplay()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local speed = GetEntitySpeed(vehicle) * 1.60934
--		SendNUIMessage({ vehicle = true, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hours, minutes = minutes, direction = direction, voice = voice, fuel = fuel, speed = speed, seatbelt = beltLock })
--	else
--		SendNUIMessage({ vehicle = false, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hours, minutes = minutes, direction = direction, voice = voice, timeAndDateString = timeAndDateString })
		SendNUIMessage({ vehicle = true, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hour, minutes = minute, voice = voice, fuel = fuel, speed = speed, seatbelt = beltLock })
	else
		SendNUIMessage({ vehicle = false, talking = talking, health = health, armour = armour, thirst = thirst, hunger = hunger, stress = stress, oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId()), street = street, radio = radioDisplay, hours = hour, minutes = minute, voice = voice, timeAndDateString = timeAndDateString })

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	showHud = not showHud
	SendNUIMessage({ hud = showHud })
	updateDisplayHud(PlayerPedId())
	TriggerEvent("vrp_prison:switchHud",showHud)
end)

RegisterNetEvent('gcphone:tooglehud')
AddEventHandler('gcphone:tooglehud',function(state)
	showHud = state
	SendNUIMessage({ hud = showHud })
	updateDisplayHud(PlayerPedId())
	TriggerEvent("vrp_prison:switchHud",showHud)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("movie",function(source,args)
	showMovie = not showMovie
	SendNUIMessage({ movie = showMovie })
	updateDisplayHud(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:toggleHood")
AddEventHandler("vrp_hud:toggleHood",function()
	showHood = not showHood
	SendNUIMessage({ hood = showHood })

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,2)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
local discordHood = true
RegisterCommand("seialal",function(source,args,rawCommand)
	discordHood = true
	SendNUIMessage({ hood = false })
end)

RegisterNetEvent("vrp_hud:discordTrue")
AddEventHandler("vrp_hud:discordTrue",function()
	if not discordHood then
		discordHood = true
		SendNUIMessage({ hood = true })
	end
end)

RegisterNetEvent("vrp_hud:discordFalse")
AddEventHandler("vrp_hud:discordFalse",function(status)
	if discordHood then
		discordHood = false
		SendNUIMessage({ hood = false })
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- STATUSHUNGER
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterNetEvent("statusHunger")
--AddEventHandler("statusHunger",function(number)
--	hunger = parseInt(number)
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- STATUSTHIRST
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterNetEvent("statusThirst")
--AddEventHandler("statusThirst",function(number)
--	thirst = parseInt(number)
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusFome")
AddEventHandler("statusFome",function(number)
	hunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusSede")
AddEventHandler("statusSede",function(number)
	thirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSSTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusStress")
AddEventHandler("statusStress",function(number)
	stress = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHud = status
	SendNUIMessage({ hud = showHud })
	updateDisplayHud(PlayerPedId())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:VoiceMode")
AddEventHandler("vrp_hud:VoiceMode",function(status)
	voice = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOKOVOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hud:RadioDisplay")
AddEventHandler("vrp_hud:RadioDisplay",function(number)
	if parseInt(number) <= 0 then
		radioDisplay = ""
	else
		if parseInt(number) == 911 then
			radioDisplay = "Policia <s>:</s>"
		elseif parseInt(number) == 912 then
			radioDisplay = "Policia <s>:</s>"
		elseif parseInt(number) == 112 then
			radioDisplay = "Paramédico <s>:</s>"
		elseif parseInt(number) == 704 then
			radioDisplay = "Reboque <s>:</s>"
		else
			radioDisplay = parseInt(number).."Mhz <s>:</s>"
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			local veh = GetVehiclePedIsUsing(ped)
			local vehClass = GetVehicleClass(veh)
			if (vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20) then
				local speed = GetEntitySpeed(veh) * 1.60934
				if speed ~= beltSpeed then
					--if ((beltSpeed - speed) >= 30 and not beltLock) or ((beltSpeed - speed) >= 90 and beltLock) then
					if (beltSpeed - speed) >= 30 and not beltLock then
						local entCoords = GetOffsetFromEntityInWorldCoords(veh,0.0,7.0,0.0)
						SetEntityHealth(ped,GetEntityHealth(ped)-50)

						SetEntityCoords(ped,entCoords.x,entCoords.y,entCoords.z+1)
						SetEntityVelocity(ped,entVelocity.x,entVelocity.y,entVelocity.z)
						Citizen.Wait(1)
						SetPedToRagdoll(ped,5000,5000,0,0,0,0)
					end
					beltSpeed = speed
					entVelocity = GetEntityVelocity(veh)
				end

				if beltLock then
					DisableControlAction(1,75,true)
				end

				if IsControlJustReleased(1,47) then
					beltLock = not beltLock

					if not beltLock then
						TriggerEvent("vrp_sound:source","unbelt",0.5)
					else
						TriggerEvent("vrp_sound:source","belt",0.5)
					end
				end
			end
		else
			if beltSpeed ~= 0 then
				beltSpeed = 0
			end

			if beltLock then
				beltLock = false
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterNetEvent("vrp_hud:syncTimers")
--AddEventHandler("vrp_hud:syncTimers",function(timer)
--	minutes = parseInt(timer[1])
--	hours = parseInt(timer[2])
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
--local homeInterior = false
--RegisterNetEvent("vrp_homes:Hours")
--AddEventHandler("vrp_homes:Hours",function(status)
--	homeInterior = status
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--	while true do
--		SetWeatherTypeNow("CLEAR")
--		SetWeatherTypePersist("CLEAR")
--		SetWeatherTypeNowPersist("CLEAR")
--
--		if homeInterior then
--			NetworkOverrideClockTime(00,00,00)
--		else
--			NetworkOverrideClockTime(hours,minutes,00)
--		end
--		Citizen.Wait(0)
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHREDUCE
-----------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--	while true do
--		local ped = PlayerPedId()
--		local health = GetEntityHealth(ped)
--
--		if health > 101 then
--			if hunger >= 10 and hunger <= 20 then
--				SetFlash(0,0,500,1000,500)
--				SetEntityHealth(ped,health-1)
--			elseif hunger <= 9 then
--				SetFlash(0,0,500,1000,500)
--				SetEntityHealth(ped,health-2)
--			end
--
--			if thirst >= 10 and thirst <= 20 then
--				SetFlash(0,0,500,1000,500)
--				SetEntityHealth(ped,health-1)
--			elseif thirst <= 9 then
--				SetFlash(0,0,500,1000,500)
--				SetEntityHealth(ped,health-2)
--			end
--		end
--
--		Citizen.Wait(5000)
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- THREADHEALTHREDUCE
-------------------------------------------------------------------------------------------------------------------------------------------
--Citizen.CreateThread(function()
--	while true do
--		local ped = PlayerPedId()
--		local health = GetEntityHealth(ped)
--
--		if health > 101 then
--			if stress >= 80 then
--				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.10)
--				if parseInt(math.random(3)) >= 3 and not IsPedInAnyVehicle(ped) then
--					SetPedToRagdoll(ped,5000,5000,0,0,0,0)
--					TriggerServerEvent("vrp_inventory:Cancel")
--				end
--			elseif stress >= 60 and stress <= 79 then
--				ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
--				if parseInt(math.random(3)) >= 3 and not IsPedInAnyVehicle(ped) then
--					SetPedToRagdoll(ped,3000,3000,0,0,0,0)
--					TriggerServerEvent("vrp_inventory:Cancel")
--				end
--			end
--		end
--
--		Citizen.Wait(10000)
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
    function()
        while true do
            local ped = PlayerPedId()
            if showSkate then
                if not IsMinimapRendering() then
                    DisplayRadar(true)
                end 
            end 
			if showHud and prison  then
                if not IsMinimapRendering() then
                    DisplayRadar(true)
                end 
            else
            if IsPedInAnyVehicle(ped) and showHud then
                if not IsMinimapRendering() then
                    DisplayRadar(true)
                end
            else
                if IsMinimapRendering() and not showSkate then
                    DisplayRadar(false)
                end
            end
            Citizen.Wait(1000)
        end
    end
end)