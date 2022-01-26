local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vrp_hospital",emP)
vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
local idgens = Tools.newIDGenerator()

local emschatlog = "SEULINK"
local pricetratamento = 500

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-- [ CHECA SE NÂO TEM PARAMÉDICO EM SERVIÇO ] -- 
function emP.checkServices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission("ems.permission")
		if parseInt(#paramedicos) == 0 then
			local ok = vRP.request(source,"O tratamento custa <b>$"..vRP.format(parseInt(pricetratamento)).."</b> dólares, deseja fazer o pagamento ?",60)
			if ok then
				if vRP.tryFullPayment(user_id,parseInt(pricetratamento)) then
					TriggerClientEvent("Notify",source,"sucesso","Pagamento efetuado com sucesso.",10000)
					return true
				end
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Existem médicos em serviço.")
		end
	end
end

-- [ CHECA SE NÂO TEM PARAMÉDICO EM SERVIÇO ] -- 
function emP.checkServices2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local paramedicos = vRP.getUsersByPermission("ems.permission")
		if parseInt(#paramedicos) == 0 then
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Existem médicos em serviço.")
		end
	end
end

-- [ 112 (CHAT PARAMÉDICO GERAL) ] -- 
--RegisterCommand('112',function(source,args,rawCommand)
--	if args[1] then
--		local user_id = vRP.getUserId(source)
--		local identity = vRP.getUserIdentity(user_id)
--		if vRP.hasPermission(user_id,"ems.permission") then
--			if user_id then
--				TriggerClientEvent('chatMessage',-1,"[ EMS ] "..identity.name.." "..identity.firstname,{255,35,35},rawCommand:sub(4))
--				SendWebhookMessage(emschatlog,"**[ EMS ] "..identity.name.." "..identity.firstname..":** "..rawCommand:sub(4)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
--			end
--		end
--	end
--end)
-- [ 112 (CHAT PARAMÉDICO INTERNO) ] -- 
--RegisterCommand('pr',function(source,args,rawCommand)
--	if args[1] then
--		local user_id = vRP.getUserId(source)
--		local identity = vRP.getUserIdentity(user_id)
--		local permission = "ems.permission"
--		if vRP.hasPermission(user_id,permission) then
--			local emsmember = vRP.getUsersByPermission(permission)
--			for l,w in pairs(emsmember) do
--				local player = vRP.getUserSource(parseInt(w))
--				if player then
--					async(function()
--						TriggerClientEvent('chatMessage',player,"[ INTERNO ] "..identity.name.." "..identity.firstname,{255,109,80},rawCommand:sub(3))
--					end)
--				end
--			end
--		end
--	end
--end)

-- [ MECS EM SERVIÇO ] --
RegisterCommand('ems', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("ems.permission")
	local paramedicos = 0
	local oficiais_nomes = ""
	if vRP.hasPermission(user_id,"ems.permission") or vRP.hasPermission(user_id,"staff.permission") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Médicos</b> em serviço.",10000)
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"importante", oficiais_nomes,10000)
		end
   else
	   TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..#oficiais.." Médicos</b> em serviço.",10000)
   end
end)

-- [ REANIMAR PLAYER ] --
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ems.permission") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local identity_user = vRP.getUserIdentity(user_id)
				local nuser_id = vRP.getUserId(nplayer)
				local identity_coma = vRP.getUserIdentity(nuser_id)
				
				local set_user = "Departamento Médico"

				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")

				SetTimeout(30000,function()	
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent('cancelando',source,false)
				end)

			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"importante","Chegue mais perto do paciente.")
		end
	elseif vRP.hasPermission(user_id,"lspd.permission") then
		if emP.checkServices2() then
			if nplayer then
				if vRPclient.isInComa(nplayer) then
					local identity_user = vRP.getUserIdentity(user_id)
					local nuser_id = vRP.getUserId(nplayer)
					local identity_coma = vRP.getUserIdentity(nuser_id)
					
					local set_user = "Departmanto de Polícia"
	
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
					TriggerClientEvent("progress",source,30000,"reanimando")
					
					SetTimeout(30000,function()
						vRPclient.killGod(nplayer)
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent('cancelando',source,false)
					end)
				else
					TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Existem membros do Departamento Médico em serviço!")
		end 
	end
end)

-- [ TRATAMENTO ] --
--RegisterCommand('tratamento',function(source,args,rawCommand)
--    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id,"ems.permission") then
--        local nplayer = vRPclient.getNearestPlayer(source,3)
--        if nplayer then
--			if not vRPclient.isComa(nplayer) then
--				TriggerClientEvent("tratamento",nplayer)
--				TriggerClientEvent("Notify",source,"sucesso","Tratando o paciente.",10000)
--            end
--        end
--    end
--end)

RegisterCommand('tratamento',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,3)
    local nuser_id = vRP.getUserId(nplayer)
	local pagamento = tonumber(args[1])
    
	if pagamento > 0 then
--    	if vRP.hasPermission(user_id,"hospital.permissao") then
		if vRP.hasPermission(user_id,"ems.permission") then
    	    if vRP.request(nplayer,"Deseja receber tratamento no valor de <b>$"..pagamento.."</b>?",30) then
    	        if vRP.tryFullPayment(nuser_id,pagamento) then
    	            vRP.giveBankMoney(user_id,pagamento)
    	            TriggerClientEvent('Notify',source,"sucesso","Você recebeu <b>$"..pagamento.."</b>")
    	            if nplayer then
    	                if not vRPclient.isComa(nplayer) then
    	                    TriggerClientEvent("tratamento",nplayer)
    	                    TriggerClientEvent("Notify",source,"sucesso","Tratamento no paciente iniciado com sucesso.",10000)
    	                end
    	            end
    	        else    
    	            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
    	        end   
    	    end
    	end
	else
		TriggerClientEvent("Notify",source,"negado","Valor inválido.")
	end
end)