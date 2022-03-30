
local stop = false
RegisterCommand('testezss', function()
    local ped = PlayerPedId()
    openNui(GetVehiclePedIsIn(ped, false), 'Compacts', 100)
end)
function totalzin()
    local full = 100
    return full
end

function openNui(veh, vehType, playerMoney)
    menuIsOpen = true
    stop = false
    local instParts = {}
    buyOut = nil
    if IsEntityAVehicle(veh) then
        SetVehicleEngineOn(veh, true, true, false)
        SetVehicleLights(veh,2)
        SetVehicleModKit(veh,0)        
        DisplayRadar(false)
        SendNUIMessage({ action = 'load' })
        SetNuiFocus(true, true)

        local previousWheelType = GetVehicleWheelType(veh)
        local previousWheelMod = GetVehicleMod(veh, 23)

        for index, part in pairs(partMods) do
            if stop then
                break
            end
            -- preciso parar esse load
            local haveItem
            local available = GetNumVehicleMods( veh, index )
            if itemPrices[index].item ~= false then
                haveItem = itemPrices[index].item
            else
                haveItem = true
            end
            if part.type == 'wheel' then
                local partId = string.sub(index,0,2)
                local wheeltype = string.sub(index,3,3)

                SetVehicleWheelType(veh, tonumber(wheeltype))
                available = GetNumVehicleMods( veh, tonumber(partId) )
                local installed
                if wheeltype == available then
                    installed = GetVehicleMod(veh, tonumber(partId))
                else
                    installed = false
                end

                if available > 0 then
                    table.insert(instParts, {
                        label = part.label,
                        part = part.name,
                        index = index,
                        availableMods = available,
                        img = part.img,
                        installed = installed,
                        type = part.type,
                        haveItem = haveItem
                    })
                end
            elseif part.type == 'toggle' then
                local installed
                if IsToggleModOn(veh, index) == 1 then installed = 0 else installed = -1 end
                table.insert(instParts, {
                    label = part.label,
                    part = part.name,
                    index = index,
                    availableMods = 1,
                    img = part.img,
                    installed = installed,
                    type = part.type,
                    haveItem = haveItem
                })
            elseif part.type == 'window' then
                local available = GetNumVehicleWindowTints()
                local installed = GetVehicleWindowTint(veh)
                if available > 0 then
                    table.insert(instParts, {
                        label = part.label,
                        part = part.name,
                        index = index, 
                        availableMods = available,
                        img = part.img,
                        installed = installed,
                        type = part.type,
                        haveItem = haveItem
                    })
                end
            elseif part.type == 'plateindex' then    
                local available = #plateIndex
                local installed = GetVehicleNumberPlateTextIndex(veh)
                if available > 0 then
                    table.insert(instParts, {
                        label = part.label,
                        part = part.name,
                        index = index, 
                        availableMods = available,
                        img = part.img,
                        installed = installed,
                        type = part.type,
                        haveItem = haveItem
                    })
                end

            elseif part.type == 'tires' then

                local available = 1
                local installed = -1

                if GetVehicleModVariation(veh,23) then installed = 1 else installed = -1 end
                
                if available > 0 then
                    table.insert(instParts, {
                        label = part.label,
                        part = part.name,
                        index = index, 
                        availableMods = available,
                        img = part.img,
                        installed = installed,
                        type = part.type,
                        haveItem = haveItem
                    })
                end
            else
                if available > 0 then
                    table.insert(instParts, {
                        part = part.name,
                        label = part.label,
                        index = index,
                        availableMods = available,
                        img = part.img,
                        installed = GetVehicleMod(veh, index),
                        type = part.type,
                        haveItem = haveItem
                    })
                end
            end
        end
        SendNUIMessage({ action = 'open', vehType = vehType, mods = instParts, toggle = partToogle, playerMoney = playerMoney})
        init(veh)
        local custom = src.getVehicleMods(veh)
        --sv.savedbcar(custom)
        SetVehicleWheelType(veh, tonumber(previousWheelType))
        SetVehicleMod(veh, 23, tonumber(previousWheelMod))
    end
end

function closeNui()
    SetNuiFocus(false, false)
    menuIsOpen = false
    DisplayRadar(true)
    stop = true
    if vehSelected then
        SetVehicleDoorShut(vehSelected,0,0)
        SetVehicleDoorShut(vehSelected,1,0)
        SetVehicleDoorShut(vehSelected,4,0)
        SetVehicleDoorShut(vehSelected,5,0)
        SetVehicleEngineOn(vehSelected, false, true, false)
        SetVehicleLights(vehSelected, 0)
        RenderScriptCams(0,0,cam,0,0)
        DestroyCam(cam, true)
        SetFocusEntity(PlayerPedId())
    end
    buyOut = nil
    local _, custom = getVehicleMods(GetVehiclePedIsIn(PlayerPedId(),false))
    --sv.savedbcar(custom)
    
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Callbacks
----------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(data, cb)
    closeNui()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeNui()
    end
end)

RegisterNUICallback("changeItem", function(data, cb)
    local before = data.before
    local modType = data.type
    local veh = vehSelected
    local playerMoney = 0
    if data.value then
        local value = data.value
    end

    local part = data.part

    if modType == 'mod' then
        local part = data.part
        local partId = data.partId
        local oldpart = tonumber(GetVehicleMod(veh, tonumber(part)))
        SetVehicleMod(veh,tonumber(part),tonumber(partId)) 
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        custom.mods[tonumber(part)] = partId
        SendNUIMessage({ action = "update", oldInstalled = oldpart, installedPart = tonumber(partId), partname = partMods[tonumber(part)].name, id = tonumber(partId), totalPrice = totalPrice, playerMoney = playerMoney})
    elseif modType == 'toggle' then
        local part = data.part
        local partId = data.partId
        local oldpart
        local installedPart
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        if IsToggleModOn(veh, tonumber(part)) == 1 then oldpart = 0 else oldpart = -1 end
        ToggleVehicleMod(veh, tonumber(part), tonumber(partId+1))
        custom.mods[part] = partId + 1
        if IsToggleModOn(veh, tonumber(part)) == 1 then installedPart = 0 else installedPart = -1 end
        SendNUIMessage({ action = "update", oldInstalled = tonumber(oldpart), installedPart = tonumber(installedPart), partname = partMods[tonumber(part)].name, id = tonumber(partId), totalPrice = totalPrice, playerMoney = playerMoney })
    elseif modType == 'plateindex' then    
        local part = data.part
        local partId = data.partId
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        local oldpart = GetVehicleNumberPlateTextIndex(veh)
        if tonumber(partId) < 0 then partId = 0 end
        SetVehicleNumberPlateTextIndex(veh,tonumber(data.partId))
        SendNUIMessage({ action = "update", oldInstalled = oldpart, installedPart = tonumber(partId), partname = partMods[tonumber(part)].name, id = tonumber(partId), totalPrice = totalPrice, playerMoney = playerMoney })

    elseif modType == 'tires' then
        local part = data.part
        local partId = data.partId
        local _, custom = getVehicleMods(veh)
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        local tyresvariation
        if tonumber(partId) == -1 then tyresvariation = false else tyresvariation = true end
        SetVehicleMod(veh,23,tonumber(custom.tyres),tyresvariation)
        SetVehicleMod(veh,24,tonumber(custom.tyres),tyresvariation)
        SendNUIMessage({ action = "update", oldInstalled = oldpart, installedPart = tonumber(partId), partname = partMods[tonumber(part)].name, id = tonumber(partId), totalPrice = totalPrice, playerMoney = playerMoney })
    elseif modType == 'wheel' then
        local oldWheelType = GetVehicleWheelType(veh)
        local oldpart = tonumber( GetVehicleMod(veh, tonumber(23)) )
        local partType = string.sub(part,0,2)
        local wheeltype = string.sub(part,3,3)
        custom.wheel = wheeltype
        custom.mods[23] = tonumber(data.partId)
        SetVehicleWheelType( veh, tonumber(wheeltype) )
        SetVehicleMod(veh, tonumber(partType), tonumber(data.partId))
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        SendNUIMessage({ action = "update", oldInstalled = oldpart, oldWheelType = partMods[tonumber(partType..oldWheelType)].name, partType = partMods[tonumber(part)].type, installedPart = tonumber(data.partId), partname = partMods[tonumber(part)].name, id = tonumber(partType), totalPrice = totalPrice, playerMoney = playerMoney })
    elseif modType == "window" then
        local part = data.part
        local totalPrice,playerMoney = sv.getPrices(tonumber(part))
        local partId = data.partId
        custom.mods[data.part] = data.partId
        local oldpart = tonumber( GetVehicleWindowTint(veh) )
        SetVehicleWindowTint(veh, tonumber(data.partId) )
        SendNUIMessage({ action = "update", oldInstalled = oldpart, installedPart = tonumber(partId), partname = partMods[tonumber(part)].name, id = tonumber(partId), totalPrice = totalPrice, playerMoney = playerMoney })
    elseif modType == 'xenoncolor' then 
        local op = data.op
        local installed = GetVehicleXenonLightsColour(veh)
        
        if op == '+' then
            if installed == #headlightColors then
                installed = -1
            else
                installed = installed + 1
            end
        else
            if installed == -1 then
                installed = #colorTable
            else
                installed = installed - 1
            end
        end
        custom.xenon = installed
        SetVehicleXenonLightsColour(veh, installed)
        SendNUIMessage({ action = 'changeXenonColorName', cName = headlightColors[installed] })
    elseif modType == 'color' or modType == 'Scolor' or modType == 'smoke' or modType == 'neon' or modType == 'customcolor' or colorP == 'primary' or colorP == 'secundary' or colorP == 'extra1' or colorP == 'extra2' then
        
        if modType == 'color' then 
            SetVehicleCustomPrimaryColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.colour.custom.primary = {data.r,data.g,data.b}
            cb(true)
        elseif modType == 'Scolor' then
            SetVehicleCustomSecondaryColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.colour.custom.secondary = {data.r,data.g,data.b}
            cb(true)

        elseif modType == 'smoke' then
            ToggleVehicleMod(veh, 20 , true)
            SetVehicleTyreSmokeColor(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.smoke = true
            custom.colour.smoke = {data.r,data.g,data.b}
            cb(true)

        elseif modType == 'neon' then
            SetVehicleNeonLightEnabled(veh,0,true)
            SetVehicleNeonLightEnabled(veh,1,true)
            SetVehicleNeonLightEnabled(veh,2,true)
            SetVehicleNeonLightEnabled(veh,3,true)
            SetVehicleNeonLightsColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.colour.neon = {data.r,data.g,data.b}
            cb(true) 
           
        elseif modType == 'customcolor' then 
            local customColor = data.customColor
            local colorP = data.colorP
            local op = data.op
            local colorTable 
            if customColor == 'metalic' then 
                colorTable = Metalic 
            elseif customColor == 'matte' then 
                colorTable = Matte 
            elseif customColor == 'metal' then 
                colorTable = Metal 
            elseif customColor == 'smetalic' then
                colorTable = Metalic 
            elseif customColor == 'smatte' then 
                colorTable = Matte 
            elseif customColor == 'smetal' then 
                colorTable = Metal 
            elseif customColor == 'pearlescent' then 
                colorTable = Pearlescent 
            elseif customColor == 'wheel' then 
                colorTable = Wheel 
            end
            if op == '+' then
                if selectedColors[customColor] == #colorTable then
                    selectedColors[customColor] = 1
                else
                    selectedColors[customColor] = selectedColors[customColor] + 1
                end
            else
                if selectedColors[customColor] == 1 then
                    selectedColors[customColor] = #colorTable
                else
                    selectedColors[customColor] = selectedColors[customColor] - 1
                end
            end
            if colorP == 'primary' then 
                SetVehicleModKit(veh,0)
                ClearVehicleCustomPrimaryColour(veh)
                SetVehicleColours(veh, colorTable[selectedColors[customColor]].id, custom.colour.secondary)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true) 
            elseif colorP == 'secundary' then
                SetVehicleModKit(veh,0)
                ClearVehicleCustomSecondaryColour(veh)
                SetVehicleColours(veh, custom.colour.primary, colorTable[selectedColors[customColor]].id)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            elseif colorP == 'extra1' then
                SetVehicleModKit(veh,0)
                custom.colour.pearlescent = colorTable[selectedColors[customColor]].id
                SetVehicleExtraColours(veh,colorTable[selectedColors[customColor]].id,custom.colour.wheel)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            elseif colorP == 'extra2' then
                SetVehicleModKit(veh,0)
                custom.colour.wheel = colorTable[selectedColors[customColor]].id
                SetVehicleExtraColours(veh, custom.colour.pearlescent, colorTable[selectedColors[customColor]].id)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            end
        end
        SendNUIMessage({ action = "update", totalPrice = 0, playerMoney = playerMoney })
    end
end)

RegisterNUICallback("changeCamera", function(data, cb)
    if data.type then
        
        if data.type == "Spoiler" then
            MoveVehCam('back',0.5,-1.6,1.3)
        elseif data.type == "FBumper" then
            MoveVehCam('front',-0.6,1.5,0.4)
        elseif data.type == "RBumper" then
            MoveVehCam('back',-0.5,-1.5,0.2)
        elseif data.type == "SSkirt" then
            MoveVehCam('left',-1.8,-1.3,0.7)
        elseif data.type == "Exhaust" then
            PointCamAtBone("exhaust",-0.4,-1.0,0.3)
        elseif data.type == "Frame" then
            SetFollowVehicleCamViewMode(4)
            SetCamRot(cam, 0, 0, 0, 0)
        elseif data.type == "SWheels" or data.type == "MWheels" or data.type == "LWheels" or data.type == "SuvWheels" or data.type == "OWheels"
        or data.type == "TWheels" or data.type == "HWheels" or data.type == "BWheels" or data.type == "BackWheels" or data.type == 'pneus' then  
            PointCamAtBone("wheel_lf",-1.4,0,0.3)
        elseif data.type == "Suspension" then
            MoveVehCam('left',-1.8,-1.3,0.7)
        elseif data.type == "Grille" then
            MoveVehCam('front',-0.6,1.5,0.4)
        elseif data.type == "Hood" then
            MoveVehCam('front',-0.6,1.5,1.5)
        elseif data.type == "Fender" then
            MoveVehCam('left',-1.8,-1.3,0.7)
        elseif data.type == "Roof" then         
            MoveVehCam('front-top',-0.5,1.3,1.0)
        elseif data.type == "Engine" then         
            PointCamAtBone("engine",2.0,3.0,2.0)
            SetVehicleDoorOpen(vehSelected,4,0,0)
        elseif data.type == "Brakes" then
            MoveVehCam('left',-1.8,-1.3,0.7)
        elseif data.type == "Transmission" then
            PointCamAtBone("engine",2.0,3.0,2.0)
            SetVehicleDoorOpen(vehSelected,4,1,1)
        elseif data.type == "painel" then
            SetVehicleDoorOpen(vehSelected,0,0,0)
            PointCamAtBone("windscreen",-1.3,-1.5,0.0)    
        elseif data.type == "Macaneta" then   
            PointCamAtBone("door_dside_f",-1.3,-1.5,0.0)    
            SetVehicleDoorOpen(vehSelected,0,0,0)
            SetVehicleDoorOpen(vehSelected,1,0,0)
        elseif data.type == "Xenon" then   
            PointCamAtBone("headlight_l",0.0,1.0,0.0)    
        elseif data.type == "SupPlaca" then          
            MoveVehCam('front',0.0,1.0,0.4)
        elseif data.type == "Bancos" then          
            SetVehicleDoorOpen(vehSelected,0,0,0)
            PointCamAtBone("seat_dside_f",-1.0,0.0,0.5)    
        elseif data.type == "Volante" then           
            SetVehicleDoorOpen(vehSelected,0,0,0)
            PointCamAtBone("windscreen",-1.3,-1.5,0.0)   
        elseif data.type == "Placa" then       
            MoveVehCam('back',-0.5,-1.5,0)
        elseif data.type == "Tanque" then   
            -- nao encontrei
            MoveVehCam('back',-0.5,-1.5,1.2)
            SetVehicleDoorOpen(vehSelected,4,0,0)
            SetVehicleDoorOpen(vehSelected,5,0,0)

        elseif data.type == "Cfarois" then          
            MoveVehCam('front',0.0,1.0,0.4)
        elseif data.type == "Antenas" then         
            MoveVehCam('front',0.0,1.0,1.4)
        elseif data.type == "FiltrodeAr" or data.type == "Struts" or data.type == "PlacadeMotor" then             
            PointCamAtBone("engine",0.0,0.0,2.0)
            SetVehicleDoorOpen(vehSelected,4,1,1) 
        elseif data.type == "reset" then
            defaultCam()
        end
    end
end)

function src.updateCustoms(veh)
    _, custom = getVehicleMods(veh)
    updateColors(custom,veh)
end

function updateColors(custom,veh)
    local smokeR, smokeG, smokeB = table.unpack(custom['colour']['smoke'])
    local neonR, neonG, neonB = table.unpack(custom['colour']['neon'])
    local primaryR, primaryG, primaryB = table.unpack(custom['colour']['custom']['primary'])
    local secondaryR, secondaryG, secondaryB = table.unpack(custom['colour']['custom']['secondary'])
    SendNUIMessage({ 
        action = 'updateColors',  
        primary = {r = primaryR, g = primaryG, b = primaryB},
        secondary = {r = secondaryR, g = secondaryG, b = secondaryB},
        smoke = { r = smokeR, g = smokeG, b = smokeB},
        neon = { r = neonR, g = neonG, b = neonB}
    }) 
    SetVehicleNeonLightEnabled(veh,0,tonumber(custom['neon']['left']))
    SetVehicleNeonLightEnabled(veh,1,tonumber(custom['neon']['right']))
    SetVehicleNeonLightEnabled(veh,2,tonumber(custom['neon']['front']))
    SetVehicleNeonLightEnabled(veh,3,tonumber(custom['neon']['back']))

    if not custom['neon']['left'] then 
        SetVehicleNeonLightEnabled(veh,0,false)
        SetVehicleNeonLightEnabled(veh,1,false)
        SetVehicleNeonLightEnabled(veh,2,false)
        SetVehicleNeonLightEnabled(veh,3,false)
    end
end

function src.updateTotalPrice(price)
    totalPrice = 0
    SendNUIMessage({ action = 'updatePrice', totalPrice = totalPrice })
end

RegisterNUICallback("acceptMod", function(data, cb)
    local valor = tonumber(data.price)
    local prices = sv.getTotal()
    sv.updateMoney(valor)
    sv.somar(valor)
    sv.savedbcar(custom)
    sv.updateOld(custom)
    local playerMoney = sv.getPlayerTotalMoney()
    SendNUIMessage({ action = "update", totalPrice = prices, playerMoney = playerMoney })
end)

RegisterNUICallback("declineMod", function(data, cb)
    local prices = sv.getTotal()
    local playerMoney = sv.getPlayerTotalMoney()
    sv.savedbcar(sv.getCustoms())
    updateCar(vehSelected,sv.getCustoms())
    SendNUIMessage({ action = "update", totalPrice = prices, playerMoney = playerMoney })
end)

function updateCar(veh,saves)
    local customs = {}
    customs.spoiler = saves.mods[0]
    customs.fbumper = saves.mods[1]
    customs.rbumper = saves.mods[2]
    customs.skirts = saves.mods[3]
    customs.exhaust = saves.mods[4]
    customs.rollcage = saves.mods[5]
    customs.grille = saves.mods[6]
    customs.hood = saves.mods[7]
    customs.fenders = saves.mods[8]
    customs.roof = saves.mods[10]
    customs.engine = saves.mods[11]
    customs.brakes = saves.mods[12]
    customs.transmission = saves.mods[13]
    customs.horn = saves.mods[14]
    customs.suspension = saves.mods[15]
    customs.armor = saves.mods[16]
    customs.tires = saves.mods[23]
    customs.tiresvariation = saves.mods[23]

    customs.btires = saves.mods[24]
    customs.btiresvariation = saves.mods[24]

    customs.plateholder = saves.mods[25]
    customs.vanityplates = saves.mods[26]
    customs.trimdesign = saves.mods[27] 
    customs.ornaments = saves.mods[28]
    customs.dashboard = saves.mods[29]
    customs.dialdesign = saves.mods[30]
    customs.doors = saves.mods[31]
    customs.seats = saves.mods[32]
    customs.steeringwheels = saves.mods[33]
    customs.shiftleavers = saves.mods[34]
    customs.plaques = saves.mods[35]
    customs.speakers = saves.mods[36]
    customs.trunk = saves.mods[37] 
    customs.hydraulics = saves.mods[38]
    customs.engineblock = saves.mods[39]
    customs.camcover = saves.mods[40]
    customs.strutbrace = saves.mods[41]
    customs.archcover = saves.mods[42]
    customs.aerials = saves.mods[43]
    customs.roofscoops = saves.mods[44]
    customs.tank = saves.mods[45]
    customs.doors = saves.mods[46]
    customs.liveries = saves.mods[48]

    customs.tyresmoke = saves.mods[20]
    customs.headlights = saves.mods[22]
    customs.turbo = saves.mods[18]
    
    customs.colorp = saves.colour.custom.primary
    customs.colors = saves.colour.custom.secondary
    customs.neoncolor = saves.colour.neon
    customs.smokecolor = saves.colour.smoke
    customs.tyresmoke = saves.fumaca
    customs.neon = saves.neon.back

-- 	customs.color = veh.color
    customs.extracolor = {saves.colour.pearlescent,saves.colour.wheel}
-- 	customs.neon = veh.neon
-- 	customs.neoncolor = veh.neoncolor
-- 	customs.smokecolor = veh.smokecolor
    customs.plateindex = saves.plate.index
    customs.windowtint = saves.janela
    customs.wheeltype = saves.wheel
    customs.xenon = saves.xenon
	if customs and veh then
		SetVehicleModKit(veh,0)
        if customs.colorp then
			SetVehicleCustomPrimaryColour(veh,tonumber(customs.colorp[1]),tonumber(customs.colorp[2]),tonumber(customs.colorp[3]))
		end

		if customs.extracolor then
			SetVehicleExtraColours(veh,tonumber(customs.extracolor[1]),tonumber(customs.extracolor[2]))
		end

		if customs.colors then
			SetVehicleCustomSecondaryColour(veh,tonumber(customs.colors[1]),tonumber(customs.colors[2]),tonumber(customs.colors[3]))
		end

		if customs.smokecolor then
			SetVehicleTyreSmokeColor(veh,tonumber(customs.smokecolor[1]),tonumber(customs.smokecolor[2]),tonumber(customs.smokecolor[3]))
		end

		if customs.neon then
			SetVehicleNeonLightEnabled(veh,tonumber(customs.neon),1)
			SetVehicleNeonLightEnabled(veh,tonumber(customs.neon),1)
			SetVehicleNeonLightEnabled(veh,tonumber(customs.neon),1)
			SetVehicleNeonLightEnabled(veh,tonumber(customs.neon),1)
			SetVehicleNeonLightsColour(veh,tonumber(customs.neoncolor[1]),tonumber(customs.neoncolor[2]),tonumber(customs.neoncolor[3]))
		else
			SetVehicleNeonLightEnabled(veh,0,0)
			SetVehicleNeonLightEnabled(veh,1,0)
			SetVehicleNeonLightEnabled(veh,2,0)
			SetVehicleNeonLightEnabled(veh,3,0)
		end

		if customs.plateindex then
			SetVehicleNumberPlateTextIndex(veh,tonumber(customs.plateindex))
		end

		if customs.windowtint then
			SetVehicleWindowTint(veh,tonumber(customs.windowtint))
		end

		if customs.bulletProofTyres then
			SetVehicleTyresCanBurst(veh,customs.bulletProofTyres)
		end

		if customs.wheeltype then
			SetVehicleWheelType(veh,tonumber(customs.wheeltype))
		end

		if customs.spoiler then
			SetVehicleMod(veh,0,tonumber(customs.spoiler))
			SetVehicleMod(veh,1,tonumber(customs.fbumper))
			SetVehicleMod(veh,2,tonumber(customs.rbumper))
			SetVehicleMod(veh,3,tonumber(customs.skirts))
			SetVehicleMod(veh,4,tonumber(customs.exhaust))
			SetVehicleMod(veh,5,tonumber(customs.rollcage))
			SetVehicleMod(veh,6,tonumber(customs.grille))
			SetVehicleMod(veh,7,tonumber(customs.hood))
			SetVehicleMod(veh,8,tonumber(customs.fenders))
			SetVehicleMod(veh,10,tonumber(customs.roof))
			SetVehicleMod(veh,11,tonumber(customs.engine))
			SetVehicleMod(veh,12,tonumber(customs.brakes))
			SetVehicleMod(veh,13,tonumber(customs.transmission))
			SetVehicleMod(veh,14,tonumber(customs.horn))
			SetVehicleMod(veh,15,tonumber(customs.suspension))
			SetVehicleMod(veh,16,tonumber(customs.armor))
			SetVehicleMod(veh,23,tonumber(customs.tires),customs.tiresvariation)
		
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleMod(veh,24,tonumber(customs.btires),customs.btiresvariation)
			end
		
			SetVehicleMod(veh,25,tonumber(customs.plateholder))
			SetVehicleMod(veh,26,tonumber(customs.vanityplates))
			SetVehicleMod(veh,27,tonumber(customs.trimdesign)) 
			SetVehicleMod(veh,28,tonumber(customs.ornaments))
			SetVehicleMod(veh,29,tonumber(customs.dashboard))
			SetVehicleMod(veh,30,tonumber(customs.dialdesign))
			SetVehicleMod(veh,31,tonumber(customs.doors))
			SetVehicleMod(veh,32,tonumber(customs.seats))
			SetVehicleMod(veh,33,tonumber(customs.steeringwheels))
			SetVehicleMod(veh,34,tonumber(customs.shiftleavers))
			SetVehicleMod(veh,35,tonumber(customs.plaques))
			SetVehicleMod(veh,36,tonumber(customs.speakers))
			SetVehicleMod(veh,37,tonumber(customs.trunk)) 
			SetVehicleMod(veh,38,tonumber(customs.hydraulics))
			SetVehicleMod(veh,39,tonumber(customs.engineblock))
			SetVehicleMod(veh,40,tonumber(customs.camcover))
			SetVehicleMod(veh,41,tonumber(customs.strutbrace))
			SetVehicleMod(veh,42,tonumber(customs.archcover))
			SetVehicleMod(veh,43,tonumber(customs.aerials))
			SetVehicleMod(veh,44,tonumber(customs.roofscoops))
			SetVehicleMod(veh,45,tonumber(customs.tank))
			SetVehicleMod(veh,46,tonumber(customs.doors))
			SetVehicleMod(veh,48,tonumber(customs.liveries))
			SetVehicleLivery(veh,tonumber(customs.liveries))

			ToggleVehicleMod(veh,20,customs.tyresmoke)
			ToggleVehicleMod(veh,22,customs.headlights)
			SetVehicleXenonLightsColour(veh,customs.xenon)
			ToggleVehicleMod(veh,18,customs.turbo)
		end
	end
end



