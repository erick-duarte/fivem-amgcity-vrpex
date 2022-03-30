local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

encomendasAMG = {}
Tunnel.bindInterface("amg_encomendas",encomendasAMG)
encomendasAMGCLIENT = Tunnel.getInterface("amg_encomendas")

local amGcfg = module("amg_scripts", "amg_encomendas/config")
local listEncomendas, attEncomendas, produtoIlegal, valorIlegal, produtoLegal, valorLegal, mercadorias, permissao, tipo = nil
local pedidoIlegal = {}
local grupo = {}
local caixaEmpresa = 0

vRP.prepare("empresa/selectEmpresa","SELECT * from amg_empresas where cnpj = @cnpj")
vRP.prepare("empresa/updateCaixa","UPDATE amg_empresas set caixa = @caixa where cnpj = @cnpj")
vRP.prepare("empresa/updateEncomendas","UPDATE amg_empresas set encomendas = @attEncomendas where cnpj = @cnpj")

vRP._prepare("vrpplayer/createDataBase",[[
  CREATE TABLE IF NOT EXISTS amg_empresas(
	cnpj int(11) NOT NULL AUTO_INCREMENT,
	empresa varchar(255) DEFAULT NULL,
	permissao varchar(255) NOT NULL,
	caixa int(20) DEFAULT NULL,
	encomendas varchar(255) DEFAULT NULL,
	produtos varchar(255) DEFAULT NULL,
	PRIMARY KEY (`cnpj`) USING BTREE
  )
]])

async(function()
	vRP.execute("vrpplayer/createDataBase")
end)

RegisterCommand('encomendar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local user_groups = vRP.getUserGroups(user_id)
	for a, b in pairs(user_groups) do
		for c, d in pairs(amGcfg.empresas) do
			if a:gsub('%-', '') == c then
				permissao = d.permission
				mercadorias = d.produtos
				tipo = d.tipo
				cnpj = d.cnpj
				grupo[source] = a:gsub('%-', '')
				minloc = d.minloc
				maxloc = d.maxloc
				break
			end
		end
	end
	if permissao == nil then
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
	end
	if args[1] == nil or args[2] == nil then
		TriggerClientEvent("Notify",source,"negado","Comando inválido")
		Citizen.Wait(1500)
		TriggerClientEvent("Notify",source,"importante","Utilize o /encomendar PRODUTO QTD")
    else
		if vRP.hasPermission(user_id,permissao) or vRP.hasPermission(user_id,'founder.permission') then
        	if args[2]%10 == 0 and parseInt(args[2]) > 1 then
				if parseInt(args[2]) < 50 then
					if tipo == 0 then
						encomendasAMG.encomendasLegal(source, args[1], args[2])
					elseif tipo == 1 then
						if not pedidoIlegal[source] then
							encomendasAMG.encomendasIlegais(source, args[1], args[2])
						else
							TriggerClientEvent("Notify",source,"importante","Você já tem um encomenda em andamento.")
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Você pode solicitar no máximo 50 itens por vez.")
				end
        	else
				TriggerClientEvent("Notify",source,"negado","O pedido só pode ser feito em multiplos de 10.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão para solicitar encomendas.")
		end
     end
end)

function encomendasAMG.encomendasLegal(source, args1, args2)
	local source = source
	local user_id = vRP.getUserId(source)
	local quantidade = args2
	for k, v in pairs(mercadorias) do
		if k == args1 then
			produtoLegal = k
			valorLegal = v
			break
		end
	end
	if produtoLegal == nil then
		TriggerClientEvent("Notify",source,"negado","Produto não identificado")
	else
		local rows = vRP.query("empresa/selectEmpresa",{ cnpj = cnpj })
		for k, v in pairs(rows) do
			caixaEmpresa = v.caixa
			listEncomendas = json.decode(v.encomendas)
			break
		end
		local valorTotal = parseInt(quantidade) * parseInt(valorLegal)
		if parseInt(caixaEmpresa) >= parseInt(valorTotal) then

			local attCaixa = parseInt(caixaEmpresa) - parseInt(valorTotal)
			vRP.query("empresa/updateCaixa",{ caixa = parseInt(attCaixa), cnpj = cnpj })
			os.execute("$(which bash) /amgcity/server-data/shellscript/bennysBanco.sh "..user_id.." 'Order' "..parseInt(valorTotal).." "..parseInt(caixaEmpresa).." "..parseInt(attCaixa).."")
			os.execute("$(which bash) /amgcity/server-data/shellscript/bennysEncomendas.sh "..user_id.." "..produtoLegal.." "..quantidade.." "..valorTotal.."")

			if cnpj == 1 then
				if produtoLegal == "repairkit" then
					attEncomendas = '{"repairkit":{"amount":'..(parseInt(listEncomendas.repairkit.amount + quantidade))..'},"pneu":{"amount":'..listEncomendas.pneu.amount..'},"militec":{"amount":'..listEncomendas.militec.amount..'}}'
				elseif produtoLegal == "pneu" then
					attEncomendas = '{"pneu":{"amount":'..(parseInt(listEncomendas.pneu.amount + quantidade))..'},"repairkit":{"amount":'..listEncomendas.repairkit.amount..'},"militec":{"amount":'..listEncomendas.militec.amount..'}}'
				elseif produtoLegal == "militec" then
					attEncomendas = '{"militec":{"amount":'..(parseInt(listEncomendas.militec.amount + quantidade))..'},"repairkit":{"amount":'..listEncomendas.repairkit.amount..'},"pneu":{"amount":'..listEncomendas.pneu.amount..'}}'
				end

			elseif cnpj == 2 then
				--attEncomendas = '{"repairkit":{"amount":'..(parseInt(listEncomendas.repairkit.amount + quantidade))..'},"pneu":{"amount":'..listEncomendas.pneu.amount..'}}'
			end

			vRP.query("empresa/updateEncomendas",{ attEncomendas = attEncomendas, cnpj = cnpj })
			TriggerClientEvent("Notify",source,"sucesso","Pedido efetuado. Você pagou $"..string.format("%.2f", parseInt(valorTotal)).." por "..quantidade.."x "..produtoLegal.."")
			Citizen.Wait(10000)
			TriggerClientEvent("Notify",-1,"importante","Atenção caminhoneiros, Mecânica precisando de reposição")
		else
			TriggerClientEvent("Notify",source,"negado","A empresa não possui saldo")
		end
	end
end

function encomendasAMG.encomendasIlegais(source, args1, args2)
	local source = source
	local user_id = vRP.getUserId(source)
	local quantidadeIlegal = args2
	for k, v in pairs(mercadorias) do
		if k == args1 then
			produtoIlegal = k
			valorIlegal = v
			break
		end
	end
	if produtoIlegal == nil then
		TriggerClientEvent("Notify",source,"negado","Produto não identificado")
	else
		pedidoIlegal[source] = true
		local tempoIlegal = 1000 * math.random(3,5)
		local locPos = math.random(minloc, maxloc)
		TriggerClientEvent("Notify",source,"sucesso","Pedido efetuada. Aguarde o contato e localização do contrabandista.")
		encomendasAMGCLIENT.criarObjEncomenda(-1, grupo[source], locPos)
		SetTimeout(parseInt(quantidadeIlegal*1000),function()
			encomendasAMGCLIENT.solicitarEncomenda(source, tempoIlegal, produtoIlegal, valorIlegal, quantidadeIlegal, amGcfg.contrabandistas[locPos].point.posIlegal)
		end)
	end
end

function encomendasAMG.pegarEncomendaIlegais(produto, valor, quantidade)
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Itens armamento",2)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(produto)*quantidade <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryPayment(user_id,parseInt(valor*quantidade)) then
				TriggerClientEvent("progress",source,quantidade*1000)
				TriggerClientEvent("cancelando",source,true)
				vCLIENT.freezPed(source, quantidade*1000)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				SetTimeout(quantidade*1000,function()
					TriggerClientEvent("cancelando",source,false)
					vRP.giveInventoryItem(user_id,produto,quantidade)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("Notify",source,"sucesso","Você pegou "..quantidade.."x "..produto.." e pagou $"..string.format("%.2f", valor*quantidade).."")
					pedidoIlegal[source] = false
					encomendasAMGCLIENT.resetVariaveis(source, quantidade*1100)
					encomendasAMGCLIENT.deleteSyncProps(-1, grupo[source], quantidade*1000)
				end)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem espaço na mochila")
		end
	end
end