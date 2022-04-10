local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("amg_plantar",emP)
plantarAMGCLIENT = Tunnel.getInterface("amg_plantar")
local syncPlantacao = {}
local atualizarPlantacao = {}

vRP._prepare("plantacao/createDataBase",[[
  CREATE TABLE IF NOT EXISTS amg_plantacao(
    id int(11) NOT NULL AUTO_INCREMENT,
    user_id int(11) NOT NULL,
    hashplant varchar(255) NOT NULL,
    position text NOT NULL,
    status varchar(255) NOT NULL,
    lastdata timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
  )
]])

vRP.prepare("plantacao/selectPlantacao","SELECT id, user_id, hashplant, position, status FROM amg_plantacao")
vRP.prepare("plantacao/insertPlantacao","INSERT INTO amg_plantacao (user_id, hashplant, position, status, item) VALUES(@user_id, '@hashplant', @position, @status, @item)")
vRP.prepare("plantacao/updatePlantacao","UPDATE amg_plantacao set hashplant = '@hashplant', position = @position, status = @status, item = @item where id = @dbid")
vRP.prepare("plantacao/deletePlantacao","DELETE FROM amg_plantacao where hashplant = @hashplant")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

async(function()
	vRP.execute("plantacao/createDataBase")
end)

function emP.iniciarPlantacao(itemName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"adubo") > 0 then
			if vRP.getInventoryItemAmount(user_id,"vaso") > 0 then
				vRP.tryGetInventoryItem(user_id,itemName,1)
				vRP.tryGetInventoryItem(user_id,"vaso",1)
				vRP.tryGetInventoryItem(user_id,"adubo",1)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não tem vaso")
				return false
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem adubo")
			return false
		end
	end
end

function emP.reSync(hashPlantacao)
	local source = source
	local user_id = vRP.getUserId(source)
	syncPlantacao[hashPlantacao] = nil
	plantarAMGCLIENT.syncPlantacao(-1,syncPlantacao)
end

function emP.reSyncDelete(hashPlantacao)
	local source = source
	local user_id = vRP.getUserId(source)
	plantarAMGCLIENT.deleteSyncPlantacao(-1,hashPlantacao)
end

function emP.syncProgress(syncPlantacao)
	local source = source
	local user_id = vRP.getUserId(source)
	plantarAMGCLIENT.syncPlantacao(-1,syncPlantacao)
end

function emP.syncPlantacao(hashPlantacao, coordPlantacao, fasePlantacao, resultID, statusProgress, itemName)
	local source = source
	local user_id = vRP.getUserId(source)
	local resultID = resultID
	if user_id then
		if fasePlantacao == 1 then
			local result = vRP.query("plantacao/insertPlantacao", { 
				user_id = user_id, 
				hashplant = hashPlantacao,
				position = coordPlantacao.x..","..coordPlantacao.y..""..coordPlantacao.z,
				status = fasePlantacao,
				item = itemName
			})
			resultID = result[1].insertId
			
		elseif fasePlantacao == 2 then
			local result = vRP.query("plantacao/updatePlantacao", { 
				dbid = resultID, 
				hashplant = hashPlantacao,
				position = coordPlantacao.x..","..coordPlantacao.y..""..coordPlantacao.z,
				status = fasePlantacao,
				item = itemName
			})
		elseif fasePlantacao == 3 then
			local result = vRP.query("plantacao/updatePlantacao", { 
				dbid = resultID, 
				hashplant = hashPlantacao,
				position = coordPlantacao.x..","..coordPlantacao.y..""..coordPlantacao.z,
				status = fasePlantacao,
				item = itemName
			})
		end
		syncPlantacao[hashPlantacao] = { coordPlantacao = coordPlantacao, fasePlantacao = fasePlantacao, resultID = resultID, statusProgress = statusProgress, itemName = itemName }
		plantarAMGCLIENT.syncPlantacao(-1,syncPlantacao)
	end
end

function emP.colherPlantacao(hashPlantacao, coordPlantacao, fasePlantacao, resultID, itemName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local pesoItem = vRP.getItemWeight('maconha') -- foi definido maconha apenas para pegar o peso, todas as outras sao o meso peso
		local mochilaPlayer = vRP.getInventoryWeight(user_id)
		local totalMochilaPlayer = vRP.getInventoryMaxWeight(user_id)
		local pesoTotal = pesoItem + mochilaPlayer
		if pesoTotal < totalMochilaPlayer then
			
			if itemName == "maconhasemente" then
				vRP.giveInventoryItem(user_id,'maconha',1)
			elseif itemName == "papoulasemente" then
				vRP.giveInventoryItem(user_id,'lockpick',1)
			elseif itemName == "cocainasemente" then
				vRP.giveInventoryItem(user_id,'folha-coca',1)
			end

			local result = vRP.query("plantacao/updatePlantacao",
				{ 
					dbid = resultID, 
					hashplant = hashPlantacao,
					position = coordPlantacao.x..","..coordPlantacao.y..""..coordPlantacao.z,
					status = fasePlantacao,
					item = itemName
				})
			plantarAMGCLIENT.deleteSyncPlantacao(-1,hashPlantacao)
			syncPlantacao[hashPlantacao] = nil
			plantarAMGCLIENT.syncPlantacao(-1,syncPlantacao)
			TriggerClientEvent("Notify",source,"sucesso","Você pegou 1 XXXXX")
		else
			TriggerClientEvent("Notify",source,"negado","Voce nao possui espaco suficiente na mochila!")
		end
	end
end