-----------------------------------------------------------------------------------------------------------------------------------------
-- Notify
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("Notify")
--AddEventHandler("Notify",function(css,prefix,mensagem,delay)
AddEventHandler("Notify",function(css,mensagem,delay)
	if delay == nil then
		delay = 5000
	end
--	SendNUIMessage({ css = css, prefix = prefix, mensagem = mensagem, delay = delay })
	SendNUIMessage({ css = css, mensagem = mensagem, delay = delay })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode,mensagem,item)
	SendNUIMessage({ mode = mode, mensagem = mensagem, item = item })
end)

