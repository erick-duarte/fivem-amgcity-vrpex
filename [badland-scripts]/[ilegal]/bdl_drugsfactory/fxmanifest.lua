fx_version 'adamant'
game 'gta5'

author 'RossiniJS for Badland Project'
version '1.0.0'
contact 'Edu#0069 or github.com/rossinijs'

ui_page 'nui/badland.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client-side/*.lua',
	'client-side/maconha/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'ellie.lua',
	'maconha/*.lua'
}

files {
	'nui/badland.html',
	'nui/badland.js',
	'nui/badland.css',
	'nui/img/*.png',
}

