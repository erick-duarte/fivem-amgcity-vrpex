local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("amg_lavagem",oC)

vRP._prepare("vRP/registro_lavagem","INSERT INTO amg_lavagem(player,dinheirosujo,porcentagem,tempo,horarioinicial,organizacao) VALUES(@user_id,@dinheirosujo,@porcentagem,@tempo,@horarioinicial,@organizacao)")
vRP._prepare("vRP/pegar_lavagem","SELECT * from amg_lavagem where player = @user_id and horariofinal = 0 and organizacao = @organizacao")
vRP._prepare("vRP/atualizar_lavagem","UPDATE amg_lavagem SET tempo = @tempominutos where id = @id")
vRP._prepare("vRP/atualizar_lagemconcluida","UPDATE amg_lavagem SET horariofinal = @horariofinal, tempo = @tempominutos, dinheirolimpo = @dinheirolimpo where id = @id")
vRP._prepare("vRP/pegarvida_lavagem","SELECT * from amg_lavagem where vida = 1")
vRP._prepare("vRP/resetvida_lavagem","UPDATE amg_lavagem SET vida = 0 where vida = 1")

local organizacao = nil
local qthvida = 0

function oC.checkPermissionYakuza()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"ykz.permission") --or vRP.hasPermission(user_id,"staff.permission")
end

RegisterServerEvent('AMG_Lavagem:calcularporcentagem')
AddEventHandler('AMG_Lavagem:calcularporcentagem', function(organizacao)
    local source = source
    local user_id = vRP.getUserId(source)
    if qthvida < 5 then
        local porcentagem = math.random(98,99)
        local resultporcentagem = 100 - porcentagem
        local calcporcentagem = porcentagem/100
        local ok = vRP.request(source,"Taxa de "..resultporcentagem.."%, aceita?",60)
        if ok then
            local quantia = vRP.prompt(source, "Valor que você quer lavar:", "")
            local quantia = parseInt(quantia)
            if quantia > 0 then
                if vRP.tryGetInventoryItem(user_id, "dinheiro-sujo", quantia, true) then
                    minutos = math.random(5,20)
                    tempomilisegundos = minutos*60*1000
                    TriggerClientEvent("Notify",source,"importante","Vamos lavar seu dinheiro. Volte daqui "..minutos.." minutos") 
                    local data = os.date("%d-%m-%Y %H:%M:%S")
                    vRP.execute("vRP/registro_lavagem",{ user_id = user_id, dinheirosujo = quantia, porcentagem = resultporcentagem, tempo = minutos, horarioinicial = data, organizacao = organizacao})
                    local vida = vRP.query("vRP/pegarvida_lavagem",{})
                    qthvida = #vida
                    TriggerClientEvent("AMG_Lavagem:aguardarlavegemYakuza", source)
                else
                    TriggerClientEvent("Notify", source, "negado", "Valor insuficiente.")
                end
            else
                TriggerClientEvent("Notify", source, "negado", "Digite um valor válido")
            end
        else
            TriggerClientEvent("AMG_Lavagem:taxanaoaceitaYakuza", source)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Maquina com defeito. Utilize a peça <b>Componente Eletronico</b> para concertar.")
        TriggerClientEvent("AMG_Lavagem:pegoudinheiroYakuza", source)
    end
end)

RegisterServerEvent('AMG_Lavagem:verificalavagem')
AddEventHandler('AMG_Lavagem:verificalavagem', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ykz.permission") then
        organizacao = "Yakuza"
        local registro = vRP.query("vRP/pegar_lavagem",{ user_id = user_id, organizacao = organizacao})
        if #registro > 0 then
            TriggerClientEvent("AMG_Lavagem:aguardarlavegemYakuza", source)
            lavadorMercenario = registro[1]
            idMercenario = lavadorMercenario.id
            quantiaMercenario = lavadorMercenario.dinheirosujo
            calcporcentagemMercenario = lavadorMercenario.porcentagem
            tempominutosMercenario =  math.floor(tonumber(lavadorMercenario.tempo - 1))
            if tempominutosMercenario ~= 0 then
                vRP.execute("vRP/atualizar_lavagem",{ id = idMercenario, tempominutos = tempominutosMercenario})
            elseif tempominutosMercenario == 0 or tempominutosMercenario < 0 then
                TriggerClientEvent("AMG_Lavagem:lavagemconcluidaYakuza", source, quantiaMercenario, calcporcentagemMercenario)
            end
        end
    else
        organizacao = "Vazio"
    end
end)

RegisterServerEvent('AMG_Lavagem:receberpagamento')
AddEventHandler('AMG_Lavagem:receberpagamento', function(quantia2, calcporcentagem2, organizacao)
    local source = source
    local user_id = vRP.getUserId(source)
    local desconto = (quantia2 * calcporcentagem2) / 100
    vRP.giveMoney(user_id, parseInt(quantia2 - desconto))
    data = os.date("%d-%m-%Y %H:%M:%S")
    if vRP.hasPermission(user_id,"ykz.permission") then
        vRP.execute("vRP/atualizar_lagemconcluida",{ id = idMercenario,  horariofinal = data, tempominutos = tempominutosMercenario, dinheirolimpo = quantia2 - desconto })
        TriggerClientEvent("Notify", source, "importante", "Lavou <b>$" .. vRP.format(quantia2) .. ",00 Sujo</b> e recebeu <b>$" .. vRP.format(parseInt(quantia2 - desconto)) .. ",00</b> Limpo.")
        TriggerEvent("AMG_Logs:lavagem",source, user_id, quantia2, calcporcentagem2, quantia2 - desconto )
        TriggerClientEvent("AMG_Lavagem:pegoudinheiroYakuza", source)
    end
end)

RegisterServerEvent('AMG_Lavagem:resetvidaSV')
AddEventHandler('AMG_Lavagem:resetvidaSV', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.tryGetInventoryItem(user_id,"componenteeletronico",1) then
        vRPclient._playAnim(source,false,{{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}},true)
	    SetTimeout(12000,function()
	    	vRPclient._stopAnim(source,false)
            vRP.execute("vRP/resetvida_lavagem",{})
            local vida = vRP.query("vRP/pegarvida_lavagem",{})
            qthvida = #vida
            TriggerClientEvent("Notify",source,"sucesso","Maquina consertada.") 
	    end)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(500)
    local vida = vRP.query("vRP/pegarvida_lavagem")
    qthvida = #vida
end)