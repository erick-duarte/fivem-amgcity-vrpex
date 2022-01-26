local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")

--[ WEBHOOK ]----------------------------------------------------------------------------------------------------------------------------

local casaslog = "https://discord.com/api/webhooks/845497342756388925/iROOFzKxVGjuuUQj7UxQFLKpZ2ewhQ8j3i1afw3UchQum43L6J7hcef4JMSiQmDoglf5"

--[ PREPARES ]---------------------------------------------------------------------------------------------------------------------------

vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")

--[ HOMESINFO ]--------------------------------------------------------------------------------------------------------------------------

local homes = {

--[ FORTHILLS ]--------------------------------------------------------------------------------------------------------------------------

	["FH01"] = { 900000,2,800 },
	["FH02"] = { 800000,2,800 },
	["FH03"] = { 750000,2,800 },
	["FH04"] = { 700000,2,800 },
	["FH05"] = { 750000,2,800 },
	["FH06"] = { 800000,2,800 },
	["FH07"] = { 800000,2,800 },
	["FH08"] = { 500000,2,800 },
	["FH09"] = { 600000,2,800 },
	["FH10"] = { 600000,2,800 },
	["FH11"] = { 650000,2,800 },
	["FH12"] = { 700000,2,800 },
	["FH13"] = { 850000,2,800 },
	["FH14"] = { 750000,2,800 },
	["FH15"] = { 650000,2,800 },
	["FH16"] = { 450000,2,800 },
	["FH17"] = { 550000,2,800 },
	["FH18"] = { 750000,2,800 },
	["FH19"] = { 700000,2,800 },
	["FH20"] = { 750000,2,800 },
	["FH21"] = { 800000,2,800 },
	["FH22"] = { 650000,2,800 },
	["FH23"] = { 750000,2,800 },
	["FH24"] = { 750000,2,800 },
	["FH25"] = { 700000,2,800 },
	["FH26"] = { 750000,2,800 },
	["FH27"] = { 650000,2,800 },
	["FH28"] = { 700000,2,800 },
	["FH29"] = { 700000,2,800 },
	["FH30"] = { 700000,2,800 },
	["FH31"] = { 900000,2,800 },
	["FH32"] = { 750000,2,800 },
	["FH33"] = { 600000,2,800 },
	["FH34"] = { 750000,2,800 },
	["FH35"] = { 500000,2,800 },
	["FH36"] = { 600000,2,800 },
	["FH37"] = { 650000,2,800 },
	["FH38"] = { 650000,2,800 },
	["FH39"] = { 650000,2,800 },
	["FH40"] = { 650000,2,800 },
	["FH41"] = { 650000,2,800 },
	["FH42"] = { 650000,2,800 },
	["FH43"] = { 650000,2,800 },
	["FH44"] = { 550000,2,800 },
	["FH45"] = { 750000,2,800 },
	["FH46"] = { 650000,2,800 },
	["FH47"] = { 700000,2,800 },
	["FH48"] = { 750000,2,800 },
	["FH49"] = { 800000,2,800 },
	["FH50"] = { 900000,2,800 },
	["FH51"] = { 650000,2,800 },
	["FH52"] = { 890000,2,800 },
	["FH53"] = { 900000,2,800 },
	["FH54"] = { 900000,2,800 },
	["FH55"] = { 880000,2,800 },
	["FH56"] = { 500000,2,800 },
	["FH57"] = { 1000000,2,800 },
	["FH58"] = { 850000,2,800 },
	["FH59"] = { 650000,2,800 },
	["FH60"] = { 550000,2,800 },
	["FH61"] = { 700000,2,800 },
	["FH62"] = { 850000,2,800 },
	["FH63"] = { 900000,2,800 },
	["FH64"] = { 850000,2,800 },
	["FH65"] = { 850000,2,800 },
	["FH66"] = { 800000,2,800 },
	["FH67"] = { 600000,2,800 },
	["FH68"] = { 700000,2,800 },
	["FH69"] = { 550000,2,800 },
	["FH70"] = { 700000,2,800 },
	["FH71"] = { 670000,2,800 },
	["FH72"] = { 700000,2,800 },
	["FH73"] = { 800000,2,800 },
	["FH74"] = { 550000,2,800 },
	["FH75"] = { 550000,2,800 },
	["FH76"] = { 600000,2,800 },
	["FH77"] = { 500000,2,800 },
	["FH78"] = { 500000,2,800 },
	["FH79"] = { 500000,2,800 },
	["FH80"] = { 500000,2,800 },
	["FH81"] = { 700000,2,800 },
	["FH82"] = { 600000,2,800 },
	["FH83"] = { 540000,2,800 },
	["FH84"] = { 800000,2,800 },
	["FH85"] = { 800000,2,800 },
	["FH86"] = { 550000,2,800 },
	["FH87"] = { 550000,2,800 },
	["FH88"] = { 800000,2,800 },
	["FH89"] = { 560000,2,800 },
	["FH90"] = { 600000,2,800 },
	["FH91"] = { 600000,2,800 },
	["FH92"] = { 760000,2,800 },
	["FH93"] = { 800000,2,800 },
	["FH94"] = { 800000,2,800 },
	["FH95"] = { 760000,2,800 },
	["FH96"] = { 800000,2,800 },
	["FH97"] = { 600000,2,800 },
	["FH98"] = { 800000,2,800 },
	["FH99"] = { 740000,2,800 },
	["FH100"] = { 560000,2,800 },
	
	--[ LUXURY ]-----------------------------------------------------------------------------------------------------------------------------
	
	["LX02"] = { 2800000,2,1000 },
	["LX01"] = { 1000000,2,1000 },
	["LX03"] = { 2500000,2,1000 },
	["LX04"] = { 1500000,2,1000 },
	["LX05"] = { 800000,2,1000 },
	["LX06"] = { 2900000,2,1000 },
	["LX07"] = { 1500000,2,1000 },
	["LX08"] = { 2600000,2,1000 },
	["LX09"] = { 1400000,2,1000 },
	["LX10"] = { 1000000,2,1000 },
	["LX11"] = { 2000000,2,1000 },
	["LX12"] = { 1500000,2,1000 },
	["LX13"] = { 1900000,2,1000 },
	["LX14"] = { 1000000,2,1000 },
	["LX15"] = { 1500000,2,1000 },
	["LX16"] = { 1700000,2,1000 },
	["LX17"] = { 1700000,2,1000 },
	["LX18"] = { 1300000,2,1000 },
	["LX19"] = { 1900000,2,1000 },
	["LX20"] = { 1800000,2,1000 },
	["LX21"] = { 1200000,2,1000 },
	["LX22"] = { 2700000,2,1000 },
	["LX23"] = { 2000000,2,1000 },
	["LX24"] = { 2300000,2,1000 },
	["LX25"] = { 2300000,15,5000 },
	["LX26"] = { 1700000,2,1000 },
	["LX27"] = { 1800000,2,1000 },
	["LX28"] = { 800000,2,1000 },
	["LX29"] = { 870000,2,1000 },
	["LX30"] = { 960000,2,1000 },
	["LX31"] = { 850000,2,1000 },
	["LX32"] = { 950000,2,1000 },
	["LX33"] = { 1600000,2,1000 },
	["LX34"] = { 1400000,2,1000 },
	["LX35"] = { 1000000,2,1000 },
	["LX36"] = { 2300000,2,1000 },
	["LX37"] = { 1300000,2,1000 },
	["LX38"] = { 1600000,2,1000 },
	["LX39"] = { 1600000,2,1000 },
	["LX40"] = { 1700000,2,1000 },
	["LX41"] = { 1700000,2,1000 },
	["LX42"] = { 950000,2,1000 },
	["LX43"] = { 1000000,2,1000 },
	["LX44"] = { 1400000,2,1000 },
	["LX45"] = { 9500000,2,1000 },
	["LX46"] = { 3500000,2,1000 },
	["LX47"] = { 950000,2,1000 },
	["LX48"] = { 850000,2,1000 },
	["LX49"] = { 800000,2,1000 },
	["LX50"] = { 900000,2,1000 },
	["LX51"] = { 1600000,2,1000 },
	["LX52"] = { 1400000,2,1000 },
	["LX53"] = { 2500000,2,1000 },
	["LX54"] = { 2000000,2,1000 },
	["LX55"] = { 1000000,2,1000 },
	["LX56"] = { 1500000,2,1000 },
	["LX57"] = { 1400000,2,1000 },
	["LX58"] = { 1700000,2,1000 },
	["LX59"] = { 1600000,2,1000 },
	["LX60"] = { 1800000,2,1000 },
	["LX61"] = { 1800000,2,1000 },
	["LX62"] = { 1600000,2,1000 },
	["LX63"] = { 1500000,2,1000 },
	["LX64"] = { 1800000,2,1000 },
	["LX65"] = { 1800000,2,1000 },
	["LX66"] = { 1800000,2,1000 },
	["LX67"] = { 1500000,2,1000 },
	["LX68"] = { 1800000,2,1000 },
	["LX69"] = { 1800000,2,1000 },
	["LX70"] = { 1500000,2,1000 },	
	
	--[ SAMIR ]------------------------------------------------------------------------------------------------------------------------------
	
	["LS01"] = { 650000,2,450 },
	["LS02"] = { 650000,2,450 },
	["LS03"] = { 650000,2,450 },
	["LS04"] = { 650000,2,450 },
	["LS05"] = { 650000,2,450 },
	["LS06"] = { 650000,2,450 },
	["LS07"] = { 650000,2,450 },
	["LS08"] = { 650000,2,450 },
	["LS09"] = { 650000,2,450 },
	["LS10"] = { 650000,2,450 },
	["LS11"] = { 450000,2,450 },
	["LS12"] = { 560000,2,450 },
	["LS13"] = { 560000,2,450 },
	["LS14"] = { 540000,2,450 },
	["LS15"] = { 350000,2,450 },
	["LS16"] = { 610000,2,450 },
	["LS17"] = { 480000,2,450 },
	["LS18"] = { 640000,2,450 },
	["LS19"] = { 590000,2,450 },
	["LS20"] = { 600000,2,450 },
	["LS21"] = { 450000,2,450 },
	["LS22"] = { 570000,2,450 },
	["LS23"] = { 550000,2,450 },
	["LS24"] = { 630000,2,450 },
	["LS25"] = { 670000,2,450 },
	["LS26"] = { 730000,2,450 },
	["LS27"] = { 730000,2,450 },
	["LS28"] = { 730000,2,450 },
	["LS29"] = { 550000,2,450 },
	["LS30"] = { 600000,2,450 },
	["LS31"] = { 650000,2,450 },
	["LS32"] = { 440000,2,450 },
	["LS33"] = { 450000,2,450 },
	["LS34"] = { 470000,2,450 },
	["LS35"] = { 540000,2,450 },
	["LS36"] = { 780000,2,450 },
	["LS37"] = { 650000,2,450 },
	["LS38"] = { 600000,2,450 },
	["LS39"] = { 590000,2,450 },
	["LS40"] = { 730000,2,450 },
	["LS41"] = { 520000,2,450 },
	["LS42"] = { 580000,2,450 },
	["LS43"] = { 700000,2,450 },
	["LS44"] = { 600000,2,450 },
	["LS45"] = { 480000,2,450 },
	["LS46"] = { 550000,2,450 },
	["LS47"] = { 750000,2,450 },
	["LS48"] = { 500000,2,450 },
	["LS49"] = { 440000,2,450 },
	["LS50"] = { 750000,2,450 },
	["LS51"] = { 350000,2,450 },
	["LS52"] = { 320000,2,450 },
	["LS53"] = { 320000,2,450 },
	["LS54"] = { 500000,2,450 },
	["LS55"] = { 420000,2,450 },
	["LS56"] = { 360000,2,450 },
	["LS57"] = { 360000,2,450 },
	["LS58"] = { 460000,2,450 },
	["LS59"] = { 340000,2,450 },
	["LS60"] = { 500000,2,450 },
	["LS61"] = { 340000,2,450 },
	["LS62"] = { 280000,2,450 },
	["LS63"] = { 350000,2,450 },
	["LS64"] = { 350000,2,450 },
	["LS65"] = { 300000,2,450 },
	["LS66"] = { 350000,2,450 },
	["LS67"] = { 280000,2,450 },
	["LS68"] = { 400000,2,450 },
	["LS69"] = { 400000,2,450 },
	["LS70"] = { 300000,2,450 },
	["LS71"] = { 350000,2,450 },
	["LS72"] = { 350000,2,450 },
	
	--[ BOLLINI ]----------------------------------------------------------------------------------------------------------------------------
	
	["BL01"] = { 200000,2,200 },
	["BL02"] = { 200000,2,200 },
	["BL03"] = { 200000,2,200 },
	["BL04"] = { 200000,2,200 },
	["BL05"] = { 200000,2,200 },
	["BL06"] = { 200000,2,200 },
	["BL07"] = { 200000,2,200 },
	["BL08"] = { 200000,2,200 },
	["BL09"] = { 200000,2,200 },
	["BL10"] = { 200000,2,200 },
	["BL11"] = { 200000,2,200 },
	["BL12"] = { 200000,2,200 },
	["BL13"] = { 200000,2,200 },
	["BL14"] = { 200000,2,200 },
	["BL15"] = { 200000,2,200 },
	["BL16"] = { 200000,2,200 },
	["BL17"] = { 200000,2,200 },
	["BL18"] = { 200000,2,200 },
	["BL19"] = { 200000,2,200 },
	["BL20"] = { 200000,2,200 },
	["BL21"] = { 200000,2,200 },
	["BL22"] = { 200000,2,200 },
	["BL23"] = { 200000,2,200 },
	["BL24"] = { 200000,2,200 },
	["BL25"] = { 200000,2,200 },
	["BL26"] = { 200000,2,200 },
	["BL27"] = { 200000,2,200 },
	["BL28"] = { 200000,2,200 },
	["BL29"] = { 200000,2,200 },
	["BL30"] = { 200000,2,200 },
	["BL31"] = { 200000,2,200 },
	["BL32"] = { 200000,2,200 },
	
	--[ LOSVAGOS ]---------------------------------------------------------------------------------------------------------------------------
	
	["LV01"] = { 250000,2,250 },
	["LV02"] = { 250000,2,250 },
	["LV03"] = { 250000,2,250 },
	["LV04"] = { 250000,2,250 },
	["LV05"] = { 250000,2,250 },
	["LV06"] = { 250000,2,250 },
	["LV07"] = { 250000,2,250 },
	["LV08"] = { 250000,2,250 },
	["LV09"] = { 250000,2,250 },
	["LV10"] = { 250000,2,250 },
	["LV11"] = { 250000,2,250 },
	["LV12"] = { 250000,2,250 },
	["LV13"] = { 250000,2,250 },
	["LV14"] = { 250000,2,250 },
	["LV15"] = { 250000,2,250 },
	["LV16"] = { 250000,2,250 },
	["LV17"] = { 250000,2,250 },
	["LV18"] = { 250000,2,250 },
	["LV19"] = { 250000,2,250 },
	["LV20"] = { 250000,2,250 },
	["LV21"] = { 250000,2,250 },
	["LV22"] = { 250000,2,250 },
	["LV23"] = { 250000,2,250 },
	["LV24"] = { 250000,2,250 },
	["LV25"] = { 250000,2,250 },
	["LV26"] = { 250000,2,250 },
	["LV27"] = { 250000,2,250 },
	["LV28"] = { 250000,2,250 },
	["LV29"] = { 250000,2,250 },
	["LV30"] = { 250000,2,250 },
	["LV31"] = { 250000,2,250 },
	["LV32"] = { 250000,2,250 },
	["LV33"] = { 250000,2,250 },
	["LV34"] = { 250000,2,250 },
	["LV35"] = { 250000,2,250 },
	
	--[ KRONDORS ]---------------------------------------------------------------------------------------------------------------------------
	
	["KR01"] = { 200000,2,200 },
	["KR02"] = { 200000,2,200 },
	["KR03"] = { 200000,2,200 },
	["KR04"] = { 200000,2,200 },
	["KR05"] = { 200000,2,200 },
	["KR06"] = { 200000,2,200 },
	["KR07"] = { 200000,2,200 },
	["KR08"] = { 200000,2,200 },
	["KR09"] = { 200000,2,200 },
	["KR10"] = { 200000,2,200 },
	["KR11"] = { 200000,2,200 },
	["KR12"] = { 200000,2,200 },
	["KR13"] = { 200000,2,200 },
	["KR14"] = { 200000,2,200 },
	["KR15"] = { 200000,2,200 },
	["KR16"] = { 200000,2,200 },
	["KR17"] = { 200000,2,200 },
	["KR18"] = { 200000,2,200 },
	["KR19"] = { 200000,2,200 },
	["KR20"] = { 200000,2,200 },
	["KR21"] = { 200000,2,200 },
	["KR22"] = { 200000,2,200 },
	["KR23"] = { 200000,2,200 },
	["KR24"] = { 200000,2,200 },
	["KR25"] = { 200000,2,200 },
	["KR26"] = { 200000,2,200 },
	["KR27"] = { 200000,2,200 },
	["KR28"] = { 200000,2,200 },
	["KR29"] = { 200000,2,200 },
	["KR30"] = { 200000,2,200 },
	["KR31"] = { 200000,2,200 },
	["KR32"] = { 200000,2,200 },
	["KR33"] = { 200000,2,200 },
	["KR34"] = { 200000,2,200 },
	["KR35"] = { 200000,2,200 },
	["KR36"] = { 200000,2,200 },
	["KR37"] = { 200000,2,200 },
	["KR38"] = { 200000,2,200 },
	["KR39"] = { 200000,2,200 },
	["KR40"] = { 200000,2,200 },
	["KR41"] = { 200000,2,200 },
	
	--[ GROOVEMOTEL ]------------------------------------------------------------------------------------------------------------------------
	
	["GR01"] = { 140000,2,200 },
	["GR02"] = { 140000,2,200 },
	["GR03"] = { 140000,2,200 },
	["GR04"] = { 140000,2,200 },
	["GR05"] = { 140000,2,200 },
	["GR06"] = { 140000,2,200 },
	["GR07"] = { 140000,2,200 },
	["GR08"] = { 140000,2,200 },
	["GR09"] = { 140000,2,200 },
	["GR10"] = { 140000,2,200 },
	["GR11"] = { 140000,2,200 },
	["GR12"] = { 140000,2,200 },
	["GR13"] = { 140000,2,200 },
	["GR14"] = { 140000,2,200 },
	["GR15"] = { 140000,2,200 },
	
	--[ ALLSUELLMOTEL ]----------------------------------------------------------------------------------------------------------------------
	
	["AS01"] = { 140000,2,200 },
	["AS02"] = { 140000,2,200 },
	["AS03"] = { 140000,2,200 },
	["AS04"] = { 140000,2,200 },
	["AS05"] = { 140000,2,200 },
	["AS06"] = { 140000,2,200 },
	["AS07"] = { 140000,2,200 },
	["AS08"] = { 140000,2,200 },
	["AS09"] = { 140000,2,200 },
	["AS10"] = { 140000,2,200 },
	["AS12"] = { 140000,2,200 },
	["AS13"] = { 140000,2,200 },
	["AS14"] = { 140000,2,200 },
	["AS15"] = { 140000,2,200 },
	["AS16"] = { 140000,2,200 },
	["AS17"] = { 140000,2,200 },
	["AS18"] = { 140000,2,200 },
	["AS19"] = { 140000,2,200 },
	["AS20"] = { 140000,2,200 },
	["AS21"] = { 140000,2,200 },
	
	--[ PINKCAGEMOTEL ]----------------------------------------------------------------------------------------------------------------------
	
	["PC01"] = { 140000,2,150 },
	["PC02"] = { 140000,2,150 },
	["PC03"] = { 140000,2,150 },
	["PC04"] = { 140000,2,150 },
	["PC05"] = { 140000,2,150 },
	["PC06"] = { 140000,2,150 },
	["PC07"] = { 140000,2,150 },
	["PC08"] = { 140000,2,150 },
	["PC09"] = { 140000,2,150 },
	["PC10"] = { 140000,2,150 },
	["PC11"] = { 140000,2,150 },
	["PC12"] = { 140000,2,150 },
	["PC13"] = { 140000,2,150 },
	["PC14"] = { 140000,2,150 },
	["PC15"] = { 140000,2,150 },
	["PC16"] = { 140000,2,150 },
	["PC17"] = { 140000,2,150 },
	["PC18"] = { 140000,2,150 },
	["PC19"] = { 140000,2,150 },
	["PC20"] = { 140000,2,150 },
	["PC21"] = { 140000,2,150 },
	["PC22"] = { 140000,2,150 },
	["PC23"] = { 140000,2,150 },
	["PC24"] = { 140000,2,150 },
	["PC25"] = { 140000,2,150 },
	["PC26"] = { 140000,2,150 },
	["PC27"] = { 140000,2,150 },
	["PC28"] = { 140000,2,150 },
	["PC29"] = { 140000,2,150 },
	["PC30"] = { 140000,2,150 },
	["PC31"] = { 140000,2,150 },
	["PC32"] = { 140000,2,150 },
	["PC33"] = { 140000,2,150 },
	["PC34"] = { 140000,2,150 },
	["PC35"] = { 140000,2,150 },
	["PC36"] = { 140000,2,150 },
	["PC37"] = { 140000,2,150 },
	["PC38"] = { 140000,2,150 },
	
	--[ PALETOMOTEL ]------------------------------------------------------------------------------------------------------------------------
	
	["PL01"] = { 140000,2,150 },
	["PL02"] = { 140000,2,150 },
	["PL03"] = { 140000,2,150 },
	["PL04"] = { 140000,2,150 },
	["PL05"] = { 140000,2,150 },
	["PL06"] = { 140000,2,150 },
	["PL07"] = { 140000,2,150 },
	["PL08"] = { 140000,2,150 },
	["PL09"] = { 140000,2,150 },
	["PL11"] = { 140000,2,150 },
	["PL12"] = { 140000,2,150 },
	["PL13"] = { 140000,2,150 },
	["PL14"] = { 140000,2,150 },
	["PL15"] = { 140000,2,150 },
	["PL16"] = { 140000,2,150 },
	["PL17"] = { 140000,2,150 },
	["PL18"] = { 140000,2,150 },
	["PL19"] = { 140000,2,150 },
	["PL20"] = { 140000,2,150 },
	["PL21"] = { 140000,2,150 },
	["PL22"] = { 140000,2,150 },
	
	--[ PALETOBAY ]--------------------------------------------------------------------------------------------------------------------------
	
	["PB01"] = { 500000,2,350 },
	["PB02"] = { 300000,2,350 },
	["PB03"] = { 250000,2,350 },
	["PB04"] = { 250000,2,350 },
	["PB05"] = { 350000,2,350 },
	["PB06"] = { 400000,2,350 },
	["PB07"] = { 500000,2,350 },
	["PB08"] = { 600000,2,350 },
	["PB09"] = { 500000,2,350 },
	["PB10"] = { 150000,2,150 },
	["PB11"] = { 350000,2,350 },
	["PB12"] = { 200000,2,350 },
	["PB13"] = { 200000,2,350 },
	["PB14"] = { 150000,2,350 },
	["PB15"] = { 150000,2,350 },
	["PB16"] = { 400000,2,350 },
	["PB17"] = { 350000,2,350 },
	["PB18"] = { 350000,2,350 },
	["PB19"] = { 250000,2,350 },
	["PB20"] = { 550000,2,350 },
	["PB21"] = { 200000,2,350 },
	["PB22"] = { 100000,2,150 },
	["PB23"] = { 250000,2,350 },
	["PB24"] = { 300000,2,350 },
	["PB25"] = { 300000,2,350 },
	["PB26"] = { 200000,2,350 },
	["PB27"] = { 200000,2,350 },
	["PB28"] = { 200000,2,350 },
	["PB29"] = { 200000,2,350 },
	["PB30"] = { 200000,2,350 },
	["PB31"] = { 100000,2,350 },
	
	--[ MANSAO ]-----------------------------------------------------------------------------------------------------------------------------
	
	["MS01"] = { 1500000,2,1000 },
	["MS02"] = { 2500000,2,1000 },
	["MS03"] = { 2500000,2,1000 },
	["MS04"] = { 2500000,2,1000 },
	["MS05"] = { 1000000,2,1000 },
	["MS06"] = { 1000000,2,1000 },
	["MS07"] = { 1000000,2,1000 },
	["MS08"] = { 1000000,2,1000 },
	["MS09"] = { 850000,2,1000 },
	
	--[ SANDYSHORE ]-------------------------------------------------------------------------------------------------------------------------
	
	["SS01"] = { 800000,2,1000 },
	
	--[ SANDYSHORE ]-------------------------------------------------------------------------------------------------------------------------
	
--	["FZ01"] = { 99999999,2,1500 },
}

--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------

local actived = {}
local blipHomes = {}

--[ BLIPHOMES ]--------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)

--[ HOMES ]------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,20000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",20000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				--if not vRP.hasGroup(user_id,"Platina") then
					local house_price = parseInt(homes[tostring(args[2])][1])
					local house_tax = 0.10
					if house_price >= 7000000 then
						house_tax = 0.00
					end
					if vRP.tryFullPayment(user_id,parseInt(house_price * house_tax)) then
						vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				--end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(homes[tostring(v.home)][1])
						local house_tax = 0.10
						if house_price >= 7000000 then
							house_tax = 0.00
						end

						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						else
							TriggerClientEvent("Notify",source,"importante","<b>Residência:</b> "..v.home.."<br>Taxa em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",20000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)

--[ BLIPS ]------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)

--[ ACTIVEDOWNTIME ]---------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)

--[ CHECKPERMISSIONS ]-------------------------------------------------------------------------------------------------------------------

local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then

						if homes[homeName][1] >= 7000000 then
							return true
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("losanjos/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*15*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) and homes[homeName][1] < 5000000 then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("losanjos/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) and homes[homeName][1] < 5000000 then
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b> ?",30)
					if ok then
						local preco = parseInt(homes[tostring(homeName)][1])

						if preco then
							if vRP.hasPermission(user_id,"ultimate.permissao") then
								desconto = math.floor(preco*20/100)
								pagamento = math.floor(preco-desconto)
							elseif vRP.hasPermission(user_id,"platinum.permissao") then
								desconto = math.floor(preco*15/100)
								pagamento = math.floor(preco-desconto)
							elseif vRP.hasPermission(user_id,"gold.permissao") then
								desconto = math.floor(preco*10/100)
								pagamento = math.floor(preco-desconto)
							elseif vRP.hasPermission(user_id,"standard.permissao") then
								desconto = math.floor(preco*5/100)
								pagamento = math.floor(preco-desconto)
							else
								pagamento = math.floor(preco)
							end
						end
			
						if vRP.tryPayment(user_id,parseInt(pagamento)) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)		
						end
					end
					return false
				end
			end
		end
	end
	return false
end

--[ CHECKINTPERMISSIONS ]----------------------------------------------------------------------------------------------------------------

function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] or vRP.hasPermission(user_id,"lspd.permission") then
			return true
		end
	end
	return false
end

function src.returnPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lspd.permission") then
		return true
	end
end

--[ OUTFIT ]-----------------------------------------------------------------------------------------------------------------------------

RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"aviso","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,20000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)

--[ OPENCHEST ]--------------------------------------------------------------------------------------------------------------------------

function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end

--[ STOREITEM ]--------------------------------------------------------------------------------------------------------------------------

function src.storeItem(homeName,itemName,amount)
    if itemName then
        local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if itemName ~= "passaporte" then
				if vRP.storeChestItem(user_id,"chest:"..tostring(homeName),itemName,amount,homes[tostring(homeName)][1]) then
					TriggerClientEvent("vrp_homes:Update",source,"updateVault")
					PerformHttpRequest(casaslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CASA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"},{ name = "**CASA:**", value = "[ ** "..tostring(homeName).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
				end
			end
        end
    end
end
--[ TAKEITEM ]---------------------------------------------------------------------------------------------------------------------------

function src.takeItem(homeName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
        if user_id then
            if vRP.tryChestItem(user_id,"chest:"..tostring(homeName),itemName,amount) then
                TriggerClientEvent("vrp_homes:Update",source,"updateVault")
				PerformHttpRequest(casaslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CASA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"},{ name = "**CASA:**", value = "[ ** "..tostring(homeName).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
            end
        end
    end
end

--[ CHECKPOLICE ]------------------------------------------------------------------------------------------------------------------------

function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			return true
		end
		return false
	end
end