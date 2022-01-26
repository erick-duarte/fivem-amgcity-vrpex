local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_fuel")

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentFuel2 = 0.0
local currentCost = 0.0
local new_perc = 0


function open(vehicle,model,money,precogasolina,combustivel)
	SetNuiFocus(true, true)
	SendNUIMessage({ action = true, fuel = GetVehicleFuelLevel(vehicle), vehicle = model, money = money, link = Config.linkimages, format = Config.imageformat, precolitro = precogasolina, combustivel = combustivel })
end

function close()
	SetNuiFocus(false, false)
	SendNUIMessage({ action = false })
	isFueling = false
end


AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then return end
    close()
end)

RegisterNetEvent('nation_fuel:close')
AddEventHandler('nation_fuel:close',function()
	close()
end)

function ManageFuelUsage(vehicle)
	if IsVehicleEngineOn(vehicle) then
		SetVehicleFuelLevel(vehicle,GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle),1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))
	end
end

Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor,1)
	while true do
		Citizen.Wait(2000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				ManageFuelUsage(vehicle)
			end
		end
	end
end)

function FindNearestFuelPump()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle,object = FindFirstObject()
	local success

	repeat
		if Config.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps,object)
		end

		success,object = FindNextObject(handle,object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for k,v in pairs(fuelPumps) do
		local dstcheck = GetDistanceBetweenCoords(coords,GetEntityCoords(v))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = v
		end
	end
	return pumpObject,pumpDistance
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local pumpObject,pumpDistance = FindNearestFuelPump()
		if pumpDistance < 2.0 then
			isNearPump = pumpObject
		else
			isNearPump = false
			Citizen.Wait(math.ceil(pumpDistance*20))
		end
	end
end)

RegisterNetEvent('nation_fuel:galao')
AddEventHandler('nation_fuel:galao',function()
	GiveWeaponToPed(PlayerPedId(),883325847,4500,false,true)
end)

function Round(num,numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end

AddEventHandler('fuel:refuelFromPump',function(pumpObject,ped,vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)
	TaskTurnPedToFaceEntity(ped,vehicle,5000)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)

	while isFueling do
		Citizen.Wait(4)
        local oldFuel = DecorGetFloat(vehicle,Config.FuelDecor)
		local fuelToAdd = math.random(1,2) / 100.0

		for k,v in pairs(Config.DisableKeys) do
			DisableControlAction(0,v)
		end

		local vehicleCoords = GetEntityCoords(vehicle)
		if not pumpObject then
			DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.5,"PRESSIONE ~g~E ~w~PARA CANCELAR")
			DrawText3Ds(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z + 0.34,"GALÃO: ~b~"..Round(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100,1).."%~w~    TANQUE: ~y~"..Round(currentFuel,1).."%")
			if GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd
				SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		end

		if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
			TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
		end

		SetVehicleFuelLevel(vehicle,currentFuel)
		DecorSetFloat(vehicle,Config.FuelDecor,GetVehicleFuelLevel(vehicle))

		if IsControlJustReleased(0,38) or DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) then
			isFueling = false
		end
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function()
	while true do
		local storm = 1000
		local ped = PlayerPedId()
		local money = func.GetUserMoney()
		while not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) do
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped),-1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)
				DrawText3Ds(pumpCoords.x,pumpCoords.y,pumpCoords.z + 1.2,"SAIA DO ~y~VEÍCULO ~w~PARA ABASTECER")
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)
				local vehx = GetEntityModel(vehicle)
				local model = GetDisplayNameFromVehicleModel(vehx)
				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped),vehicleCoords) < 3.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle,-1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true
						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords
							if GetAmmoInPedWeapon(ped,883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 99 and canFuel then
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.5,"PRESSIONE ~g~E ~w~PARA ABASTECER")
							if IsControlJustReleased(0,38) then
								if isNearPump then
									local combustivel = Config.Veiculos[vRP.vehListHash(vehx)]
									if combustivel == 1 then
										pricecomb = Config.Combustivel[combustivel]
										namecombust = "PODIUM"
										open(vehicle,model,money,pricecomb,namecombust)
										isFueling = true
										payed = false
									elseif combustivel == 2 then
										pricecomb = Config.Combustivel[combustivel]
										namecombust = "DIESEL"
										open(vehicle,model,money,pricecomb,namecombust)
										isFueling = true
										payed = false
									else
										pricecomb = Config.Combustivel[0]
										namecombust = "GASOLINA"
										open(vehicle,model,money,pricecomb,namecombust)
										isFueling = true
										payed = false
									end
								else
									isFueling = true
									TriggerEvent('nation_fuel:pagamento',isNearPump,ped,vehicle)
								end
							end
						elseif not canFuel then
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"~o~GALÃO VAZIO")
						else
							DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"~g~TANQUE CHEIO")
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)
					DrawText3Ds(stringCoords.x,stringCoords.y,stringCoords.z + 1.2,"PRESSIONE ~g~E ~w~PARA COMPRAR UM ~b~GALÃO DE GASOLINA")
					if IsControlJustReleased(0,38) then
						TriggerServerEvent('nation_fuel:pagamento',parseInt(3500),true)
					end
				end
			end
			Citizen.Wait(4)
		end
		Citizen.Wait(storm)
	end
end)





RegisterNUICallback('escape', function(data, cb)
    close()
end)

RegisterNUICallback('pay', function(data, cb)
	local vehicle = GetPlayersLastVehicle()
    local new_perc = tonumber(data.new_perc)
	if not payed then
		if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(vehicle)) < 5 then
			TriggerServerEvent('nation_fuel:pagamento',math.floor(new_perc),false,VehToNet(vehicle),math.floor(new_perc),Config.FuelDecor)
			payed = true
		end
	end
end)

RegisterNUICallback('checkpay', function(data, cb)
	new_perc = tonumber(data.new_perc)
	TriggerServerEvent('nation_fuel:check',math.floor(new_perc))
end)

RegisterNUICallback('notifytext', function(data, cb)
    local text = data.text
	TriggerEvent("Notify","importante",text)
end)

RegisterNUICallback('startanim',function(data,cb)
	local ped = PlayerPedId()
	local vehicle = GetPlayersLastVehicle()
	local fuei = GetVehicleFuelLevel(vehicle)
	local new_perc2 = new_perc / Config.precolitro
	local fuel = new_perc2 + fuei
	SetVehicleFuelLevel(vehicle,fuel)
	TaskTurnPedToFaceEntity(ped,vehicle,5000)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0,8.0,-1,50,0,0,0,0)
end)

RegisterNUICallback('removeanim',function(data,cb)
	local ped = PlayerPedId()
	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)





function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(10)
		end
	end
end