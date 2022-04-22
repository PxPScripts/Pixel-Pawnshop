fx_version 'cerulean'
games { 'gta5' }

author 'Pixel#7068'
description 'Pixel Pawnshop (FIXED)'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server/main.lua',
    'config.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'client/main.lua',
    'config.lua',
}