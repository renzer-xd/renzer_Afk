fx_version 'cerulean'
game 'gta5'
description ''
version '1.0'
author 'RenZer Developer Shop'

ui_page "script/html/index.html"


files {
	"script/html/index.html",
    'script/html/css/*.css',
    'script/html/js/*.js',
    'script/html/img/*.png'
}

shared_scripts {
    'config/config.general.lua',
    'config/config.translate.lua',
    'config/config.function.lua',
}

client_scripts {
    'script/function.lua',
    'script/client.lua',
}

server_scripts {
   'script/function.lua',
   'script/server.lua'
}