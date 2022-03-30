local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
yRP = {}
Tunnel.bindInterface("warm-bennys",yRP)

local oldcustoms = {}
local valorTotal = {}

function yRP.savedbcar(saves)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--local show = vRP.prompt(source, "copie", ""..json.encode(saves))
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		--print(json.encode(saves.colour.custom.primary))
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			 if puser_id then
			 	local custom = {}

				custom.spoiler = saves.mods[0]
				custom.fbumper = saves.mods[1]
				custom.rbumper = saves.mods[2]
				custom.skirts = saves.mods[3]
				custom.exhaust = saves.mods[4]
				custom.rollcage = saves.mods[5]
				custom.grille = saves.mods[6]
				custom.hood = saves.mods[7]
				custom.fenders = saves.mods[8]
				custom.roof = saves.mods[10]
				custom.engine = saves.mods[11]
				custom.brakes = saves.mods[12]
				custom.transmission = saves.mods[13]
				custom.horn = saves.mods[14]
				custom.suspension = saves.mods[15]
				custom.armor = saves.mods[16]
				custom.tires = saves.mods[23]
				custom.tiresvariation = saves.mods[23]

				custom.btires = saves.mods[24]
				custom.btiresvariation = saves.mods[24]

				custom.plateholder = saves.mods[25]
				custom.vanityplates = saves.mods[26]
				custom.trimdesign = saves.mods[27] 
				custom.ornaments = saves.mods[28]
				custom.dashboard = saves.mods[29]
				custom.dialdesign = saves.mods[30]
				custom.doors = saves.mods[31]
				custom.seats = saves.mods[32]
				custom.steeringwheels = saves.mods[33]
				custom.shiftleavers = saves.mods[34]
				custom.plaques = saves.mods[35]
				custom.speakers = saves.mods[36]
				custom.trunk = saves.mods[37] 
				custom.hydraulics = saves.mods[38]
				custom.engineblock = saves.mods[39]
				custom.camcover = saves.mods[40]
				custom.strutbrace = saves.mods[41]
				custom.archcover = saves.mods[42]
				custom.aerials = saves.mods[43]
				custom.roofscoops = saves.mods[44]
				custom.tank = saves.mods[45]
				custom.doors = saves.mods[46]
				custom.liveries = saves.mods[48]

				custom.tyresmoke = saves.mods[20]
				custom.headlights = saves.mods[22]
				custom.turbo = saves.mods[18]
				
				custom.colorp = saves.colour.custom.primary
				custom.colors = saves.colour.custom.secondary
--				custom.neoncolor = saves.colour.neon
				custom.smokecolor = saves.smoke
				custom.tyresmoke = saves.fumaca
--				custom.neon = saves.neon.back

			-- 	custom.color = veh.color
			 	custom.extracolor = {saves.colour.pearlescent,saves.colour.wheel}
			 	custom.neon = saves.neon
			 	custom.neoncolor = saves.neoncolor
			-- 	custom.smokecolor = veh.smokecolor
			 	custom.plateindex = saves.plate.index
				custom.windowtint = saves.janela
				custom.wheeltype = saves.wheel
				custom.xenon = saves.xenon
			-- 	custom.bulletProofTyres = veh.bulletProofTyres
				
				vRP.setSData("custom:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))
			end
		end
	end
end

function yRP.getPlayerTotalMoney()
    local source = source
    local user_id = vRP.getUserId(source)
    local fullmoney  = vRP.getMoney(user_id) + vRP.getBankMoney(user_id)
    return fullmoney
end

local valor = {}

function yRP.getValues(type)
    return itemPrices[type].price
end

function yRP.validateBuy(vehSelected)
end

function yRP.resetCustoms(vehSelected)
end

function yRP.verCustoms(table)
end

function yRP.getPrices(type)
	local source = source
    local user_id = vRP.getUserId(source)
	local fullmoney  = vRP.getMoney(user_id) + vRP.getBankMoney(user_id)
	local prices = 0
	if type ~= -1 then
		prices = itemPrices[type].price
	end
	return prices,fullmoney
end

function yRP.saveOldCustom(table)
	local source = source
	local user_id = vRP.getUserId(source)
	oldcustoms[user_id] = table
end

function yRP.updateMoney(index)
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.tryFullPayment(user_id,index)
end

function yRP.somar(valorItem)
	local source = source
	local user_id = vRP.getUserId(source)
	if valorTotal[user_id] then
		valorTotal[user_id] = valorTotal[user_id] + valorItem
	else
		valorTotal[user_id] = valorItem
	end
end

function yRP.getTotal()
	local source = source
	local user_id = vRP.getUserId(source)
	return valorTotal[user_id]
end

function yRP.startTotal()
	local source = source
	local user_id = vRP.getUserId(source)
	valorTotal[user_id] = 0
end

function yRP.getPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission (user_id,'staff.permission')
end

function yRP.getCustoms()
	local source = source
	local user_id = vRP.getUserId(source)
	return oldcustoms[user_id]
end

function yRP.updateOld(data)
	local source = source
	local user_id = vRP.getUserId(source)
	oldcustoms[user_id] = data
end



