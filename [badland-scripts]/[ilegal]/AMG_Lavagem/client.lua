-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = Tunnel.getInterface("AMG_Lavagem")

local lavarYakuza = true
local dinheirolavadoYakuza = false
local quantia = 0
local calcporcentagem = 0

---////////////////////////////////////////////////////////////
--- LAVAR DINHEIRO SUJO
---////////////////////////////////////////////////////////////
Citizen.CreateThread(function()
	while true do
		tempo = 1000
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1580.72,-30.02,53.45, true ) < 2.5 then
			tempo = 1
			if lavarYakuza then
				DrawText3Ds(-1580.72,-30.02,53.45,"PRESSIONE ~r~E~w~ LAVAR DINHEIRO")
				DrawMarker(21,-1580.72,-30.02,53.45-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if IsControlJustPressed(0,38) and oC.checkPermissionYakuza() then
					TriggerServerEvent("AMG_Lavagem:calcularporcentagem", "Yakuza")
					lavarYakuza = false
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)

---////////////////////////////////////////////////////////////
--- PEGAR DINHEIRO LIMPO
---////////////////////////////////////////////////////////////
Citizen.CreateThread(function()
	while true do
		tempo = 1000
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1580.72,-30.02,53.45, true ) < 2.5 then
			tempo = 1 
			if not lavarYakuza and dinheirolavadoYakuza then
				DrawText3Ds(-1580.72,-30.02,53.45,"PRESSIONE ~r~E~w~ PEGAR DINHEIRO LIMPO")
				DrawMarker(21,-1580.72,-30.02,53.45-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if IsControlJustPressed(0,38) and oC.checkPermissionYakuza() then
					TriggerServerEvent("AMG_Lavagem:receberpagamento", quantia2Yakuza, calcporcentagem2Yakuza, "Yakuza")
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)

---////////////////////////////////////////////////////////////
--- CHECAR LAVAGEM
---////////////////////////////////////////////////////////////
Citizen.CreateThread(function()
	while true do
		TriggerServerEvent("AMG_Lavagem:verificalavagem")
		tempo = 60000
		Citizen.Wait(tempo)
	end
end)

---////////////////////////////////////////////////////////////
--- AGUARDAR LAVAGEM
---////////////////////////////////////////////////////////////
RegisterNetEvent("AMG_Lavagem:aguardarlavegemYakuza")
AddEventHandler('AMG_Lavagem:aguardarlavegemYakuza',function()
	lavarYakuza = false
end)

---////////////////////////////////////////////////////////////
--- LAVAGEM CONCLUIDA
---////////////////////////////////////////////////////////////
RegisterNetEvent('AMG_Lavagem:lavagemconcluidaYakuza')
AddEventHandler('AMG_Lavagem:lavagemconcluidaYakuza',function(quantia, calcporcentagem)
	quantia2Yakuza = quantia
	calcporcentagem2Yakuza = calcporcentagem
	dinheirolavadoYakuza = true
end)

---////////////////////////////////////////////////////////////
--- TAXA NAO ACEITA
---////////////////////////////////////////////////////////////
RegisterNetEvent('AMG_Lavagem:taxanaoaceitaYakuza')
AddEventHandler('AMG_Lavagem:taxanaoaceitaYakuza',function()
	lavarYakuza = false
	minutos = math.random(2,5)
	tempomilisegundos = minutos*60*1000
	TriggerEvent("Notify","importante","Agora você só pode lavar daqui "..minutos.." minutos") 
	Citizen.Wait(tempomilisegundos)
	lavarYakuza = true
end)


---////////////////////////////////////////////////////////////
--- RESETAR VIDA
---////////////////////////////////////////////////////////////
RegisterNetEvent('AMG_Lavagem:resetvida')
AddEventHandler('AMG_Lavagem:resetvida',function()
	local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped, 0)
    local distance = GetDistanceBetweenCoords(-1580.72,-30.02,53.45, pedCoords['x'], pedCoords['y'], pedCoords['z'], true)
    if distance <= 1.2 then
		TriggerServerEvent("AMG_Lavagem:resetvidaSV")
	end
end)

---////////////////////////////////////////////////////////////
--- FUNÇÕES
---////////////////////////////////////////////////////////////
RegisterNetEvent('AMG_Lavagem:pegoudinheiroYakuza')
AddEventHandler('AMG_Lavagem:pegoudinheiroYakuza',function()
	dinheirolavadoYakuza = false
	lavarYakuza = true
	ClearPedTasks(PlayerPedId())
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
