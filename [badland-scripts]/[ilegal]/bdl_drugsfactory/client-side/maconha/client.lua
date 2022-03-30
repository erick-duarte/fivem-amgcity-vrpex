local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
srcMaconha = {}
Tunnel.bindInterface("bdl_drugsfactory",srcMaconha)
maconhaSERVER = Tunnel.getInterface("bdl_drugsfactory")

local progressMaconha = {}
local emProducaoMaconha = false
local locMaconha = vector3(99.43,6346.94,31.38)

local mesaProducao = {
	{ 1860.31,3464.65,45.96 },
	{ 1860.29,3463.22,45.96 },
}

local plantasMaconha = {
	{ "maconha",96.41,6335.84,31.38 },
	{ "maconha",97.74,6336.72,31.38 },
	{ "maconha",99.44,6337.61,31.38 },
	{ "maconha",98.7,6339.51,31.38 },
	{ "maconha",97.99,6340.89,31.38 },
	{ "maconha",97.3,6342.45,31.38 },
	{ "maconha",96.38,6344.04,31.38 },
	{ "maconha",95.45,6345.49,31.38 },
	{ "maconha",94.57,6346.61,31.38 },
	{ "maconha",93.79,6347.86,31.38 },
	{ "maconha",93.13,6349.29,31.38 },
	{ "maconha",94.55,6349.23,31.38 },
	{ "maconha",95.96,6349.96,31.38 },
	{ "maconha",97.44,6350.54,31.38 },
	{ "maconha",98.88,6351.22,31.38 },
	{ "maconha",100.52,6353.05,31.38 },
	{ "maconha",102.03,6353.72,31.38 },
	{ "maconha",103.56,6354.78,31.38 },
}

function srcMaconha.returnPlanting(status)
	progressMaconha = status
end

--#### COLHER E ADUBAR
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		local disPlantWeed = Vdist(x,y,z,locMaconha)
		if disPlantWeed <= 30 then
			for k,v in pairs(plantasMaconha) do
				local distance = Vdist(x,y,z,v[2],v[3],v[4])
				if distance <= 5 then
					idle = 5
					if parseInt(progressMaconha[k]) >= 100 then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~p~E~w~] para ~p~COLHER~w~.")
					elseif progressMaconha[k] then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"REAGINDO: ~p~"..progressMaconha[k].."~w~%.")
					else
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~p~E~w~] para ~p~ADUBAR~w~.")
					end

					if distance <= 1 and IsControlJustPressed(1,38) then
						maconhaSERVER.startPlanting(k,v[1])
					end
				end
			end
		end
        Citizen.Wait(idle)
    end
end)

--#### EMBALAR
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		for k,v in pairs(mesaProducao) do
			local distance = Vdist(v[1],v[2],v[3],x,y,z)
			if distance <= 2.3 and not emProducaoMaconha then
				idle = 5
				DrawText3Ds(v[1],v[2],v[3], "[~p~E~w~] Para ~p~EMBALAR~w~ o produto.")
			end
			if distance <= 1.2 then
				idle = 5
				if IsControlJustPressed(0,38) then
					if maconhaSERVER.tryPackProduct() then
						emProducaoMaconha = true
					end
				end
			end
		end
		Wait(idle)
	end
end)

function src.freezPed(timer)
	print(timer)
	FreezeEntityPosition(PlayerPedId(), true)
	SetTimeout(timer*1000,function()
		facembalando = false
		weedchairprogress = false
		FreezeEntityPosition(PlayerPedId(), false)
	end)
end