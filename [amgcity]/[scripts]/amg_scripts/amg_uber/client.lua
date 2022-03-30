local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
amGSERVER = Tunnel.getInterface("amg_uber")
amG = {}
Tunnel.bindInterface("amg_uber",amG)
local amGcfg = module('amg_scripts', 'amg_uber/config')

local ridercorrida = false
local drivercorrida = false
local riderX = nil
local riderY = nil
local riderZ = nil
local destX = nil
local destY = nil
local destZ = nil
local riderNotificar = false
local riderSrc = nil
local notificarrider = nil 
local totalCorrida = 0

RegisterCommand('uber', function(source, args)
    local ped = PlayerPedId()
    if IsWaypointActive() then
        if not ridercorrida then
            local dx, dy, dz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector()))
            local Px, Py, Pz = table.unpack(GetEntityCoords(ped))
            print(dx, dy, dz)
            print(Px, Py, Pz)
            local distancia = CalculateTravelDistanceBetweenPoints(Px, Py, Pz, dx, dy, dz)
            if parseInt(distancia) < 1000 then
                distancia = "0."..distancia
            end
            local accept, valor = amGSERVER.uberConfirmarPedido(km(parseInt(distancia)))
            if accept then
                if amGSERVER.uberEnviarSolicitacao(Px, Py, Pz, dx, dy, dz-1, valor) then
                    ridercorrida = true
                end
            end
        else
            TriggerEvent("Notify","importante","Você já tem uma corrida em andamento.")
        end
    else
        TriggerEvent("Notify","importante","Marque o destino, antes de solicitar um Uber.")
    end
end)

function amG.uberDistanciaRiderDiver(locx, locy, locz)
    local ped = PlayerPedId()
    local Px, Py, Pz = table.unpack(GetEntityCoords(ped))
    local distancia = CalculateTravelDistanceBetweenPoints(Px, Py, Pz, locx, locy, locz)
    return km(parseInt(distancia)), Px, Py, Pz
end

function amG.uberIniciarCorrida(srcrider, locx, locy, locz, loc2x, loc2y, loc2z, valor)
    local ped = PlayerPedId()
    local driverX, driverY, dirverZ = table.unpack(GetEntityCoords(ped))
    riderX, riderY, riderZ = locx, locy, locz
    destX, destY, destZ = loc2x, loc2y, loc2z
    riderSrc = srcrider
    totalCorrida = valor
    drivercorrida = true
    CriandoBlip(riderX, riderY, riderZ,"Uber | Passageiro")
end

function amG.uberLimparVariaveis()
    ridercorrida = false
    drivercorrida = false
    riderX = nil
    riderY = nil
    riderZ = nil
    destX = nil
    destY = nil
    destZ = nil
    riderNotificar = false
    riderSrc = nil
    totalCorrida = 0
    notificarrider = nil
    RemoveBlip(blips)
end

Citizen.CreateThread(function()
    while true do
        local tempo = 2000
        if drivercorrida then
            local ped = PlayerPedId()
            local riderDistance = GetDistanceBetweenCoords(GetEntityCoords(ped),riderX, riderY, riderZ,true)
            if riderDistance < 15 then
                if not notificarrider then
                    notificarrider = true
                    RemoveBlip(blips)
                    CriandoBlip(destX, destY, destZ,"Uber | Destino")
                    amGSERVER.uberNotificarPassageiro(riderSrc)
                end
            end
            local destDistance = GetDistanceBetweenCoords(GetEntityCoords(ped), destX, destY, destZ,true)
            if destDistance < 15 and notificarrider then
                RemoveBlip(blips)
                amGSERVER.uberReceberPagamento(riderSrc, totalCorrida)
            end
        end 
        Citizen.Wait(tempo)
    end
end)

function CriandoBlip(x,y,z,mensagem)
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,2)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(mensagem)
	EndTextCommandSetBlipName(blips)
end

function km(n)
    if n >= 10^6 then
        return string.format("%.2f", n / 10^6)
    elseif n >= 10^3 then
        return string.format("%.2f", n / 10^3)
    else
        return tostring(n)
    end
end
