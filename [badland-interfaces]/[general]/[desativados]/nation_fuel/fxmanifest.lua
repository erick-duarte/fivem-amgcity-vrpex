fx_version "adamant"
game "gta5"

ui_page 'html/ui.html'

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"client.lua"
}

files {
  'html/ui.html',
  'html/ui.css', 
  'html/ui.js',
}

