fx_version "adamant"
game "gta5"

ui_page "nui/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	"nui/index.html",
	"nui/jquery.js",
	"nui/css.css",
	"nui/dseg7.ttf",
	"nui/images/background.png"
}