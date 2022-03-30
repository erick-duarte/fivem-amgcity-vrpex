local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("bdl_chest",src)
vSERVER = Tunnel.getInterface("bdl_chest")

--[ VARIAVEIS ]--------------------------------------------------------------------------------------------------------------------------

local chestTimer = 0
local chestOpen = ""
onMenu = false


--[ CHESTCLOSE ]-------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("chestClose",function(data)
	onMenu = false
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	TriggerEvent("bdl:triggerhud")
	SendNUIMessage({ action = "hideMenu" })
end)

--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)

--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)

--[ AUTO-UPDATE ]------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Chest:UpdateChest")
AddEventHandler("Chest:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)

--[ REQUESTCHEST ]-----------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)

--[ VARIAVEIS ]--------------------------------------------------------------------------------------------------------------------------

local chest = {
	{ "lspd",-1087.44,-820.76,11.04,0,140,255, "[~b~E~w~] Para ~b~ABRIR~w~ o baú da ~b~POLICIA~w~" },
	{ "ems",306.63,-601.49,43.29,255,25,25, "[~r~E~w~] Para ~r~ABRIR~w~ o baú do ~r~HOSPITAL~w~" },
	{ "bennys",1016.47,-2314.45,30.51,255,180,0, "[~y~E~w~] Para ~y~ABRIR~w~ o baú da ~y~BENNY'S~w~" },
	
--	{ "grove",-131.35,-1606.73,35.04,25,255,25, "[~g~E~w~] Para ~g~ABRIR~w~ o baú da ~g~GROVE ST.~w~" },
--	{ "ballas",262.01,-1805.45,26.92,130,0,255, "[~p~E~w~] Para ~p~ABRIR~w~ o baú dos ~p~BALLAS~w~" },
--	{ "vagos",337.81,-2012.41,22.4,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~VAGOS~w~" },

	{ "verdes",1909.02,6449.24,79.84,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~VERDES~w~" },
	{ "chf-verdes",1912.35,6448.33,79.84,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~LIDER VERDES~w~" },

	{ "vermelhos",1854.07,3464.68,41.96,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~VERMELHOS~w~" },
	{ "chf-vermelhos",1853.99,3468.22,45.96,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~LIDER VERMELHOS~w~" },

	{ "brancos",-147.26,2128.04,166.14,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~BRANCOS~w~" },
	{ "chf-brancos",-143.96,2123.52,170.15,255,255,25, "[~y~E~w~] Para ~y~ABRIR~w~ o baú dos ~y~LIDER BRANCOS~w~" },
	
	{ "bratva",1393.01,1152.82,108.15,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú dos ~c~BRATVA~w~" },
	{ "l-bratva",1391.61,1158.86,114.34,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú dos ~c~LIDER BRATVA~w~" },

	{ "lost",985.86,-134.0,78.9,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú do ~c~MOTOCLUB~w~" },
--	{ "l-lost",985.86,-134.0,78.9,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú do ~c~MOTOCLUB~w~" },

--	{ "yakuza",985.86,-134.0,78.9,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú do ~c~MOTOCLUB~w~" },
--	{ "l-yakuza",985.86,-134.0,78.9,50,50,50, "[~c~E~w~] Para ~c~ABRIR~w~ o baú do ~c~MOTOCLUB~w~" },
}

--[ CHESTTIMER ]-------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		if chestTimer > 0 then
			chestTimer = chestTimer - 3
		end
	end
end)

--[ CHEST ]------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("chest",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(chest) do
		local distance = GetDistanceBetweenCoords(x,y,z,v[2],v[3],v[4],true)
		if distance <= 2.0 and chestTimer <= 0 then
			chestTimer = 3
			if vSERVER.checkIntPermissions(v[1]) then
				onMenu = true
				TransitionToBlurred(1000)
				SetNuiFocus(true,true)
				TriggerEvent("bdl:triggerhud")
				SendNUIMessage({ action = "showMenu" })
				chestOpen = tostring(v[1])
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(chest) do
			local distance = GetDistanceBetweenCoords(x,y,z,v[2],v[3],v[4],true)
			if distance < 5 then
				if not onMenu then
					idle = 5
					DrawMarker(23,v[2],v[3],v[4]-1,0,0,0,0,180.0,130.0,1.2,1.2,1.2,v[5],v[6],v[7],50,0,0,0,1)
					if distance <= 2 then
						DrawText3D(v[2],v[3],v[4],v[8])
						if distance < 1.1 then
							if IsControlJustPressed(0,38) and chestTimer <= 0 then
								chestTimer = 3
								if vSERVER.checkIntPermissions(v[1]) then
									onMenu = true
									TransitionToBlurred(1000)
									SetNuiFocus(true,true)
									TriggerEvent("bdl:triggerhud")
									SendNUIMessage({ action = "showMenu" })
									chestOpen = tostring(v[1])
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

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