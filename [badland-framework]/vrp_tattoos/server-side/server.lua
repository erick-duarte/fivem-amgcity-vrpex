local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPts = {}
Tunnel.bindInterface("vrp_tattoos",vRPts)
Proxy.addInterface("vrp_tattoos",vRPts)
TSclient = Tunnel.getInterface("vrp_tattoos")

function vRPts.updateTattoo(custom)
	local user_id = vRP.getUserId(source)
	vRP.setUData(user_id,"vRP:tattoos",json.encode(custom))
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	if first_spawn then
		local custom = {}
		local data = vRP.getUData(user_id,"vRP:tattoos")
		if data then
			custom = json.decode(data)
			TSclient.setTattoos(source,custom)
		end
	end
end)

function vRPts.restartScript()
	local source = source
	local user_id = vRP.getUserId(source)
	local custom = {}
	local data = vRP.getUData(user_id,"vRP:tattoos")
	if data then
		custom = json.decode(data)
		TSclient.setTattoos(source,custom)
	end
end

local settatoos = {
    [1885233650] = {
        [1] = { 0,0 },
        [2] = { 4,0 },
        [3] = { 15,0 },
        [4] = { 21,0 },
        [5] = { 0,0 },
        [6] = { 34,0 },
        [7] = { 0,0 },			
        [8] = { 15,0 },
        [9] = { 0,0 },
        [10] = { -1,0 },
        [11] = { 15,0 },
		["p0"] = { -1,0 },		
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [2] = { 4,0 },
        [3] = { 15,0 },
        [4] = { 17,0 },
        [5] = { -1,0 },
        [6] = { 35,0 },
        [7] = { -1,0 },
        [8] = { 7,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 15,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

function vRPts.savecloak()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = settatoos
    if custom then
		local old_custom = vRPclient.getCustomization(source)
		local idle_copy = {}
		idle_copy = vRP.save_idle_custom(source,old_custom)
		idle_copy.modelhash = nil
		for k,v in pairs(custom[old_custom.modelhash]) do
			idle_copy[k] = v
		end
		vRPclient._setCustomization(source,idle_copy)
    end
end

function vRPts.restorecloak()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.removeCloak(source)
end