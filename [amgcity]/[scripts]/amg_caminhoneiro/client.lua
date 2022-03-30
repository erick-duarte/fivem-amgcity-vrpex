local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("amg_caminhoneiro")

emPserver = {}
Tunnel.bindInterface("amg_caminhoneiro",emPserver)

cfg = module("amg_caminhoneiro", "config")

local blips, blipentregafinal, entregafinal, entregaencomenda, servico, servicoNormal, servicoEncomenda, encomendaNConluida = false
local servehicle, caminhao, truckTrailer, nveh, carga, numberLocalizacao, nomeMercadoria, nomePedido, nomeBau, numCNPJ = nil
local coordenadas = 0.0
local delay = 0
local qtdEncomendas = 0

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
	carga = data
	if servico then
		TriggerEvent("Notify","negado","Você já pegou uma carga")
		ToggleActionMenu()
	else
		if data == 'fechar' then
			ToggleActionMenu()

		elseif delay <= 0 then

			for k,v in pairs(cfg.encomendas) do
				if data == k and v.cnpj > 0 then
					qtdEncomendas = emP.checkEncomenda(v.cnpj,v.mercadorias)
					ToggleActionMenu()
					if qtdEncomendas ~= nil and qtdEncomendas > 0 then
						servicoEncomenda = true
						servico = true
						caminhao = v.veiculos.cavalo.hash
						nomeMercadoria = v.mercadorias 
						nomePedido = data
						nomeBau = v.nomeBau
						numCNPJ = v.cnpj
						spawnVehicle(caminhao,nil)
						numberLocalizacao = math.random(#v.locEncomenda)
						coordenadas = v.locEncomenda[numberLocalizacao][1]
						CriandoBlip(coordenadas,"Local da carga")
						--ToggleActionMenu()
						TriggerEvent("Notify","sucesso","Rota iniciada!")
					--else
					--	TriggerEvent("Notify","negado","Nenhuma encomenda disponivel")
					--	ToggleActionMenu()
					end
				elseif data == k then
					servicoNormal = true
					servico = true
					delay = cfg.encomendas.config.delay
					caminhao = v.veiculos.cavalo.hash
					servehicle = v.veiculos.carreta.hash
					spawnVehicle(caminhao,servehicle)
					coordenadas = v.locEntrega[math.random(#v.locEntrega)]
					CriandoBlip(coordenadas,"Entrega de Carga")
					ToggleActionMenu()
					TriggerEvent("Notify","sucesso","Rota iniciada!")
				end
			end
		else
			TriggerEvent("Notify","negado","Aguarde <b>"..delay.."</b> segundos, para pegar outra carga.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		tempo = 1000
		local ped = PlayerPedId()
		local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),cfg.encomendas.inicio.localizacao,true)
		if distance <= 10 and not servico and not entregafinal and not entregaencomenda then
			tempo = 1
			DrawMarker(39,cfg.encomendas.inicio.localizacao-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
			if distance <= 1.2 then
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end

		if servico and not entregafinal and not entregaencomenda then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(coordenadas,x,y,z,true)
			if distance <= 100.0 then
				tempo = 1
				if IsPedInAnyVehicle(PlayerPedId()) then
					DrawMarker(21,coordenadas-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
				end
				if distance <= 20.0 then
					if servicoEncomenda and not entregaencomenda then
						if IsPedInAnyVehicle(PlayerPedId()) then
							drawTxt("DESÇA DO CAMINHÃO E PEGUE A ENCOMENDA",4,0.5,0.93,0.50,255,255,255,180)
						else
							for k,v in pairs(cfg.encomendas) do
								if nomePedido == k then
									DrawMarker(39,v.locEncomenda[numberLocalizacao][2]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
									local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),v.locEncomenda[numberLocalizacao][2],true)
									if distance <= 1.5 then
										drawTxt("PRESSIONE  ~b~E~w~  PARA PEGAR A MERCADORIA",4,0.5,0.93,0.50,255,255,255,180)
										if IsControlJustPressed(0,38) then
											local vehicle = GetPlayersLastVehicle()
											if GetEntityModel(vehicle) == caminhao then
												--if emP.pegarEncomenda(nomeMercadoria) then
													RemoveBlip(blip)
													CriandoBlip(v.locEntrega)
													entregaencomenda = true
													TriggerEvent("Notify","sucesso","Você pegou a encomenda, agora vá até o ponto de entrega")
												--end
											else
												TriggerEvent("Notify","negado","Você está com o caminhão errado",5000)
											end
										end
									end
								end
							end
						end
					
					elseif servicoNormal then
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
									CriandoBlip(cfg.encomendas.final.localizacao,cfg.encomendas.final.mensagem)
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
		end

		if servico and entregaencomenda and not entregafinal then		
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				for k,v in pairs(cfg.encomendas) do
					if nomePedido == k then
						local distance = GetDistanceBetweenCoords(v.locEntrega,x,y,z,true)
						if distance <= 100.0 then
							tempo = 1
							DrawMarker(21,v.locEntrega-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
							if distance <= 6.0 then
								drawTxt("PRESSIONE  ~b~E~w~  PARA DEIXAR A ENCOMENDA",4,0.5,0.93,0.50,255,255,255,180)
								if IsControlJustPressed(0,38) then
									local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
									if GetEntityModel(vehicle) == caminhao then
										if emP.deixarEncomenda(nomeMercadoria,nomeBau) then
											TriggerEvent("Notify","sucesso","Entrega efetuada")
											Citizen.Wait(1000)
											TriggerEvent("Notify","importante","Volte até a central do caminhoneiro, para deixar o caminhão e receber o seu dinheiro.")
											RemoveBlip(blip)
											CriandoBlip(cfg.encomendas.final.localizacao)
											entregafinal = true
										--else 
										--	TriggerEvent("Notify","negado","Você esta sem a mercadoria. Entrega foi cancelada e voce nao recebera nada.")
										--	Citizen.Wait(1000)
										--	TriggerEvent("Notify","importante","Volte ate a central do caminhoneiro, para deixar o caminhao.")
										--	RemoveBlip(blip)
										--	CriandoBlip(cfg.encomendas.final.localizacao)
										--	entregafinal = true
										--	encomendaNConluida = true
										end
									else
										TriggerEvent("Notify","negado","Você está com o caminhão errado",5000)
									end
								end
							end
						end
					end
				end
		end

		if servico and entregafinal then --ENTREGA FINAL
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(cfg.encomendas.final.localizacao,x,y,z,true)
			if distance <= 100.0 then
				tempo = 1
				DrawMarker(21,cfg.encomendas.final.localizacao-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,100,0,0,0,1)
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
							if entregaencomenda then
								emP.checkPayment(true)
							else
								emP.checkPayment(false)
								delay = cfg.encomendas.config.delay
							end
							RemoveBlip(blips)
							RemoveBlip(blipentregafinal)
							Citizen.Wait(1)
							blips, blipentregafinal, entregafinal, entregaencomenda, servico, servicoNormal, servicoEncomenda, encomendaNConluida = false
							servehicle, caminhao, truckTrailer, nveh, carga, numberLocalizacao, nomeMercadoria, nomePedido, nomeBau, numCNPJ = nil
							coordenadas = 0.0
							qtdEncomendas = 0
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
		if delay > 0 then
			delay = delay - 1
		end
		Citizen.Wait(1000)
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
				RemoveBlip(blips)
				if entregafinal then
					RemoveBlip(blipentregafinal)
				end
				Citizen.Wait(1)
				TriggerEvent('deletarveiculo',truckTrailer)
				TriggerEvent('deletarveiculo',nveh)
				if servicoEncomenda and not entregafinal then
					emP.retornaPedidos(numCNPJ, nomeMercadoria)
				end
				blips, blipentregafinal, entregafinal, entregaencomenda, servico, servicoNormal, servicoEncomenda, encomendaNConluida = false
				servehicle, caminhao, truckTrailer, nveh, carga, numberLocalizacao, nomeMercadoria, nomePedido, nomeBau, numCNPJ = nil
				coordenadas = 0.0
				qtdEncomendas = 0
				TriggerEvent("Notify","negado","Entrega cancelada",5000)
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

function CriandoBlip(localizacao,mensagem)
	blips = AddBlipForCoord(localizacao)
	SetBlipSprite(blips,2)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(mensagem)
	EndTextCommandSetBlipName(blips)
end

function spawnVehicle(mhash,thash)
	local checkslot = 1

	RequestModel(mhash)
	while not HasModelLoaded(mhash) do
	  Citizen.Wait(10)
	end

	if thash ~= nil then
		RequestModel(thash)
		while not HasModelLoaded(thash) do
		  Citizen.Wait(10)
		end
	end

	local checkPos = GetClosestVehicle(cfg.posicoes.cavalo[checkslot],3.001,0,71)
	if DoesEntityExist(checkPos) and checkPos ~= nil then
		checkslot = checkslot + 1
		if checkslot > #cfg.posicoes.cavalo then
			checkslot = -1
			TriggerEvent("Notify","importante","Todas as vagas estão ocupadas no momento.",10000)
		end
	end

	if checkslot ~= -1 then
		nveh = CreateVehicle(mhash,cfg.posicoes.cavalo[checkslot]+0.5,270.90,true,false)
		if thash ~= nil then
			truckTrailer = CreateVehicle(thash,1138.21,-3259.25,5.91+0.5,270.90,true,false)
		end
		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,true)
		AttachVehicleToTrailer(nveh,truckTrailer,15.0)
		SetModelAsNoLongerNeeded(mhash)
		SetModelAsNoLongerNeeded(thash)
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