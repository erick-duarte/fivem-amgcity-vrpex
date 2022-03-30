--bomdia

local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')


radios = {}
volumes = {}
veiculos_net = {}
veiculos = {}
myVeh = "null"
veh = {}
meu_v = {}
myradio = false
vehid= {}


RegisterNetEvent('jbl:myRadio')
AddEventHandler('jbl:myRadio',function(netveh)		
	myVeh = netveh
end)

RegisterNUICallback('radiooff',function(data,cb)	
	radios[data.user_id] = false
end)

RegisterNetEvent('jbl:setvolumeRadio')
AddEventHandler('jbl:setvolumeRadio',function(volume,user_id)		
	if(volume~=nil)then		
		volumes[user_id] = (volume/100)
	end
end)

RegisterNetEvent('jbl:PlayOnOneRadio')
AddEventHandler('jbl:PlayOnOneRadio',function(soundFile,soundVolume, user_id)
	SendNUIMessage({ transactionType = 'play', transactionFile = soundFile, user_id = user_id})
end)

RegisterNetEvent('JBL:Play_URL')
AddEventHandler('JBL:Play_URL',function(url,volume, user_id)
	volumes[user_id] = (volume/100)
	radios[user_id] = true
	SendNUIMessage({ transactionType = 'play_url', transactionFile = url, user_id = user_id})
end)

RegisterNetEvent('jbl:RadioON')
AddEventHandler('jbl:RadioON',function(veh, user_id, Volume)	
	radios[user_id] = true
	volumes[user_id] = (Volume/100)
	veiculos_net[user_id] = veh
	veiculos[user_id] = NetToVeh(veh)
	
	SendNUIMessage({transactionType = 'RadioON', user_id = user_id, volume_max = volumes[user_id]})
end)


RegisterNetEvent('jbl:RadioOFF')
AddEventHandler('jbl:RadioOFF',function(user_id)	
	radios[user_id] = nil	
	SendNUIMessage({ transactionType = 'RadioOFF', user_id = user_id})
end)

-- amem
Citizen.CreateThread(function()
	while true do
		local waits = 1000
		for user_id, estado in pairs(radios)do
			if(estado == true)then
				local vehid = veiculos_net[user_id]
				if NetworkDoesNetworkIdExist(vehid) then
					local veh = NetToVeh(vehid)			
					if DoesEntityExist(veh) then
						
						local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
						
						
						local x2,y2,z2 = table.unpack(GetEntityCoords(veh,false))
						
						local ped = GetPlayerPed(-1)
						local distancia = GetDistanceBetweenCoords(x, y, z, x2, y2, z2, true)
						local alcance = ((volumes[user_id]*100)/2)
						if(distancia<alcance)then
							local volume = distancia/alcance
							volume = 1-volume
							volume = volume*volumes[user_id]
							SendNUIMessage({ transactionType = 'setvolumeRadio', transactionVolume = volume, user_id = user_id })
						else				
							SendNUIMessage({ transactionType = 'setvolumeRadio', transactionVolume = 0 ,user_id = user_id})
						end
						--[[
						if(myradio)then
							x,y,z = table.unpack(GetEntityCoords(veh,true))				
							local distancia2 = GetDistanceBetweenCoords(x, y, z, x2, y2, z2, true)
							if(distancia2>30)then
								enviacords()
							end
						end
						]]
					else
						SendNUIMessage({ transactionType = 'setvolumeRadio', transactionVolume = 0, user_id = user_id })
					end
				else
					if(myVeh==vehid)then
						radios[user_id] = false
						TriggerServerEvent("JBL:offRadio")
					end
					SendNUIMessage({ transactionType = 'RadioOFF', user_id = user_id})
				end
			end
		end
		Citizen.Wait(waits)
	end
end)
		




