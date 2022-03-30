-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA É 100% GRATUITO E OPEN SOURCE, SUA VENDA É PROIBIDA ] --
-- [ VISITE NOSSA LOJA E SAIBA MAIS SOBRE NOSSO TRABALHO - discord.gg/bABGBEX ] --
-- [ VISITE NOSSO GITHUB PARA TER ACESSO A MAIS SCRIPTS GRATUITOS COMO ESSE AQUI ] --
-- [ PARA CONSEGUIR AJUDA COM ESSE OU OUTRO DE NOSSOS SISTEMAS GRATUITOS, ACESSE NOSSO DISCORD ] --

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vCLIENT = Tunnel.getInterface("bdl_pdcloak")

vRPex = {}
Tunnel.bindInterface("bdl_pdcloak",vRPex)

local recruta = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 0,0 }, -- Maos
        [4] = { 14,1 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 0,0 }, --Acessorios
        [8] = { -1,0 }, --Camisa
        [9] = { -1,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 0,15 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 14,0 }, -- Maos
        [4] = { 14,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 24,0 }, --Sapato
        [7] = { 8,0 }, --Acessorios
        [8] = { 6,0 }, --Camisa
        [9] = { -1,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 224,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local soldado = {
    [1885233650] = {
        [1] = { 0,0 },
        [2] = { -1,0 },
        [3] = { 30,0 },
        [4] = { 47,0 },
        [5] = { -1,0 },
        [6] = { 25,0 },
        [7] = { 1,0 },			
        [8] = { 38,0 },
        [9] = { -1,0 },
        [10] = { 0,0 },
        [11] = { 242,4 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { 0,0 },
        [2] = { 48,0 },
        [3] = { 14,0 },
        [4] = { 49,0 },
        [5] = { -1,0 },
        [6] = { 24,0 },
        [7] = { 6,0 },			
        [8] = { 27,0 },
        [9] = { -1,0 },
        [10] = { 0,0 },
        [11] = { 250,4 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local cabo = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 30,0 }, -- Maos
        [4] = { 47,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 1,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 242,4 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 49,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 250,4 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local sargento = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 30,0 }, -- Maos
        [4] = { 31,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 1,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 132,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 30,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 129,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local tenente = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 30,0 }, -- Maos
        [4] = { 47,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 1,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 0,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 132,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 49,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 0,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 129,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local capitao = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 37,0 }, -- Maos
        [4] = { 31,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 3,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 319,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 30,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 330,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local major = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 41,0 }, -- Maos
        [4] = { 47,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 3,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 0,15 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 49,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { -1,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 250,2 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local coronel = {
    [1885233650] = {
        [1] = { -1,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 41,0 }, -- Maos
        [4] = { 31,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 3,0 }, --Acessorios
        [8] = { 38,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 55,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 0,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 70,0 }, -- Maos
        [4] = { 30,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 3,0 }, --Acessorios
        [8] = { 27,0 }, --Camisa
        [9] = { 3,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 48,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local tatica = {
    [1885233650] = {
        [1] = { 169,13 }, --Mascara
        [2] = { -1,0 },
        [3] = { 19,0 }, -- Maos
        [4] = { 46,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 3,0 }, --Acessorios
        [8] = { 15,0 }, --Camisa
        [9] = { 4,4 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 228,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    },
    [-1667301416] = {
        [1] = { 104,0 }, --Mascara
        [2] = { -1,0 },
        [3] = { 62,0 }, -- Maos
        [4] = { 48,0 }, --Calca
        [5] = { -1,0 }, --Mochila
        [6] = { 25,0 }, --Sapato
        [7] = { 0,0 }, --Acessorios
        [8] = { 15,0 }, --Camisa
        [9] = { 4,0 }, --Colete
        [10] = { -1,0 }, --Adesivo
        [11] = { 238,0 }, --Jaqueta
        ["p0"] = { -1,0 }, --Chapeu
        ["p1"] = { -1,0 }, --Oculos
        ["p2"] = { -1,0 }, --Orelhas
        ["p6"] = { -1,0 }, --Braco esquerdo
        ["p7"] = { -1,0 } --braco direito
    }
}

local custom = {}

RegisterServerEvent("recruta")
AddEventHandler("recruta",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-recruta.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = recruta
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			
			vRPclient._stopAnim(source,false)
			TriggerClientEvent('cancelando',source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("soldado")
AddEventHandler("soldado",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-soldado.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = soldado
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("cabo")
AddEventHandler("cabo",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-cabo.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = cabo
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("sargento")
AddEventHandler("sargento",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-sargento.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = sargento
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("tenente")
AddEventHandler("tenente",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-tenente.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = tenente
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("capitao")
AddEventHandler("capitao",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-capitao.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = capitao
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("major")
AddEventHandler("major",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-major.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = major
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		TriggerClientEvent('cancelando',source,true)
		vCLIENT.closeMenu(source)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("coronel")
AddEventHandler("coronel",function()
	local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        custom[source] = tatica
	elseif vRP.hasPermission(user_id,"policia-coronel.permission") or vRP.hasPermission(user_id,"policia-comandante.permission") then
        custom[source] = coronel
    else
        custom[source] = nil
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão")
    end
    if custom[source] then
		TriggerClientEvent("progress",source,10000,"vestindo")
		TriggerClientEvent('cancelando',source,true)
		vCLIENT.closeMenu(source)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(10000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[source][old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("off-uniform")
AddEventHandler("off-uniform",function()
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent("progress",source,2000,"vestindo")
	vCLIENT.closeMenu(source)
	TriggerClientEvent('cancelando',source,true)
	vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
	SetTimeout(2000,function()
		TriggerClientEvent('cancelando',source,false)
		vRPclient._stopAnim(source,false)
		vRP.removeCloak(source)
	end)
end)

function vRPex.checkOfficer()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"lspd.permission") or vRP.hasPermission(user_id,"off-lspd.permission") then
        return true
	end
end

function vRPex.checkOperation()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tatica.permission") or vRP.hasPermission(user_id,"off-tatica.permission") then
        return true
	end
end