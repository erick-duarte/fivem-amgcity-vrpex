local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "feijonts_anti")

src = {}
Tunnel.bindInterface("feijonts_anti",src)
Proxy.addInterface("feijonts_anti",src)

local webhook = "https://discord.com/api/webhooks/842550232125538326/KuzV3_OCP-3upD5Q_QMwV9zhBnTA-tfR0PvQFKmfPzwDTWyjDOz8_4a2u3HY1KSkbql9"

local loaded = {}
function src.pegaTrouxa()
    local source = source
    local user_id = vRP.getUserId(source)

    local fields2 = {}
    table.insert(fields2, { name = "ChomeInspector:", value = 'ID => **'..user_id..'** \nFoi pego tentando roubar o Html/Client da cidade.', inline = true });
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "In Game Log System", content = nil, embeds = {{color = 16754176, fields = fields2,}}}), { ['Content-Type'] = 'application/json' }) 
    print("Tentativa de Acesso ao Chrome Inspector! ID: "..user_id)
    vRP.kick(source,"FEIJONTS TE MANDOU UM BEIJO!")    
    vRP.setBanned(user_id,true)

end

