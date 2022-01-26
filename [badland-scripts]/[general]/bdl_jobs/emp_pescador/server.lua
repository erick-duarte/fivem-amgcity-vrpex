local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

pesC = {}
Tunnel.bindInterface("emp_pescador",pesC)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local peixes = {
	[1] = { x = "dourado" },
	[2] = { x = "corvina" },
	[3] = { x = "salmao" },
	[4] = { x = "pacu" },
	[5] = { x = "pintado" },
	[6] = { x = "pirarucu" },
	[7] = { x = "tilapia" },
	[8] = { x = "tucunare" }
}

function pesC.checkIscaPeso()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dourado") <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"isca",1) then
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Isca</b> para pescar")
				return false
			end
		end
	end
end

function pesC.pegarPeixe()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if math.random(100) >= 98 then
			vRP.giveInventoryItem(user_id,"lambari",1)
			TriggerClientEvent("Notify",source,"sucesso","Você pegou um <b>Lambari</b>")
		else
			peixe = peixes[math.random(8)].x
			vRP.giveInventoryItem(user_id,peixe,1)
			TriggerClientEvent("Notify",source,"sucesso","Você pegou um <b>"..peixe.."</b>")
		end
	end
end