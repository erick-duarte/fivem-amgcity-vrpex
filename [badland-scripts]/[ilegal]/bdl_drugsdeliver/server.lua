local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("bdl_drugsdeliver",src)


--local vendameta = "https://discord.com/api/webhooks/849650891605803038/hqwo2i3FmsbD9gUyfIMB6Sjekgz5OKMHdsrVhYC3OzwKl-8FzoXWdnVdTtISS4hQqM-G"
--local vendacoca = "https://discord.com/api/webhooks/849650978659106817/eIMmFamtWITcorddHf9QAcsI_PkArjiumSldXVnDyejITeGocUpVbOq9O2_41DqVFaIT"
--local vendamaconha = "https://discord.com/api/webhooks/849651058937561098/pW5lQPw_wbopCRzYOL3JDMBcHF4V7sTujhnTzpnxsIGbEm0KIwZSXY7UGBz4Xjtk4g1k"


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
    
    if user_id then
		vRP.antiflood(source,"Venda drogas",3)
		local item = nil
		local qthvenda = math.random(1,quantidade[source])
     
        if vRP.tryGetInventoryItem(user_id,"maconha-embalada",qthvenda) then
			local value = math.random(2300,2500)
			item = "maconha-embalada"
		elseif vRP.tryGetInventoryItem(user_id,"coca-embalada",qthvenda) then
			local value = math.random(3600,3800)
			item = "coca-embalada"
		elseif vRP.tryGetInventoryItem(user_id,"meta-embalada",qthvenda) then
			local value = math.random(1800,2000)
			item = "meta-embalada"
        end
		local payment = parseInt(value*qthvenda)

		vRP.giveInventoryItem(user_id,"dinheiro-sujo", payment)
		TriggerClientEvent("Notify",source,"sucesso","Vendeu "..qthvenda.."x drogas e ganhou $"..payment.."",5000)

		vRP.execute("bdl_drugsdeliver/insertVendas",{ user_id = user_id, item = item, quantidade = qthvenda, recebido = payment })

		droga = nil
		quantidade[source] = nil
		qthvenda = nil
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