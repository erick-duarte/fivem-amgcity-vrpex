local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vCLI = {}
Tunnel.bindInterface("vrp_tela",vCLI)
tvRP = Tunnel.getInterface("vrp")
vRPserver = Tunnel.getInterface("vrp")
vSERVER = Tunnel.getInterface("vrp_tela")

--=====================================================
local nocauteado = false
local deathtimer = 600

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		if GetEntityHealth(PlayerPedId()) <= 101 then
			if not nocauteado then
				sleep = 5
				deathtimer = 600
				vSERVER.checkDead(true)
				nocauteado = true
			end
			if deathtimer > 0 then
				SetPedToRagdoll(ped,1000,1000,0,0,0,0)
				BlockWeaponWheelThisFrame()
				SetEntityHealth(ped,101)
				SetNuiFocus(true,true)
				TransitionToBlurred(1000)
				SendNUIMessage({
					setDisplay = true,
					setDisplayDead = false,
					deathtimer = deathtimer
				})
			else
				SetNuiFocus(true,true)
				TransitionToBlurred(1000)
				SendNUIMessage({
					setDisplay = false,
					setDisplayDead = true,
					deathtimer = deathtimer
				})
			end
		elseif GetEntityHealth(PlayerPedId()) >= 101 and nocauteado then
			SetNuiFocus(false,false)
			TransitionFromBlurred(1000)
			deathtimer = 600
			vSERVER.checkDead(false)
			nocauteado = false
			SendNUIMessage({
				setDisplay = false,
				setDisplayDead = false,
				deathtimer = s
			})
			SetTimeout(5000,function()
					FreezeEntityPosition(ped,false)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
			end)
		end
		Citizen.Wait(sleep)
	end
end)
--============================================================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
--============================================================================================
local hospital = vector3(290.71+0.0001,-560.6+0.0001,43.26+0.0001) -- 311.76,-569.94,28.9
local heading = 82.58

RegisterNUICallback('ButtonRevive',function()
	SetEntityHealth(PlayerPedId(),250)
	deathtimer = 600
	nocauteado = false
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	TriggerServerEvent("clearInventory")
	ClearPedBloodDamage(PlayerPedId())
	SetEntityInvincible(ped,false)
	DoScreenFadeOut(1000)
	SetPedArmour(PlayerPedId(),0)
	Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), hospital.x, hospital.y, hospital.z + 0.20,1,0,0,1)
	SetEntityHeading(PlayerPedId(), heading)
	FreezeEntityPosition(PlayerPedId(),true)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	vSERVER.checkDead(false)
	SendNUIMessage({
		setDisplay = false,
		setDisplayDead = false,
		deathtimer = s
	})
	SetTimeout(5000,function()
		FreezeEntityPosition(PlayerPedId(),false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		vSERVER.checkPermissao()
	end)
end)


function vCLI.jailCombatLog()
	Citizen.Wait(3000)
	SetEntityCoords(PlayerPedId(), 3108.52, 1147.45, 17.48 + 0.20,1,0,0,1)
	TriggerEvent("Notify","aviso","Sistema de anti combat-log.")
	SetEntityHealth(PlayerPedId(),250)
	deathtimer = 600
	nocauteado = false
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	TriggerServerEvent("clearInventory")
	ClearPedBloodDamage(PlayerPedId())
	SetEntityInvincible(PlayerPedId(),false)
	DoScreenFadeOut(1000)
	SetPedArmour(PlayerPedId(),0)
	Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), hospital.x, hospital.y, hospital.z + 0.20,1,0,0,1)
	SetEntityHeading(PlayerPedId(), heading)
	FreezeEntityPosition(PlayerPedId(),true)
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	vSERVER.checkDead(false)
	SendNUIMessage({
		setDisplay = false,
		setDisplayDead = false,
		deathtimer = s
	})
	SetTimeout(5000,function()
		FreezeEntityPosition(PlayerPedId(),false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		vSERVER.checkPermissao()
	end)
end