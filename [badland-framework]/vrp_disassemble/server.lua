local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vrp_disassemble",emP)

local desmanche = "https://discord.com/api/webhooks/847545163970904074/X9IeAaC1MzCE_eL3p8lIwxkEEu_Zy1KS3fiMaJrTHSy3LZKALKypK9yoE9kYqhFaE_yT"

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("lspd.permission")
	if #policia >= 2 and not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") and not vRP.hasPermission(user_id,"bennys.permission") then	
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Número insuficiente de policiais no momento.",8000)
		return false
	end
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,work = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
				if #vehicle <= 0 then
					TriggerClientEvent("Notify",source,"importante","Veículo não encontrado na lista do proprietário.",8000)
					return
				end
				if parseInt(vehicle[1].detido) == 1 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.",8000)
					return
				end
				if banned then
					TriggerClientEvent("Notify",source,"negado","Veículos de serviço ou alugados não podem ser desmanchados.",8000)
					return
				end
			end
			if vRP.getInventoryItemAmount(user_id,"jammer") >= 1 then
				TriggerClientEvent("Notify",source,"importante","Você possui o <b>Jammer</b> à Policia não será alertada.",5000)
				TriggerClientEvent("vrp_disassemble:jammer", source, true)
				Wait(5000)
				local perderjammer = math.random(100)
				if perderjammer > 79 then
					TriggerClientEvent("Notify",source,"importante","Seu <b>Jammer</b> queimou.",5000)
					vRP.tryGetInventoryItem(user_id,"jammer",1)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui o <b>Jammer</b> à Policia poderá ser alertada.",5000)
			end
			return true
		end
	end
end

function emP.receberDesmanche()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.antiflood(source,"Desmanche",2)
		local vehicle,vnetid,placa,vname,lock,banned,work = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			local price = (vRP.vehiclePrice(vname)*0.1)
			vRP.giveInventoryItem(user_id,"dinheiro-sujo",price)
		end
	end
end

function emP.alertPolicia(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"lspd.permission") then
			local policiais = vRP.getUsersByPermission("lspd.permission")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacaoDesmanche',player,x,y,z,user_id)
				end
			end
		end
	end
end