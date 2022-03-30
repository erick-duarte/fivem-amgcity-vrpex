local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_mecanico", src)

-- [ WEBHOOK ] --
local onServiceBN = "https://discord.com/api/webhooks/842983587560423444/YLsv12UXKCstj52PkhsXsEdEr0Psn8azxSP3cNfgQtlm5KJ7ss536Vvpe0vSMRj-a0LC"
local offServiceBN = "https://discord.com/api/webhooks/842983650483241012/o7H4WzlhvzdHTcPJ1Js44gbSPjZ_WLnG7m60JUdZODm56kxxdH9Jn0MFeCVcftS7Ubqg"
local positionBennys = "https://discord.com/api/webhooks/842983691537088574/hP-eGEW2zG6JYPjDkc5pGq6-9RVhV_d7IHdbRHOfqbCNkSRGUg_GuRGWHSM5g0Ii2Xrh"
-- [ COMPRAR ARRAY ] --
local forSale = {
    { item = "repairkit", name = "Kit de Reparos", price = 2000, amount = 1 },
    { item = "militec", name = "Militec-9", price = 750, amount = 1 },
    { item = "pneus", name = "Pneus", price = 750, amount = 1 }
--    { item = "melhoria", name = "Melhoria", price = 7500, amount = 1 }
}
-- [ COMPRAR ] --
RegisterServerEvent("bennys-comprar")
AddEventHandler("bennys-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(forSale) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.price)) then
						if vRP.tryChestItem(user_id,"chest:"..tostring("bennys"),v.item,v.amount) then
							--vRP.giveInventoryItem(user_id,v.item,parseInt(v.amount))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.amount).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)).." dólares</b>.")
							PerformHttpRequest(bennysLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DA BENNYS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Registro do usuário:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Comprou:**", value = "` "..vRP.itemNameList(v.item).." `"},{ name = "**Pagou a quantia:**", value = "` "..parseInt(v.compra).." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
						else
							TriggerClientEvent("Notify",source,"negado","Estamos sem estoque desse produto.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)

-- [ EVENTO TOW ] --
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)

RegisterServerEvent("trytowboat")
AddEventHandler("trytowboat",function(nveh,rveh)
	TriggerClientEvent("synctowboat",-1,nveh,rveh)
end)
-- [ EVENTO REPARAR ] --
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-- [ EVENTO MOTOR ] --
RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-- [ EVENTO PNEUS ] --
RegisterServerEvent("trypneus")
AddEventHandler("trypneus",function(nveh)
	TriggerClientEvent("syncpneus",-1,nveh)
end)

local custom = {}

local uniforme1 = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 35,0 }, -- Maos
        [4] = { 39,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 24,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 90,0 }, --Camisa
        [9] = { -1,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 66,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
--    [-1667301416] = {
--        [1] = { 104,0 }, --Mascara
--        [2] = { -1,0 },
--        [3] = { 62,0 }, -- Maos
--        [4] = { 48,0 }, --Calca
--        [5] = { -1,0 }, --Mochila
--        [6] = { 25,0 }, --Sapato
--        [7] = { 0,0 }, --Acessorios
--        [8] = { 15,0 }, --Camisa
--        [9] = { 4,0 }, --Colete
--        [10] = { -1,0 }, --Adesivo
--        [11] = { 238,0 }, --Jaqueta
--        ["p0"] = { -1,0 }, --Chapeu
--        ["p1"] = { -1,0 }, --Oculos
--        ["p2"] = { -1,0 }, --Orelhas
--        ["p6"] = { -1,0 }, --Braco esquerdo
--        ["p7"] = { -1,0 } --braco direito
--    }
}

-- [ ENTRAR/SAIR DE SERVIÇO ] --
function src.checkBennys()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        	if vRP.hasPermission(user_id,"bennys.permission") then
          	vRP.addUserGroup(user_id,"off-bennys")
			TriggerClientEvent("progress",source,2000,"vestindo")
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
			SetTimeout(2000,function()
				TriggerClientEvent('cancelando',source,false)
				vRPclient._stopAnim(source,false)
				vRP.removeCloak(source)
			end)
          	TriggerClientEvent("Notify",source,"importante","Você saiu de serviço")
			os.execute("$(which bash) /amgcity/server-data/shellscript/bennysPonto.sh "..identity.firstname.." "..user_id.." Exit")
          	PerformHttpRequest(offServiceBN, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Bennys `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
        	elseif vRP.hasPermission(user_id,"off-bennys.permission") then
          	vRP.addUserGroup(user_id,"bennys")
			custom[source] = uniforme1
            	TriggerClientEvent("Notify",source,"importante","Você entrou em serviço")
			if custom[source] then
				TriggerClientEvent("progress",source,10000,"vestindo")
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
				SetTimeout(10000,function()
					
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local old_custom = vRPclient.getCustomization(source)
					local idle_copy = {}
		
					idle_copy = vRP.save_idle_custom(source,old_custom)
					idle_copy.modelhash = nil
		
					for k,v in pairs(custom[source][old_custom.modelhash]) do
						idle_copy[k] = v
					end
					vRPclient._setCustomization(source,idle_copy)
				end)
			end
			os.execute("$(which bash) /amgcity/server-data/shellscript/bennysPonto.sh "..identity.firstname.." "..user_id.." Enter")
            	PerformHttpRequest(onServiceBN, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Bennys `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
        	else
			TriggerClientEvent("Notify",source,"negado","Você não faz parte da bennys.")
		end
    	end
end

-- [ MECS EM SERVIÇO ] --
RegisterCommand('mecs', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local oficiais = vRP.getUsersByPermission("bennys.permission")
 	local paramedicos = 0
 	local oficiais_nomes = ""
 	if vRP.hasPermission(user_id,"bennys.permission") or vRP.hasPermission(user_id,"staff.permission") then
 		for k,v in ipairs(oficiais) do
 			local identity = vRP.getUserIdentity(parseInt(v))
 			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
 			paramedicos = paramedicos + 1
 		end
 		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Mecânicos</b> em serviço.",10000)
 		if parseInt(paramedicos) > 0 then
 			TriggerClientEvent("Notify",source,"importante", oficiais_nomes,10000)
 		end
	else
		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..#oficiais.." Mecânicos</b> em serviço.",10000)
	end
end)

-- [ BENNYS CHAT ] --
--RegisterCommand('bnns',function(source,args,rawCommand)
--	if args[1] then
--		local user_id = vRP.getUserId(source)
--		local identity = vRP.getUserIdentity(user_id)
--		if vRP.hasPermission(user_id,"bennys.permission") then
--			if user_id then
--				TriggerClientEvent('chatMessage',-1,"[ BENNY'S ] "..identity.name.." "..identity.firstname,{255,180,0},rawCommand:sub(5))
--				SendWebhookMessage(webhookchatlspd,"**[ BENNY'S ] "..identity.name.." "..identity.firstname..":** "..rawCommand:sub(5)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
--			end
--		end
--	end
--end)
-- [ INTERNO ] --
--RegisterCommand('br',function(source,args,rawCommand)
--	if args[1] then
--		local user_id = vRP.getUserId(source)
--		local identity = vRP.getUserIdentity(user_id)
--		local permission = "bennys.permission"
--		if vRP.hasPermission(user_id,permission) then
--			local soldado = vRP.getUsersByPermission(permission)
--			for l,w in pairs(soldado) do
--				local player = vRP.getUserSource(parseInt(w))
--				if player then
--					async(function()
--						TriggerClientEvent('chatMessage',player,"[ INTERNO ] "..identity.name.." "..identity.firstname,{255,80,0},rawCommand:sub(3))
--					end)
--				end
--			end
--		end
--	end
--end)
-- [ CONTRATAR ] --
RegisterCommand('contratar',function(source,args,rawCommand)
	if args[1] and args[2] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		local hirePosition = ""
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if nplayer_ == nil then
				TriggerClientEvent("Notify",source,"negado","Passaporte inválido ou indisponível.")
			else
				if args[1] == tostring(user_id) then
					TriggerClientEvent("Notify",source,"negado","Você não pode contratar a si mesmo.")
				else
					local yes = vRP.request(nsource_,"O responsável <b>"..identity.name.." "..identity.firstname.."</b> deseja realizar um processo de contratação, deseja aceitar ?",30)
					if args[2] == 'tow' then
						if yes then
							hirePosition = "Guincho"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-tow")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					elseif args[2] == 'mec' then
						if yes then
							hirePosition = "Mecânico"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-mechanic")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					elseif args[2] == 'manager' then
						if yes then
							hirePosition = "Gerente"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-manager")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					else
						TriggerClientEvent("Notify",source,"negado","Posição inválida.")
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /contratar <b> passaporte posição </b><br><b>mec</b> - Mecânico<br><b>manager</b> - Gerente",8000)
	end
end)

RegisterCommand('promover',function(source,args,rawCommand)
	if args[1] then
		local currentPos = 0
		local posNumber = 0
		local currentString = ""
		local stringPos = ""
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if vRP.hasPermission(nplayer_,"bennys.permission") then
				if vRP.hasPermission(nplayer_,"tow.permission") then
					currentPos = 1
					currentString = "Guincho"
				elseif vRP.hasPermission(nplayer_,"mechanic.permission") then
					currentPos = 2
					currentString = "Mecânico"
				elseif vRP.hasPermission(nplayer_,"manager.permission") then
					currentPos = 3
					currentString = "Gerente"
				end
				local yes = vRP.request(source,"Você deseja realmente promover o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if args[2] == "mec" then
					if yes then
						local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
						if confirm == tostring(confirmText) then
							posNumber = 2
							if posNumber <= currentPos then
								TriggerClientEvent("Notify",source,"negado","Você não pode promover um funcionário para uma posição inferior da atual.")
							else
								vRP.addUserGroup(nplayer_,"bennys-mechanic")
								TriggerClientEvent("Notify",source,"sucesso","Promoveu o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> para a posição <b> Mecânico </b>")
								TriggerClientEvent("Notify",nsource_,"sucesso","Você foi promovido pelo responsável <b>"..identity.name.." "..identity.firstname.."</b> para a posição <b> Mecânico </b>")
								stringPos = "Mecânico"
								PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Promoção", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem promovel:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário promovido:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
							end
						end
					end
				elseif args[2] == "manager" then
					if yes then
						local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
						if confirm == tostring(confirmText) then
							posNumber = 3
							if posNumber <= currentPos then
								TriggerClientEvent("Notify",source,"negado","Você não pode promover um funcionário para uma posição inferior da atual.")
							else
								vRP.addUserGroup(nplayer_,"bennys-manager")
								TriggerClientEvent("Notify",source,"sucesso","Promoveu o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> para a posição <b> Gerente </b>")
								TriggerClientEvent("Notify",nsource_,"sucesso","Você foi promovido pelo responsável <b>"..identity.name.." "..identity.firstname.."</b> para a posição <b> Gerente </b>")
								stringPos = "Gerente"
								PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Promoção", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem promovel:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário promovido:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
							end
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Posição inválida.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Passaporte não pertence a um funcionário da Bennys.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /promover <b> passaporte posição </b><br><b>mec</b> - Mecânico<br><b>manager</b> - Gerente",8000)
	end
end)

-- [ EXONERAR ] --
RegisterCommand('demitir',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if args[1] ~= tostring(user_id) then
				local yes = vRP.request(source,"Você deseja realmente demitir o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if yes then
					local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
					if confirm == tostring(confirmText) then
						exonerar(nplayer_)
						TriggerClientEvent("Notify",source,"sucesso","Você exonerou o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b>")
						TriggerClientEvent("Notify",nsource_,"negado","Você foi exonerado pelo responsável <b>"..identity.name.." "..identity.firstname.."</b>")
						PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Exoneração", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem exonerou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário exonerado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
					else
						TriggerClientEvent("Notify",nsource_,"negado","Você falhou na verificação")
					end
				end
			else
				local yes = vRP.request(source,"Você deseja realmente se demitir ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if yes then
					local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
					if confirm == tostring(confirmText) then
						vRP.removeUserGroup(user_id,"bennys")
						vRP.removeUserGroup(user_id,"off-bennys")
						vRP.removeUserGroup(user_id,"bennys-ceo")
						TriggerClientEvent("Notify",source,"sucesso","Você se demitiu.")
					else
						TriggerClientEvent("Notify",source,"negado","Você falhou na verificação")
						return
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /demitir <b> passaporte </b>")
	end
end)
function exonerar(employee)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(employee,"tow.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-tow")
	elseif vRP.hasPermission(employee,"mechanic.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-mechanic")
	elseif vRP.hasPermission(employee,"manager.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-manager")
	end
end

-- [ PERMISSÃO ] --
function src.checkPermission()
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"bennys.permission") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id,"bennys.permission") then 
		vRP.addUserGroup(user_id,"off-bennys")
		TriggerEvent('eblips:remove',source)
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		PerformHttpRequest(offServiceBN, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
	end
	
end)