fx_version 'bodacious'
game 'gta5'

ui_page "jbl_sound/html/index.html"
discord_webhook 'https://discord.com/api/webhooks/851161201969987605/WHxxxsDBDnYVv5SHERBK_-Xo1nVw4BPxUVO0vPjox5VeVP-QCe-BzG2LioEHmgabLyW0' --auditoria

client_scripts {
    "@vrp/lib/utils.lua",
    "jbl_sound/client/client.lua",
    "amg_salarios/client.lua"
}

server_scripts{
    '@vrp/lib/utils.lua',
	'@mysql-async/lib/MySQL.lua',
--    'clysia/clysia.lua',
--    'clysia/config.lua',
    'suel_auditoria/lucifer.lua',
    "jbl_sound/server.lua",
    "amg_salarios/server.lua"
}

files {
	"jbl_sound/html/js/*.js",	
	"jbl_sound/html/*.html",
	'jbl_sound/html/sounds/musica1.mp3',
    'carsounds/audioconfig/lambov10_game.dat151.rel',
    'carsounds/audioconfig/lambov10_sounds.dat54.rel',
    'carsounds/sfx/dlc_lambov10/lambov10.awc',
    'carsounds/sfx/dlc_lambov10/lambov10_npc.awc',
    'carsounds/audioconfig/musv8_game.dat151.rel',
    'carsounds/audioconfig/musv8_sounds.dat54.rel',
    'carsounds/sfx/dlc_musv8/musv8.awc',
    'carsounds/sfx/dlc_musv8/musv8_npc.awc',
    'carsounds/audioconfig/brabus850_game.dat151.rel',
    'carsounds/audioconfig/brabus850_sounds.dat54.rel',
    'carsounds/sfx/dlc_brabus850/brabus850.awc',
    'carsounds/sfx/dlc_brabus850/brabus850_npc.awc',
    'carsounds/audioconfig/shonen_game.dat151.rel',
    'carsounds/audioconfig/shonen_sounds.dat54.rel',
    'carsounds/sfx/dlc_shonen/shonen.awc',
    'carsounds/sfx/dlc_shonen/shonen_npc.awc',
    'carsounds/audioconfig/toysupmk4_game.dat151.nametable',
    'carsounds/audioconfig/toysupmk4_game.dat151.rel',
    'carsounds/audioconfig/toysupmk4_sounds.dat54.nametable',
    'carsounds/audioconfig/toysupmk4_sounds.dat54.rel',
    'carsounds/sfx/dlc_toysupmk4/toysupmk4.awc',
    'carsounds/sfx/dlc_toysupmk4/toysupmk4_npc.awc',
    'carsounds/audioconfig/rb26dett_amp.dat10.rel',
    'carsounds/audioconfig/rb26dett_game.dat151.rel',
    'carsounds/audioconfig/rb26dett_sounds.dat54.rel',
    'carsounds/sfx/dlc_rb26dett/rb26dett.awc',
    'carsounds/sfx/dlc_rb26dett/rb26dett_npc.awc',
    'carsounds/audioconfig/rotary7_game.dat151.rel',
    'carsounds/audioconfig/rotary7_sounds.dat54.rel',
    'carsounds/sfx/dlc_rotary7/rotary7.awc',
    'carsounds/sfx/dlc_rotary7/rotary7_npc.awc',
    'carsounds/audioconfig/m297zonda_amp.dat10.nametable',
    'carsounds/audioconfig/m297zonda_amp.dat10.rel',
    'carsounds/audioconfig/m297zonda_game.dat151.nametable',
    'carsounds/audioconfig/m297zonda_game.dat151.rel',
    'carsounds/audioconfig/m297zonda_sounds.dat54.nametable',
    'carsounds/audioconfig/m297zonda_sounds.dat54.rel',
    'carsounds/sfx/dlc_m297zonda/m297zonda.awc',
    'carsounds/sfx/dlc_m297zonda/m297zonda_npc.awc',
    'carsounds/audioconfig/m158huayra_amp.dat10.nametable',
    'carsounds/audioconfig/m158huayra_amp.dat10.rel',
    'carsounds/audioconfig/m158huayra_game.dat151.nametable',
    'carsounds/audioconfig/m158huayra_game.dat151.rel',
    'carsounds/audioconfig/m158huayra_sounds.dat54.nametable',
    'carsounds/audioconfig/m158huayra_sounds.dat54.rel',
    'carsounds/sfx/dlc_m158huayra/m158huayra.awc',
    'carsounds/sfx/dlc_m158huayra/m158huayra_npc.awc',
    'carsounds/audioconfig/k20a_amp.dat10.nametable',
    'carsounds/audioconfig/k20a_amp.dat10.rel',
    'carsounds/audioconfig/k20a_game.dat151.nametable',
    'carsounds/audioconfig/k20a_game.dat151.rel',
    'carsounds/audioconfig/k20a_sounds.dat54.nametable',
    'carsounds/audioconfig/k20a_sounds.dat54.rel',
    'carsounds/sfx/dlc_k20a/k20a.awc',
    'carsounds/sfx/dlc_k20a/k20a_npc.awc',
    'carsounds/audioconfig/gt3flat6_amp.dat10.nametable',
    'carsounds/audioconfig/gt3flat6_amp.dat10.rel',
    'carsounds/audioconfig/gt3flat6_game.dat151.nametable',
    'carsounds/audioconfig/gt3flat6_game.dat151.rel',
    'carsounds/audioconfig/gt3flat6_sounds.dat54.nametable',
    'carsounds/audioconfig/gt3flat6_sounds.dat54.rel',
    'carsounds/sfx/dlc_gt3flat6/gt3flat6.awc',
    'carsounds/sfx/dlc_gt3flat6/gt3flat6_npc.awc',
    'carsounds/audioconfig/predatorv8_amp.dat10.nametable',
    'carsounds/audioconfig/predatorv8_amp.dat10.rel',
    'carsounds/audioconfig/predatorv8_game.dat151.nametable',
    'carsounds/audioconfig/predatorv8_game.dat151.rel',
    'carsounds/audioconfig/predatorv8_sounds.dat54.nametable',
    'carsounds/audioconfig/predatorv8_sounds.dat54.rel',
    'carsounds/sfx/dlc_predatorv8/predatorv8.awc',
    'carsounds/sfx/dlc_predatorv8/predatorv8_npc.awc',
    'carsounds/audioconfig/p60b40_amp.dat10.nametable',
    'carsounds/audioconfig/p60b40_amp.dat10.rel',
    'carsounds/audioconfig/p60b40_game.dat151.nametable',
    'carsounds/audioconfig/p60b40_game.dat151.rel',
    'carsounds/audioconfig/p60b40_sounds.dat54.nametable',
    'carsounds/audioconfig/p60b40_sounds.dat54.rel',
    'carsounds/sfx/dlc_p60b40/p60b40.awc',
    'carsounds/sfx/dlc_p60b40/p60b40_npc.awc'
}

data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/lambov10_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/lambov10_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_lambov10'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/musv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/musv8_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_musv8'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/brabus850_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/brabus850_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_brabus850'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/shonen_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/shonen_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_shonen'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/toysupmk4_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/toysupmk4_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_toysupmk4'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/rb26dett_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/rb26dett_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/rb26dett_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_rb26dett'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/rotary7_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/rotary7_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_rotary7'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/m297zonda_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/m297zonda_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/m297zonda_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_m297zonda'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/m158huayra_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/m158huayra_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/m158huayra_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_m158huayra'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/k20a_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/k20a_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/k20a_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_k20a'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/gt3flat6_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/gt3flat6_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/gt3flat6_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_gt3flat6'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/predatorv8_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/predatorv8_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/predatorv8_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_predatorv8'
data_file 'AUDIO_SYNTHDATA' 'carsounds/audioconfig/p60b40_amp.dat'
data_file 'AUDIO_GAMEDATA' 'carsounds/audioconfig/p60b40_game.dat'
data_file 'AUDIO_SOUNDDATA' 'carsounds/audioconfig/p60b40_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'carsounds/sfx/dlc_p60b40'


