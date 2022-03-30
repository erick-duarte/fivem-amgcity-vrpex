local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emPclient = Tunnel.getInterface("amg_caminhoneiro")

emP = {}
Tunnel.bindInterface("amg_caminhoneiro",emP)

addCaminhao = {}
Proxy.addInterface("amg_caminhoneiro",addCaminhao)

cfg = module("amg_caminhoneiro", "config")

AMGCoin = Proxy.getInterface("AMG_Coin")
local cnpj = nil
local chest = {
	["ems"] = { 5000,"ems.permission" },
	["bennys"] = { 5000,"bennys.permission" }
}

function emP.addEmprego()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.addUserGroup(user_id,"Caminhoneiro")
	end
end

function emP.removeEmprego()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.addUserGroup(user_id,"Desempregado")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(entregaEncomenda)
    local source = source
    local user_id = vRP.getUserId(source)
	local valorpago = math.random(7500,8000)
	vRP.antiflood(source,"Emprego Caminhao",2)
    if user_id then
		if AMGCoin.checkbeneficio(user_id,"boostemp") then
        	vRP.giveMoney(user_id,(valorpago*2))
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..(valorpago*2).." dólares",3000)
		elseif entregaEncomenda then
			vRP.giveMoney(user_id,(valorpago*2))
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..(valorpago*2).." dólares",3000)
		else
        	vRP.giveMoney(user_id,valorpago)
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..valorpago.." dólares",3000)
		end
    end
end

function emP.checkEncomenda(cnpj, item)
	local source = source
    	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"bennys.permission") or vRP.hasPermission(user_id,"off-bennys.permission") then
		local empresa = vRP.query("empresa/selectEmpresa",{ cnpj = cnpj })
		for k, v in pairs(empresa) do
			
			encomendas = json.decode(v.encomendas)
			qtdPneu = encomendas.pneu.amount
			qtdMilitec = encomendas.militec.amount
			qtdRepairKit = encomendas.repairkit.amount
			break
		end
		for k, v in pairs(encomendas) do
			if k == item then
				if v.amount >= cfg.encomendas.config.qtdEncomendas then

					if item == "repairkit" then
						attEncomendas = '{"repairkit":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"pneu":{"amount":'..qtdPneu..'},"militec":{"amount":'..qtdMilitec..'}}'
					elseif item == "pneu" then
						attEncomendas = '{"pneu":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"repairkit":{"amount":'..qtdRepairKit..'},"militec":{"amount":'..qtdMilitec..'}}'
					elseif item == "militec" then
						attEncomendas = '{"militec":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"repairkit":{"amount":'..qtdRepairKit..'},"pneu":{"amount":'..qtdPneu..'}}'
					end

					vRP.query("empresa/updateEncomendas",{ attEncomendas = attEncomendas, cnpj = cnpj })
					return cfg.encomendas.config.qtdEncomendas
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma encomenda disponivel")
					return 0
				end
			end
		end
	else
		TriggerClientEvent("Notify",source,"negado","Você nao tem autorizacao para esse tipo de emprego",5000)
	end
end

function emP.retornaPedidos(cnpj, item)
	local empresa = vRP.query("empresa/selectEmpresa",{ cnpj = cnpj })
	for k, v in pairs(empresa) do
		encomendas = json.decode(v.encomendas)
		--qtdPneu = encomendas.pneu.amount
		--qtdRepairKit = encomendas.repairkit.amount
		qtdPneu = encomendas.pneu.amount
		qtdMilitec = encomendas.militec.amount
		qtdRepairKit = encomendas.repairkit.amount
		break
	end
	for k, v in pairs(encomendas) do
		if k == item then

			--if item == "repairkit" then
			--	attEncomendas = '{"repairkit":{"amount":'..(parseInt(v.amount + cfg.encomendas.config.qtdEncomendas))..'},"pneu":{"amount":'..qtdPneu..'}}'
			--elseif item == "pneu" then
			--	attEncomendas = '{"pneu":{"amount":'..(parseInt(v.amount + cfg.encomendas.config.qtdEncomendas))..'},"repairkit":{"amount":'..qtdRepairKit..'}}'
			--end

			if item == "repairkit" then
				attEncomendas = '{"repairkit":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"pneu":{"amount":'..qtdPneu..'},"militec":{"amount":'..qtdMilitec..'}}'
			elseif item == "pneu" then
				attEncomendas = '{"pneu":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"repairkit":{"amount":'..qtdRepairKit..'},"militec":{"amount":'..qtdMilitec..'}}'
			elseif item == "militec" then
				attEncomendas = '{"militec":{"amount":'..(parseInt(v.amount - cfg.encomendas.config.qtdEncomendas))..'},"repairkit":{"amount":'..qtdRepairKit..'},"pneu":{"amount":'..qtdPneu..'}}'
			end

			vRP.query("empresa/updateEncomendas",{ attEncomendas = attEncomendas, cnpj = cnpj })
			return cfg.encomendas.config.qtdEncomendas
		end
	end
end

function emP.pegarEncomenda(nomeEncomenda)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
--[[	local pesoItem = vRP.getItemWeight(nomeEncomenda)
		local mochilaPlayer = vRP.getInventoryWeight(user_id)
		local totalMochilaPlayer = vRP.getInventoryMaxWeight(user_id)
		local pesoTotal = (pesoItem*cfg.encomendas.config.qtdEncomendas) + mochilaPlayer
		if pesoTotal < totalMochilaPlayer then
			vRP.giveInventoryItem(user_id,nomeEncomenda,cfg.encomendas.config.qtdEncomendas)
			TriggerClientEvent("Notify",source,"sucesso","Você pegou a encomenda!") ]]
			return true
--[[	else
			TriggerClientEvent("Notify",source,"negado","Voce nao possui espaco suficiente na mochila!")
		end ]]
	end
end


function emP.deixarEncomenda(nomeEncomenda,nomeBau)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	vRP.antiflood(source,"Emprego Caminhao",2)
	if user_id then
		if vRP.storeChestItemCaminhoneiro(user_id,"chest:"..tostring(nomeBau),nomeEncomenda,cfg.encomendas.config.qtdEncomendas,chest[tostring(nomeBau)][1]) then
			
			local bennys = vRP.getUsersByPermission("bennys.permission")
			for k,v in pairs(bennys) do
				local srcBennys = vRP.getUserSource(v)
				if srcBennys then
					async(function()
						TriggerClientEvent("Notify",source,"importante","Encomenda recebida !<br><br>Motorista: "..identity.firstname.."<br>Produto: "..nomeEncomenda.."<br>Quantidade: 10x")
					end)
				end
			end
			
			return true
		end
	end
end