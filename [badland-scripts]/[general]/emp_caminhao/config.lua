cfg = {}

cfg.entregas = {

	['inicio'] = {
		localizacao = vector3(1197.13,-3254.02,7.1)
	},

	['final'] = {
		mensagem = "Entrega final",
		localizacao = vector3(1185.5405273438, -3222.9682617188, 5.7997798919678)
	},

	['gasolina'] = { 
		['localizacao'] = {
			[1] = vector3(167.3, 6603.91, 31.85),
			[2] = vector3(-84.96, 6423.42, 31.07)
		},
        ['veiculos'] = {
            ['carreta'] = {
                nome = 'tanker2',
                hash = 1956216962
            },
            ['cavalo'] = {
                nome = 'packer',
                hash = 569305213
			}
        }
	},

	['diesel'] = { 
		['localizacao'] = {
			[1] = vector3(-84.96, 6423.42, 31.07),
			[2] = vector3(167.3, 6603.91, 31.85)
		},
		['veiculos'] = {
            ['carreta'] = {
                nome = 'armytanker',
                hash = -1207431159
            },
            ['cavalo'] = {
                nome = 'packer',
                hash = 569305213
			}
        }
	},

	['cars'] = { 
		['localizacao'] = {
			[1] = vector3(129.31, 6624.37, 31.35),
			[2] = vector3(-699.74, 5775.75, 16.91)
		},
		['veiculos'] = {
            ['carreta'] = {
                nome = 'tr4',
                hash = 2091594960
            },
            ['cavalo'] = {
                nome = 'packer',
                hash = 569305213
			}
        }
	},

	['woods'] = { 
		['localizacao'] = {
			[1] = vector3(-1529.87, 4475.42, 17.87),
			[2] = vector3(407.66, 6631.81, 27.91)
		},
		['veiculos'] = {
            ['carreta'] = {
                nome = 'trailerlogs',
                hash = 2016027501
            },
            ['cavalo'] = {
                nome = 'packer',
                hash = 569305213
			}
        }
	},

	['show'] = { 
		['localizacao'] = {
			[1] = vector3(-241.64, 6233.63, 31.48),
			[2] = vector3( -2173.49, 4272.84, 48.98)
		},
		['veiculos'] = {
            ['carreta'] = {
                nome = 'tvtrailer',
                hash = -1770643266
            },
            ['cavalo'] = {
                nome = 'packer',
                hash = 569305213
			}
        } 
	},

	['config'] = {
		delay = 300
	}

}

cfg.posicoes = { 

	['cavalo'] = {
		[1] = vector3(1155.23,-3252.85,5.91),
		[2] = vector3(1155.24,-3260.62,5.91),
		[3] = vector3(1155.24,-3267.87,5.91),
		[4] = vector3(1155.22,-3274.93,5.91)
	},

	['carreta'] = {
		[1] = vector3(1144.19,-3252.7,5.91),
		[2] = vector3(1143.48,-3260.5,5.91),
		[3] = vector3(1143.88,-3267.68,5.91),
		[4] = vector3(1143.67,-3274.74,5.91)
	}

	

}

return cfg