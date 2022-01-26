local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("bdl_chest",src)
vCLIENT = Tunnel.getInterface("bdl_chest")

--[ VARIAVEIS ]---------------------------------------------------------------------------------------------------------------------------------------------------------

local lspdlog = "https://discord.com/api/webhooks/845402825403531294/w6Zwe_iQC8ZT1NdRz1j2ujkiUvg9LPFwey0xHJ4QnrlS4gz-uZpauWRnaj8anDELMi_U"
local emslog = "https://discord.com/api/webhooks/845402992794140692/BIhjGMs2LwCRrcqgpiT2gWhmzTLpBhWZyXRmSXEwlVXtUwJn9rkbYLKKEv0DZVHnfmvU"
local bennyslog = "https://discord.com/api/webhooks/845403059374260244/aOhvVhGJEf4iOXQFw5dEg3gYhL6gFphMMGTOx1AiS891XhOabzCi_Dr5mvAB2B_rzWEJ"
local verdeslog = "https://discord.com/api/webhooks/849466763137384499/tXPsEG8XrZsdhuhiWOyx8nGX5gIOnCzXdjU_T79fC9Iy4TWrwTNwit1x9H_6EnG657Wz"
local chfverdeslog = "https://discord.com/api/webhooks/849466763137384499/tXPsEG8XrZsdhuhiWOyx8nGX5gIOnCzXdjU_T79fC9Iy4TWrwTNwit1x9H_6EnG657Wz"
local vermelhoslog = "https://discord.com/api/webhooks/849466698222665738/o3TttFYalvaYDSnk_q38o2CMWn2PTkrR6qL9XbDI2JUp7gvBu3IMuhGtHCwcYVwei4FM"
local chfvermelhoslog = "https://discord.com/api/webhooks/849466698222665738/o3TttFYalvaYDSnk_q38o2CMWn2PTkrR6qL9XbDI2JUp7gvBu3IMuhGtHCwcYVwei4FM"
local brancoslog = "https://discord.com/api/webhooks/849466569646276618/-Arr9JFsYtD2j5qVMBxXP5KZJRKNH9lTZAuiCYiOkJU5FiDEXcEaUfkOG2Z2CvwFJZWL"
local chfbrancoslog = "https://discord.com/api/webhooks/849466569646276618/-Arr9JFsYtD2j5qVMBxXP5KZJRKNH9lTZAuiCYiOkJU5FiDEXcEaUfkOG2Z2CvwFJZWL"
local bratvalog = "https://discord.com/api/webhooks/849466841310298192/9BvfHSQaTn3Ta4JDzFyWbGu5LXSURTXNvJ5GB2gJSnNPBtMoj-SComlL-d2k8dCdnq8K"
local lbratvalog = "https://discord.com/api/webhooks/849466841310298192/9BvfHSQaTn3Ta4JDzFyWbGu5LXSURTXNvJ5GB2gJSnNPBtMoj-SComlL-d2k8dCdnq8K"
local lostlog = "https://discord.com/api/webhooks/849466969132367882/hPP-6aczrGbOYOg3t8Rqls8FndiKuL1vhXojMEIgeDu6reDYdHS6lXBh7dVvl9q84txK"
local llostlog = "https://discord.com/api/webhooks/849466969132367882/hPP-6aczrGbOYOg3t8Rqls8FndiKuL1vhXojMEIgeDu6reDYdHS6lXBh7dVvl9q84txK"
local yakuzalog = "https://discord.com/api/webhooks/849466901155020851/fKW4j8WPlmTS6tJY1aS3k3BTH6GGybvXvAHnrfX54EhrX-OkIRZj79CalGaETI7voC58"
local lyakuzalog = "https://discord.com/api/webhooks/849466901155020851/fKW4j8WPlmTS6tJY1aS3k3BTH6GGybvXvAHnrfX54EhrX-OkIRZj79CalGaETI7voC58"

--[ CHEST ]-------------------------------------------------------------------------------------------------------------------------------------------------------------

local chest = {
	["lspd"] = { 5000,"lspd.permission" },
	["ems"] = { 5000,"ems.permission" },
	["bennys"] = { 5000,"bennys.permission" },
	
	["verdes"] = { 5000,"verdes.permission" },
	["chf-verdes"] = { 5000,"chf-verdes.permission" },

	["vermelhos"] = { 5000,"vermelhos.permission" },
	["chf-vermelhos"] = { 5000,"chf-vermelhos.permission" },

	["brancos"] = { 5000,"brancos.permission" },
	["chf-brancos"] = { 5000,"chf-brancos.permission" },
	
	["bratva"] = { 5000,"bratva.permission" },
	["l-bratva"] = { 5000,"l-bratva.permission" },

	["lost"] = { 5000,"lost.permission" },
	["l-lost"] = { 5000,"l-lost.permission" },

	["yakuza"] = { 5000,"ykz.permission" },
	["l-yakuza"] = { 5000,"l-ykz.permission" },
}

--[ VARIÁVEIS ]---------------------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}

--[ ACTIVEDOWNTIME ]----------------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[ CHECKINTPERMISSIONS ]-----------------------------------------------------------------------------------------------------------------------------------------------

function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			--if vRP.hasPermission(user_id,"founder.permission") then
			--	return true
			--end

			if vRP.hasPermission(user_id,chest[chestName][2]) then
				return true
			end
		end
	end
	return false
end

--[ OPENCHEST ]---------------------------------------------------------------------------------------------------------------------------------------------------------

function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				if vRP.itemBodyList(k) then
					table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				if vRP.itemBodyList(k) then
					table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end

--[ STOREITEM ]---------------------------------------------------------------------------------------------------------------------------------------------------------

function src.storeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.storeChestItem(user_id,"chest:"..tostring(chestName),itemName,amount,chest[tostring(chestName)][1]) then
				local identity = vRP.getUserIdentity(user_id)
				if identity then

					if chestName == "lspd" then
						PerformHttpRequest(lspdlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "ems" then
						PerformHttpRequest(emslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE BAÚ - EMS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"),icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "bennys" then
						PerformHttpRequest(bennyslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BENNY'S:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })	
					

					elseif chestName == "verdes" then
						PerformHttpRequest(verdeslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VERDES:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-verdes" then
						PerformHttpRequest(chfverdeslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE VERDES:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "vermelhos" then
						PerformHttpRequest(vermelhoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VERMELHOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-vermelhos" then
						PerformHttpRequest(chfvermelhoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE VERMELHOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "brancos" then
						PerformHttpRequest(brancoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRANCOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-brancos" then
						PerformHttpRequest(chfbrancoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE BRANCOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "bratva" then
						PerformHttpRequest(bratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-bratva" then
						PerformHttpRequest(lbratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					elseif chestName == "lost" then
						PerformHttpRequest(lostlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LOST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-lost" then
						PerformHttpRequest(llostlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER LOST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					elseif chestName == "yakuza" then
						PerformHttpRequest(yakuzalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - YAKUZA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-yakuza" then
						PerformHttpRequest(lyakuzalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER YAKUZA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					end



				end
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
			else
				TriggerClientEvent("Notify",source,"negado","Quantidade inválida e/ou baú cheio.",10000)
            end
        end
    end
end

--[ TAKEITEM ]----------------------------------------------------------------------------------------------------------------------------------------------------------

function src.takeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.tryChestItem(user_id,"chest:"..tostring(chestName),itemName,amount) then
				local identity = vRP.getUserIdentity(user_id)
				if identity then

					if chestName == "lspd" then
						PerformHttpRequest(lspdlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "ems" then
						PerformHttpRequest(emslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE BAÚ - EMS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"),icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "bennys" then
						PerformHttpRequest(bennyslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BENNY'S:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })	
					

					elseif chestName == "verdes" then
						PerformHttpRequest(verdeslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VERDES:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-verdes" then
						PerformHttpRequest(chfverdeslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE VERDES:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "vermelhos" then
						PerformHttpRequest(vermelhoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VERMELHOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-vermelhos" then
						PerformHttpRequest(chfvermelhoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE VERMELHOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "brancos" then
						PerformHttpRequest(brancoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRANCOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "chf-brancos" then
						PerformHttpRequest(chfbrancoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - CHEFE BRANCOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					
					elseif chestName == "bratva" then
						PerformHttpRequest(bratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-bratva" then
						PerformHttpRequest(lbratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					elseif chestName == "lost" then
						PerformHttpRequest(lostlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LOST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-lost" then
						PerformHttpRequest(llostlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER LOST:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					elseif chestName == "yakuza" then
						PerformHttpRequest(yakuzalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - YAKUZA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "l-yakuza" then
						PerformHttpRequest(lyakuzalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LIDER YAKUZA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					
					end
				end
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
			else
				TriggerClientEvent("Notify",source,"negado","Quantidade inválida e/ou inventário cheio.",10000)
            end
        end
    end
end