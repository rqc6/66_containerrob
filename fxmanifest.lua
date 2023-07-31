fx_version('cerulean')
games({ 'gta5' })

author '.rqc_'

server_scripts{
  'sv_*.lua'
}

shared_script '@ox_lib/init.lua'

client_scripts{
    'cl_*.lua'
}

lua54 'yes'
