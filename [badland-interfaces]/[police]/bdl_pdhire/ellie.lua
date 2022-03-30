local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPex = {}
Tunnel.bindInterface("bdl_pdhire",vRPex)

local cfg = module("vrp","cfg/groups")
local groups = cfg.groups


local hireLog = "https://discord.com/api/webhooks/842942160676716544/ga6ugMTejvDn3haMTdILY44EWIKapDhI0wcU0iW5-dsayBjyi0dDAvoOJKUVzpC2m7-d"
local fireLog = "https://discord.com/api/webhooks/842942247670513675/cY87sdAVjyIPU1mM0KuSrr9nMdwG1sINBytGkrwT86wgkVZoEvqck33gTLUqwbyr7pC2"
local promoteLog = "https://discord.com/api/webhooks/842942319526543391/fCQpHlJEzIxVAhWZNaHJa0D1yQ_Vvwrt55dNdPUxYV2nMO8fdQ5gKlRSckQlw08RroBl"

RegisterServerEvent('Policia:procurarPlayer')
AddEventHandler('Policia:procurarPlayer', function(rg)
    local infoPlayer = {}
	local source = source
	local _nplayer = vRP.getUserSource(parseInt(rg))
    local player = vRP.getUserByRegistration(rg)
    if player then
		local identidade = vRP.getUserIdentity(player)
		local job = vRPex.getUserGroupByType(player,"job")
        table.insert(infoPlayer, {
            ["Pessoa"] = identidade.name..' '..identidade.firstname
        })
		TriggerClientEvent("Policia:infoPlayer", source, identidade.name..' '..identidade.firstname, identidade.age, job, identidade.registration)
		
    else
        TriggerClientEvent("Notify",source,"negado","ERRO - Registro não encontrado.")
    end
end)


function vRPex.getUserGroupByType(user_id,gtype)
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

function vRPex.checkCaptain()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") or vRP.hasPermission(user_id,"policia-subcomandante.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
		return true
	end
end

RegisterServerEvent('system:hire')
AddEventHandler('system:hire', function(position,passport)
	local _source = source
	local user_id = vRP.getUserId(_source)

	local _nplayer = vRP.getUserSource(parseInt(passport))
	local nuser_id = vRP.getUserId(_nplayer)

	if nuser_id == user_id then
		TriggerClientEvent("Notify",_source,"negado","Você não pode contratar a si mesmo.")
	else
		if nuser_id == nil then
			TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
		else
			local hirePosition = ""
			local identity = vRP.getUserIdentity(user_id)
			local identitynu = vRP.getUserIdentity(nuser_id)
			local yes = vRP.request(_nplayer,"O responsável <b>"..identity.name.." "..identity.firstname.."</b> deseja realizar um processo de contratação, deseja aceitar ?",30)
			if not vRP.hasPermission(nuser_id,"lspd.permission") then
				if position == "1" then
					if yes then
						hirePosition = "Recruta"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-recruta")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "2" then
					if yes then
						hirePosition = "Soldado"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-soldado")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "3" then
					if yes then
						hirePosition = "Cabo"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-cabo")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "4" then
					if yes then
						hirePosition = "Sargento"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-sargento")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "5" then
					if yes then
						hirePosition = "Tenente"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-tenente")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "6" then
					if yes then
						hirePosition = "Capitão"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-capitao")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "7" then
					if yes then
						hirePosition = "Major"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-major")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				elseif position == "8" then
					if yes then
						hirePosition = "Coronel"
						TriggerClientEvent("Notify",_source,"sucesso","Você contratou o passaporte nº "..nuser_id.." na posição: "..hirePosition,5000)
						TriggerClientEvent("Notify",_nplayer,"sucesso","Você foi contratado por "..identity.name.." "..identity.firstname,5000)
						vRP.addUserGroup(nuser_id,"policia")
						vRP.addUserGroup(nuser_id,"policia-coronel")
						PerformHttpRequest(hireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Contratou o usuário:**", value = "` "..identitynu.name.. " "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Na posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
					end
				else
					TriggerClientEvent("Notify",_source,"negado","Posição inválida. Consulte a lista.")
				end
			else
				TriggerClientEvent("Notify",_source,"negado","O usuário já faz parte da polícia.")
			end
		end
	end
end)

RegisterServerEvent('system:fire')
AddEventHandler('system:fire', function(passport)
	local _source = source
	local user_id = vRP.getUserId(_source)

	local _nplayer = vRP.getUserSource(parseInt(passport))
	local nuser_id = vRP.getUserId(_nplayer)
	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		local hirePosition = ""
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		firePlayer(nuser_id)
		if nuser_id == user_id then
			TriggerClientEvent("Notify",_source,"sucesso","Você se demitiu.")
		elseif nuser_id ~= user_id then
			TriggerClientEvent("Notify",_source,"sucesso","Você demitiu o passaporte <b>n."..nuser_id.."</b> de suas funções na <b>polícia</b>.")
			TriggerClientEvent("Notify",_nplayer,"negado","Você foi demitido pelo passaporte <b>n."..user_id.."</b> de suas funções na <b>polícia</b>.")
		end
		PerformHttpRequest(fireLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Demitiu o usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterServerEvent('system:promote')
AddEventHandler('system:promote', function(position,passport)
	local _source = source
	local user_id = vRP.getUserId(_source)

	local _nplayer = vRP.getUserSource(parseInt(passport))
	local nuser_id = vRP.getUserId(_nplayer)

	
	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		if vRP.hasPermission(nuser_id,"lspd.permission") then
			local hirePosition = ""
			local identity = vRP.getUserIdentity(user_id)
			local identitynu = vRP.getUserIdentity(nuser_id)
			local yesProm = vRP.request(_nplayer,"O responsável <b>"..identity.name.." "..identity.firstname.."</b> deseja realizar um processo de administração de cargo, deseja aceitar ?",30)
			if position == "1" then
				if yesProm then
					hirePosition = "Recruta"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-recruta")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "2" then
				if yesProm then
					hirePosition = "Soldado"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-soldado")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "3" then
				if yesProm then
					hirePosition = "Cabo"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-cabo")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "4" then
				if yesProm then
					hirePosition = "Sargento"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-sargento")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "5" then
				if yesProm then
					hirePosition = "Tenente"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-tenente")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "6" then
				if yesProm then
					hirePosition = "Capitao"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-capitao")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "7" then
				if yesProm then
					hirePosition = "Major"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-major")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			elseif position == "8" then
				if yesProm then
					hirePosition = "Coronel"
					TriggerClientEvent("Notify",_source,"sucesso","Você trocou o passaporte nº "..nuser_id.." pra posição: "..hirePosition,5000)
					TriggerClientEvent("Notify",_nplayer,"sucesso","Sua posição foi trocada para "..hirePosition,5000)
					vRP.addUserGroup(nuser_id,"policia-coronel")
					PerformHttpRequest(promoteLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DO LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**O responsável:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Trocou a posição do usuário:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `"},{ name = "**Nº do ID:**", value = "` "..nuser_id.." ` "},{ name = "**Para a posição:**", value = "` "..hirePosition.." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
				end
			else
				TriggerClientEvent("Notify",_source,"negado","Posição inválida. Consulte a lista.")
			end
		else
			TriggerClientEvent("Notify",_source,"negado","Esse passaporte não pertence a um policial.")
		end
	end
end)

function firePlayer(officer)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(officer,"policia-recruta.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-recruta")

	elseif vRP.hasPermission(officer,"policia-soldado.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-soldado")

	elseif vRP.hasPermission(officer,"policia-cabo.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-cabo")

	elseif vRP.hasPermission(officer,"policia-sargento.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-sargento")

	elseif vRP.hasPermission(officer,"policia-tenente.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-tenente")
		
	elseif vRP.hasPermission(officer,"policia-capitao.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-capitao")

	elseif vRP.hasPermission(officer,"policia-major.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-major")

	elseif vRP.hasPermission(officer,"policia-coronel.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-coronel")

	elseif vRP.hasPermission(officer,"policia-subcomandante.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-subcomandante")

	elseif vRP.hasPermission(officer,"policia-comandante.permission") then
		vRP.removeUserGroup(officer,"policia")
		vRP.removeUserGroup(officer,"off-policia")
		vRP.removeUserGroup(officer,"policia-comandante")
	end
end

function vRPex.playerInfo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local coins = vRP.getCoins(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local foto = identity.foto
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		local bills = vRP.getBills(user_id)
		local job = vRPex.getUserGroupByType(user_id,"position")
		local cargo = vRPex.getUserGroupByType(user_id,"cargo")
		local vip = vRPex.getUserGroupByType(user_id,"vip")
		local position = vRPex.getUserGroupByType(user_id,"position")
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),vRP.format(parseInt(coins)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,cargo,vip,vRP.format(parseInt(mybills)),multas,mypaypal,position
		end
	end
end