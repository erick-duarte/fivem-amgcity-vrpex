local pedlist = {
--- venda de maconha
--	{ ['x'] = -1679.66, ['y'] = -264.34, ['z'] = 51.89, ['h'] = 59.55, ['hash'] = 0xE497BBEF, ['hash2'] = "s_m_y_dealer_01" },
--
--- venda de coca
--	{ ['x'] = -1089.67, ['y'] = -2397.98, ['z'] = 13.95, ['h'] = 150.52, ['hash'] = 0x62018559, ['hash2'] = "s_m_y_airworker" },
 
-- Venda de meta
	{ ['x'] = -51.91, ['y'] = -2761.0, ['z'] = 6.09, ['h'] = 1.51, ['hash'] = 0xCAE9E5D5, ['hash2'] = "Csb_Cletus" }, -- outros

---- Venda Munições
--	{ ['x'] = 951.8, ['y'] = -2527.47, ['z'] = 28.33, ['h'] = 176.42, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Aztecas
--	{ ['x'] = 1308.87, ['y'] = 316.07, ['z'] = 82.0, ['h'] = 55.65, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Metralhas
---- Venda armas
--	{ ['x'] = 1571.25, ['y'] = -2167.19, ['z'] = 77.59, ['h'] = 78.08, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Mafia

-- Vacas
	{ ['x'] = 425.55, ['y'] = 6463.64, ['z'] = 28.79, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 431.11, ['y'] = 6459.52, ['z'] = 28.76, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 436.25, ['y'] = 6454.87, ['z'] = 28.75, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 429.02, ['y'] = 6476.92, ['z'] = 28.79, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" },
	{ ['x'] = 434.12, ['y'] = 6472.93, ['z'] = 28.78, ['h'] = 134.37, ['hash'] = 0xFCFA9E1E, ['hash2'] = "A_C_Cow" }
	
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)