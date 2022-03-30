-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("rob_market",src)
vCLIENT = Tunnel.getInterface("rob_market")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown2x2 = 0
local timedown3x3 = 0
local timedown6x6 = 0
local qthpolicia = 0 
local acao2x2 = false
local acao3x3 = false
local acao6x6 = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdepartamento = "https://discord.com/api/webhooks/845401440901660732/dKYmPrENs_Eo-gKYcgnTaqpHPupp-0im5ixCQ-1aWhYj9uEm-A1ILt2N1mnfDjBXM0SF"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[2] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[3] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
--	[4] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[5] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[6] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[7] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[8] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[9] = { ['place'] = "Loja de Departamento", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
--AMMUNATION
	[10] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[11] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[12] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[13] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[14] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
	[15] = { ['place'] = "Ammunation", ['seconds'] = 300, ['rewmin'] = 350000, ['rewmax'] = 360000 },
--AÇOUGUE
	[16] = { ['place'] = "Açougue", ['seconds'] = 300, ['rewmin'] = 450000, ['rewmax'] = 460000 },
--GALINHEIRO
	[17] = { ['place'] = "Galinheiro", ['seconds'] = 300, ['rewmin'] = 450000, ['rewmax'] = 460000 },
--TEATRO
	[18] = { ['place'] = "Teatro", ['seconds'] = 300, ['rewmin'] = 450000, ['rewmax'] = 460000 },
--BARBEARIA
	[19] = { ['place'] = "Barbearia", ['seconds'] = 120, ['rewmin'] = 40000, ['rewmax'] = 45000 },
--BARBEARIA
	[20] = { ['place'] = "Los Santos", ['seconds'] = 300, ['rewmin'] = 450000, ['rewmax'] = 460000 },
--JOALHEIRA
	[21] = { ['place'] = "Joalheria", ['seconds'] = 300, ['rewmin'] = 3600000, ['rewmax'] = 3700000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice(ponto)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"lspd.permission") or vRP.hasPermission(user_id,"ems.permission") or vRP.hasPermission(user_id,"bennys.permission") then
			local policia = vRP.getUsersByPermission("lspd.permission")
			qthpolicia = #policia

			if acao2x2 and qthpolicia >= 2 then
				qthpolicia = qthpolicia - 2
			elseif acao3x3 and qthpolicia >= 3 then
				qthpolicia = qthpolicia - 3
			elseif acao6x6 and qthpolicia >= 6 then
				qthpolicia = qthpolicia - 6
			end

			if qthpolicia < 2 then
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
				return false
			elseif (os.time()-timedown2x2) <= 1800 and ponto >= 1 and ponto <= 15 then
				TriggerClientEvent("Notify",source,"aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((1800-(os.time()-timedown2x2)))).." segundos</b> até que os civis efetuem depositos.",8000)
				return false
			elseif (os.time()-timedown3x3) <= 1800 and ponto >= 16 and ponto <= 18 or ponto == 20 then
				TriggerClientEvent("Notify",source,"aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((1800-(os.time()-timedown3x3)))).." segundos</b> até que os civis efetuem depositos.",8000)
				return false
			elseif (os.time()-timedown6x6) <= 1800 and ponto == 21 then
				TriggerClientEvent("Notify",source,"aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((1800-(os.time()-timedown6x6)))).." segundos</b> até que os civis efetuem depositos.",8000)
				return false
			elseif ponto >= 1 and ponto <= 15 or ponto == 19 and qthpolicia >= 2 then
				acao2x2 = true
				return true
			elseif ponto >= 16 and ponto <= 18 or ponto == 20 and qthpolicia >= 3 then
				acao3x3 = true
				return true
			elseif ponto == 21 and qthpolicia >= 6 then
				acao6x6 = true
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento ou outra ação está em andamento.",8000)
				return false
			end
		else
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		robbery = true

		if id >= 1 and id <= 15 or id == 19 then
			timedown2x2 = os.time()
		elseif id >= 16 and id <= 18 or id == 20 then
			timedown3x3 = os.time()
		elseif id == 21 then
			timedown6x6 = os.time()
		end

		vCLIENT.startRobbery(source,robbers[id].seconds,x,y,z)
		TriggerClientEvent("vrp_sound:source",source,'alarm',0.2)
		vRPclient.setStandBY(source,parseInt(600))

		local policia = vRP.getUsersByPermission("lspd.permission")
		for k,v in pairs(policia) do
			local policial = vRP.getUserSource(v)
			if policial then
				async(function()
					vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id].place)
					vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo começou no ^1"..robbers[id].place.."^0, dirija-se até o local e intercepte os assaltantes.")
				end)
			end
		end
		SendWebhookMessage(webhookdepartamento,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		SetTimeout(robbers[id].seconds*1000,function()
			if robbery then
				robbery = false
--				vRP.searchTimer(user_id,1800)
				vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(math.random(robbers[id].rewmin,robbers[id].rewmax)))

				if acao2x2 then
					acao2x2 = false
				elseif acao3x3 then
					acao3x3 = false
				elseif acao6x6 then
					acao6x6 = false
				end

				for k,v in pairs(policia) do
					local policial = vRP.getUserSource(v)
					if policial then
						async(function()
							vCLIENT.stopRobberyPolice(policial)
							TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			if acao2x2 then
				acao2x2 = false
			elseif acao3x3 then
				acao3x3 = false
			elseif acao6x6 then
				acao6x6 = false
			end
			local policia = vRP.getUsersByPermission("lspd.permission")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end