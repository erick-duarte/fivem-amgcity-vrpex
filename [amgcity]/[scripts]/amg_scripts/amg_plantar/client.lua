local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("amg_plantar")
src = {}
Tunnel.bindInterface("amg_plantar",src)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Variaveis
-----------------------------------------------------------------------------------------------------------------------------------------
local syncPlantacao = {}
local atualizarPlantacao = {}
local progressPlantacao = {}
local atualizando = false
local ativarwhile = false
local attCoordX = nil
local attCoordY = nil
local attCoordZ = nil
local attCoordAll = nil
local attResultID = nil
local attFasePlantacao = nil
local hash = nil
local fasePlant = 0
local hashSmall = GetHashKey('bkr_prop_weed_01_small_01a')
local hashMedium = GetHashKey('bkr_prop_weed_med_01a')
local hashBig = GetHashKey('bkr_prop_weed_lrg_01a')

function src.syncPlantacao(data)
	syncPlantacao = data
end

function src.deleteSyncPlantacao(hashPlantacao)
	Citizen.InvokeNative(0xAD738C3085FE7E11,hashPlantacao,true,true)
	SetObjectAsNoLongerNeeded(Citizen.PointerValueIntInitialized(hashPlantacao))
	DeleteObject(hashPlantacao)
end

function src.attPlantacao(data)
	atualizarPlantacao = data
	for k,v in pairs(atualizarPlantacao) do
		if v ~= nil then

			vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
			Citizen.Wait(500)
			vRP._stopAnim(false)
			TriggerEvent("cancelando",false)

			progressPlantacao[k] = 0
			attOldHash = k
			attCoordAll = v.coordPlantacao
			attCoordX = v.coordPlantacao.x
			attCoordY = v.coordPlantacao.y
			attCoordZ = v.coordPlantacao.z
			attResultID = v.resultID
			attFasePlantacao = v.fasePlantacao
			attStatusProgress = v.statusProgress
			ativarwhile = true

			Citizen.CreateThread(function()
				while ativarwhile do
					local idle = 1000
					for z,y in pairs(progressPlantacao) do
						if y ~= nil and y < 100 then
							idle = 5
							progressPlantacao[z] = y + 1
							if progressPlantacao[z] > 99 then

								if attFasePlantacao == 3 then
									hash = hashBig
									fasePlant = 3
								elseif attFasePlantacao == 2 then
									hash = hashMedium
									fasePlant = 2
								end
			
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									RequestModel(hash)
									Citizen.Wait(10)
								end
								syncPlantacao[attOldHash] = { coordPlantacao = attCoordAll, fasePlantacao = attFasePlantacao, resultID = attResultID, statusProgress = false }
								emP.reSyncDelete(attOldHash)
								emP.reSync(attOldHash)
								local hashPlantacao = CreateObject(hash,attCoordX,attCoordY-0.5,attCoordZ,true,true,true)
								PlaceObjectOnGroundProperly(hashPlantacao)
								SetModelAsNoLongerNeeded(hashPlantacao)
								Citizen.InvokeNative(0xAD738C3085FE7E11,hashPlantacao,true,true)
								SetEntityHeading(hashPlantacao,GetEntityHeading(PlayerPedId()))
								FreezeEntityPosition(hashPlantacao,true)
								Citizen.Wait(500)
								emP.syncPlantacao(hashPlantacao, attCoordAll, fasePlant, attResultID, false)
								attCoordAll = nil
								attCoordX = nil
								attCoordY = nil
								attCoordZ = nil
								attResultID = nil
								ativarwhile = false
								progressPlantacao = {}
								atualizarPlantacao = {}
								break
							else
								text3D(attCoordX,attCoordY-0.5,attCoordZ,""..progressPlantacao[z].."%")
							end
						else
							break
						end
					end
					Citizen.Wait(idle)
				end
			end)			
		end
	end
end

RegisterCommand("plantar",function(source,args)
	local coordPlantacao = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
	local h = GetEntityHeading(PlayerPedId())
	if emP.iniciarPlantacao() and not IsPedInAnyVehicle(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
		
		vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
		Citizen.Wait(500)
		vRP._stopAnim(false)
		TriggerEvent("cancelando",false)

		RequestModel(hashSmall)
		while not HasModelLoaded(hashSmall) do
			RequestModel(hashSmall)
			Citizen.Wait(10)
		end

		local hashObject = CreateObject(hashSmall,coordPlantacao.x,coordPlantacao.y-0.5,coordPlantacao.z,true,true,true)
		PlaceObjectOnGroundProperly(hashObject)
		SetModelAsNoLongerNeeded(hashObject)
		Citizen.InvokeNative(0xAD738C3085FE7E11,hashObject,true,true)
		SetEntityHeading(hashObject,h)
		FreezeEntityPosition(hashObject,true)
		emP.syncPlantacao(hashObject, coordPlantacao, 1, 0, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local coord = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,1.0,-0.94)
		for k,v in pairs(syncPlantacao) do
			if v ~= nil then
				local distance = Vdist(coord.x,coord.y,coord.z,v.coordPlantacao.x,v.coordPlantacao.y,v.coordPlantacao.z)
				if v.fasePlantacao == 1 then 
					if distance <= 5 and not v.statusProgress then
						idle = 5
						text3D(v.coordPlantacao.x,v.coordPlantacao.y,v.coordPlantacao.z,"[~p~E~w~] para colocar ~p~FERTILIZAR~w~.")
						if distance <= 1.2 then
							idle = 5
							if 	IsControlJustPressed(1,38) then
								local fasePlantacao = v.fasePlantacao + 1
								atualizarPlantacao[k] = { coordPlantacao = v.coordPlantacao, fasePlantacao = fasePlantacao, resultID = v.resultID, statusProgress = true }
								syncPlantacao[k] = { coordPlantacao = v.coordPlantacao, fasePlantacao = v.fasePlantacao, resultID = v.resultID, statusProgress = true }
								emP.syncProgress(syncPlantacao)
								src.attPlantacao(atualizarPlantacao)
							end
						end
					end
				end
				if v.fasePlantacao == 2 then 
					if distance <= 5 and not v.statusProgress then
						idle = 5
						text3D(v.coordPlantacao.x,v.coordPlantacao.y,v.coordPlantacao.z,"[~p~E~w~] para colocar ~p~ADUBAR~w~.")
						if distance <= 1.2 and not atualizando then
							idle = 5
							if 	IsControlJustPressed(1,38) then
								local fasePlantacao = v.fasePlantacao + 1
								atualizarPlantacao[k] = { coordPlantacao = v.coordPlantacao, fasePlantacao = fasePlantacao, resultID = v.resultID, statusProgress = true }
								syncPlantacao[k] = { coordPlantacao = v.coordPlantacao, fasePlantacao = v.fasePlantacao, resultID = v.resultID, statusProgress = true }
								emP.syncProgress(syncPlantacao)
								src.attPlantacao(atualizarPlantacao)
							end
						end
					end
				end
				if v.fasePlantacao == 3 then
					if distance <= 5 and not v.statusProgress then
						idle = 5
						text3D(v.coordPlantacao.x,v.coordPlantacao.y,v.coordPlantacao.z,"[~p~E~w~] para colocar ~p~COLHER~w~.")
						if distance <= 1.2 and not atualizando then
							idle = 5
							if 	IsControlJustPressed(1,38) then
								local fasePlantacao = v.fasePlantacao + 1
								syncPlantacao[k] = { coordPlantacao = v.coordPlantacao, fasePlantacao = v.fasePlantacao, resultID = v.resultID, statusProgress = true }
								emP.syncProgress(syncPlantacao)
								vRP._playAnim(false,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
								Citizen.Wait(500)
								vRP._stopAnim(false)
								TriggerEvent("cancelando",false)
								emP.colherPlantacao(k, v.coordPlantacao, fasePlantacao, v.resultID)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
  	end
end)

function text3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = (string.len(text) + 4) / 170 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,38,42,56,200)
	end
end