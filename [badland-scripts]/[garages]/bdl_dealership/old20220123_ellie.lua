-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
AMGCoin = Proxy.getInterface("AMG_Coin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("bdl_dealership",src)
vCLIENT = Tunnel.getInterface("bdl_dealership")
local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local motos = {}
local carros = {}
local import = {}
local offroad = {}
local vans = {}
local vips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do
		if v.tipo == "carros" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(carros,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "motos" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(motos,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "import" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(import,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "offroad" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(offroad,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "vans" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(vans,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
		if v.tipo == "vips" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				table.insert(vips,{ k = k, nome = v.name, price = v.price, chest = v.mala, stock = parseInt(vehicle[1].quantidade) })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateVehicles(vname,vehtype)
	if vehtype == "carros" then
		for k,v in pairs(carros) do
			if v.k == vname then
				table.remove(carros,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(carros,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "motos" then
		for k,v in pairs(motos) do
			if v.k == vname then
				table.remove(motos,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(motos,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice(vname)), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "import" then
		for k,v in pairs(import) do
			if v.k == vname then
				table.remove(import,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(import,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "offroad" then
		for k,v in pairs(offroad) do
			if v.k == vname then
				table.remove(offroad,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(offroad,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "vans" then
		for k,v in pairs(offroad) do
			if v.k == vname then
				table.remove(vans,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(vans,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	elseif vehtype == "vips" then
		for k,v in pairs(vips) do
			if v.k == vname then
				table.remove(vips,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					table.insert(vips,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice(vname), chest = (vRP.vehicleChest(vname)), stock = parseInt(vehicle[1].quantidade) })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Carros()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carros
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Motos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Import()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return import
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OFFROAD
-----------------------------------------------------------------------------------------------------------------------------------------
function src.OffRoad()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return offroad
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VANS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Vans()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vans
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Vips()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vips
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Possuidos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local veiculos = {}
		local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicle) do
			table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = vRP.vehicleChest(v.vehicle) })
		end
		return veiculos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function src.buyDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = parseInt(user_id) })
		local maxgars = vRP.query("creative/get_users",{ user_id = parseInt(user_id) })
		if vRP.hasPermission(user_id,"founder.permission") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 100 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"bronze.pass") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 2 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"prata.pass") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 4 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"ouro.pass") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 6 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"platina.pass") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 8 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		elseif vRP.hasPermission(user_id,"amg.pass") then
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) + 10 then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		else
			if parseInt(maxvehs[1].qtd) >= parseInt(maxgars[1].garagem) then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end
		end

		if vRP.vehicleType(name) ~= "vips" then
			local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
				return
			else
				local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
				if parseInt(rows2[1].quantidade) <= 0 then
					TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponivel.",8000)
					return
				end
				local carteira = vRP.getMoney(user_id)
				local banco = vRP.getBankMoney(user_id)
				local desconto30 = parseInt(vRP.vehiclePrice(name)*0.3)
				local valorattveiculo = parseInt(vRP.vehiclePrice(name)-desconto30-1)
				if banco >= vRP.vehiclePrice(name) or carteira >= vRP.vehiclePrice(name) or banco >= valorattveiculo or carteira >= valorattveiculo then
					if AMGCoin.checkbeneficio(user_id,"desconc30") then
						local desconto30 = parseInt(vRP.vehiclePrice(name)*0.3)
						local valorattveiculo = parseInt(vRP.vehiclePrice(name)-desconto30)
						if vRP.tryFullPayment(user_id,valorattveiculo) then
							vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
							vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })
							TriggerClientEvent("Notify",source,"importante","Você usou seu cupom de desconto")
							TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b>$ "..vRP.format(parseInt(valorattveiculo)).." dólares</b>.",10000)
							src.updateVehicles(name,vRP.vehicleType(name))
							if vRP.vehicleType(name) == "carros" then
								TriggerClientEvent('dealership:Update',source,'updateCarros')
							elseif vRP.vehicleType(name) == "motos" then
								TriggerClientEvent('dealership:Update',source,'updateMotos')
							elseif vRP.vehicleType(name) == "import" then
								TriggerClientEvent('dealership:Update',source,'updateImport')
							elseif vRP.vehicleType(name) == "offroad" then
								TriggerClientEvent('dealership:Update',source,'updateOffRoad')
							elseif vRP.vehicleType(name) == "vans" then
								TriggerClientEvent('dealership:Update',source,'updateVans')
							end
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					else
						if vRP.tryFullPayment(user_id,vRP.vehiclePrice(name)) then
							vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
							vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })
							TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b>$ "..vRP.format(parseInt(vRP.vehiclePrice(name))).." dólares</b>.",10000)
							src.updateVehicles(name,vRP.vehicleType(name))
							if vRP.vehicleType(name) == "carros" then
								TriggerClientEvent('dealership:Update',source,'updateCarros')
							elseif vRP.vehicleType(name) == "motos" then
								TriggerClientEvent('dealership:Update',source,'updateMotos')
							elseif vRP.vehicleType(name) == "import" then
								TriggerClientEvent('dealership:Update',source,'updateImport')
							elseif vRP.vehicleType(name) == "offroad" then
								TriggerClientEvent('dealership:Update',source,'updateOffRoad')
							elseif vRP.vehicleType(name) == "vans" then
								TriggerClientEvent('dealership:Update',source,'updateVans')
							end
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Veículos <b>VIP</b> não podem ser comprados na Concessionária",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
function src.sellDealer(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
		local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
		if vehicle[1] then
			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(user_id), vehicle = name })
			vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
			local consulta = vRP.getUData(user_id,"vRP:paypal")
			local resultado = json.decode(consulta) or 0
			vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado + parseInt(vRP.vehiclePrice(name)*0.85))))
			--vRP.giveMoney(user_id,parseInt(vRP.vehiclePrice(name)*0.85))
			TriggerClientEvent("Notify",source,"sucesso","Você vendeu um <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.85)).." dólares</b>.",10000)
			src.updateVehicles(name,vRP.vehicleType(name))
			TriggerClientEvent('dealership:Update',source,'updatePossuidos')
		end
	end
end