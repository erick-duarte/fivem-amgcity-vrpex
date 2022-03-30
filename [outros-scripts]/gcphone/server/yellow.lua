local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
--------------  PROJETINHO FIVEM https://discord.gg/4mRG2Bp ----------------------
function YellowGetPagess (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
      ORDER BY time DESC LIMIT 130
      ]===], {}, cb)
  end
end

function YellowUsersPagess (phone, cb)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM yellow_tweets
	  WHERE phone = @phone
      ORDER BY time DESC LIMIT 130
      ]===], {['@phone'] = phone}, phone)
end

function BankUserTransfer (identifier, cb)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM bank_transfer
      ]===], {}, cb)
end

function getUserYellow(phone, name, user)
  MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = @phone AND name = @name",{ 
    ['@phone'] = phone_number,
    ['@name'] = firstname 
  }, function (data)
    user = data[1]
  end)
end
RegisterServerEvent('gcPhone:yellow_getUserTweets')
AddEventHandler('gcPhone:yellow_getUserTweets', function(phone)
  getUserYellow(phone, name, user)
  local sourcePlayer = tonumber(source)
  local user_id = vRP.getUserId(source)
  local name = vRP.getUserIdentity(user_id)
    YellowUsersPagess(phone_number, function (pagess)
      TriggerClientEvent('gcPhone:yellow_getUserTweets', sourcePlayer, pagess)
    end)
end)

RegisterServerEvent('gcPhone:bank_gkst')
AddEventHandler('gcPhone:bank_gkst', function(identifier)
  local sourcePlayer = tonumber(source)
    BankUserTransfer(nil, function (bankgks)
      TriggerClientEvent('gcPhone:bank_gkst', sourcePlayer, bankgks)
    end)
end)


function YellowPostPages (phone_number, firstname, message, image, sourcePlayer, cb)
    getUserYellow(phone, name, user)
    MySQL.Async.insert("INSERT INTO yellow_tweets (`phone_number`, `firstname`, `message`, `image`) VALUES(@phone_number, @firstname, @message, @image);", {
	  ['@phone_number'] = phone_number,
	  ['@firstname'] = firstname,
    ['@message'] = message,
	  ['@image'] = image
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from yellow_tweets WHERE id = @id', {
        ['@id'] = id
      }, function (pagess)
        pages = pagess[1]
        pages['firstname'] = firstname
        pages['phone_number'] = phone_number
        TriggerClientEvent('gcPhone:yellow_newPagess', -1, pages)
        TriggerEvent('gcPhone:yellow_newPagess', pages)
      end)
    end)
  
end

function YellowUsersDelete (yellowId, phone, sourcePlayer)
    MySQL.Async.execute('DELETE FROM yellow_tweets WHERE id = @id AND phone = @phone', {
      ['@id'] = yellowId,
	  ['@phone'] = phone
    }, function ()
	end)
end

RegisterServerEvent('gcPhone:yellow_usersDeleteTweet')
AddEventHandler('gcPhone:yellow_usersDeleteTweet', function(yellowId, phone)
  local sourcePlayer = tonumber(source)
  local name = getIdentity(source)
  YellowUsersDelete(yellowId, name.phone, sourcePlayer)
end)


function YellowShowError (sourcePlayer, title, message, image)
  TriggerClientEvent('gcPhone:yellow_showError', sourcePlayer, message, image)
end
function YellowShowSuccess (sourcePlayer, title, message, image)
  TriggerClientEvent('gcPhone:yellow_showSuccess', sourcePlayer, title, message, image)
end

RegisterServerEvent('gcPhone:yellow_getPagess')
AddEventHandler('gcPhone:yellow_getPagess', function(phone, name)
  local sourcePlayer = tonumber(source)
    YellowGetPagess(nil, function (pagess)
      TriggerClientEvent('gcPhone:yellow_getPagess', sourcePlayer, pagess)
    end)
end)

function getIdentity(source)
  local user_id = vRP.getUserId(source)
  local identifier = vRP.getUserIdentity(user_id)
	local result = MySQL.Sync.fetchAll("SELECT vrp_user_identities FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier",{ ['@identifier'] = identifier })
	if result[1] ~= nil then
		local identity = result[1]
    print(identity)
		return {
			identifier = identity['identifier'],
			name = identity['name'],
			phone = identity['phone'],
		}
	else
		return nil
	end
end

RegisterServerEvent('gcPhone:yellow_postPagess')
AddEventHandler('gcPhone:yellow_postPagess', function(name, phone, message, image)
  local sourcePlayer = tonumber(source)
  local user_id = vRP.getUserId(source)
  local name = vRP.getUserIdentity(user_id)
  YellowPostPages(name.phone, name.name,  message, image, sourcePlayer)
end)