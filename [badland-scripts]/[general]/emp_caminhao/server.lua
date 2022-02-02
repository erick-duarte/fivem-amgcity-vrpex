local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_caminhao",emP)
addCaminhao = {}
Proxy.addInterface("emp_caminhao",addCaminhao)
AMGCoin = Proxy.getInterface("AMG_Coin")
local cnpj = nil

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
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
	vRP.antiflood(source,"Emprego Caminhao",2)
    if user_id then
		if AMGCoin.checkbeneficio(user_id,"boostemp") then
        	local valorpago = math.random(7500,8000)
			local valorpago = valorpago*2
        	vRP.giveMoney(user_id,valorpago)
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..valorpago.." dólares",3000)
		else
			local valorpago = math.random(7500,8000)
        	vRP.giveMoney(user_id,valorpago)
        	TriggerClientEvent("Notify",source,"sucesso","Você recebeu $"..valorpago.." dólares",3000)
		end
    end
end

function emP.verificaEncomendas(data)
    local source = source
    local user_id = vRP.getUserId(source)
	local kitreparoQtd = 0
	local pneuQtd = 0

	if data == "mecanica" then
		cnpj = 1
	elseif data == "hospital" then
		cnpj = 2
	end

	local rows = vRP.query("empresa/getEncomendas",{ cnpj = cnpj })
	local resultEncomendas = rows[1]
	local totalEncomendas = json.decode(resultEncomendas.encomendas)
	
	for k, v in pairs(totalEncomendas.encomendas) do
		if k == "kitreparo" then
			kitreparoQtd = v
		end
		if k == "pneu" then
			pneuQtd = v
		end
	end
	local codEncomenda = vRP.prompt(source,"Qual entrega deseja fazer? 1 - KitReparo: "..kitreparoQtd.." | 2 - Pneu: "..pneuQtd..""," ")
--	if parseInt(codEncomenda) >= 1 then
		

end

function addCaminhao.receberPedidos(qtd)
	local source = source
	local user_id = vRP.getUserId(source)
	print("caminhao",qtd)
end