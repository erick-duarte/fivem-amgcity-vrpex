-- [ TUNELAGEM ] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
sRPex = {}
Tunnel.bindInterface("AMG_Coin",vRPex)
Proxy.addInterface("AMG_Coin",sRPex )

local idgens = Tools.newIDGenerator()
local blips = {}
local comprabeneficios = "https://discord.com/api/webhooks/845838994390384721/vs1R6kZvbw1ndKJAKCWGenWQ2VjlpQbdusDjb-nwSO5o8pPZjalEEhNrpmYMx6ynoIzC"
local timeboostemprego = 3600

vRP._prepare("vRP/all_amgcoin","SELECT * from amgcoin")
vRP._prepare("vRP/check_amgcoin","SELECT * from amgcoin where user_id = @user_id")
vRP._prepare("vRP/insertfirst_amgcoin","INSERT INTO amgcoin(user_id,coins) VALUES(@user_id,@coins)")
vRP._prepare("vRP/insert_amgcoin","INSERT INTO amgcoin(user_id,coins) VALUES(@user_id,@coins)")
vRP._prepare("vRP/update_amgcoin","UPDATE amgcoin set coins = @coins where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_boostemp","UPDATE amgcoin set boostemp = @ostime where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_desconc30","UPDATE amgcoin set desconc30 = @desconc30 where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_descvip15","UPDATE amgcoin set descvip15 = @descvip15 where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_descvip50","UPDATE amgcoin set descvip50 = @descvip50 where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_descvip15","UPDATE amgcoin set descvip15 = @descvip15 where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_vipbronze","UPDATE amgcoin set vipbronze = @vipbronze where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_vipouro","UPDATE amgcoin set vipouro = @vipouro where user_id = @user_id")
vRP._prepare("vRP/update_amgcoin_money100k","UPDATE amgcoin set money100k = @money100k where user_id = @user_id")


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-- [ TABELA ] --
local valores = {
    { item = "boostemp", compra = 20 },
    { item = "desconc30", compra = 50 },
    { item = "descvip15", compra = 50 },
    { item = "money100k", compra = 75 },
    { item = "descvip50", compra = 150 },
    { item = "vipbronze", compra = 200 },
    { item = "vipouro", compra = 400 },
}

-- [ EVENTO DE COMPRA ] --
RegisterServerEvent("AMG_Coin:compras")
AddEventHandler("AMG_Coin:compras",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local data = vRP.query("vRP/check_amgcoin",{ user_id = user_id })
	if user_id then
		if #data ~= 0 then
			for k,v in pairs(valores) do
				if item == v.item then
					if item == 'boostemp' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							if data[1].boostemp == 0 then
								vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
								vRP.execute("vRP/update_amgcoin_boostemp",{ user_id = user_id, ostime = os.time() })
								TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>1 Hora de Boost</b> em qualquer emprego. Aproveite",5000)
								SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: Boost Temporario "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							else
								TriggerClientEvent("Notify",source,"negado","Você já possui um <b>Boost de Emprego</b> ativado",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif item == 'money100k' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
							TriggerClientEvent("Notify",source,"sucesso","Você resgatou <b>100 Mil dólares</b> com o AMG Coin. Aproveite",5000)
							vRP.giveBankMoney(user_id,parseInt(100000))
							SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: 100k dólar "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif item == 'desconc30' then
						local totalamgcoin = parseInt(data[1].coins)
						local totaldescconc = parseInt(data[1].desconc30)
						if totalamgcoin >= parseInt(v.compra) then
							vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
							vRP.execute("vRP/update_amgcoin_desconc30",{ user_id = user_id, desconc30 = totaldescconc+1 })
							TriggerClientEvent("Notify",source,"sucesso","Você comprou um cupom de <b>30% de desconto</b> na compra de qualquer veículo da concessionária. Aproveite",5000)
							SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: 30% Desconto Concessionaria "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif  item == 'descvip15' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							if data[1].descvip15 == 0 then
								vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
								vRP.execute("vRP/update_amgcoin_descvip15",{ user_id = user_id, descvip15 = 1 })
								TriggerClientEvent("Notify",source,"sucesso","Você comprou um cupom de <b>15% de desconto</b> na compra de qualquer VIP. Chame um staff e aproveite",5000)
								SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: 15% Desconto VIP "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							else
								TriggerClientEvent("Notify",source,"negado","Você já possui um cupom de desconto",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif  item == 'descvip50' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							if data[1].descvip50 == 0 then
								vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
								vRP.execute("vRP/update_amgcoin_descvip50",{ user_id = user_id, descvip50 = 1 })
								TriggerClientEvent("Notify",source,"sucesso","Você comprou um cupom de <b>50% de desconto</b> na compra de qualquer VIP. Chame um staff e aproveite",5000)
								SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: 50% Desconto VIP "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							else
								TriggerClientEvent("Notify",source,"negado","Você já possui um cupom de desconto",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif  item == 'vipbronze' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							if data[1].vipbronze == 0 then
								vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
								vRP.execute("vRP/update_amgcoin_vipbronze",{ user_id = user_id, vipbronze = 1 })
								TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>VIP Bronze</b>. Chame um staff para ativa-lo",5000)
								SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: VIP BRONZE "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							else
								TriggerClientEvent("Notify",source,"negado","Você já comprou um <b>VIP Bronze</b>.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					elseif  item == 'vipouro' then
						local totalamgcoin = parseInt(data[1].coins)
						if totalamgcoin >= parseInt(v.compra) then
							if data[1].vipouro == 0 then
								vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = totalamgcoin-parseInt(v.compra) })
								vRP.execute("vRP/update_amgcoin_vipouro",{ user_id = user_id, vipouro = 1 })
								TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>VIP Ouro</b>. Chame um staff para ativa-lo",5000)
								SendWebhookMessage(comprabeneficios,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[BENEFICIO]: VIP OURO "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							else
								TriggerClientEvent("Notify",source,"negado","Você já comprou um <b>VIP Ouro</b>.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui <b>Coins</b> suficientes",5000)
						end
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui registro no <b>AMG Coins</b>",5000)
			Wait(5000)
			TriggerClientEvent("Notify",source,"importante","O registro é feito de Hora/Hora. Aguarde.",5000)
		end
	end
end)

RegisterCommand('vamgcoins',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.query("vRP/check_amgcoin",{ user_id = user_id })
	TriggerClientEvent("Notify",source,"importante","<b>AMG Coins</b><br><b>Quantidade:</b> "..data[1].coins.."<br>",8000)
end)

function sRPex.checkbeneficio(user_id,beneficio)
	local data = vRP.query("vRP/check_amgcoin",{ user_id = user_id })
	if user_id then
		if #data ~= 0 then
			for k,v in pairs(valores) do
				if beneficio == v.item then
					if beneficio == 'boostemp' then
						if (os.time()-data[1].boostemp) <= timeboostemprego then
							return true
						else
							return false
						end
					elseif beneficio == 'desconc30' then
						if data[1].desconc30 >= 1 then
							local totaldescconc = parseInt(data[1].desconc30)
							vRP.execute("vRP/update_amgcoin_desconc30",{ user_id = user_id, desconc30 = totaldescconc-1 })
							return true
						else
							return false
						end
					end
				end
			end
		end
	end
end

function vRPex.amgCoin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.query("vRP/check_amgcoin",{ user_id = user_id })
		if #data == 0 then
			if vRP.hasPermission(user_id,"amg.pass") then
				vRP.execute("vRP/insertfirst_amgcoin",{ user_id = user_id, coins = 1.5 })
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>1.5</b> AMG Coins", 5000)
			else
				vRP.execute("vRP/insertfirst_amgcoin",{ user_id = user_id, coins = 1 })
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>1</b> AMG Coins", 5000)
			end
		else
			if vRP.hasPermission(user_id,"amg.pass") then
				vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = data[1].coins + 1.5 })
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>1.5</b> AMG Coins", 5000)
			else
				vRP.execute("vRP/update_amgcoin",{ user_id = user_id, coins = data[1].coins + 1 })
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"aviso","Você recebeu <b>1</b> AMG Coins", 5000)
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		local allamgcoins = vRP.query("vRP/all_amgcoin")
	  	for k,v in pairs(allamgcoins) do
			local allplayer = v.user_id
			local beneficiados = vRP.query("vRP/check_amgcoin",{ user_id = allplayer })
			local beneficiado = beneficiados[1]
			local boosttemp = beneficiado.boostemp
			if (os.time()-boosttemp) >= timeboostemprego and beneficiado.boostemp ~= 0 then
				vRP.execute("vRP/update_amgcoin_boostemp",{ user_id = allplayer, ostime = 0 })
			end
	  	end
	  	Citizen.Wait(60000)
	end
end)