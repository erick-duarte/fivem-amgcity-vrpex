fx_version 'adamant'
game 'gta5'

ui_page 'nui/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client-side/*.lua',
	'config.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'ellie.lua',
	'config.lua'
}

files {
	'nui/index.html',
	'nui/visual.css',
	'nui/app.js'
}