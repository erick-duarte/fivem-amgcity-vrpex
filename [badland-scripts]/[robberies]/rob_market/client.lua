-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("rob_market",src)
vSERVER = Tunnel.getInterface("rob_market")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
local robmark = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['x'] = 2549.20, ['y'] = 384.92, ['z'] = 108.62 },
	[2] = { ['x'] = -709.18, ['y'] = -904.26, ['z'] = 19.21 },
	[3] = { ['x'] = -3250.06, ['y'] = 1004.43, ['z'] = 12.83 },
--	[4] = { ['x'] = 1734.88, ['y'] = 6420.87, ['z'] = 35.03 },
	[5] = { ['x'] = 546.36, ['y'] = 2662.74, ['z'] = 42.15 },
	[6] = { ['x'] = 1160.16, ['y'] = -314.12, ['z'] = 69.20 },
	[7] = { ['x'] = 28.27, ['y'] = -1339.78, ['z'] = 29.49 },
	[8] = { ['x'] = 378.08, ['y'] = 332.77, ['z'] = 103.56 },
	[9] = { ['x'] = -1828.58, ['y'] = 799.10, ['z'] = 138.17 },
--AMMUNATION
	[10] = { ['x'] = 253.92, ['y'] = -51.98, ['z'] = 69.95 },
	[11] = { ['x'] = -1304.31, ['y'] = -396.54, ['z'] = 36.7 },
	[12] = { ['x'] = -660.64, ['y'] = -933.08, ['z'] = 21.83 },
	[13] = { ['x'] = 24.61, ['y'] = -1105.61, ['z'] = 29.8 },
	[14] = { ['x'] = 840.5, ['y'] = -1035.58, ['z'] = 28.2 },
	[15] = { ['x'] = 808.95, ['y'] = -2159.71, ['z'] = 29.62 },
--AÇOUGUE
	[16] = { ['x'] = 990.86, ['y'] = -2149.65, ['z'] = 30.21},
--GALINHEIRO
	[17] = { ['x'] = -68.24, ['y'] = 6253.72, ['z'] = 31.1 },
--TEATRO
	[18] = { ['x'] = -1087.33, ['y'] = -563.36, ['z'] = 34.71 },
--BARBEARIA
	[19] = { ['x'] = 138.51, ['y'] = -1703.86, ['z'] = 29.3 },
-- LOS SANTOS
	[20] = { ['x'] = -345.04, ['y'] = -123.0, ['z'] = 39.01 },
-- JOALHERIA
	[21] = { ['x'] = -622.47, ['y'] = -229.85, ['z'] = 38.06 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		if not robbery then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 1.1 and GetEntityHealth(ped) > 101 then
					sleep = 5
					DrawText3D(v.x,v.y,v.z, "[~r~E~w~] Para ~r~INICIAR~w~ o roubo.")
					if IsControlJustPressed(0,38) and timedown <= 0 then
						timedown = 3
						if vSERVER.checkPolice(k) then
							vSERVER.startRobbery(k,v.x,v.y,v.z)
						end
					end
				end
			end
		elseif robbery then
			sleep = 5
			drawText("PARA CANCELAR O ROUBO SAIA PELA PORTA DA FRENTE",4,0.5,0.88,0.36,255,255,255,50)
			drawText("AGUARDE ~g~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			if GetEntityHealth(PlayerPedId()) <= 101 then
				robbery = false
				vSERVER.stopRobbery()
				timedown = 0
				TriggerEvent("Notify","negado","Roubo cancelado, você morreu.")
			end
		else
			break
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(time,x2,y2,z2)
	robbery = true
	timedown = time
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			local sleep = 1000
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,x2,y2,z2)
			if distance >= 10.0 then
				sleep = 5
				robbery = false
				vSERVER.stopRobbery()
				timedown = 0
				TriggerEvent("Notify","negado","Roubo cancelado, você se afastou de mais.")
				break
			end
			Citizen.Wait(sleep)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobberyPolice(x,y,z,localidade)
	if not DoesBlipExist(robmark) then
		robmark = AddBlipForCoord(x,y,z)
		SetBlipScale(robmark,0.5)
		SetBlipSprite(robmark,161)
		SetBlipColour(robmark,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: "..localidade)
		EndTextCommandSetBlipName(robmark)
		SetBlipAsShortRange(robmark,false)
		SetBlipRoute(robmark,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobberyPolice()
	if DoesBlipExist(robmark) then
		RemoveBlip(robmark)
		robmark = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timedown >= 1 then
			timedown = timedown - 1
			if timedown == 0 then
				robbery = false
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- [ FUNÇÃO DO TEXTO 3D ] --
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end