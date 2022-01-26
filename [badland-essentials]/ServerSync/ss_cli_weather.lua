local currentWeather = ss_default_weather
local transistioning = false

AddEventHandler( "onClientMapStart", function()
    -- We just joined - so get the current weather.
    TriggerServerEvent( "changeWeather",true )
    TriggerServerEvent( "addWeatherChatSuggests" )
end)

RegisterNetEvent("changeWeather")
AddEventHandler("changeWeather", function(newWeather,blackout,startup)
    transistioning = false
    if newWeather ~= currentWeather then
        if startup then
            SetWeatherTypeOverTime(newWeather, 1.00)
        else
            SetWeatherTypeOverTime(newWeather, (ss_weather_timer*60/8) + 0.1)
            transistioning = true
            Citizen.Wait(ss_weather_timer*60/8*1000)
        end
        Citizen.Wait(100)
        currentWeather = newWeather
        transistioning = false
    end

    if currentWeather == 'XMAS' then
        SetForceVehicleTrails(true)
        SetForcePedFootstepsTracks(true)
    else
        SetForceVehicleTrails(false)
        SetForcePedFootstepsTracks(false)
    end
    
    --Currently in a blackout?
    SetBlackout(blackout)

    --Set Starting Wind
    SetWindDirection(32.1)
    SetWind(ss_wind_speed_Mult[newWeather] + 0.1 )
    SetWindSpeed(ss_wind_speed_Mult[newWeather] + 0.1)

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- one second = 10 second switches
        if transistioning == false then
            ClearOverrideWeather()
            ClearWeatherTypePersist()
            SetWeatherTypePersist(currentWeather)
            SetWeatherTypeNow(currentWeather)
            SetWeatherTypeNowPersist(currentWeather)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000) -- every 30 seconds
        if transistioning == false and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            if string.upper(currentWeather) == string.upper("CLEARING") then
                local veh = GetVehiclePedIsIn( GetPlayerPed( -1 ) )
                local curDirt = GetVehicleDirtLevel( veh , false)
                if curDirt - 1 < 0 then
                    SetVehicleDirtLevel(veh, 0)
                else 
                    SetVehicleDirtLevel(veh, curDirt - 1.0)
                end
            end
        end
    end
end)

RegisterNetEvent("addWeatherChatSuggests")
AddEventHandler("addWeatherChatSuggests", function(newWeather,blackout,startup)
    TriggerEvent('chat:addSuggestion', '/weather', 'Change the weather.', {{ name="weatherType", help="Available types: extrasunny, clear, neutral, smog, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas"}})
end)
