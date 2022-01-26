fx_version 'bodacious'
game 'gta5'

ui_page "client/html/ui.html"
files {
	"client/html/ui.html",
	"client/html/styles.css",
	"client/html/dark.css",
	"client/html/scripts.js",
	"client/html/ckeditor.js",
	"configNui.js",
	"client/html/debounce.min.js",
	"client/html/sweetalert2.min.js"
}

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"config.lua",
	"client/main.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@vrp/lib/utils.lua",
	"config.lua",
	"server/main.lua"
}


