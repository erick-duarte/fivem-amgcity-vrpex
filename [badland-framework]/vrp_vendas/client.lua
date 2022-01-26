Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRPvd = {}
vRP = Proxy.getInterface("vRP")
VDserver = Tunnel.getInterface("vrp_vendas")
Tunnel.bindInterface("vrp_vendas",vRPvd)
Proxy.addInterface("vrp_vendas",vRPvd)

local vendas = {
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 211.525, y = -785.816, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 209.012, y = -790.944, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 27.164,  y = -1070.479, z = 38.152, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 27.696,  y = -1067.529, z= 38.152, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 210.480, y = -788.588, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 212.332, y = -783.387, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 213.432, y = -780.998, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 214.474, y = -778.625, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 221.034, y = -786.516, z = 30.900, h = 247.610, ocupado = false },
--    { mensagem = "Pressione ~g~E~s~ para colocar seu carro a venda!", x = 219.399, y = -788.936, z = 30.900, h = 247.610, ocupado = false },
}


local lojas_usados = {
    { nome = "Venda de Usados", id_blip = 468, cor = 46, x = 211.525, y = -785.816, z = 30.904 },
}

Citizen.CreateThread(function()
	VDserver.restartScript()
end)

function vRPvd.setVendas22(v)
    VDserver.loglog(v)
    vendas = v
end

-- Function Mensagem
function vRPvd.limiteVenda()
    SendNUIMessage({limiteVenda = true})
end

function vRPvd.naoPertence()
    SendNUIMessage({naoPertence = true})
end

function vRPvd.seuVeiculo()
    SendNUIMessage({seuVeiculo = true})
end

function vRPvd.valorInvalido()
    SendNUIMessage({valorInvalido = true})
end

function vRPvd.estaForaVeiculo()
    SendNUIMessage({estaForaVeiculo = true})
end

function vRPvd.avisoDinheiroInsuficiente()
    SendNUIMessage({avisoDinheiroInsuficiente = true})
end

function vRPvd.AvisoCompraSucesso()
    SendNUIMessage({AvisoCompraSucesso = true})
end

function vRPvd.AvisoSucesso()
    SendNUIMessage({AvisoSucesso = true})
end

function vRPvd.removidoSucesso()
    SendNUIMessage({removidoSucesso = true})
end

-- Retorna o modelo do carro em que o player está
function vRPvd.getModel()
    local ped = GetPlayerPed(-1)
    local currentVehicle = GetVehiclePedIsUsing(ped)
    local model = GetEntityModel(currentVehicle)
    local name = GetDisplayNameFromVehicleModel(model)
    return name
end

-- Checa se o player está em um veiculo
function vRPvd.IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
end

-- Spawna o veiculo com a customização
function vRPvd.spawnVeiculo(porta0,porta1,porta2,porta3,porta4,porta5,custom, v)
    -- carrega o modelo do veiculo
    local mhash = GetHashKey(v.modelo)

    local i = 0
    while not HasModelLoaded(mhash) and i < 30000 do
        RequestModel(mhash)
        Citizen.Wait(10)
        i = i+1
    end
    -- spawna o carro
    if HasModelLoaded(mhash) then
        local nveh = CreateVehicle(mhash, vendas[v.slot].x,vendas[v.slot].y,vendas[v.slot].z-1.0, vendas[v.slot].h, true, false)
        SetVehicleOnGroundProperly(nveh)
        SetVehicleNumberPlateText(nveh, v.placa)
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetModelAsNoLongerNeeded(mhash)
        -- proteção
        FreezeEntityPosition(nveh,true)
        SetVehicleUndriveable(nveh,true)
        SetEntityInvincible(nveh,true)
        -- Coloca a modificação no carro

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

-- Retira o veiculo
function vRPvd.despawnVeiculo()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    -- deleta o veiculo
    SetVehicleHasBeenOwnedByPlayer(veh,false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true)
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
end

-- Texto 3D
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
		--print(GetEntityHeading(GetPlayerPed(-1)))
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