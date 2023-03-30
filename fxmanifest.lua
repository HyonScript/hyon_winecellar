fx_version 'cerulean'
game 'gta5'
name 'hyon_winecellar'
version      '1.0.2'
description 'hyon_winecellar'

lua54 'yes'

shared_script 'config.lua'

client_scripts {
	'@es_extended/imports.lua',
    'client/main.lua'
}

server_scripts {
	'@es_extended/imports.lua',
	'@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependency 'es_extended'