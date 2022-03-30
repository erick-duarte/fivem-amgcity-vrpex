-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local aracici = false
local currentVehicle = nil

RegisterNetEvent("statusFome")
AddEventHandler("statusFome",function(number)
	hunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEDE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusSede")
AddEventHandler("statusSede",function(number)
	thirst = parseInt(number)
end)

Citizen.CreateThread(function()
    while true do

        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            DisplayRadar(0)
            SendNUIMessage({
                type = 'arac',
                bool = false,
            }) 
            aracici = false
        else
            DisplayRadar(1)
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 1) then
                SendNUIMessage({
                    type = 'arac',
                    bool = true,
                })
                currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if aracici == false then 
                    dongugobrr()
                    dongu2gobrr() 
                end
                aracici = true
            end
        end
        
        --TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
        --    TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                SendNUIMessage({
                    type = "updateStatusHudOthers",
                    hunger = parseInt(hunger),
                    thirst = parseInt(thirst)
                })
        --    end)
        --end)
        Citizen.Wait(5000)
    end
end)

function dongugobrr() 
    Citizen.CreateThread(function()
        while aracici do
            aga, ligh, lights = GetVehicleLightsState(currentVehicle)
            Citizen.Wait(50)
            SendNUIMessage({
                type = 'aracOthers',
                speed = GetEntitySpeed(currentVehicle) * 3.6,
                fuel = GetVehicleFuelLevel(currentVehicle) / 2.6,
                engine = GetIsVehicleEngineRunning(currentVehicle),
                light = lights,
            })
        end
    end)
end

function dongu2gobrr() 
    local vehicleSignalIndicator = 'off'
    Citizen.CreateThread(function()
        while aracici do
            Citizen.Wait(1)
            if IsControlJustPressed(1, 174) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'left'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('wiro_hud:setCarSignalLights', vehicleSignalIndicator)
            end

            if IsControlJustPressed(1, 175) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'right'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('wiro_hud:setCarSignalLights', vehicleSignalIndicator)
            end

            if IsControlJustPressed(1, 173) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'both'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('wiro_hud:setCarSignalLights', vehicleSignalIndicator)
            end
        end
    end)
end

RegisterNetEvent("wiro_hud:setCarSignalLights")
AddEventHandler("wiro_hud:setCarSignalLights", function(indexx)
    SendNUIMessage({
        type = 'sinyal',
        index = indexx,
    })
end)

Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
--        local health = GetEntityHealth(player) - 100 / 2.6
        local health = (GetEntityHealth(GetPlayerPed(-1))-100)/300*100
        local armor = GetPedArmour(player) / 2.6
        SendNUIMessage({
            type = 'updateStatusHudmain',
            health = health,
            armour = armor,
        })
        Citizen.Wait(200)
    end
end)

RegisterNetEvent("wiro_hud:kemer")
AddEventHandler("wiro_hud:kemer", function(bool)
    SendNUIMessage({
        type = 'kemer',
        takili = bool,
    })
end)