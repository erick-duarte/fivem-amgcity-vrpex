Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPvd = {}
vRP = Proxy.getInterface("vRP")
VDserver = Tunnel.getInterface("vrp_vendas")
Tunnel.bindInterface("vrp_vendas",vRPvd)
Proxy.addInterface("vrp_vendas",vRPvd)
local vendas = cfg.vendas
local syncVeh = {}

local lojas_usados = {
    { nome = "Venda de Usados", id_blip = 468, cor = 46, x = 211.525, y = -785.816, z = 30.904 },
}

Citizen.CreateThread(function()
	VDserver.restartScript()
end)

function vRPvd.setVendas(v)
    vendas = v
end

function vRPvd.syncClientVehHash(syncVeh)
    syncVeh = syncVeh
end

function vRPvd.IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
end

function vRPvd.spawnVeiculo(porta0,porta1,porta2,porta3,porta4,porta5,custom, v)
    local mhash = GetHashKey(v.modelo)


print(json.encode(v))



    local i = 0
    while not HasModelLoaded(mhash) and i < 30000 do
        RequestModel(mhash)
        Citizen.Wait(10)
        i = i+1
    end

    if HasModelLoaded(mhash) then
        local nveh = CreateVehicle(mhash, vendas[v.slot].x,vendas[v.slot].y,vendas[v.slot].z-1.0, vendas[v.slot].h, false, false)
        SetVehicleOnGroundProperly(nveh)
        SetVehicleNumberPlateText(nveh, v.placa)
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetModelAsNoLongerNeeded(mhash)

        syncVeh[v.slot] = nveh
        print(json.encode(syncVeh))
        VDserver.syncServerVehHash(syncVeh)

        FreezeEntityPosition(nveh,true)
        SetVehicleUndriveable(nveh,true)
        SetEntityInvincible(nveh,true)

        if parseInt(porta0) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 0,true)
        end
        if parseInt(porta1) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 1,true)
        end
        if parseInt(porta2) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 2,true)
        end
        if parseInt(porta3) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 3,true)
        end
        if parseInt(porta4) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 4,true)
        end
        if parseInt(porta5) ~= parseInt(0) then
            SetVehicleDoorBroken(nveh, 5,true)
        end

        if custom and nveh then
            SetVehicleModKit(nveh,0)
            if custom.colour then
                SetVehicleColours(nveh, tonumber(custom.colour.primary), tonumber(custom.colour.secondary))
                SetVehicleExtraColours(nveh, tonumber(custom.colour.pearlescent), tonumber(custom.colour.wheel))
                if custom.colour.neon then
                    SetVehicleNeonLightsColour(nveh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
                end
                if custom.colour.smoke then
                    SetVehicleTyreSmokeColor(nveh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
                end
                if custom.colour.custom then
                    if custom.colour.custom.primary then
                        SetVehicleCustomPrimaryColour(nveh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
                    end
                    if custom.colour.custom.secondary then
                        SetVehicleCustomSecondaryColour(nveh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
                    end
                end
            end

            if custom.plate then
                SetVehicleNumberPlateTextIndex(nveh,tonumber(custom.plate.index))
            end

            SetVehicleWindowTint(nveh,tonumber(custom.mods[46]))
            SetVehicleTyresCanBurst(nveh, tonumber(custom.bulletproof))
            SetVehicleWheelType(nveh, tonumber(custom.wheel))

            ToggleVehicleMod(nveh, 18, tonumber(custom.mods[18]))
            ToggleVehicleMod(nveh, 20, tonumber(custom.mods[20]))
            ToggleVehicleMod(nveh, 22, tonumber(custom.mods[22]))

            if custom.neon then
                SetVehicleNeonLightEnabled(nveh,0, tonumber(custom.neon.left))
                SetVehicleNeonLightEnabled(nveh,1, tonumber(custom.neon.right))
                SetVehicleNeonLightEnabled(nveh,2, tonumber(custom.neon.front))
                SetVehicleNeonLightEnabled(nveh,3, tonumber(custom.neon.back))
            end

            for i,mod in pairs(custom.mods) do
                if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
                    SetVehicleMod(nveh, tonumber(i), tonumber(mod))
                end
            end
        end
        return true
    end
    return false
end

function vRPvd.despawnVeiculo()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true)
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
end

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

function DrawText3D(x,y,z, text)
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
end

-- Blips
--Citizen.CreateThread(function()
--    for _, item in pairs(lojas_usados) do
--        item.blip = AddBlipForCoord(item.x, item.y, item.z)
--        SetBlipSprite(item.blip, item.id_blip)
--        SetBlipColour(item.blip, item.cor)
--        SetBlipAsShortRange(item.blip, true)
--        BeginTextCommandSetBlipName("STRING")
--        AddTextComponentString("~o~Loja~w~ " ..item.nome)
--        EndTextCommandSetBlipName(item.blip)
--    end
--end)

-- Marcações
local entrou = nil
Citizen.CreateThread(function()
    while true do
       local tempo = 1000
        for k in pairs(vendas) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), vendas[k].x, vendas[k].y, vendas[k].z, true ) < 10 then
                tempo = 1
                if vendas[k].ocupado then
                    DrawText3D(vendas[k].x, vendas[k].y, vendas[k].z, "Dono: "..vendas[k].dono_nome.."\nTelefone: "..vendas[k].telefone.."\nModelo: "..vendas[k].modelo.. "\nPreço: ~g~R$"..addComma(vendas[k].preco).."\n~y~/comprarcarro")
                else
                    DrawText3Ds(vendas[k].x, vendas[k].y, vendas[k].z, vendas[k].mensagem)
                end
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), vendas[k].x, vendas[k].y, vendas[k].z, true ) < 1 then
                    if vendas[k].ocupado then
                        if type(entrou) == 'nil' and DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then -- se existe um veiculo que o player esta tentando entrar (peguei do vrp_nocarjack)
                            entrou = k
                            VDserver.entrarVenda(k)
                        end
                    else
                        if IsControlJustPressed(0, 38) then
                            VDserver.colocarVenda(k)
                        end
                    end
                else
                    if entrou == k then
                        entrou = nil
                        VDserver.sairVenda(k)
                    end
                end
            end
        end
        Citizen.Wait(tempo)
    end
end)

function addComma(amount)
    local formatted = amount
    while true do  
      formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end