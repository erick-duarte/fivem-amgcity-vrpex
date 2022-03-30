--====================================================================================
--------------  PROJETINHO FIVEM https://discord.gg/4mRG2Bp ----------------------
--====================================================================================

RegisterNetEvent("gcPhone:yellow_getPagess")
AddEventHandler("gcPhone:yellow_getPagess", function(pagess)
  SendNUIMessage({event = 'yellow_pagess', pagess = pagess})
end)

RegisterNetEvent("gcPhone:yellow_newPagess")
AddEventHandler("gcPhone:yellow_newPagess", function(pages)
  SendNUIMessage({event = 'yellow_newPages', pages = pages})
end)

RegisterNetEvent("gcPhone:yellow_getUserTweets")
AddEventHandler("gcPhone:yellow_getUserTweets", function(pagess)
  SendNUIMessage({event = 'yellow_UserTweets', pagess = pagess})
end)

RegisterNetEvent("gcPhone:bank_gkst")
AddEventHandler("gcPhone:bank_gkst", function(bankgks)
  SendNUIMessage({event = 'bankk_gks', bankgks = bankgks})
end)

RegisterNetEvent("gcPhone:yellow_showError")
AddEventHandler("gcPhone:yellow_showError", function(title, message)
  SendNUIMessage({event = 'yellow_showError', message = message, title = title})
end)

RegisterNetEvent("gcPhone:yellow_showSuccess")
AddEventHandler("gcPhone:yellow_showSuccess", function(title, message)
  SendNUIMessage({event = 'yellow_showSuccess', message = message, title = title})
end)

RegisterNUICallback('yellow_getPagess', function(data, cb)
  TriggerServerEvent('gcPhone:yellow_getPagess', data.name, data.phone)
end)

RegisterNUICallback('yellow_postPages', function(data, cb)
  TriggerServerEvent('gcPhone:yellow_postPagess', data.name or '', data.phone or '', data.message, data.image)
end)


RegisterNUICallback('yellow_getUserTweets', function(data, cb)
  TriggerServerEvent('gcPhone:yellow_getUserTweets', data.phone)
end)

RegisterNUICallback('bank_gkst', function(data, cb)
  TriggerServerEvent('gcPhone:bank_gkst', data.identifier)
end)

RegisterNUICallback('yellow_userssDeleteTweet', function(data, cb) 
  TriggerServerEvent('gcPhone:yellow_usersDeleteTweet', data.yellowId or '', data.phone)
end)



