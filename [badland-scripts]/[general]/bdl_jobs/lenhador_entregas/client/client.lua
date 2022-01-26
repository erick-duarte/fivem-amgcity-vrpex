local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emPLenEnt = Tunnel.getInterface("lenhador_entregas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 1218.74
local CoordenadaY = -1266.87
local CoordenadaZ = 36.42
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1408.65, ['y'] = -734.98, ['z'] = 67.69 },
	[2] = { ['x'] = 1210.62, ['y'] = -1309.52, ['z'] = 35.22 },
	[3] = { ['x'] = 1561.41, ['y'] = -1693.56, ['z'] = 89.21 },
	[4] = { ['x'] = 557.64, ['y'] = -2328.00, ['z'] = 5.82 },
	[5] = { ['x'] = -1097.71, ['y'] = -1649.72, ['z'] = 4.39 },
	[6] = { ['x'] = -2016.37, ['y'] = 559.32, ['z'] = 108.30 },
	[7] = { ['x'] = -663.58, ['y'] = 222.33, ['z'] = 81.95 },
	[8] = { ['x'] = 141.28, ['y'] = -379.58, ['z'] = 43.25 },
	[9] = { ['x'] = 23.99, ['y'] = -619.81, ['z'] = 35.34 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				tempo = 1
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.97,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR O TRABALHO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = math.random(9)
						CriandoBlipLenhador(locs,selecionado)
						spawnVehicle()
						TriggerEvent("lenhador_coletar:permitircoleta")
						TriggerEvent("Notify","sucesso","Trabalho iniciado.")
						TriggerEvent("Notify","importante","Vá até a floresta para colher <b>Tora de Madeira</b>.", 3000)
						Citizen.Wait(3000)
						TriggerEvent("Notify","importante","Você precisa de <b>Machado</b> para ir há floresta. Pode ser comprado na <b>Ammunation</b>", 3000)
						Citizen.Wait(3000)
						TriggerEvent("Notify","aviso","Depois faça a entrega no local indicado no mapa.", 3000)
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				tempo = 1
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.3,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA ENTREGAR TORAS DE MADEIRA",4,0.5,0.93,0.50,255,255,255,255)
					if IsControlJustPressed(0,38) then
						if emPLenEnt.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(9)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlipLenhador(locs,selecionado)
						end
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if servico then
			tempo = 1
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				--emP.removeEmprego()
				TriggerEvent("lenhador_coletar:cancelarcoleta")
				TriggerEvent('deletarveiculo',nveh)
				TriggerEvent("Notify","negado","Você encerrou o trabalho.")
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicle()
	mhash = GetHashKey("Sadler")
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		nveh = CreateVehicle(mhash,1205.5858154297,-1265.5639648438,35.22673034668+0.5,270.90,true,false)

		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,true)

		SetModelAsNoLongerNeeded(mhash)
	end
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

function CriandoBlipLenhador(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
--	SetBlipSprite(blips,1)
	SetBlipSprite(blips,2)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Madeira")
	EndTextCommandSetBlipName(blips)
end