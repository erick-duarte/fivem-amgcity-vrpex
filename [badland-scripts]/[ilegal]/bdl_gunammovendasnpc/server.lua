local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("bdl_gunammovendasnpc",src)

local vendaarmas = "https://discord.com/api/webhooks/854087598015643648/txHkUnkjp-QLIPJO93TzI_G8Fkmjm7FRVMg3vRub8-cZp1G2Odj51bsFFivVx0N7X862"
local vendamunicao = "https://discord.com/api/webhooks/854087502206074940/hNjRCbmMum1tCaCoipQgizn-bacELs-srj0XWhr0ZHSzoXvHK3ZXR2jpLdHe788aPOTw"

local quantidadegun = {}
local quantidadeammo = {}
function src.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	quantidadegun[source] = 0
	quantidadeammo[source] = 0
	if user_id and data and data.inventory then
		for i,o in pairs(data.inventory) do
			print(i)
			if i == "wbody|WEAPON_PISTOL_MK2" then
				quantidadegun[source] = o.amount
			end
			if i == "wammo|WEAPON_PISTOL_MK2" then
				quantidadeammo[source] = o.amount
			end
		end
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"ems.permission") and not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"bennys.permission") then
		return true
	end
end

function src.checkItens()
	src.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"ems.permission") and not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"bennys.permission") then
            return vRP.getInventoryItemAmount(user_id,"wbody|WEAPON_PISTOL_MK2") >= quantidadegun[source] or vRP.getInventoryItemAmount(user_id,"cwammo|WEAPON_PISTOL_MK2") >= quantidadeammo[source]
		end
		return
	end
end

function src.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local value = 0
    if user_id then
		vRP.antiflood(source,"Venda armas e municoes",3)
        local sold = 0
		local qthvendagun = 1
		local qthvendaammo = 0
		local arma = false
		local municao = false

		if quantidadegun[source] > 0 then
			qthvendagun = 1
		end
		if quantidadeammo[source] > 0 then
			qthvendaammo = math.random(1,quantidadeammo[source])
		end
     
		print(qthvendagun)
        if vRP.tryGetInventoryItem(user_id,"wbody|WEAPON_PISTOL_MK2",qthvendagun) then
			valuegun = math.random(30000,32000)
            sold = sold + 1
			arma = true
        end

		print(qthvendaammo)
        if vRP.tryGetInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",qthvendaammo) then
			valueammo = math.random(350,400)
            sold = sold + 1
			municao = true
        end

        if sold > 0 then
			if arma then
				local payment = parseInt(valuegun*qthvendagun)
				vRP.giveInventoryItem(user_id,"dinheiro-sujo", payment)
				TriggerClientEvent("Notify",source,"sucesso","Vendeu "..qthvendagun.."x Five Seven e ganhou $"..payment.."",5000)
				PerformHttpRequest(vendaarmas, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE VENDA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ARMA VENDIDA:**", value = "[ **Item: "..vRP.itemNameList("wbody|WEAPON_PISTOL_MK2").."** ][ **Quantidade: "..parseInt(qthvendagun).."** ][ **Recebido: $"..payment.."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
			end
			if municao then
				local payment = parseInt(valueammo*qthvendaammo)
				vRP.giveInventoryItem(user_id,"dinheiro-sujo", payment)
				TriggerClientEvent("Notify",source,"sucesso","Vendeu "..qthvendaammo.."x munição de Five Seven e ganhou $"..payment.."",5000)
				PerformHttpRequest(vendamunicao, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE VENDA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM VENDEU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**MUNIÇÃO:**", value = "[ **Item: "..vRP.itemNameList("wammo|WEAPON_PISTOL_MK2").."** ][ **Quantidade: "..parseInt(qthvendaammo).."** ][ **Recebido: $"..payment.."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
			end
			quantidadeammo[source] = nil
			quantidadegun[source] = nil
			qthvendagun = nil
			qthvendaammo = nil
			sold = 0
			arma = false
			municao = false
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