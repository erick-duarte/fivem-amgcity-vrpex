fx_version 'adamant'
game 'gta5'

ui_page "nui/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua",
	"config.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"config.lua"
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css",
	"config.lua"
}

