local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRP._prepare("isDead/addDeadPlayer","UPDATE vrp_user_identities SET isDead = 1 WHERE user_id = @user_id")
vRP._prepare("isDead/removeDeadPlayer","UPDATE vrp_user_identities SET isDead = 0 WHERE user_id = @user_id")
vRP._prepare("isDead/getDeadPlayer","select isDead from vrp_user_identities WHERE user_id = @user_id")

emP = {}
Tunnel.bindInterface("vrp_tela",emP)
vCLIENT = Tunnel.getInterface("vrp_tela")
local isDead = {}

function emP.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"pass-prata") or vRP.hasPermission(user_id,"pass-ouro") or vRP.hasPermission(user_id,"pass-platina") or vRP.hasPermission(user_id,"amg.pass") then
			vRP.varyExp(user_id,"physical","strength",650)
		end
	end
end

function emP.checkDead(setDead)
	local source = source
	local user_id = vRP.getUserId(source)
	isDead[user_id] = setDead
	if setDead then
		vRP.execute("isDead/addDeadPlayer",{ user_id = parseInt(user_id) })
	else
		vRP.execute("isDead/removeDeadPlayer",{ user_id = parseInt(user_id) })
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if identity.isDead >= 1 then
		vCLIENT.jailCombatLog(source)
	end
end)

AddEventHandler("playerDropped",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if isDead[user_id] then
		vRP.execute("isDead/addDeadPlayer",{ user_id = parseInt(user_id) })
	else
		vRP.execute("isDead/removeDeadPlayer",{ user_id = parseInt(user_id) })
	end
end)

