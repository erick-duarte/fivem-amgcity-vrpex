local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

src = {}
Tunnel.bindInterface("amg_salarios",src)
srcSERVER = Tunnel.getInterface("amg_salarios")

-- [ THREAD DO SALÁRIO ] --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		srcSERVER.pagamentoSalario()
	end
end)
