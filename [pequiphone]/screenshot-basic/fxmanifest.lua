fx_version 'adamant'
--------------  PROJETINHO FIVEM https://discord.gg/4mRG2Bp ----------------------
game 'gta5'

client_script 'dist/client.js'
server_script 'dist/server.js'

dependency 'yarn'
dependency 'webpack'

webpack_config 'client.config.js'
webpack_config 'server.config.js'
webpack_config 'ui.config.js'

files {
    'dist/ui.html'
}

ui_page 'dist/ui.html'

--client_script "@vrp_anticheatnovo/acloader.lua"