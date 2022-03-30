
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
srcCocaina = {}
Tunnel.bindInterface("bdl_drugsfactory",srcCocaina)
cocainaSERVER = Tunnel.getInterface("bdl_drugsfactory")

local progressCocaina = {}
local locCocaina = vector3(-1077.38,4928.51,12.98)
local locMaquinaProcessarPasta = vector3(-1108.26,4938.33,219.65)

local plantasCocaina = { -- VERDES
    { "cocaina",-1080.55,4926.19,213.3 },
    { "cocaina",-1078.42,4927.62,213.1 },
    { "cocaina",-1076.56,4929.2,212.84 },
    { "cocaina",-1081.58,4927.93,213.35 },
    { "cocaina",-1079.4,4929.2,213.16 },
    { "cocaina",-1077.66,4930.86,213.05 },

    { "cocaina",-1079.51,4924.77,213.25 },
    { "cocaina",-1077.14,4926.28,212.95 },
    { "cocaina",-1075.15,4927.7,212.77 },
    { "cocaina",-1075.97,4932.44,212.82 },
    { "cocaina",-1074.52,4930.74,212.64 },
    { "cocaina",-1072.93,4929.29,212.68 },

    { "cocaina",-1074.2,4934.1,212.65 },
    { "cocaina",-1072.8,4932.6,212.42 },
    { "cocaina",-1071.32,4931.07,212.28 },
    { "cocaina",-1084.44,4926.62,213.91 },
    { "cocaina",-1082.8,4924.44,213.76 },
    { "cocaina",-1081.48,4923.04,213.57 },
}

function srcCocaina.returnPlanting(status)
	progressCocaina = status
end

--COLHER FOLHAS
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		local disPlantCoca = Vdist(x,y,z,locCocaina)
		if disPlantCoca <= 30 then
			for k,v in pairs(plantasCocaina) do
				local distance = Vdist(x,y,z,v[2],v[3],v[4])
				if distance <= 5 then
					idle = 5
					if parseInt(progressCocaina[k]) >= 100 then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~g~E~w~] para ~g~COLHER~w~.")
					elseif progressCocaina[k] then
						DrawText3Ds(v[2],v[3],v[4]-0.7,"REAGINDO: ~g~"..progressCocaina[k].."~w~%.")
					else
						DrawText3Ds(v[2],v[3],v[4]-0.7,"[~g~E~w~] para ~g~ADUBAR~w~.")
					end

					if distance <= 1 and IsControlJustPressed(1,38) then
						cocainaSERVER.startPlanting(k,v[1])
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--PROCESSA PARA PASTA
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		local distance = Vdist(x,y,z,locMaquinaProcessarPasta)
		if distance <= 5 then
			idle = 5

			if parseInt(cl_progress) >= 100 then
				DrawText3Ds(locMaquinaProcessarPasta-0.7,"[~g~E~w~] para ~g~PEGAR~w~ a droga.")
			elseif parseInt(cl_progress) > 0 and parseInt(cl_progress) < 100 then
				DrawText3Ds(locMaquinaProcessarPasta-0.7,"PROCESSANDO: ~g~"..cl_progress.."~w~%.")
			else
				DrawText3Ds(locMaquinaProcessarPasta-0.7,"[~g~E~w~] para ~g~PROCESSAR~w~ a pasta.")
			end

			if distance <= 1.3 then
				if IsControlJustPressed(0,38) and not isprocessing and not isready then
					if vSERVER.tryGetDrugsFromInv("pasta-coca") then
						incl_process = true
						startcl_process()
						isprocessing = true
					else
						TriggerEvent("Notify","negado","Quantidade inválida.")
					end
				end
				if isready and IsControlJustPressed(0,38) then
					if vSERVER.tryGiveDrugsToInv() then
						cl_progress = 0
						incl_process = false
						isready = false
					end
				end
			end
		end
		Wait(idle)
	end
end)


function startcl_process()
	Citizen.CreateThread(function()
		while true do
			if incl_process and not isready then
				if cl_progress ~= nil and cl_progress < 100 then
					cl_progress = cl_progress + 1
					Citizen.Wait(10)
				end
				if cl_progress == 100 then
					isready = true
					isprocessing = false
				end
			else
				break
			end
			Citizen.Wait(200)
		end
	end)
end