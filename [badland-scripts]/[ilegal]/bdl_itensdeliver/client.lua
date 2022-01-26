local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("bdl_itensdeliver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local processo = false 
local segundos = 0


local factory = {
	{ ['x'] = -970.24, ['y'] = -1431.39, ['z'] = 7.68, ['posicao'] = 1 }, --fabricar lockpick
	{ ['x'] = 660.13, ['y'] = 592.72, ['z'] = 129.24, ['posicao'] = 2 }, --fabricar placa de carro
	{ ['x'] = 1143.13, ['y'] = -299.37, ['z'] = 68.81, ['posicao'] = 3 }, --fabricar Jammer
	{ ['x'] = -318.64, ['y'] = 150.59, ['z'] = 67.41, ['posicao'] = 4 }, --fabricar algemas
	{ ['x'] = 464.23, ['y'] = -735.95, ['z'] = 26.51, ['posicao'] = 5 }, --fabricar capuz
	{ ['x'] = -428.66, ['y'] = -1728.34, ['z'] = 19.79, ['posicao'] = 6 }, --fabricar colete

	{ ['x'] = 1309.58, ['y'] = 4384.39, ['z'] = 42.06, ['posicao'] = 1 }, --fabricar lockpick
	{ ['x'] = -64.18, ['y'] = -1223.92, ['z'] = 28.78, ['posicao'] = 2 }, --fabricar placa de carro
	{ ['x'] = 660.89, ['y'] = 1282.72, ['z'] = 360.3, ['posicao'] = 3 }, --fabricar Jammer
	{ ['x'] = 191.32, ['y'] = 3082.16, ['z'] = 43.48, ['posicao'] = 4 }, --fabricar algemas
	{ ['x'] = 15.72, ['y'] = 3688.28, ['z'] = 39.58, ['posicao'] = 5 }, --fabricar capuz
	{ ['x'] = -1585.65, ['y'] = -838.0, ['z'] = 9.96, ['posicao'] = 6 }, --fabricar colete
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] =-308.83102416992, ['y'] = 6301.7563476562, ['z'] = 32.489311218262 },
	[2] = { ['x'] =-2554.0383300781, ['y'] = 1911.9188232422, ['z'] = 168.96308898926 },
	[3] = { ['x'] =403.30596923828, ['y'] = 2584.4790039062, ['z'] = 43.519504547119 },
	[4] = { ['x'] =1946.1986083984, ['y'] = 3848.5051269531, ['z'] = 32.168800354004 },
	[5] = { ['x'] =2415.6721191406, ['y'] = 5005.1206054688, ['z'] = 46.685199737549 },
	[6] = { ['x'] =2354.8713378906, ['y'] = 2567.7204589844, ['z'] = 46.61291885376 },
	[7] = { ['x'] =174.20697021484, ['y'] = 484.05276489258, ['z'] = 142.40306091309 },
	[8] = { ['x'] =-1665.9332275391, ['y'] = -442.57888793945, ['z'] = 40.038597106934 },
	[9] = { ['x'] =-1254.9315185547, ['y'] = -1330.5341796875, ['z'] = 4.0736088752747 },
	[10] = { ['x'] =-37.20051574707, ['y'] = -1447.5657958984, ['z'] = 31.498020172119 },
	[11] = { ['x'] =1337.6453857422, ['y'] = -1527.5190429688, ['z'] = 53.91996383667 },
	[12] = { ['x'] =460.45657348633, ['y'] = -759.48077392578, ['z'] = 27.357799530029 },
	[13] = { ['x'] =-125.91371917725, ['y'] = 1895.1654052734, ['z'] = 197.33280944824 },
	[14] = { ['x'] = 315.15, ['y'] = -128.23, ['z'] = 69.98 },
	[15] = { ['x'] = 660.21, ['y'] = 263.73, ['z'] = 102.7 },
	[16] = { ['x'] = 1144.57, ['y'] = -299.53, ['z'] = 68.81 },
	[17] = { ['x'] = 815.86, ['y'] = 542.69, ['z'] = 125.93 },
	[18] = { ['x'] = 1915.55, ['y'] = 582.71, ['z'] = 176.37 },
	[19] = { ['x'] = 852.16, ['y'] = -1163.81, ['z'] = 25.75 },
	[20] = { ['x'] = 747.68, ['y'] = -1214.99, ['z'] = 24.75 },
	[21] = { ['x'] = 576.11, ['y'] = -1635.89, ['z'] = 25.99 },
	[22] = { ['x'] = 750.4, ['y'] = -1697.44, ['z'] = 29.79 },
	[23] = { ['x'] = 903.03, ['y'] = -1721.93, ['z'] = 32.25 },
	[24] = { ['x'] = 1437.37, ['y'] = -1491.92, ['z'] = 63.63 },
	[25] = { ['x'] = 1122.85, ['y'] = -1304.6, ['z'] = 34.72 },
	[26] = { ['x'] = 1120.82, ['y'] = -1523.72, ['z'] = 34.85 },
	[27] = { ['x'] = 765.77, ['y'] = -1643.25, ['z'] = 30.09 },
	[28] = { ['x'] = 743.88, ['y'] = -1906.03, ['z'] = 29.42 },
	[29] = { ['x'] = 888.93, ['y'] = -1959.98, ['z'] = 30.66 },
	[30] = { ['x'] = 1620.58, ['y'] = -2258.42, ['z'] = 106.67 },
	[31] = { ['x'] = 1219.3, ['y'] = -3200.39, ['z'] = 5.53 },
	[32] = { ['x'] = 1230.45, ['y'] = -2911.39, ['z'] = 9.32 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if not servico then
			for k,v in pairs(factory) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local distance = Vdist(v.x,v.y,v.z,x,y,z)
				local factory = factory[k]

				if distance <= 3 then
					idle = 5
					DrawMarker(23,factory.x, factory.y, factory.z-1,0,0,0,0,180.0,130.0,1.2,1.2,1.2,50,50,50,50,0,0,0,1)
					DrawText3D(factory.x, factory.y, factory.z,"[~c~E~w~] Para ~c~INICIAR~w~ rota de itens para ILEGAIS")
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) and vSERVER.ItemPermit(factory.posicao) then
							cancelDeliver()
							servico = true
							selecionado = math.random(32)
							CriandoBlip(locs,selecionado)
							TriggerEvent("Notify","sucesso","Você entrou em serviço.")
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			
			if distance <= 10 then
				idle = 5
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,50,50,50,50,0,0,0,1)
				DrawText3D(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,"[~c~E~w~] Para ~c~COLETAR~w~ as peças.")
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							while true do
								if backentrega == selecionado then
									selecionado = math.random(32)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
function cancelDeliver()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			if servico then
				if IsControlJustPressed(0,168) then
					servico = false
					RemoveBlip(blips)
					TriggerEvent("Notify","aviso","Você saiu de serviço.")
				end
				if IsPedInAnyVehicle(PlayerPedId()) then
					drawTxt("PRESSIONE ~r~F7~w~ PARA ENCERRAR O SERVIÇO",4,0.218,0.963,0.35,255,255,255,120)
				else
					drawTxt("PRESSIONE ~r~F7~w~ PARA ENCERRAR O SERVIÇO",4,0.068,0.963,0.35,255,255,255,120)
				end
			else
				break
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Peças de Armas")
	EndTextCommandSetBlipName(blips)
end