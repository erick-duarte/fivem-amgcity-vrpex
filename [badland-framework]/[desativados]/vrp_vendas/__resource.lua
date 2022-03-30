description 'vrp_vendas'

ui_page "nui/index.html"

files {
	"nui/index.html",
  "nui/ui.js"
}

client_script {
  '@vrp/lib/utils.lua',
  'cfg/config.lua',
  'client.lua'
}

server_script {
  '@vrp/lib/utils.lua',
  'cfg/config.lua',
  'server.lua'
}

