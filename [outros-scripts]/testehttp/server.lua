local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local user_id = 1
local idclient = 4
local vname = "zenotnor"
local amount = 214234141
local database = "275570379f2b4cb99593c8a142a1b117"

os.execute("$(which bash) /amgcity/server-data/shellscript/bennysEncomendas.sh")


--os.execute("$(which bash) /amgcity/server-data/shellscript/bennysVendas.sh "..user_id.." "..idclient.." "..vname.." "..amount.." "..database.."")