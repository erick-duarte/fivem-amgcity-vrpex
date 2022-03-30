local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("bdl_drugsdeliver/insertVendas","INSERT INTO log_drugsdeliver (user_id,item,quantidade,recebido) VALUES (@user_id, @item, @quantidade, @recebido)")

vRP._prepare("nation_bennys/insertPagamento","INSERT INTO log_bennys (idmecanico,idcliente,veiculo,valor,date) VALUES (@idmecanico,@idcliente,@veiculo,@valor,now())")