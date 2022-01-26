local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Estandeclient = Tunnel.getInterface("AMG_EstandePVP")

estandepvp = {}
Tunnel.bindInterface("AMG_EstandePVP",estandepvp)
Proxy.addInterface("AMG_EstandePVP",estandepvp)

local estande1 = 0
local estande2 = 0
local estande3 = 0
local estande4 = 0

vRP._prepare("vRP/entrouEstande",'UPDATE vrp_user_identities SET estandepvp = @estande WHERE user_id = @id')

function estandepvp.entraEstande(estande)
	local source = source
    local user_id = vRP.getUserId(source)
	if estande == 1 then
		if estande1 < 8 then
			estande1 = estande1 + 1
			vRP.execute("vRP/entrouEstande",{ id = user_id, estande = estande })
			TriggerEvent("AMG_Logs:sventrouestandepvp", source, user_id, estande)
			print("---- ENTROU ESTANDE 1 ----")
			print("ID PLAYER: "..user_id.."")
			print("QUANTIDADE DE PLAYER:"..estande1.."")
			return true
		else
			return false
		end
	elseif estande == 2 then
		if estande2 < 8 then
			estande2 = estande2 + 1
			vRP.execute("vRP/entrouEstande",{ id = user_id, estande = estande })
			TriggerEvent("AMG_Logs:sventrouestandepvp", source, user_id, estande)
			print("---- ENTROU ESTANDE 2 ----")
			print("ID PLAYER: "..user_id.."")
			print("QUANTIDADE DE PLAYER:"..estande1.."")
			return true
		else
			return false
		end
	elseif estande == 3 then
		if estande3 < 4 then
			estande3 = estande3 + 1
			vRP.execute("vRP/entrouEstande",{ id = user_id, estande = estande })
			TriggerEvent("AMG_Logs:sventrouestandepvp", source, user_id, estande)
			print("---- ENTROU ESTANDE 3 ----")
			print("ID PLAYER: "..user_id.."")
			print("QUANTIDADE DE PLAYER:"..estande1.."")
			return true
		else
			return false
		end
	elseif estande == 4 then
		if estande4 < 4 then
			estande4 = estande4 + 1
			vRP.execute("vRP/entrouEstande",{ id = user_id, estande = estande })
			TriggerEvent("AMG_Logs:sventrouestandepvp", source, user_id, estande)
			print("---- ENTROU ESTANDE 4 ----")
			print("ID PLAYER: "..user_id.."")
			print("QUANTIDADE DE PLAYER:"..estande1.."")
			return true
		else
			return false
		end
	end
end

RegisterServerEvent("AMG_EstandePVP:sairEstande")
AddEventHandler("AMG_EstandePVP:sairEstande", function(estande)
	local source = source
    local user_id = vRP.getUserId(source)
	if estande == 1 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU DST ESTANDE 1 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande1 > 0 then
			estande1 = estande1 - 1
		end
	elseif estande == 2 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU DST ESTANDE 2 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande2 > 0 then
			estande2 = estande2 - 1
		end
	elseif estande == 3 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU DST ESTANDE 3 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande3 > 0 then
			estande3 = estande3 - 1
		end
	elseif estande == 4 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU DST ESTANDE 4 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande4 > 0 then
			estande4 = estande4 - 1
		end
	end
end)

function estandepvp.sairEstandev2(estande)
	local source = source
	local user_id = vRP.getUserId(source)
	if estande == 1 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU CMD ESTANDE 1 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande1 > 0 then
			estande1 = estande1 - 1
		end
		return true
	elseif estande == 2 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU CMD ESTANDE 2 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande2 > 0 then
			estande2 = estande2 - 1
		end
		return true
	elseif estande == 3 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU CMD ESTANDE 3 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande3 > 0 then
			estande3 = estande3 - 1
		end
		return true
	elseif estande == 4 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, estande)
		print("---- SAIU CMD ESTANDE 4 ----")
		print("ID PLAYER: "..user_id.."")
		print("QUANTIDADE DE PLAYER:"..estande1.."")
		if estande4 > 0 then
			estande4 = estande4 - 1
		end
		return true
	end
end

function estandepvp.verificaDB()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if identity.estandepvp >= 1 then
		return true
	else
		return false
	end
end

function estandepvp.resetDB()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if identity.estandepvp > 0 then
		vRP.execute("vRP/entrouEstande",{ id = user_id, estande = 0 })
		TriggerEvent("AMG_Logs:svsaiuestandepvp", source, user_id, identity.estandepvp)
		print("---- RESET DB ----")
		print("ID PLAYER: "..user_id.."")
	end
end

RegisterServerEvent("AMG_EstandePVP:limparInventario")
AddEventHandler("AMG_EstandePVP:limparInventario", function()
    local source = source
    local user_id = vRP.getUserId(source)
	local weapons = vRPclient.replaceWeapons(source,{})
	local encode = json.encode(weapons)
	TriggerEvent("AMG_Logs:svsaiuestandepvpinv", source, user_id, encode)
	print("---- LIMPANDO INVENTARIO ----")
	print("ID PLAYER: "..user_id.."")
	Citizen.Wait(2000)
    vRP.clearInventory(user_id)
end)