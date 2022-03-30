-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("voip",cnVRP)
vCLIENT = Tunnel.getInterface("voip")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"bcso.permissao") then
					vCLIENT.startFrequency(source,911)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 912 then
				if vRP.hasPermission(user_id,"bcso.permissao") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 913 then
				if vRP.hasPermission(user_id,"bcso.permissao") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 914 then
				if vRP.hasPermission(user_id,"bcso.permissao") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 915 then
				if vRP.hasPermission(user_id,"Investigativa") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"dmla.permissao") then
					vCLIENT.startFrequency(source,112)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"mecanico.permissao") then
					vCLIENT.startFrequency(source,443)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 999 then
				if vRP.hasPermission(user_id,"staff.permissao") then
					vCLIENT.startFrequency(source,999)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 120 then
				if vRP.hasPermission(user_id,"Crips") then
					vCLIENT.startFrequency(source,120)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 121 then
				if vRP.hasPermission(user_id,"families.permissao") then
					vCLIENT.startFrequency(source,121)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 122 then
				if vRP.hasPermission(user_id,"vagos.permissao") then
					vCLIENT.startFrequency(source,122)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 123 then
				if vRP.hasPermission(user_id,"ballas.permissao") then
					vCLIENT.startFrequency(source,123)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 124 then
				if vRP.hasPermission(user_id,"reds.permissao") then
					vCLIENT.startFrequency(source,124)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 125 then
				if vRP.hasPermission(user_id,"mafia.permissao") then
					vCLIENT.startFrequency(source,125)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 126 then
				if vRP.hasPermission(user_id,"yakuza.permissao") then
					vCLIENT.startFrequency(source,126)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 127 then
				if vRP.hasPermission(user_id,"TheLost") then
					vCLIENT.startFrequency(source,127)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 128 then
				if vRP.hasPermission(user_id,"Serpents") then
					vCLIENT.startFrequency(source,128)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 129 then
				if vRP.hasPermission(user_id,"DriftKing") then
					vCLIENT.startFrequency(source,129)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 130 then
				if vRP.hasPermission(user_id,"Brokers") then
					vCLIENT.startFrequency(source,130)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 131 then
				if vRP.hasPermission(user_id,"Vanilla") then
					vCLIENT.startFrequency(source,131)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 132 then
				if vRP.hasPermission(user_id,"Bahamas") then
					vCLIENT.startFrequency(source,132)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 133 then
				if vRP.hasPermission(user_id,"Anonymous") then
					vCLIENT.startFrequency(source,133)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 134 then
				if vRP.hasPermission(user_id,"LifeInvader") then
					vCLIENT.startFrequency(source,134)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 135 then
				if vRP.hasPermission(user_id,"CyberBar") then
					vCLIENT.startFrequency(source,135)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
			return true
		end
		return false
	end
end