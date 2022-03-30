require('dotenv').config(); //initialize dotenv
const log = console.log
const { Client, Intents } = require('discord.js');
const client = new Client({ intents: [Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES] });

client.login('OTI0MzQ4Njc1NzMwMzE3MzQy.YcdQyQ.UGlUAirsCeYi38cVdpNcyHI5lpU');

const prefix = "!"

client.on("message", function(message) {
    if (message.author.bot) return;                           
    if (!message.content.startsWith(prefix)) {
        message.reply(`Prefixo inválido`)
        return;
    }
    const commandBody = message.content.slice(prefix.length);
    if (commandBody.startsWith(' ')) {
        message.reply(`Comando inválido`)
        return;
    }

    const args = commandBody.split(' ');
    const command = args.shift().toLowerCase();

    if (command === "teste") {
        log(nodejs('klandnsalndal'))
    }

    //const numArgs = args.map(x => {
    //    return `${x}`;
    //});

});

function nodejs(valor) {
	console.log(valor)
	return 'adawdadwa';
};


//ban 
//[ Comando para banir um usuario da cidade ]
//unban 
//[ Comando para desbanir um usuario da cidade ]
//liberar 
//[ Comando para aprovar na cidade sem necessidade da Whitelit ]
//unwl 
//[ Comando para remover whitelist de um usuario na cidade ]
//addcar 
//[ Comando para adicionar um carro na garagem de um usuario ]
//remcar 
//[ Comando para remover um carro da garagem de um usuario ]
//addgroup 
//[ Comando para adicionar um group para um usario da cidade ]
//remgroup 
//[ Comando para remover um group do usuario da cidade ]
//addmoney 
//[ Comando para adicionar dinheiro para um usario da cidade ]
//identidade 
//[ Comando para mostrar infos de um usuario ]
//veiculos 
//[ Comando para verificar veiculos que um usario possui ]