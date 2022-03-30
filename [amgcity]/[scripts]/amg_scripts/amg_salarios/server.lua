local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("amg_salarios",src)
srcCLI = Tunnel.getInterface("amg_salarios")
local cfg = module("vrp","cfg/groups")
local groups = cfg.groups
local salarios = {}

vRP.prepare("amgsalario/get_all","SELECT id,posicao,grupo,nome,pagamento,tipo FROM amg_salarios")

Citizen.CreateThread(function()
	Citizen.Wait(500)
	salarios = vRP.query("amgsalario/get_all")
end)

function src.pagamentoSalario()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in ipairs(salarios) do
          	if v.tipo == "job" then
				if vRP.hasPermission(user_id,v.posicao) and vRP.hasPermission(user_id,v.grupo) then
					TriggerClientEvent("vrp_sound:source",source,'coins',0.2)
					TriggerClientEvent("Notify",source,"importante","Obrigado pelo seu trabalho, seu salario de <b>$"..vRP.format(parseInt(v.pagamento)).." dólares</b> foi depositado.", 10000)
					vRP.giveBankMoney(user_id,parseInt(v.pagamento))
			    end
            elseif v.tipo == "vip" then
            	if vRP.hasPermission(user_id,v.posicao) then
            	    TriggerClientEvent("vrp_sound:source",source,'coins',0.2)
            	    TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.pagamento)).." dólares</b> foi depositado.", 10000)
            	    vRP.giveBankMoney(user_id,parseInt(v.pagamento))
            	end
        	end			
		end
	end
end
