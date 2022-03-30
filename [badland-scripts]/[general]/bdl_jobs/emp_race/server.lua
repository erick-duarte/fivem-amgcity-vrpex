local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_race",emP)
emPClient = Tunnel.getInterface("emp_race")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

local startCorrida = "https://discord.com/api/webhooks/842991335384285196/mmLPCFT4dlDviS-fL4v3HubA4fmE9JRPMMdsBT9hb1X76vdla9b1a5JeLXjUD53pZYVe"
local endCorrida = "https://discord.com/api/webhooks/842991430858309663/-7Ow6wXDUhbIIjHS2t6xkngiqajNw3fM5zoFkxdaMgng3IaVwTQZjgWCt9VfEbrlNyjB"

local pay = {
	[1] = { ['min'] = 6000, ['max'] = 8500 },
	[2] = { ['min'] = 6000, ['max'] = 8500 },
	[3] = { ['min'] = 6000, ['max'] = 8500 },
	[4] = { ['min'] = 6000, ['max'] = 8500 },
	[5] = { ['min'] = 6000, ['max'] = 8500 }
}

function emP.paymentCheck(check,status)
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Corrida ilegal",2)
	if user_id then
		local random = math.random(pay[check].min,pay[check].max)
		local policia = vRP.getUsersByPermission("lspd.permission")
		vRP.searchTimer(user_id,900)
		vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(random*status))
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(((random*#policia)*status)*0.7).."</b> dinheiro sujo.",5000)
		PerformHttpRequest(endCorrida, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "", description = "Corrida finalizada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Qth dinheiro:**", value = "` Númers "..parseInt(((random*#policia)*status)*0.7).."`" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
	end
end

local racepoint = 1
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(180000)
		racepoint = math.random(#pay)
	end
end)

local corridas = 0
function emP.AutorizadoRace()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("lspd.permission")
	local qthpoliciais = parseInt(#policia) / 2
	if parseInt(qthpoliciais) >= 0 and parseInt(qthpoliciais) >= corridas then
		corridas = 1 + corridas
		PerformHttpRequest(startCorrida, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "", description = "Corrida iniciada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Qth Policiais:**", value = "` Númers "..qthpoliciais.."`" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Policiais insuficiente.",3000)
		return false
	end
end

function emP.getRacepoint()
	return parseInt(racepoint)
end

function emP.startBombRace(x,y,z)
	local source = source
	local policia = vRP.getUsersByPermission("lspd.permission")
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				TriggerClientEvent('blip:remover:race',player)
				TriggerClientEvent('blip:criar:race',player,x,y,z)
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Encontramos um corredor ilegal na cidade, intercepte-o.")
			end)
		end
	end
end

function emP.removeBlipRace()
	local source = source
	local policia = vRP.getUsersByPermission("lspd.permission")
	if corridas > 0 then
		corridas = corridas - 1
	end
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				TriggerClientEvent('blip:remover:race',player)
				TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Corrida finalizada.")
			end)
		end
	end
end

function emP.removeBombRace()
	local source = source
	TriggerEvent('eblips:remove',source)
end

RegisterCommand('defuse',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lspd.permission") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('emp_race:defuse',nplayer)
		end
	end
end)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"lspd.permission") or vRP.hasPermission(user_id,"ems.permission") or vRP.hasPermission(user_id,"bennys.permission"))
end