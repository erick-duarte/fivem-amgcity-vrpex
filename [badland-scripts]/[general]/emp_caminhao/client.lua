local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_caminhao")
cfg = module("emp_caminhao", "config")

local blips = false
local blipentregafinal = false
local entregafinal = false
local servico = false
local servehicle = nil
local caminhao = nil
local coordenadas = 0.0
local delay = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if servico then
		TriggerEvent("Notify","negado","Você já pegou uma carga")
		ToggleActionMenu()
	else
		if data == "fechar" then
			ToggleActionMenu()

		elseif delay[data] <= 0 then
			ToggleActionMenu()
			servico = true
			delay[data] = cfg.entregas['config'].delay
			
			caminhao = cfg.entregas[data]['veiculos']['cavalo'].hash
			servehicle = cfg.entregas[data]['veiculos']['carreta'].hash
			spawnVehicle(caminhao,servehicle)
			
			numloc = math.random(1,2)
			coordenadas = cfg.entregas[data]['localizacao'][numloc]

			CriandoBlip(coordenadas)
			TriggerEvent("Notify","importante","Entrega de <b>"..data.."</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local ped = PlayerPedId()
	while true do
		tempo = 1000

		local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),cfg.entregas['inicio'].localizacao,true)
		if distance <= 10 and not servico and not entregafinal then
			tempo = 1
			DrawMarker(39,cfg.entregas['inicio'].localizacao-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end

		if servico and not entregafinal then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(coordenadas,x,y,z,true)

			if distance <= 100.0 then
				tempo = 1
				DrawMarker(21,coordenadas-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
				if distance <= 6.0 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA DEIXAR A CARGA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						local HasTrailer, vehTrailer = GetVehicleTrailerVehicle(vehicle, vehTrailer)
						if GetEntityModel(vehicle) == caminhao then
							if GetEntityModel(vehTrailer) == servehicle then
								TriggerServerEvent("trydeleteveh",VehToNet(vehTrailer))
								Citizen.Wait(1000)
								if DoesEntityExist(vehTrailer) then
									TriggerServerEvent("trydeleteveh",VehToNet(vehTrailer))
								end
								RemoveBlip(blip)
								CriandoBlipEntregaCaminhao(cfg.entregas['inicio'].localizacao,1)
								entregafinal = true
								TriggerEvent("Notify","aviso","Volte para <b>Central do Caminhoneiro</b> e devolva o <b>Caminhão</b>",5000)
							else
								TriggerEvent("Notify","negado","Você está com a carga errada!",5000)
							end
						else
							TriggerEvent("Notify","negado","Você está com o caminhão errado",5000)
						end
					end
				end
			end
		end

		if servico and entregafinal then --ENTREGA FINAL
--			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(cfg.entregas['fim'].localizacao,x,y,z,true)

			if distance <= 100.0 then
				tempo = 1
				DrawMarker(21,cfg.entregas['fim'].localizacao-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
				if distance <= 6.0 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA DEIXAR O CAMINHÃO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						if GetEntityModel(vehicle) == caminhao then
							TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
							Citizen.Wait(1000)
							if DoesEntityExist(vehicle) then
								TriggerServerEvent("trydeleteveh",VehToNet(vehicle))
							end
							emP.checkPayment()

							delay[data] = cfg.entregas['config'].delay

							RemoveBlip(blips)
							RemoveBlip(blipentregafinal)
							Citizen.Wait(1)
							blips = false
							blipentregafinal = false
							servico = false
							entregafinal = false
						else
							TriggerEvent("Notify","negado","Você está com o caminhão errado",5000)
						end
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		if delay[data] > 0 then
			delay[data] = delay[data] - 1
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				RemoveBlip(blips)
				if entregafinal then
					RemoveBlip(blipentregafinal)
				end
				Citizen.Wait(1)
				blips = false
				blipentregafinal = false
				servico = false
				entregafinal = false
				TriggerEvent('deletarveiculo',nveh)
				TriggerEvent('deletarveiculo',nveh2)
				TriggerEvent("Notify","negado","Entrega cancelada",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function CriandoBlip(x,y,z)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,2)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Carga")
	EndTextCommandSetBlipName(blips)
end

function CriandoBlipEntregaCaminhao(locentregafinal,destino)
	blipentregafinal = AddBlipForCoord(locentregafinal)
	SetBlipSprite(blipentregafinal,2)
	SetBlipColour(blipentregafinal,5)
	SetBlipScale(blipentregafinal,0.4)
	SetBlipAsShortRange(blipentregafinal,false)
	SetBlipRoute(blipentregafinal,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega final")
	EndTextCommandSetBlipName(blipentregafinal)
end

function spawnVehicle(vehname,trailername)
	local checkslot = 1
	local mhash = GetHashKey('packer')
	local thash = GetHashKey('tanker2')
--	while not HasModelLoaded(mhash) and not HasModelLoaded(thash) do
		RequestModel(mhash)
		RequestModel(thash)
--		Citizen.Wait(1)
--	end

--	if HasModelLoaded(mhash) and HasModelLoaded(thash) then
		while true do
			local checkPos = GetClosestVehicle(cfg.posicoes['cavalo'][checkslot],3.001,0,71)
			if DoesEntityExist(checkPos) and checkPos ~= nil then
				checkslot = checkslot + 1
				if checkslot > #cfg.posicoes['cavalo'] then
					checkslot = -1
					TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.",10000)
					break
				end
			else
				break
			end
			Citizen.Wait(10)
		end

		if checkslot ~= -1 then

			local nveh = CreateVehicle(mhash,cfg.posicoes['cavalo'][checkslot]+0.5,270.90,true,false)

			local truckTrailer = CreateVehicle(thash,1178.76,-3265.23,5.71+0.5,270.90,true)

			SetVehicleOnGroundProperly(nveh)
			SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
			SetEntityAsMissionEntity(nveh,true,true)
			SetVehicleDoorOpen(truckTrailer, 5, false, false)
			
			AttachVehicleToTrailer(nveh,truckTrailer,10.0)

			SetModelAsNoLongerNeeded(mhash)
			SetModelAsNoLongerNeeded(thash)
		end
--	end
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
