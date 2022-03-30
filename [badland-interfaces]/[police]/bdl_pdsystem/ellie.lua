local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("bdl_pdsystem",vRPex)

local onServicePD = "https://discord.com/api/webhooks/842940923398586419/dPqyMFNHo2fjVObPeqeQfBvxS-RLutsV7uHFqQeDnIYZodQF1SrwU3DmssgU0Vh3asrC"
local offServicePD = "https://discord.com/api/webhooks/842940996982931496/CYPTHfK1nIKvKeihe7pn-8zsXH7wrHsX4b-L37gqrsc_Lnl5rAZwjaJoni2wBc2GjJwD"
local actionsLog = "https://discord.com/api/webhooks/842941055074828307/j1sU2jGBWowOy2bC64iKKSVqVppWqLFhvNlEtnoyKVBThNNefq-aSNFgT195HdXjKgYB"

function vRPex.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function vRPex.checkOfficer()
	local src = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lspd.permission") or vRP.hasPermission(user_id,"off-lspd.permission") then
		return true
	end
end

RegisterNetEvent('bdl:onarmor')
AddEventHandler('bdl:onarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			vRPclient.setArmour(source,100)
			return true
		end
	end
end)

RegisterNetEvent('bdl:offarmor')
AddEventHandler('bdl:offarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			vRPclient.setArmour(source,0)
			return true
		end
	end
end)

function vRPex.remEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,0)
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

RegisterServerEvent("bdl:onduty")
AddEventHandler("bdl:onduty",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id,"off-policia.permission") then
        vRP.addUserGroup(user_id,"policia")
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
		PerformHttpRequest(onServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
    
	elseif vRP.hasPermission(user_id,"off-tatica.permission") then
        vRP.addUserGroup(user_id,"tatica")
		TriggerEvent('eblips:add',{ name = "Tatica", src = source, color = 47 })
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
		PerformHttpRequest(onServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Tatica `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
    
	elseif vRP.hasPermission(user_id,"off-investigativa.permission") then
        vRP.addUserGroup(user_id,"investigativa")
		TriggerEvent('eblips:add',{ name = "Investigador", src = source, color = 47 })
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
		PerformHttpRequest(onServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Investigativa `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })

	else 
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.",5000)
    end

end)

RegisterServerEvent("bdl:offduty")
AddEventHandler("bdl:offduty",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

--    if vRP.hasPermission(user_id,"lspd.permission") then
--        vRP.addUserGroup(user_id,"off-policia")
--		TriggerEvent('eblips:remove',source)
--		vRPex.remEquip()
--        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
--		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
--		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
--    else
--        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.",5000)
--    end
	if vRP.hasPermission(user_id,"policiaamg.permission") then 
		vRP.addUserGroup(user_id,"off-policia")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })

	elseif vRP.hasPermission(user_id,"tatica.permission") then
		vRP.addUserGroup(user_id,"off-tatica")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Tatica `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })

	elseif vRP.hasPermission(user_id,"investigativa.permission") then
		vRP.addUserGroup(user_id,"off-investigativa")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
		TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Investigativa `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterServerEvent("bdl:takekitlog")
AddEventHandler("bdl:takekitlog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Retirou kit de defesa pessoal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:remkitlog")
AddEventHandler("bdl:remkitlog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Guardou kit de defesa pessoal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:remWeaponsLog")
AddEventHandler("bdl:remWeaponsLog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Guardou todo o armamento no arsenal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:takeWeapons")
AddEventHandler("bdl:takeWeapons",function(weapon)
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Registro de retirada de armamento.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Pegou uma "..weapon.." do arsenal`" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id,"policiaamg.permission") then 
		vRP.addUserGroup(user_id,"off-policia")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
	
	elseif vRP.hasPermission(user_id,"tatica.permission") then
		vRP.addUserGroup(user_id,"off-tatica")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Tatica `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
	
	elseif vRP.hasPermission(user_id,"investigativa.permission") then
        vRP.addUserGroup(user_id,"off-investigativa")
		TriggerEvent('eblips:remove',source)
		TriggerClientEvent("bdl_pdsystem:removerarmamento",source)
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` Investigativa `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
    end
	
end)
