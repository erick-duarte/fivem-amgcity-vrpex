local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local amGcfg = module("amg_fabriarmas", "config")
local fabricacaoArma = nil

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

src = {}
Tunnel.bindInterface("amg_fabriarmas", src)
vCLIENT = Tunnel.getInterface("amg_fabriarmas")

function src.fabricarArmas(arma)
	local src = source
	local user_id = vRP.getUserId(src)
	if user_id then
		local tempQtd = vRP.prompt(src, "Deseja fabricar quantas unidades?","")
		local qtdUnidades = parseInt(tempQtd)
        if parseInt(qtdUnidades) < 1 then
            qtdUnidades = 1
        end
		for k, v in pairs(amGcfg.armas) do
			if arma == k then
				fabricacaoArma = arma
				nomeCorpo = v.corpo.nome
				qtdCorpo = v.corpo.qtd * qtdUnidades
				qtdPlaca = v.placametal * qtdUnidades
				qtdGatilho = v.gatilho * qtdUnidades
				qtdMolas = v.molas * qtdUnidades
				nomeItem = v.item
				break
			end
		end
		if fabricacaoArma ~= nil then
			if qtdCorpo > 0 then
				if vRP.getInventoryItemAmount(user_id,nomeCorpo) < qtdCorpo then
					TriggerClientEvent("Notify",src,"negado","Você precisa de pelo menos "..qtdCorpo.."x de <b>"..vRP.itemNameList(nomeCorpo).."</b>.")
					vCLIENT.limparVariaveis(src)
					return false
				end
			end

			if qtdPlaca > 0 then
				if vRP.getInventoryItemAmount(user_id,"placametal") < qtdPlaca then
					TriggerClientEvent("Notify",src,"negado","Você precisa de pelo menos "..qtdPlaca.."x de <b>"..vRP.itemNameList("placametal").."</b>.")
					vCLIENT.limparVariaveis(src)
					return false
				end
			end

			if qtdGatilho > 0 then
				if vRP.getInventoryItemAmount(user_id,"gatilho") < qtdGatilho then
					TriggerClientEvent("Notify",src,"negado","Você precisa de pelo menos "..qtdGatilho.."x de <b>"..vRP.itemNameList("gatilho").."</b>.")
					vCLIENT.limparVariaveis(src)
					return false
				end
			end

			if qtdMolas > 0 then
				if vRP.getInventoryItemAmount(user_id,"molas") < qtdMolas then
					TriggerClientEvent("Notify",src,"negado","Você precisa de pelo menos "..qtdMolas.."x de <b>"..vRP.itemNameList("molas").."</b>.")
					vCLIENT.limparVariaveis(src)
					return false
				end
			end

			if vRP.tryGetInventoryItem(user_id,nomeCorpo,qtdCorpo) and vRP.tryGetInventoryItem(user_id,"placametal",qtdPlaca) and vRP.tryGetInventoryItem(user_id,"gatilho",qtdGatilho) and vRP.tryGetInventoryItem(user_id,"molas",qtdMolas) then
				TriggerClientEvent("progress",src,1000*qtdUnidades,"fazendo")
				vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
				inProgress[src] = true
				TriggerClientEvent("F6Cancel",src,true)
				SetTimeout(1000*qtdUnidades,function()
					vRPclient._stopAnim(src,false)
					vRP.giveInventoryItem(user_id,nomeItem,qtdUnidades)
					TriggerClientEvent("Notify",src,"sucesso","Você fabricou "..qtdUnidades.."x <b>"..vRP.itemNameList(nomeItem).."</b>.")
					inProgress[src] = false
					TriggerClientEvent("F6Cancel",src,false)
					os.execute("$(which bash) /amgcity/server-data/shellscript/armasFabricacao.sh "..user_id.." "..string.sub(nomeItem, 7).." "..qtdUnidades.."")
					vCLIENT.limparVariaveis(src)
				end)
			end
		else
			TriggerClientEvent("Notify",src,"negado","Arma não localizada")
			vCLIENT.limparVariaveis(src)
			return false
		end
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") and not vRP.hasPermission(user_id,"bennys.permission") then	
		return true
	end
end