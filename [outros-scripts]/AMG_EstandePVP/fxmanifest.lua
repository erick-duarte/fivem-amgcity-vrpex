fx_version 'bodacious'
games { 'gta5' }

ui_page "nui/ui.html"

client_script {
    "@vrp/lib/utils.lua",
    'client.lua'
}

server_script {
    "@vrp/lib/utils.lua",
    'server.lua'
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}