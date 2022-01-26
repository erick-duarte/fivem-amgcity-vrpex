local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
estandepvp = Tunnel.getInterface("AMG_EstandePVP")

local entrarestande = { 
	{x=504.67575073242, y=-3169.4921875, z=6.0692663192749},
	{x=547.78283691406, y=-3169.3889160156, z=6.0692577362061},
	{x=584.25183105469, y=-3180.1635742188, z=6.0694737434387},
	{x=504.77587890625, y=-3213.0666503906, z=6.0692553520203},
	{x=549.04644775391, y=-3211.5668945312, z=6.0692567825317},
}

weapons = {
	"WEAPON_PISTOL", -- Beretta
	"WEAPON_PISTOL_MK2", -- Five
	"WEAPON_COMBATPISTOL", -- Glock

	"WEAPON_SMG", -- SMG
	"WEAPON_MICROSMG", -- UZI

	"WEAPON_COMPACTRIFLE", -- M4
	"WEAPON_CARBINERIFLE", -- M4
	"WEAPON_ASSAULTRIFLE", -- AK
	"WEAPON_SPECIALCARBINE", -- PARAFAL
	"WEAPON_MILITARYRIFLE", -- AUG
	
	"WEAPON_MG" -- PKM
}

local enterestandepvp = false
local estande1 = false
local estande2 = false
local estande3 = false
local estande4 = false
local locestande = 0
local estandemorto = false
local tempomorto = 5

local estaestande = false
local check = 1

Citizen.CreateThread(function()
	while true do
		local tempo = 10000
		estaestande = estandepvp.verificaDB()
		check = check + 1
		if estaestande and not enterestandepvp then
			TriggerEvent('Notify','importante','Estamos removendo você do <b>Estande PVP</b>')
			TriggerEvent("vrp_player:entrouestandepvp")
			TriggerEvent("vrp_inventory:entrouestandepvp")
			TriggerEvent("reviver:entrouestandepvp")
			TriggerEvent("vrp_radio:entrouestandepvp")
			TriggerEvent("CarryPeople:entrouestandepvp")
			TriggerServerEvent("AMG_Logs:entrouestandepvp")
			FreezeEntityPosition(PlayerPedId(), true)
		end
		if check >= 4 and estaestande and not enterestandepvp then
			locestande = 0
			estande1 = false
			estande2 = false
			estande3 = false
			estande4 = false
			enterestandepvp = false
			estaestande = false
			estandemorto = false
			TriggerEvent("vrp_player:saiuestandepvp")
			TriggerEvent("vrp_inventory:saiuestandepvp")
			TriggerEvent("reviver:saiuestandepvp")
			TriggerEvent("vrp_radio:saiuestandepvp")
			TriggerEvent("CarryPeople:saiuestandepvp")
			TriggerEvent('Notify','sucesso','Você saiu do estande')
			SetEntityCoords(GetPlayerPed(-1), 491.50637817383,-3171.8706054688,6.0695629119873)
			RemoveAllPedWeapons(PlayerPedId(),true)
			Citizen.Wait(1000)
			RemoveAllPedWeapons(PlayerPedId(),true)
			TriggerServerEvent("AMG_EstandePVP:limparInventario")
			estandepvp.resetDB()
			check = 1
			FreezeEntityPosition(PlayerPedId(), false)
			Citizen.Wait(1000)
			FreezeEntityPosition(PlayerPedId(), false)
		elseif check == 4 then
			check = 1
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		if estaestande and not enterestandepvp then
			DisableControlAction(0,24,true) -- disable attack
        	DisableControlAction(0,25,true) -- disable aim
        	DisableControlAction(0,47,true) -- disable weapon
        	DisableControlAction(0,58,true) -- disable weapon
		end
		Citizen.Wait(1)
	end
end)

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
	if data == "estande1" and not estande1 then --Estande 4x4
		locestande = 1
		if estandepvp.entraEstande(locestande) then
			estande1 = true
			enterestandepvp = true
			TriggerEvent("Notify","importante","Você entrou no <b>Estande 1 4x4</b>")
			SetEntityCoords(GetPlayerPed(-1), 528.90246582031,-3147.6486816406,2.2620625495911)
			TriggerEvent("vrp_player:entrouestandepvp")
			TriggerEvent("vrp_inventory:entrouestandepvp")
			TriggerEvent("reviver:entrouestandepvp")
			TriggerEvent("vrp_radio:entrouestandepvp")
			TriggerEvent("CarryPeople:entrouestandepvp")
			TriggerServerEvent("AMG_Logs:entrouestandepvp")
			pegarArmas()
		else
			TriggerEvent("Notify","negado","O <b>Estande 1</b> já está cheio.")
		end
		ToggleActionMenu()
	elseif data == "estande2" then --Estande 4x4
		locestande = 2
		if estandepvp.entraEstande(locestande) then
			estande2 = true
			enterestandepvp = true
			TriggerEvent("Notify","importante","Você entrou no <b>Estande 2 4x4</b>")
			SetEntityCoords(GetPlayerPed(-1), 532.9794921875,-3224.9194335938,4.5318851470947)
			TriggerEvent("vrp_player:entrouestandepvp")
			TriggerEvent("vrp_inventory:entrouestandepvp")
			TriggerEvent("reviver:entrouestandepvp")
			TriggerEvent("vrp_radio:entrouestandepvp")
			TriggerEvent("CarryPeople:entrouestandepvp")
			TriggerServerEvent("AMG_Logs:entrouestandepvp")
			pegarArmas()
		else
			TriggerEvent("Notify","negado","O <b>Estande 2</b> já está cheio.")
		end
		ToggleActionMenu()
	elseif data == "estande3" then --Estande 2x2
		locestande = 3
		if estandepvp.entraEstande(locestande) then
			estande3 = true
			enterestandepvp = true
			TriggerEvent("Notify","importante","Você entrou no <b>Estande 3 2x2</b>")
			SetEntityCoords(GetPlayerPed(-1), 00000000000000000000)
			TriggerEvent("vrp_player:entrouestandepvp")
			TriggerEvent("vrp_inventory:entrouestandepvp")
			TriggerEvent("reviver:entrouestandepvp")
			TriggerEvent("vrp_radio:entrouestandepvp")
			TriggerEvent("CarryPeople:entrouestandepvp")
			TriggerServerEvent("AMG_Logs:entrouestandepvp")
			pegarArmas()
		else
			TriggerEvent("Notify","negado","O <b>Estande 3</b> já está cheio.")
		end
		ToggleActionMenu()
	elseif data == "estande4" then --Estande 2x2
		locestande = 4
		if estandepvp.entraEstande(locestande) then
			estande4 = true
			enterestandepvp = true
			TriggerEvent("Notify","importante","Você entrou no <b>Estande 4 2x2</b>")
			SetEntityCoords(GetPlayerPed(-1), 00000000000000000000)
			TriggerEvent("vrp_player:entrouestandepvp")
			TriggerEvent("vrp_inventory:entrouestandepvp")
			TriggerEvent("reviver:entrouestandepvp")
			TriggerEvent("vrp_radio:entrouestandepvp")
			TriggerEvent("CarryPeople:entrouestandepvp")
			TriggerServerEvent("AMG_Logs:entrouestandepvp")
			pegarArmas()
		else
			TriggerEvent("Notify","negado","O <b>Estande 4</b> já está cheio.")
		end
		ToggleActionMenu()
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR ESTANDE PVP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if not enterestandepvp then
			for x, k in pairs(entrarestande) do
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), k.x,k.y,k.z, true ) < 3 then
					tempo = 1
					DrawMarker(21,k.x,k.y,k.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if estande1 then 
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),528.90246582031,-3147.6486816406,2.2620625495911,true) > 21 and enterestandepvp then
				Citizen.Wait(2000)
				TriggerServerEvent("AMG_EstandePVP:sairEstande", locestande)
				locestande = 0
				estande1 = false
				--estande2 = false
				--estande3 = false
				--estande4 = false
				enterestandepvp = false
				estaestande = false
				estandemorto = false
				TriggerEvent("vrp_player:saiuestandepvp")
				TriggerEvent("vrp_inventory:saiuestandepvp")
				TriggerEvent("reviver:saiuestandepvp")
				TriggerEvent("vrp_radio:saiuestandepvp")
				TriggerEvent("CarryPeople:saiuestandepvp")
				TriggerEvent('Notify','sucesso','Você saiu do estande')
				SetEntityCoords(GetPlayerPed(-1), 491.50637817383,-3171.8706054688,6.0695629119873)
				RemoveAllPedWeapons(PlayerPedId(),true)
				Citizen.Wait(1000)
				RemoveAllPedWeapons(PlayerPedId(),true)
				TriggerServerEvent("AMG_EstandePVP:limparInventario")
				estandepvp.resetDB()
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if estande2 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),525.8857421875,-3228.6840820312,4.531925201416,true) > 24 and enterestandepvp then
				Citizen.Wait(2000)
				TriggerServerEvent("AMG_EstandePVP:sairEstande", locestande)
				locestande = 0
				--estande1 = false
				estande2 = false
				--estande3 = false
				--estande4 = false
				enterestandepvp = false
				estaestande = false
				estandemorto = false
				TriggerEvent("vrp_player:saiuestandepvp")
				TriggerEvent("vrp_inventory:saiuestandepvp")
				TriggerEvent("reviver:saiuestandepvp")
				TriggerEvent("vrp_radio:saiuestandepvp")
				TriggerEvent("CarryPeople:saiuestandepvp")
				TriggerEvent('Notify','sucesso','Você saiu do estande')
				SetEntityCoords(GetPlayerPed(-1), 491.50637817383,-3171.8706054688,6.0695629119873)
				RemoveAllPedWeapons(PlayerPedId(),true)
				Citizen.Wait(1000)
				RemoveAllPedWeapons(PlayerPedId(),true)
				TriggerServerEvent("AMG_EstandePVP:limparInventario")
				estandepvp.resetDB()
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		local health = GetEntityHealth(PlayerPedId())
		if health <= 100 and enterestandepvp and not estandemorto then
			estandemorto = true
		elseif health > 101 and estandemorto then
			estandemorto = false
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if estandemorto then
			tempomorto = tempomorto - 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local tempo = 1000
		if enterestandepvp and estandemorto and tempomorto <= 0 then 
			tempo = 1
			if IsControlJustPressed(0,38) then
				estandemorto = false
				vRP._killGod(PlayerPedId())
				vRP._setHealth(PlayerPedId(),400)
				TriggerEvent("resetBleeding")
				SetTimeout(5000,function()
					tempomorto = 5
				end)
			end
		end
		Citizen.Wait(tempo)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if estandemorto then
			if tempomorto > 0 then
				drawTxt("Você morreu "..tempomorto.."",4,0.5,0.90,0.50,255,255,255,255)
			else
				drawTxt("Pressione ~g~E ~w~para reviver",4,0.5,0.90,0.50,255,255,255,255)
			end
		end
	end
end)

RegisterCommand("sairestande",function(source,args)
	local health = GetEntityHealth(PlayerPedId())
	if health <= 100 then
		TriggerEvent('Notify','negado','Não autorizado')
	else
		if estande1 or estande2 or estande3 or estande4 and health > 101 then
			if estandepvp.sairEstandev2(locestande) then
				locestande = 0
				estande1 = false
				estande2 = false
				estande3 = false
				estande4 = false
				enterestandepvp = false
				estaestande = false
				estandemorto = false
				TriggerEvent("vrp_player:saiuestandepvp")
				TriggerEvent("vrp_inventory:saiuestandepvp")
				TriggerEvent("reviver:saiuestandepvp")
				TriggerEvent("vrp_radio:saiuestandepvp")
				TriggerEvent("CarryPeople:saiuestandepvp")
				TriggerEvent('Notify','sucesso','Você saiu do estande')
				SetEntityCoords(GetPlayerPed(-1), 491.50637817383,-3171.8706054688,6.0695629119873)
				RemoveAllPedWeapons(PlayerPedId(),true)
				Citizen.Wait(1000)
				RemoveAllPedWeapons(PlayerPedId(),true)
				TriggerServerEvent("AMG_EstandePVP:limparInventario")
				estandepvp.resetDB()
			end
		end
	end
end)

function pegarArmas()
	for _, k in pairs(weapons) do
		GiveWeaponToPed(PlayerPedId(),GetHashKey(k),200,0,0)
		SetPedInfiniteAmmo(PlayerPedId(),true,GetHashKey(k))
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


