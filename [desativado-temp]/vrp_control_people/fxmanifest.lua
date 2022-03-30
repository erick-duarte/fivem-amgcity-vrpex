fx_version 'adamant'
game 'gta5'

ui_page "nui/index.html"

files {
	"nui/img/logo.png",
	"nui/img/nophoto.png",
	"nui/img/bg.png",
	"nui/style.css",
	"nui/index.html",
	"nui/ui.js",
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}



