---gambiarra quase pronta porem funcional by iND :*


local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("vrp_garages")


RegisterCommand("setradio", function(source, args)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
--		local vehassh = vCLIENT.getHash(source,vehiclehash)
--		print(vehassh)
		if vehicle and placa then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if user_id == placa_user_id then
				if not args[1] then
					TriggerClientEvent("chatMessage", source, "Use /som ON ou /som OFF")
				elseif args[1] == 'on' or args[1] == 'ON' then
					TriggerClientEvent("chatMessage",source, "Som LIGADO ")
					TriggerClientEvent("jbl:myRadio",-1, vname)
					TriggerClientEvent("jbl:RadioON",-1, vnetid,user_id,50)
				elseif args[1] == 'url' or args[1] == 'URL' then
					local url = vRP.prompt(source,"Som do carro ligado, coloque uma musica.","")
						if url == "" then
							return
						end
					TriggerClientEvent("jbl:PlayOnOneRadio",-1, url,50,user_id)
					TriggerClientEvent("JBL:Play_URL", -1, url,50,user_id,vname)
				elseif args[1] == 'volume' or args[1] == 'VOLUME' then
					local volume = vRP.prompt(source,"Volume 0 a 100.","")
						if volume == "" then
							return
						end
						TriggerClientEvent("jbl:setvolumeRadio",-1, volume,user_id)
				elseif args[1] == 'OFF' then
					TriggerClientEvent("jbl:RadioOFF",-1,user_id)
				end
			end
		else
			TriggerClientEvent("chatMessage", source, "Longe do veiculo.")
		end
	end
end)