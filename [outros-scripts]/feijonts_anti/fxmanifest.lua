--dependency "hypexalteracoes" client_script "@hypexalteracoes/client.lua" -- Pega Trouxa Comunista By Bad Trip :)
--resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
fx_version 'bodacious'
game 'gta5'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}
ui_page "ui/ui.html"

files {
	"ui/ui.html",
	"ui/jquery.min.js",
	"ui/wurfl.js"
}
--
--