local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_motorista")
vRP = Proxy.getInterface("vRP")
vCLIENT = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local empontofinal = false
local aguardar = false
local segundos = 0
local CoordenadaX = 453.48
local CoordenadaY = -607.74
local CoordenadaZ = 28.57
local entregas = {}
local destinogeral = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local rota1 = {
	[1] = { x=59.458339691162, y=-656.99877929688, z=31.478841781616},
	[2] = { x=244.32598876954, y=-860.48010253906, z=29.513933181762},
	[3] = { x=396.3427734375, y=-989.68878173828, z=29.35901260376},
	[4] = { x=316.91091918946, y=-1037.778930664, z=29.147840499878},
	[5] = { x=137.44903564454, y=-998.47998046875, z=29.277128219604},
	[6] = { x=65.319869995118, y=-1320.1589355468, z=29.239622116088},
	[7] = { x=311.73022460938, y=-1374.1730957032, z=31.842464447022},
	[8] = { x=231.94017028808, y=-1205.6857910156, z=29.25450515747},
	[9] = { x=-112.00253295898, y=-1269.9616699218, z=29.270318984986},
	[10] = { x=-997.1392211914, y=-2450.3061523438, z=13.668216705322},
	[11] = { x=-1005.7689208984, y=-2738.1594238282, z=13.711832046508},
	[12] = { x=-147.3665008545, y=-1977.0242919922, z=22.737981796264},
	[13] = { x=-1619.392578125, y=-1009.0538330078, z=13.094560623168},
	[14] = { x=-1229.2353515625, y=-320.7622680664, z=37.493812561036},
	[15] = { x=-820.35986328125, y=-246.46408081054, z=37.023849487304},
	[16] = { x=-464.08782958984, y=-389.25704956054, z=33.820190429688},
	[17] = { x=263.2367553711, y=159.17547607422, z=104.51034545898},
	[18] = { x=307.90060424804, y=-262.50326538086, z=53.89889907837},
	[19] = { x=215.08837890625, y=-850.1748046875, z=30.24612236023}
}

local rota2 = {
	[1] = { x=61.241519927978, y=-657.33966064454, z=30.979085922242},
	[2] = { x=225.94511413574, y=-853.18426513672, z=29.400548934936},
	[3] = { x=1202.9096679688, y=-694.3609008789, z=59.66075515747},
	[4] = { x=1207.3872070312, y=-419.73999023438, z=66.989204406738},
	[5] = { x=975.30450439454, y=-469.71002197266, z=61.815948486328},
	[6] = { x=953.64483642578, y=-633.06982421875, z=56.826725006104},
	[7] = { x=1119.310546875, y=-232.43824768066, z=68.464363098144},
	[8] = { x=849.29052734375, y=-80.78816986084, z=79.90714263916},
	[9] = { x=918.83135986328, y=49.646732330322, z=80.32103729248},
	[10] = { x=1065.1870117188, y=456.03427124024, z=92.00294494629},
	[11] = { x=625.73181152344, y=230.57292175292, z=99.856063842774},
	[12] = { x=243.41395568848, y=486.1400756836, z=127.15687561036},
	[13] = { x=320.66983032226, y=972.24578857422, z=209.35559082032},
	[14] = { x=-204.806930542, y=1051.3146972656, z=233.44360351562},
	[15] = { x=-1325.0333251954, y=629.11614990234, z=135.54489135742},
	[16] = { x=-1261.335571289, y=462.744140625, z=93.79842376709},
	[17] = { x=-1197.8992919922, y=252.7615814209, z=67.179931640625},
	[18] = { x=-1641.1002197266, y=-308.0564880371, z=50.375301361084}, --cemiterio
	[19] = { x=-1370.6723632812, y=-985.08508300782, z=7.6999869346618},
	[20] = { x=-1167.5224609375, y=-1470.5142822266, z=3.7653348445892},
	[21] = { x=-1008.3854980468, y=-1636.953491211, z=3.86497092247},
	[22] = { x=-991.38317871094, y=-1140.2830810546, z=1.5558415651322},
	[23] = { x=-1142.7145996094, y=-823.09509277344, z=14.410474777222},
	[24] = { x=-806.8578491211, y=-1065.6768798828, z=11.501691818238},
	[25] = { x=-621.17584228516, y=-924.3607788086, z=22.47773361206},
	[26] = { x=-623.21911621094, y=-608.31726074218, z=32.66164779663},
	[27] = { x=-725.12658691406, y=-161.35815429688, z=36.42094039917},
	[28] = { x=-345.16122436524, y=-27.700841903686, z=46.923141479492},
	[29] = { x=119.31884002686, y=-193.88262939454, z=53.955940246582},
	[30] = { x=214.20761108398, y=-850.0150756836, z=29.689407348632}
}

local pontofinal = {
	[1] = { x=465.7850036621,y=-615.58569335938,z=28.499404907226} -- ponto final
}
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
	if data == "onibus-rota1" then
		ToggleActionMenu()
		entregas = rota1
		TriggerEvent("Notify","sucesso","Rota iniciada.")
		spawnVehicle("bus",463.54663085938,-606.59564208984,28.499711990356) 
		emservico = true
		destino = 1
		destinogeral = 19
		CriandoBlip(entregas,destino)
	elseif data == "onibus-rota2" then
		ToggleActionMenu()
		entregas = rota2
		TriggerEvent("Notify","sucesso","Rota iniciada.")
		spawnVehicle("bus",463.54663085938,-606.59564208984,28.499711990356) 
		emservico = true
		destino = 1
		destinogeral = 30
		CriandoBlip(entregas,destino)
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
--		if not emservico and segundos == 0 then
		if not emservico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if distance <= 15.0 then
				tempo = 1
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if emservico then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
			if distance <= 50 then
				tempo = 1
				DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z-0.1,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA CONTINUAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("bus")) then
							RemoveBlip(blip)
							if destino == destinogeral then
								TriggerEvent("Notify","aviso","Rota finalizada, volte para a Rodoviaria.")
								emservico = false
								RemoveBlip(blip)
								CriandoBlipPontoFinal(pontofinal,1)
								empontofinal = true
								emP.checkPayment(0)
							else
								destino = destino + 1
								emP.checkPayment(0)
								CriandoBlip(entregas,destino)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PONTO FINAL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if empontofinal then
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),pontofinal[1].x,pontofinal[1].y,pontofinal[1].z,true)
			if distance <= 50 then
				tempo = 1
				DrawMarker(21,pontofinal[1].x,pontofinal[1].y,pontofinal[1].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 2.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA FINALIZAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						emP.checkPayment(600)
						TriggerEvent("Notify","aviso","Rota finalizada, aguarde 5 minutos para inicar outra rota.")
						RemoveBlip(pontofinalblip)
						TriggerEvent('deletarveiculo',nveh)
						empontofinal = false
						aguardar = true
--						segundos = 300
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if emservico then
			tempo = 1
			if IsControlJustPressed(0,168) then
				emservico = false
				TriggerEvent('deletarveiculo',nveh)
				RemoveBlip(blip)
				TriggerEvent("Notify","negado","Rota cancelada")
			end
		end
		Citizen.Wait(tempo)
	end
end)

--Citizen.CreateThread(function()
--	while true do
--		if aguardar then
--			if segundos > 0 then
--				segundos = segundos - 1
--			end
--		end
--		Citizen.Wait(1000)
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicle(name,x,y,z)
	mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		nveh = CreateVehicle(mhash,x,y,z+0.5,212.45,true,false)

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

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
--	SetBlipSprite(blip,1)
	SetBlipSprite(blip,2)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Motorista")
	EndTextCommandSetBlipName(blip)
end

function CriandoBlipPontoFinal(pontofinal,destino)
	pontofinalblip = AddBlipForCoord(pontofinal[destino].x,pontofinal[destino].y,pontofinal[destino].z)
--	SetBlipSprite(pontofinalblip,1)
	SetBlipSprite(pontofinalblip,2)
	SetBlipColour(pontofinalblip,5)
	SetBlipScale(pontofinalblip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(pontofinalblip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Ponto Final")
	EndTextCommandSetBlipName(pontofinalblip)
end