local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
encomendasAMGSV = Tunnel.getInterface("amg_encomendas")

encomendasAMG = {}
Tunnel.bindInterface("amg_encomendas",encomendasAMG)

local amGcfg = module("amg_scripts", "amg_encomendas/config")
local posEncomenda = 0
local encIlegal = false
local blips, posIlegal, produtoIlegal, valorIlegal, quantidadeIlegal = nil
local listObjectBratva = {}
local listObjectLost = {}

function encomendasAMG.criarObjEncomenda(grupo, locEncomenda)
    posEncomenda = locEncomenda
    for a,b in pairs(amGcfg.contrabandistas[posEncomenda]) do
        if a == 'peds' then
            for c1,d1 in pairs(b) do

                RequestModel(GetHashKey(c1))
		        while not HasModelLoaded(GetHashKey(c1)) do
		        	Citizen.Wait(10)
                end

		        local peds = CreatePed(5,GetHashKey(c1),d1.loc,d1.h,false,true)

                if grupo == 'bratva' then
                    table.insert(listObjectBratva, peds)
                elseif grupo == 'lost' then
                    table.insert(listObjectLost, peds)
                end
                
                if d1.animation then
                    TaskStartScenarioInPlace(peds, d1.typeanim, 0, true)
		            FreezeEntityPosition(peds,true)
		            SetEntityInvincible(peds,true)
		            SetBlockingOfNonTemporaryEvents(peds,true)
                else
                    GiveWeaponToPed(peds,GetHashKey(string.upper(d1.weapon)),200,true,true)
		            FreezeEntityPosition(peds,true)
		            SetEntityInvincible(peds,true)
		            SetBlockingOfNonTemporaryEvents(peds,true)
                end
            end
        end
        if a == 'vehicles' then
            for c2,d2 in pairs(b) do

                RequestModel(GetHashKey(c2))
		        while not HasModelLoaded(GetHashKey(c2)) do
		        	Citizen.Wait(10)
		        end
		        local vehicles = CreateVehicle(GetHashKey(c2),d2.loc,d2.h,false,true)
                if grupo == 'bratva' then
                    table.insert(listObjectBratva, vehicles)
                elseif grupo == 'lost' then
                    table.insert(listObjectLost, vehicles)
                end
		        FreezeEntityPosition(vehicles,true)
		        SetEntityInvincible(vehicles,true)
		        SetBlockingOfNonTemporaryEvents(vehicles,true)
                SetVehicleDoorsLocked(vehicles,2)
                SetVehicleNumberPlateText(vehicles,'AMGCITY0')

                if d2.Ldoor then
                    SetVehicleDoorOpen(vehicles,0,0,0)
                end
                if d2.Rdoor then
                    SetVehicleDoorOpen(vehicles,1,0,0)
                end
                if d2.TLdoor then
                    SetVehicleDoorOpen(vehicles,2,0,0)
                end
                if d2.TRdoor then
                    SetVehicleDoorOpen(vehicles,3,0,0)
                end
                if d2.Pdoor then
                    SetVehicleDoorOpen(vehicles,5,0,0)
                end

            end
        end
        if a == 'objects' then
            for c3,d3 in pairs(b) do
                
                RequestModel(c3)
                while not HasModelLoaded(GetHashKey(c3)) do
                    Citizen.Wait(10)
                end
                
                local objects = CreateObject(GetHashKey(c3),d3.loc,false,true,true)
                if grupo == 'bratva' then
                    table.insert(listObjectBratva, objects)
                elseif grupo == 'lost' then
                    table.insert(listObjectLost, objects)
                end
		        PlaceObjectOnGroundProperly(objects)
		        SetModelAsNoLongerNeeded(objects)
		        Citizen.InvokeNative(0xAD738C3085FE7E11,objects,true,true)
		        SetEntityHeading(objects,d3.h)
		        FreezeEntityPosition(objects,true)
            end
        end
    end
end

function encomendasAMG.deleteSyncProps(grupo, timeout)
    if grupo == 'bratva' then
        SetTimeout(parseInt(timeout),function()
            for k,v in pairs(listObjectBratva) do
                DeleteVehicle(v)
                DeletePed(v)
                DeleteObject(v)
            end
        end)
    elseif grupo == 'lost' then
        SetTimeout(parseInt(timeout),function()
            for k,v in pairs(listObjectLost) do
                DeleteVehicle(v)
                DeletePed(v)
                DeleteObject(v)
            end
        end)
    end
end

function encomendasAMG.resetVariaveis(timeout)
    posEncomenda = nil
    encIlegal = false
    posIlegal, produtoIlegal, valorIlegal, quantidadeIlegal = nil
    RemoveBlip(blips)
    SetTimeout(parseInt(timeout),function()
        propList = {}
    end)
end

function encomendasAMG.solicitarEncomenda(tempo, produto, valor, quantidade, localizacao)
    encIlegal = true
    posIlegal = amGcfg.contrabandistas[posEncomenda].point.posIlegal
    produtoIlegal = produto
    valorIlegal = valor
    quantidadeIlegal = quantidade
    CriandoBlipX(localizacao,"Ponto de entrega")
    TriggerEvent("Notify","importante","Localizacao recebida. Vá até o ponto de encontro.")
end

function CriandoBlipX(localizacao,mensagem)
	blips = AddBlipForCoord(localizacao)
	SetBlipSprite(blips,2)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(mensagem)
	EndTextCommandSetBlipName(blips)
end

Citizen.CreateThread(function()
    while true do
        local tempo = 1000
        if encIlegal then
            local ped = PlayerPedId()
		    local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),posIlegal,true)
		    if distance <= 10 then
		    	tempo = 1
		    	DrawMarker(3,posIlegal,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
		    	if distance <= 1.2 then
		    		if IsControlJustPressed(0,38) then
		    			encomendasAMGSV.pegarEncomendaIlegais(produtoIlegal, valorIlegal, quantidadeIlegal)
		    		end
		    	end
		    end
        end
        Citizen.Wait(tempo)
    end
end)