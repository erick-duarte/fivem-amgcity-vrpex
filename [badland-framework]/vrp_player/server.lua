local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
empCaminhao = Proxy.getInterface("emp_caminhao")
vRPclient = Tunnel.getInterface("vRP")
vPlayerclient = Tunnel.getInterface("vrp_player")
local idgens = Tools.newIDGenerator()
src = {}
Tunnel.bindInterface("vrp_player",src)

-- [ WEBHOOK LINKS ] --
local sendmoneylog = "https://discord.com/api/webhooks/842550027834359848/BcZ95q9XKOeVmdCZztd3BFBZye8MeBBvM-P51wj8UpFsSK_MA69PvWushFsj-GNOlmyY"
local garmaslog = "https://discord.com/api/webhooks/842549975543709706/YfQ7Ix4u8n7oi4ZhTamk3CPegfhYx8qYNNCGuA7n39xD4MUjC0Ve7mqmBGy8VQk6Lgb_"
local saquearlog = "https://discord.com/api/webhooks/842550165071331369/Dd3q3GeKd5vbba6mjWcuAwNOehIUz7K2TyG-bpZ0YQC3jLwQb5elSIHlS5JAG7wCzKGn"
local suspectlog = "https://discord.com/api/webhooks/842550232125538326/KuzV3_OCP-3upD5Q_QMwV9zhBnTA-tfR0PvQFKmfPzwDTWyjDOz8_4a2u3HY1KSkbql9"
local limbolog = "https://discord.com/api/webhooks/845398334306779138/ZHQLuhNFBYIAJa3warprwS-9qTt0s_Xv2-x-kTv1hcpTas-w0ZlziGaXbyai6Nf-n1My"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-- [ WEBHOOK LINKS ] --
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"staff.permission") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.") 
			return false
		end
	end
end

function src.checkPermissao()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"founder.permission") then
			return true 
		else
			return false
		end
	end
end

-- [ DEBUG PED ] --
RegisterCommand('debug',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)	
	if vRP.hasPermission(user_id,"staff.permission") then
		local tuser_id = tonumber(args[1])
        local tplayer = vRP.getUserSource(tonumber(tuser_id))
        local tplayerID = vRP.getUserId (tonumber(tplayer))
		if tplayerID ~= nil then
			vRPclient._setCustomization(tplayer,vRPclient.getCustomization(tplayer))
			vRP.removeCloak(tplayer)
			TriggerClientEvent("debug:player",tplayer)
		else
			vRPclient._setCustomization(source,vRPclient.getCustomization(source))
			vRP.removeCloak(source)
		end
	end
end)

vRP.prepare("empresa/getCaixaProdutos","SELECT caixa,produtos,encomendas from amg_empresas where cnpj = @cnpj")
vRP.prepare("empresa/debitCaixa","UPDATE amg_empresas set caixa = @caixa where cnpj = @cnpj")
vRP.prepare("empresa/getEncomendas","SELECT encomendas from amg_empresas where cnpj = @cnpj")
vRP.prepare("empresa/setEncomendas","UPDATE amg_empresas set encomendas = JSON_SET(encomendas, @nomeProduto, @qtdProduto)")

--empCaminhao.receberPedidos(args[1])
RegisterCommand('encomendar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local cnpj = nil

	if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"bennysmanager.permission") then
		cnpj = 1
	elseif vRP.hasPermission(user_id,"diretor.permission") then
		cnpj = 1
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end

	if args[1] == nil or args[2] == nil then
		TriggerClientEvent("Notify",source,"negado","Comando inválido")
		Citizen.Wait(1500)
		TriggerClientEvent("Notify",source,"importante","Utilize o /encomendar PRODUTO QTD")
		
	else
		if args[2]%10 == 0 and parseInt(args[2]) > 1 then
			local nomeProduto = args[1]
			local totalKit = args[2] * 1
			local rows = vRP.query("empresa/getCaixaProdutos",{ cnpj = cnpj })
			local resultEmpresa = rows[1]

			local totalCaixa = resultEmpresa.caixa
			local allProdutos = json.decode(resultEmpresa.produtos)
			local allEncomendas = json.decode(resultEmpresa.encomendas)

			if allProdutos.produtos[nomeProduto] == nil then
				TriggerClientEvent("Notify",source,"negado","Produto não identificado")
			else
				local valorTotal = parseInt(totalKit) * allProdutos.produtos[nomeProduto]
				if totalCaixa > valorTotal then
					local newNomeProduto = "$.encomendas."..nomeProduto..""
					vRP.query("empresa/debitCaixa",{ caixa = (parseInt(totalCaixa) - parseInt(valorTotal)), cnpj = cnpj })
					vRP.query("empresa/setEncomendas",{ nomeProduto = newNomeProduto, qtdProduto = (parseInt(allEncomendas.encomendas[nomeProduto]) + parseInt(totalKit)) })
					TriggerClientEvent("Notify",source,"sucesso","Pedido efetuado")
				else
					TriggerClientEvent("Notify",source,"negado","A empresa não possui saldo")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","O pedido só pode ser feito em multiplos de 10")
		end
	end
end)

-- [ SALARIO CFG & THREAD ] --
--local salarios = {
--
--	-- [ POLICIA AMG ] -- 
--	{ ['posicao'] = "policia-recruta.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Recruta", ['payment'] = 7000 },
--	{ ['posicao'] = "policia-cabo.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Cabo", ['payment'] = 7500 },
--	{ ['posicao'] = "policia-soldado.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Soldado", ['payment'] = 8000 },
--	{ ['posicao'] = "policia-sargento.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Sargento", ['payment'] = 9000 },
--	{ ['posicao'] = "policia-tenente.permission",  ['grupo'] = "lspd.permission", ['nome'] = "Policia Tenente", ['payment'] = 10000 },
--	{ ['posicao'] = "policia-capitao.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Capitão", ['payment'] = 11000 },
--	{ ['posicao'] = "policia-major.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Major", ['payment'] = 12000 },
--	{ ['posicao'] = "policia-coronel.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Caronel", ['payment'] = 13000 },
--	{ ['posicao'] = "policia-subcomandante.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Sub.Comandante", ['payment'] = 14000 },
--	{ ['posicao'] = "policia-comandante.permission", ['grupo'] = "lspd.permission", ['nome'] = "Policia Comandante", ['payment'] = 15000 },
--
--	-- [ TATICA AMG ] -- 
--	{ ['posicao'] = "tatica-recruta.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Recruta", ['payment'] = 9000 },
--	{ ['posicao'] = "tatica-soldado.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Soldado", ['payment'] = 10000 },
--	{ ['posicao'] = "tatica-sargento.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Sargento", ['payment'] = 11000 },
--	{ ['posicao'] = "tatica-tenente.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Tenente", ['payment'] = 12000 },
--	{ ['posicao'] = "tatica-capitao.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Capitão", ['payment'] = 13000 },
--	{ ['posicao'] = "tatica-major.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Major", ['payment'] = 14000 },
--	{ ['posicao'] = "tatica-coronel.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Caronel", ['payment'] = 15000 },
--	{ ['posicao'] = "tatica-subcomandante.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Sub.Comandante", ['payment'] = 16000 },
--	{ ['posicao'] = "tatica-comandante.permission", ['grupo'] = "lspd.permission", ['nome'] = "Tática Comandante", ['payment'] = 17000 },
--
--	-- [ INVESTIGATIVA ] -- 
--	{ ['posicao'] = "investigativa-recruta.permission", ['grupo'] = "lspd.permission", ['nome'] = "Investigador", ['payment'] = 17000 },
--	{ ['posicao'] = "investigativa-soldado.permission", ['grupo'] = "lspd.permission", ['nome'] = "Escrivão", ['payment'] = 18000 },
--	{ ['posicao'] = "investigativa-sargento.permission", ['grupo'] = "lspd.permission", ['nome'] = "Delegado", ['payment'] = 19000 },
--	
--	-- [ HOSPITAL ] -- 
--	{ ['posicao'] = "estagiario.permission", ['grupo'] = "ems.permission", ['nome'] = "Estagiário(a)", ['payment'] = 12000 },
--	{ ['posicao'] = "enfermeiro.permission", ['grupo'] = "ems.permission", ['nome'] = "Enfermeiro(a)", ['payment'] = 13000 },
--	{ ['posicao'] = "samu.permission", ['grupo'] = "ems.permission", ['nome'] = "Samu", ['payment'] = 14000 },
--	{ ['posicao'] = "medico.permission", ['grupo'] = "ems.permission", ['nome'] = "Médico(a)", ['payment'] = 15000 },
--	{ ['posicao'] = "vicediretor.permission", ['grupo'] = "ems.permission", ['nome'] = "Vice Diretor(a)", ['payment'] = 16000 },
--	{ ['posicao'] = "diretor.permission", ['grupo'] = "ems.permission", ['nome'] = "Diretor(a)", ['payment'] = 17000 },
--
--	-- [ BENNYS ] -- 
--	{ ['posicao'] = "tow.permission", ['grupo'] = "bennys.permission", ['nome'] = "Benny's Guincho", ['payment'] = 1500 },
--	{ ['posicao'] = "mechanic.permission", ['grupo'] = "bennys.permission", ['nome'] = "Benny's Mecânico", ['payment'] = 2500 },
--	{ ['posicao'] = "bennysmanager.permission", ['grupo'] = "bennys.permission", ['nome'] = "Benny's Gerente", ['payment'] = 3200 },
--	{ ['posicao'] = "bennysceo.permission", ['grupo'] = "bennys.permission", ['nome'] = "Benny's CEO", ['payment'] = 3800 },
--
--}

--local salariosvip = {
--	-- [ DOADORES ] -- 
--	{ ['posicao'] = "bronze.pass", ['nome'] = "Bronze Pass", ['payment'] = 2500 },
--	{ ['posicao'] = "prata.pass", ['nome'] = "Prata Pass", ['payment'] = 4500 },
--	{ ['posicao'] = "ouro.pass", ['nome'] = "Ouro Pass", ['payment'] = 6500 },
--	{ ['posicao'] = "platina.pass", ['nome'] = "Platina Pass", ['payment'] = 8500 },
--	{ ['posicao'] = "amg.pass", ['nome'] = "AMG Pass", ['payment'] = 10500 },
--
--	{ ['posicao'] = "manager.permission", ['nome'] = "Bronze Pass", ['payment'] = 6000 },
--	{ ['posicao'] = "admin.permission", ['nome'] = "Prata Pass", ['payment'] = 5000 },
--	{ ['posicao'] = "mod.permission", ['nome'] = "Ouro Pass", ['payment'] = 4000 },
--	{ ['posicao'] = "support.permission", ['nome'] = "Platina Pass", ['payment'] = 3000 },
--
--	{ ['posicao'] = "advogado.permission", ['nome'] = "Advogado", ['payment'] = 10000 },
--	{ ['posicao'] = "juiz.permission", ['nome'] = "Juiz", ['payment'] = 15000 },
--}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	SendWebhookMessage(suspectLog,"```prolog\n[ID]: "..user_id.."\n[SUSPEITO]: Evento PROIBIDO de salário foi triggado"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	DropPlayer(source,"Nosso anticheat detectou uma violação, a administração já foi notificada.")
end)

--RegisterServerEvent('vrp_player:limbo')
--AddEventHandler('vrp_player:limbo',function(x,y,z)
--	local source = source
--	local user_id = vRP.getUserId(source)
--	SendWebhookMessage(limbolog,"```prolog\n[ID]: "..user_id.."\n[COORDENADAS]: "..x..","..y..","..z..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--end)

--function src.publicPaycheck()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		for k,v in pairs(salarios) do
--			if vRP.hasPermission(user_id,v.posicao) and vRP.hasPermission(user_id,v.grupo) then
--				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--				TriggerClientEvent("Notify",source,"importante","Obrigado pelo seu trabalho, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.", 10000)
--				vRP.giveBankMoney(user_id,parseInt(v.payment))
--			end
--		end
--	end
--end

--function src.publicPaycheckVIP()
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		for k,v in pairs(salariosvip) do
--			if vRP.hasPermission(user_id,v.posicao) then
--				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
--				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.", 10000)
--				vRP.giveBankMoney(user_id,parseInt(v.payment))
--			end
--		end
--	end
--end

-- [ VERIFICAR PERMISSÃO NO CLIENT-SIDE ] --
function src.clientPermission(permission)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,permission)
	end
end
-- [ TRANCAR PORTAS DOS CARROS (NAO NECESSARIO PARA CIDADE SEM NPC) ] --
--[[ local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)]]
-- [ AFK KICK ] --
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"amg.pass") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-- [ SEQUESTRO ] --
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-- [ ENVIAR DINHEIRO ] --
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	  local identitynu = vRP.getUserIdentity(nuser_id)
	  
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(moneysendlog,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-- [ GARMAS ] --
RegisterCommand('garmas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rtime = math.random(3,8)

	if not vRP.hasPermission(user_id,"lspd.permission") then
		TriggerClientEvent("Notify",source,"aviso","<b>Aguarde!</b> Suas armas estão sendo desequipadas.",9500)
		TriggerClientEvent("progress",source,10000,"guardando")

		SetTimeout(1000*rtime,function()
			if user_id then
				local weapons = vRPclient.replaceWeapons(source,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(user_id,"wbody|"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
					end
					SendWebhookMessage(garmaslog,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList("wbody|"..k).." \n[QUANTIDADE]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end)
		SetTimeout(10000,function()
			TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
		end)
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
	end
end)
-- [ ROUBAR ] --
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("lspd.permission")
		if #policia >= 2 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"sucesso","Roubo concluido com sucesso.")
					TriggerClientEvent("Notify",nplayer,"sucesso","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
		end
	end
end)
-- [ SAQUEAR ] --
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("lspd.permission")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,20000,"saqueando")
				SetTimeout(20000,function()
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								if not vRP.hasPermission(nuser_id,"lspd.permission") or vRP.hasPermission(nuser_id,"lspd.permission") then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: "..1)
								else
									-----
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									if not vRP.hasPermission(nuser_id,"lspd.permission") or vRP.hasPermission(nuser_id,"lspd.permission") then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
									else
										---
									end
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRP.searchAddTime(user_id,600)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saqueamento concluido com sucesso.")
					TriggerClientEvent("Notify",nplayer,"importante","Saqueamento concluido com sucesso.")
					SendWebhookMessage(saquearlog,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)

-- [ EVENTO DAS INTERAÇÕES COM VEICULO ] --
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-- [ REVISTAR ] --
RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		if vRP.hasPermission(user_id,"staff.permission") then
			TriggerClientEvent('cancelando',source,true)
			TriggerClientEvent('cancelando',nplayer,true)
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		else
			TriggerClientEvent('cancelando',source,true)
			TriggerClientEvent('cancelando',nplayer,true)
			--TriggerClientEvent('carregar',nplayer,source)
			--vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
	--		vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
			TriggerClientEvent("progress",source,5000,"revistando")
			SetTimeout(5000,function()
			
				TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
				if data and data.inventory then
					for k,v in pairs(data.inventory) do
						TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
					end
				end
				TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
				for k,v in pairs(weapons) do
					if v.ammo < 1 then
						TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
					else
						TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
					end
				end
			
				--vRPclient._stopAnim(source,false)
			--	vRPclient._stopAnim(nplayer,false)
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('cancelando',nplayer,false)
			--	TriggerClientEvent('carregar',nplayer,source)
				TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
			end)
			TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
			--TriggerClientEvent("Notify",nplayer,"aviso","Revistado por <b>"..identity.name.." "..identity.firstname.."</b>.",8000)
		end
	end
end)
-- [ PARTES DE ROUPA ] --
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setblusa",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") or vRP.hasPermission(user_id,"lspd.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcolete",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setjaqueta",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmaos",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcalca",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setacessorios",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 and vRP.hasPermission(user_id,"staff.permission") then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setsapatos",source,args[1],args[2])
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
end)
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local admins = vRP.getUsersByPermission("admin.permissao")
		if user_id then
			for l,w in pairs(admins) do
				local player = vRP.getUserSource(parseInt(w))
				TriggerClientEvent('chatMessage',player,"[POLICIA]: "..identity.name.." "..identity.firstname.." "..identity.user_id,{65,130,255},rawCommand:sub(4))
			end
			TriggerClientEvent('chatMessage',-1,"[POLICIA]: "..identity.name.." "..identity.firstname,{65,130,255},rawCommand:sub(4))
		end
	end
end)

RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "lspd.permission"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[DP INTERNO]: "..identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local admins = vRP.getUsersByPermission("admin.permissao")
		if user_id then
			for l,w in pairs(admins) do
				local player = vRP.getUserSource(parseInt(w))
				TriggerClientEvent('chatMessage',player,"[HOSPITAL]: "..identity.name.." "..identity.firstname.." "..identity.user_id,{255,70,135},rawCommand:sub(4))
			end
			TriggerClientEvent('chatMessage',-1,"[HOSPITAL]: "..identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
		end
	end
end)

RegisterCommand('hr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "ems.permission"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[HP INTERNO]: "..identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BENNYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bnns',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local admins = vRP.getUsersByPermission("admin.permissao")
		if user_id then
			for l,w in pairs(admins) do
				local player = vRP.getUserSource(parseInt(w))
				TriggerClientEvent('chatMessage',player,"[BENNYS]: "..identity.name.." "..identity.firstname.." "..identity.user_id,{255,70,135},rawCommand:sub(5))
			end
			TriggerClientEvent('chatMessage',-1,"[BENNYS]: "..identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(5))
		end
	end
end)

RegisterCommand('br',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "bennys.permission"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[BNS INTERNO]: "..identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- admin
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admin',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and vRP.hasPermission(user_id, "admin.permissao") then
			TriggerClientEvent('chatMessage',-1,"Administração: ",{255,0,0},rawCommand:sub(6))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Twitter
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tw',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local admins = vRP.getUsersByPermission("admin.permissao")
		if user_id then
			for l,w in pairs(admins) do
				local player = vRP.getUserSource(parseInt(w))
				TriggerClientEvent('chatMessage',player,"@"..identity.name.." "..identity.firstname.." "..identity.user_id,{43,205,255},rawCommand:sub(3))
			end
			TriggerClientEvent('chatMessage',-1,"@"..identity.name.." "..identity.firstname,{43,205,255},rawCommand:sub(3))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Mercado Livre
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ml',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local admins = vRP.getUsersByPermission("admin.permissao")
		if user_id then
			for l,w in pairs(admins) do
				local player = vRP.getUserSource(parseInt(w))
				TriggerClientEvent('chatMessage',player,"Anúncio: "..identity.name.." "..identity.firstname.." "..identity.user_id,{254,254,0},rawCommand:sub(3))
			end
			TriggerClientEvent('chatMessage',-1,"Anúncio: "..identity.name.." "..identity.firstname,{254,254,0},rawCommand:sub(3))
		end
	end
end)
-- [ PENSAMENTOS ] --
RegisterServerEvent('ChatMe')
AddEventHandler('ChatMe',function(text)
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent('DisplayMe',-1,text,source)
    end
end)

---------------------------------------------------------------------------------
-------- [ COMANDOS PARA VIPS ] ----------
---------------------------------------------------------------------------------
RegisterCommand('vipxenon',function(source,args,rawCommand)
	local src = source
	local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"prata.pass") or vRP.hasPermission(user_id,"ouro.pass") or vRP.hasPermission(user_id,"platina.pass") or vRP.hasPermission(user_id,"amg.pass") then
		print("teste")
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa == identity.registration then
			local cor = vRP.prompt(source,"Qual cor deseja colocar? De 0 à 12"," ")
			local corint = parseInt(cor)
			if corint >= 0 and corint < 13 then
				vPlayerclient.corVipXenon(source, vehicle, tonumber(corint))
			else
				TriggerClientEvent("Notify", source, "negado","Cor inválida, digite os número de 0 à 12.",500)
			end
		end
	else
		TriggerClientEvent("Notify", source, "negado","Você não tem permissão. Comando exclusivo para membros <b>VIPs</b>",500)
	end
end)

RegisterCommand('vipneon',function(source,args,rawCommand)
	local src = source
	local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"bronze.pass") or vRP.hasPermission(user_id,"prata.pass") or vRP.hasPermission(user_id,"ouro.pass") or vRP.hasPermission(user_id,"platina.pass") or vRP.hasPermission(user_id,"amg.pass") then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa == identity.registration then
			local rgb = vRP.prompt(source,"Qual cor deseja colocar? Em RGB Color(255 255 255)"," ",500)
			rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
			local r,g,b = table.unpack(splitString(rgb," "))
			vPlayerclient.corVipNeon(source, vehicle, tonumber(r), tonumber(g), tonumber(b))
		end
	else
		TriggerClientEvent("Notify", source, "negado","Você não tem permissão. Comando exclusivo para membros <b>VIPs</b>",500)
	end
end)

RegisterCommand('vipcor',function(source,args,rawCommand)
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"prata.pass") or vRP.hasPermission(user_id,"ouro.pass") or vRP.hasPermission(user_id,"platina.pass") or vRP.hasPermission(user_id,"amg.pass") then
		local cor = vRP.prompt(source,"Qual cor deseja colocar? De 0 à 7"," ")
		local corint = parseInt(cor)
		if corint >= 0 and corint < 8 then
			vPlayerclient.corVipArmas(source, tonumber(corint))
		else
			TriggerClientEvent("Notify", source, "negado","Cor inválida, digite os número de 0 à 7.",500)
		end
	else
		TriggerClientEvent("Notify", source, "negado","Você não tem permissão. Comando exclusivo para membros <b>VIPs</b>",500)
	end
end)

RegisterCommand('vipattachs',function(source,args,rawCommand)
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"bronze.pass") or vRP.hasPermission(user_id,"prata.pass") or vRP.hasPermission(user_id,"ouro.pass") or vRP.hasPermission(user_id,"platina.pass") or vRP.hasPermission(user_id,"amg.pass") then
		if vRP.request(src,"Deseja pagar $500,00 pelos attachs?",30) then
			if vRP.tryFullPayment(user_id,parseInt(500)) then
				vPlayerclient.VipAttachs(source)
			else
				TriggerClientEvent("Notify", source, "negado","Dinheiro insuficiente.",500)
			end
		end
	else
		TriggerClientEvent("Notify", source, "negado","Você não tem permissão. Comando exclusivo para membros <b>VIPs</b>",500)
	end
end)