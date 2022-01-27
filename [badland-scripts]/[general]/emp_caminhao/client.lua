local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("emp_caminhao")
cfg = module("emp_caminhao", "config")

local blips = false
local blipentregafinal = false
local entregafinal = false
local random = 0
local modules = ""
local servico = false
local servehicle = nil
local caminhao = nil
local CoordenadaX2 = 0.0
local CoordenadaY2 = 0.0
local CoordenadaZ2 = 0.0
local coordenadas = 0.0
local tempogas = 0
local tempodiesel = 0
local temposhow = 0
local tempowoods = 0
local tempocars = 0
local delay = 0
local pointspawn = 1

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

		elseif delay <= 0 then
			ToggleActionMenu()
			servico = true
			delay = cfg.entregas['config'].delay
			
			caminhao = cfg.entregas[data]['veiculos']['cavalo'].hash
			servehicle = cfg.entregas[data]['veiculos']['carreta'].hash
			spawnVehicle(caminhao,servehicle)
			
			numloc = math.random(1,2)
			coordenadas = cfg.entregas[data]['localizacao'][numloc]

			CriandoBlip(coordenadas)
			TriggerEvent("Notify","importante","Entrega de <b>"..data.."</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			
--
--
--
--
--
--		if data == "gasolina" then
--			if tempogas <= 0 then
--				tempogas = 300
--				TriggerEvent('deletarveiculo',nveh2)
--				spawnVehicle("tanker2",1142.50,-3264.00,5.90)
--				spawnVehicle2("packer",1185.20,-3251.40,6.02)
--				ToggleActionMenu()
--				servico = true
--				modules = data
--				servehicle = 1956216962 --tanker2
--				caminhao = 569305213 --packer
--				localizacao = math.random(1,2)
--				CoordenadaX2 = gas[localizacao].x
--				CoordenadaY2 = gas[localizacao].y
--				CoordenadaZ2 = gas[localizacao].z
--				CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
--				TriggerEvent("Notify","importante","Entrega de <b>Combustível</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			else
--				TriggerEvent("Notify","aviso","Não temos essa carga no momento, volte daqui <b>"..tempogas.."</b> segundos",5000)
--			end
--		elseif data == "diesel" then
--			if tempodiesel <= 0 then
--				tempodiesel = 300
--				TriggerEvent('deletarveiculo',nveh2)
--				spawnVehicle("armytanker",1142.50,-3264.00,5.90)
--				spawnVehicle2("packer",1185.20,-3251.40,6.02)
--				ToggleActionMenu()
--				servico = true
--				modules = data
--				servehicle = -1207431159 --armytanker
--				caminhao = 569305213 --packer
--				localizacao = math.random(1,2)
--				CoordenadaX2 = diesel[localizacao].x
--				CoordenadaY2 = diesel[localizacao].y
--				CoordenadaZ2 = diesel[localizacao].z
--				CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
--				TriggerEvent("Notify","importante","Entrega de <b>Diesel</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			else
--				TriggerEvent("Notify","aviso","Não temos essa carga no momento, volte daqui <b>"..tempodiesel.."</b> segundos",5000)
--			end
--		elseif data == "show" then
--			if temposhow <= 0 then
--				temposhow = 300
--				TriggerEvent('deletarveiculo',nveh2)
--				spawnVehicle("tvtrailer",1142.50,-3264.00,5.90)
--				spawnVehicle2("packer",1185.20,-3251.40,6.02)
--				ToggleActionMenu()
--				servico = true
--				modules = data
--				servehicle = -1770643266 --tvtrailer
--				caminhao = 569305213 --packer
--				localizacao = math.random(1,2)
--				CoordenadaX2 = show[localizacao].x
--				CoordenadaY2 = show[localizacao].y
--				CoordenadaZ2 = show[localizacao].z
--				CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
--				TriggerEvent("Notify","importante","Entrega de <b>Shows</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			else
--				TriggerEvent("Notify","aviso","Não temos essa carga no momento, volte daqui <b>"..temposhow.."</b> segundos",5000)
--			end
--		elseif data == "woods" then
--			if tempowoods <= 0 then
--				tempowoods = 300
--				TriggerEvent('deletarveiculo',nveh2)
--				spawnVehicle("trailerlogs",1142.50,-3264.00,5.90)
--				spawnVehicle2("packer",1185.20,-3251.40,6.02)
--				ToggleActionMenu()
--				servico = true
--				modules = data
--				servehicle = 2016027501 --trailerlogs
--				caminhao = 569305213 --packer
--				localizacao = math.random(1,2)
--				CoordenadaX2 = woods[localizacao].x
--				CoordenadaY2 = woods[localizacao].y
--				CoordenadaZ2 = woods[localizacao].z
--				CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
--				TriggerEvent("Notify","importante","Entrega de <b>Madeiras</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			else
--				TriggerEvent("Notify","aviso","Não temos essa carga no momento, volte daqui <b>"..tempowoods.."</b> segundos",5000)
--			end
--		elseif data == "cars" then
--			if tempocars <= 0 then
--				tempocars = 300
--				TriggerEvent('deletarveiculo',nveh2)
--				spawnVehicle("tr4",1142.50,-3264.00,5.90)
--				spawnVehicle2("packer",1185.20,-3251.40,6.02)
--				ToggleActionMenu()
--				servico = true
--				modules = data
--				servehicle = 2091594960 --tr4
--				caminhao = 569305213 --packer
--				localizacao = math.random(1,2)
--				CoordenadaX2 = cars[localizacao].x
--				CoordenadaY2 = cars[localizacao].y
--				CoordenadaZ2 = cars[localizacao].z
--				CriandoBlip(CoordenadaX2,CoordenadaY2,CoordenadaZ2)
--				TriggerEvent("Notify","importante","Entrega de <b>Veículos</b> iniciada, pegue o caminhão, a carga e vá até o destino marcado.",5000)
--			else
--				TriggerEvent("Notify","aviso","Não temos essa carga no momento, volte daqui <b>"..tempocars.."</b> segundos",5000)
--			end	
--		elseif data == "fechar" then
--			ToggleActionMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		tempo = 1000

		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1196.80,-3253.68,7.09,true)
		if distance <= 10 and not servico and not entregafinal then
			tempo = 1
			DrawMarker(39,1196.80,-3253.68,7.09-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end

		if servico and not entregafinal then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(CoordenadaX2,CoordenadaY2,CoordenadaZ2,x,y,z,true)

			if distance <= 100.0 then
				tempo = 1
				DrawMarker(21,CoordenadaX2,CoordenadaY2,CoordenadaZ2-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
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
								CriandoBlipEntregaCaminhao(locentregafinal,1)
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
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(locentregafinal[1].x,locentregafinal[1].y,locentregafinal[1].z,x,y,z,true)

			if distance <= 100.0 then
				tempo = 1
				DrawMarker(21,locentregafinal[1].x,locentregafinal[1].y,locentregafinal[1].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
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
							emP.checkPayment(modules)

							if module == 'gas' then
								tempogas = 300
							elseif module == 'diesel' then
								tempodiesel = 300
							elseif module == 'show' then
								temposhow = 300
							elseif module == 'woods' then
								tempowoods = 300
							elseif module == 'cars' then
								tempocars = 300
							end

							RemoveBlip(blips)
							RemoveBlip(blipentregafinal)
							Citizen.Wait(1)
							blips = false
							blipentregafinal = false
							random = 0
							modules = ""
							servico = false
							entregafinal = false
							servehicle = nil
							caminhao = nil
							CoordenadaX2 = 0.0
							CoordenadaY2 = 0.0
							CoordenadaZ2 = 0.0

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
		if tempogas > 0 then
			tempogas = tempogas - 1
		end
		if tempodiesel > 0 then
			tempodiesel = tempodiesel - 1
		end
		if tempowoods > 0 then
			tempowoods = tempowoods - 1
		end
		if tempocars > 0 then
			tempocars = tempocars - 1
		end
		if temposhow > 0 then
			temposhow = temposhow - 1
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
				random = 0
				modules = ""
				servico = false
				entregafinal = false
				servehicle = nil
				caminhao = nil
				CoordenadaX2 = 0.0
				CoordenadaY2 = 0.0
				CoordenadaZ2 = 0.0
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
	blipentregafinal = AddBlipForCoord(locentregafinal[destino].x,locentregafinal[destino].y,locentregafinal[destino].z)
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

--function spawnVehicle2(name)
--	mhash2 = GetHashKey(name)
--	while not HasModelLoaded(mhash2) do
--		RequestModel(mhash2)
--		Citizen.Wait(10)
--	end
--
--	if HasModelLoaded(mhash2) then
--		nveh2 = CreateVehicle(mhash2,cfg.posicoes['carreta'][2]+0.5,270.90,true,false)
--
--		SetVehicleOnGroundProperly(nveh2)
--		SetVehicleNumberPlateText(nveh2,vRP.getRegistrationNumber())
--		SetEntityAsMissionEntity(nveh2,true,true)
--
--		SetModelAsNoLongerNeeded(mhash2)
--	end
--end

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
