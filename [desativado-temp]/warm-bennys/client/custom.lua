function getVehicleMods(veh)
	if IsEntityAVehicle(veh) then
		local custom = {}
		if DoesEntityExist(veh) then
			local colors = { }
			local toggles = { }
			local mods = {}
			local colours = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			custom.plate = {}
			custom.plate.text = GetVehicleNumberPlateText(veh)
			custom.plate.index = GetVehicleNumberPlateTextIndex(veh)

			custom.colour = {}
			custom.colour.primary = colours[1]
			custom.colour.secondary = colours[2]
			custom.colour.pearlescent = extra_colors[1]
			custom.colour.wheel = extra_colors[2]
			custom.colour.xenon = GetVehicleXenonLightsColour(veh)
			colors[1] = custom.colour.primary
			colors[2] = custom.colour.secondary
			colors[3] = custom.colour.pearlescent
			colors[4] = custom.colour.wheel

			custom.colour.neon = table.pack(GetVehicleNeonLightsColour(veh))
			custom.colour.smoke = table.pack(GetVehicleTyreSmokeColor(veh))

			custom.colour.custom = {}
			custom.colour.custom.primary = table.pack(GetVehicleCustomPrimaryColour(veh))
			custom.colour.custom.secondary = table.pack(GetVehicleCustomSecondaryColour(veh))

			custom.mods = {}
			for i = 0,49 do
				custom.mods[i] = GetVehicleMod(veh, i)
			end

			custom.mods[46] = GetVehicleWindowTint(veh)
			custom.mods[18] = IsToggleModOn(veh,18)
			custom.mods[20] = IsToggleModOn(veh,20)
			custom.mods[22] = IsToggleModOn(veh,22)
			custom.turbo = IsToggleModOn(veh,18)
			custom.janela = GetVehicleWindowTint(veh)
			custom.fumaca = IsToggleModOn(veh,20)
			custom.farol = IsToggleModOn(veh,22)
			custom.tyres = GetVehicleMod(veh,23)
			custom.tyresvariation = GetVehicleModVariation(veh,23)

			mods = custom.mods
			toggles[18] = custom.mods[18]
			toggles[20] = custom.mods[20]
			toggles[22] = custom.mods[22]

			custom.neon = {}
			custom.neon.left = IsVehicleNeonLightEnabled(veh,0)
			custom.neon.right = IsVehicleNeonLightEnabled(veh,1)
			custom.neon.front = IsVehicleNeonLightEnabled(veh,2)
			custom.neon.back = IsVehicleNeonLightEnabled(veh,3)

			custom.bulletproof = GetVehicleTyresCanBurst(veh)
			custom.wheel = GetVehicleWheelType(veh)
			wheel = custom.wheel
			return veh,custom,GetVehicleNumberPlateText(veh)
		end
	end
	return false,false
end

function setVehicleMods(veh,custom)
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.colour then
			SetVehicleColours(veh,tonumber(custom.colour.primary),tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh,tonumber(custom.colour.pearlescent),tonumber(custom.colour.wheel))
			if custom.colour.neon then
				SetVehicleNeonLightsColour(veh,tonumber(custom.colour.neon[1]),tonumber(custom.colour.neon[2]),tonumber(custom.colour.neon[3]))
			end
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				SetVehicleXenonLightsColour(veh,custom.colour.xenon)
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end

		if custom.plate then
			SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plate.index))
		end

		SetVehicleWindowTint(veh,tonumber(custom.janela))
		SetVehicleTyresCanBurst(veh,tonumber(custom.bulletproof))
		SetVehicleWheelType(veh,tonumber(custom.wheel))

		ToggleVehicleMod(veh,18,tonumber(custom.turbo))
		ToggleVehicleMod(veh,20,tonumber(custom.fumaca))
		ToggleVehicleMod(veh,22,tonumber(custom.farol))

		if custom.neon then
			SetVehicleNeonLightEnabled(veh,0,tonumber(custom.neon.left))
			SetVehicleNeonLightEnabled(veh,1,tonumber(custom.neon.right))
			SetVehicleNeonLightEnabled(veh,2,tonumber(custom.neon.front))
			SetVehicleNeonLightEnabled(veh,3,tonumber(custom.neon.back))
		end

		for i,mod in pairs(custom.mods) do
			if i ~= 18 and i ~= 20 and i ~= 22 and i ~= 46 then
				SetVehicleMod(veh,tonumber(i),tonumber(mod))
			end
		end
		SetVehicleMod(veh,23,tonumber(custom.tyres),custom.tyresvariation)
		SetVehicleMod(veh,24,tonumber(custom.tyres),custom.tyresvariation)
	end
end