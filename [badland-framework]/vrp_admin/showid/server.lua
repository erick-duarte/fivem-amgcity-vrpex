-- importa os Utils do VRP
-----------------------------------------------------------------------------------------------------------------------------------------	
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- importa os Tunneis e Proxys
-----------------------------------------------------------------------------------------------------------------------------------------	
IDDclient = Tunnel.getInterface("vrp_admin_ids")
vRPclient = Tunnel.getInterface("vRP")
vRPidd = {}
Tunnel.bindInterface("vrp_admin_ids",vRPidd)
Proxy.addInterface("vrp_admin_ids",vRPidd)
vRP = Proxy.getInterface("vRP")

local cfg = module("vrp","cfg/groups")
local groups = cfg.groups

-----------------------------------------------------------------------------------------------------------------------------------------
-- Retorna a permissao pro client
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRPidd.getPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Retorna o ID pro Client
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRPidd.getId(sourceplayer)
	local user_id = vRP.getUserId(sourceplayer)
	return user_id
end

function vRPidd.getJob(sourceplayer)
	local job = vRPidd.getUserGroupByType(vRP.getUserId(sourceplayer),"job")
	return job
end

function vRPidd.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end
