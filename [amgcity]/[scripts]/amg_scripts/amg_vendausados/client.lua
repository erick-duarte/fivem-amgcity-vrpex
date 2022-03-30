local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

usadosAMGSV = Tunnel.getInterface("amg_vendausados")

usadosAMG = {}
Tunnel.bindInterface("amg_vendausados",usadosAMG)

local syncHashVeh = {}

local amGcfg = module("amg_scripts", "amg_vendausados/config")

function usadosAMG.IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
      return true
    else
      return false
    end
end

function usadosAMG.setVendas(v)
    amGcfg.esposicaoVendas = v
end

function usadosAMG.despawnVeiculo(all, hash)
    local ped = GetPlayerPed(-1)
    if all then
        SetVehicleHasBeenOwnedByPlayer(hash,false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, hash, false, true)
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(hash))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(hash))
    else
        local veh = GetVehiclePedIsUsing(ped)
        SetVehicleHasBeenOwnedByPlayer(veh,false)
        Citizen.InvokeNative(0xAD738C3085FE7E11, veh, false, true)
        SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(veh))
        Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    end
end

function usadosAMG.syncHashVehClient(data)
    syncHashVeh = data
end

Citizen.CreateThread(function()
    while true do
       local tempo = 1000
        for k,v in pairs(amGcfg.esposicaoVendas) do
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), amGcfg.esposicaoVendas[k].x, amGcfg.esposicaoVendas[k].y, amGcfg.esposicaoVendas[k].z, true ) < 10 then
                tempo = 1
                if amGcfg.esposicaoVendas[k].ocupado then
                    DrawText3D(amGcfg.esposicaoVendas[k].x, amGcfg.esposicaoVendas[k].y, amGcfg.esposicaoVendas[k].z, "Dono: "..amGcfg.esposicaoVendas[k].dono_nome.."\nTelefone: "..amGcfg.esposicaoVendas[k].telefone.."\nModelo: "..amGcfg.esposicaoVendas[k].modelo.. "\nPreço: ~g~$"..amGcfg.esposicaoVendas[k].preco..",00\n~y~/comprarcarro")
                else
                    DrawText3D( amGcfg.esposicaoVendas[k].x,  amGcfg.esposicaoVendas[k].y,  amGcfg.esposicaoVendas[k].z,  amGcfg.esposicaoVendas[k].mensagem)
                end
                if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), amGcfg.esposicaoVendas[k].x, amGcfg.esposicaoVendas[k].y, amGcfg.esposicaoVendas[k].z, true ) < 1 then
                    if amGcfg.esposicaoVendas[k].ocupado then
                        if type(entrou) == 'nil' and DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then -- se existe um veiculo que o player esta tentando entrar (peguei do vrp_nocarjack)
                            entrou = k
                            usadosAMGSV.entrarVenda(k)
                        end
                    else
                        if IsControlJustPressed(0, 38) and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            usadosAMGSV.colocarVenda(k)
                        end
                    end
                else
                    if entrou == k then
                        entrou = nil
                        usadosAMGSV.sairVenda(k)
                    end
                end
            end
        end
        Citizen.Wait(tempo)
    end
end)

function usadosAMG.spawnVeiculo(porta0,porta1,porta2,porta3,porta4,porta5,custom, v, all)
    local mhash = GetHashKey(v.modelo)
    local i = 0
    while not HasModelLoaded(mhash) and i < 30000 do
        RequestModel(mhash)
        Citizen.Wait(10)
        i = i+1
    end

    if HasModelLoaded(mhash) then
        local nveh = nil
        if all then
            nveh = CreateVehicle(mhash, amGcfg.esposicaoVendas[v.slot].x,amGcfg.esposicaoVendas[v.slot].y,amGcfg.esposicaoVendas[v.slot].z-1.0, amGcfg.esposicaoVendas[v.slot].h, false, true)
        else
            nveh = CreateVehicle(mhash, amGcfg.esposicaoVendas[v.slot].x,amGcfg.esposicaoVendas[v.slot].y,amGcfg.esposicaoVendas[v.slot].z-1.0, amGcfg.esposicaoVendas[v.slot].h, false, true)
        end
        SetVehicleOnGroundProperly(nveh)
        SetVehicleNumberPlateText(nveh, v.placa)
        Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
        SetVehicleHasBeenOwnedByPlayer(nveh,true)
        SetModelAsNoLongerNeeded(mhash)

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

        usadosAMGSV.syncHashVehServer(v.slot,nveh)

        if custom and nveh then
            SetVehicleModKit(nveh,0)
		    if custom.color then
		    	SetVehicleColours(nveh,tonumber(custom.color[1]),tonumber(custom.color[2]))
		    	SetVehicleExtraColours(nveh,tonumber(custom.extracolor[1]),tonumber(custom.extracolor[2]))
		    end

		    if custom.smokecolor then
		    	SetVehicleTyreSmokeColor(nveh,tonumber(custom.smokecolor[1]),tonumber(custom.smokecolor[2]),tonumber(custom.smokecolor[3]))
		    end

		    if custom.neon then
		    	SetVehicleNeonLightEnabled(nveh,0,1)
		    	SetVehicleNeonLightEnabled(nveh,1,1)
		    	SetVehicleNeonLightEnabled(nveh,2,1)
		    	SetVehicleNeonLightEnabled(nveh,3,1)
		    	SetVehicleNeonLightsColour(nveh,tonumber(custom.neoncolor[1]),tonumber(custom.neoncolor[2]),tonumber(custom.neoncolor[3]))
		    else
		    	SetVehicleNeonLightEnabled(nveh,0,0)
		    	SetVehicleNeonLightEnabled(nveh,1,0)
		    	SetVehicleNeonLightEnabled(nveh,2,0)
		    	SetVehicleNeonLightEnabled(nveh,3,0)
		    end

		    if custom.plateindex then
		    	SetVehicleNumberPlateTextIndex(nveh,tonumber(custom.plateindex))
		    end

		    if custom.windowtint then
		    	SetVehicleWindowTint(nveh,tonumber(custom.windowtint))
		    end

		    if custom.bulletProofTyres then
		    	SetVehicleTyresCanBurst(nveh,custom.bulletProofTyres)
		    end

		    if custom.wheeltype then
		    	SetVehicleWheelType(nveh,tonumber(custom.wheeltype))
		    end

		    if custom.spoiler then
		    	SetVehicleMod(nveh,0,tonumber(custom.spoiler))
		    	SetVehicleMod(nveh,1,tonumber(custom.fbumper))
		    	SetVehicleMod(nveh,2,tonumber(custom.rbumper))
		    	SetVehicleMod(nveh,3,tonumber(custom.skirts))
		    	SetVehicleMod(nveh,4,tonumber(custom.exhaust))
		    	SetVehicleMod(nveh,5,tonumber(custom.rollcage))
		    	SetVehicleMod(nveh,6,tonumber(custom.grille))
		    	SetVehicleMod(nveh,7,tonumber(custom.hood))
		    	SetVehicleMod(nveh,8,tonumber(custom.fenders))
		    	SetVehicleMod(nveh,10,tonumber(custom.roof))
		    	SetVehicleMod(nveh,11,tonumber(custom.engine))
		    	SetVehicleMod(nveh,12,tonumber(custom.brakes))
		    	SetVehicleMod(nveh,13,tonumber(custom.transmission))
		    	SetVehicleMod(nveh,14,tonumber(custom.horn))
		    	SetVehicleMod(nveh,15,tonumber(custom.suspension))
		    	SetVehicleMod(nveh,16,tonumber(custom.armor))
		    	SetVehicleMod(nveh,23,tonumber(custom.tires),custom.tiresvariation)
            
		    	if IsThisModelABike(GetEntityModel(nveh)) then
		    		SetVehicleMod(nveh,24,tonumber(custom.btires),custom.btiresvariation)
		    	end
            
		    	SetVehicleMod(nveh,25,tonumber(custom.plateholder))
		    	SetVehicleMod(nveh,26,tonumber(custom.vanityplates))
		    	SetVehicleMod(nveh,27,tonumber(custom.trimdesign)) 
		    	SetVehicleMod(nveh,28,tonumber(custom.ornaments))
		    	SetVehicleMod(nveh,29,tonumber(custom.dashboard))
		    	SetVehicleMod(nveh,30,tonumber(custom.dialdesign))
		    	SetVehicleMod(nveh,31,tonumber(custom.doors))
		    	SetVehicleMod(nveh,32,tonumber(custom.seats))
		    	SetVehicleMod(nveh,33,tonumber(custom.steeringwheels))
		    	SetVehicleMod(nveh,34,tonumber(custom.shiftleavers))
		    	SetVehicleMod(nveh,35,tonumber(custom.plaques))
		    	SetVehicleMod(nveh,36,tonumber(custom.speakers))
		    	SetVehicleMod(nveh,37,tonumber(custom.trunk)) 
		    	SetVehicleMod(nveh,38,tonumber(custom.hydraulics))
		    	SetVehicleMod(nveh,39,tonumber(custom.engineblock))
		    	SetVehicleMod(nveh,40,tonumber(custom.camcover))
		    	SetVehicleMod(nveh,41,tonumber(custom.strutbrace))
		    	SetVehicleMod(nveh,42,tonumber(custom.archcover))
		    	SetVehicleMod(nveh,43,tonumber(custom.aerials))
		    	SetVehicleMod(nveh,44,tonumber(custom.roofscoops))
		    	SetVehicleMod(nveh,45,tonumber(custom.tank))
		    	SetVehicleMod(nveh,46,tonumber(custom.doors))
		    	SetVehicleMod(nveh,48,tonumber(custom.liveries))
		    	SetVehicleLivery(nveh,tonumber(custom.liveries))

		    	ToggleVehicleMod(nveh,20,tonumber(custom.tyresmoke))
		    	ToggleVehicleMod(nveh,22,tonumber(custom.headlights))
		    	ToggleVehicleMod(nveh,18,tonumber(custom.turbo))
		    end
        end
        return true
    end
    return false
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