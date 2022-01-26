local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("bdl_drugsdeliver",src)


local vendameta = "https://discord.com/api/webhooks/849650891605803038/hqwo2i3FmsbD9gUyfIMB6Sjekgz5OKMHdsrVhYC3OzwKl-8FzoXWdnVdTtISS4hQqM-G"
local vendacoca = "https://discord.com/api/webhooks/849650978659106817/eIMmFamtWITcorddHf9QAcsI_PkArjiumSldXVnDyejITeGocUpVbOq9O2_41DqVFaIT"
local vendamaconha = "https://discord.com/api/webhooks/849651058937561098/pW5lQPw_wbopCRzYOL3JDMBcHF4V7sTujhnTzpnxsIGbEm0KIwZSXY7UGBz4Xjtk4g1k"


local quantidade = {}
function src.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	quantidade[source] = 0
	if user_id and data and data.inventory then
		for i,o in pairs(data.inventory) do
			if i == "maconha-embalada" then
				quantidade[source] = o.amount
			elseif i == "coca-embalada" then
				quantidade[source] = o.amount
			elseif i == "meta-embalada" then
				quantidade[source] = o.amount
			end
		end
	end
--	if quantidade[source] == nil then
--		quantidade[source] = math.random(2,8)
--	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") then
		return true
	end
end

function src.checkItens()
	src.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") then
            return vRP.getInventoryItemAmount(user_id,"maconha-embalada") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"coca-embalada") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-embalada") >= quantidade[source]
		end
		return
	end
end

function src.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local value = math.random(4300,4700)
    if user_id then
		vRP.antiflood(source,"Venda drogas",3)
        local policia = vRP.getUsersByPermission("lspd.permission")
		local pdamount = 0
        local sold = 0
		local droga = nil
		local multiplier = 0
		local haveWeed = false
		local haveCoca = false
		local qthvenda = math.random(1,quantidade[source])
     
        if vRP.tryGetInventoryItem(user_id,"maconha-embalada",qthvenda) then
            sold = sold + 1
			droga = "maconha"
        end
        if vRP.tryGetInventoryItem(user_id,"coca-embalada",qthvenda) then
            sold = sold + 1
			droga = "coca"
        end
		if vRP.tryGetInventoryItem(user_id,"meta-embalada",qthvenda) then
            sold = sold + 1
			droga = "metanfetamina"
        end 

        if sold > 0 then
			for k,v in pairs(policia) do
				pdamount = pdamount + 1
			end
			if parseInt(pdamount) >= 2 and parseInt(pdamount) <= 4 then
				multiplier = 0.1
			elseif parseInt(pdamount) > 4 and parseInt(pdamount) <= 8 then
				multiplier = 0.2
			elseif parseInt(pdamount) > 8 and parseInt(pdamount) <= 12 then
				multiplier = 0.3
			elseif parseInt(pdamount) > 12 and parseInt(pdamount) <= 16 then
				multiplier = 0.4
			elseif parseInt(pdamount) > 16 then
				multiplier = 0.5
			else
				multiplier = 0
			end
--			local amount_drugs = sold
--			local payment = parseInt(value*quantidade[source]*sold)
			local payment = parseInt(value*qthvenda)
			vRP.giveInventoryItem(user_id,"dinheiro-sujo", payment+payment*multiplier)
			TriggerClientEvent("Notify",source,"sucesso","Vendeu "..qthvenda.."x drogas e ganhou $"..payment+payment*multiplier.."",5000)
			if droga == "maconha" then
				PerformHttpRequest(vendamaconha, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE VENDA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**DROGA VENDIDA:**", value = "[ **Item: "..vRP.itemNameList("maconha-embalada").."** ][ **Quantidade: "..parseInt(qthvenda).."** ][ **Recebido: $"..payment+payment*multiplier.."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
			elseif droga == "coca" then
				PerformHttpRequest(vendacoca, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE VENDA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**DROGA VENDIDA:**", value = "[ **Item: "..vRP.itemNameList("coca-embalada").."** ][ **Quantidade: "..parseInt(qthvenda).."** ][ **Recebido: $"..payment+payment*multiplier.."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
			elseif droga == "metanfetamina" then
				PerformHttpRequest(vendameta, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE VENDA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**DROGA VENDIDA:**", value = "[ **Item: "..vRP.itemNameList("meta-embalada").."** ][ **Quantidade: "..parseInt(qthvenda).."** ][ **Recebido: $"..payment+payment*multiplier.."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
			end
			droga = nil
			quantidade[source] = nil
			qthvenda = nil
        end
        return true
    end
end

local blips = {}
function src.setPoliceWarn()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("lspd.permission")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end

function src.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(60))
	end
end