local cfg = {}

cfg.groups = {


	["founder"] = {
		_config = {
			title = "founder"
		},
		"founder.permission",
		"prop.permission", --anticheat
		"imunidade.permission", --anticheat
		"wall.permission", --anticheat
		"staff.permission"
	},
	["manager"] = {
		_config = {
			title = "manager"
		},
		"manager.permission",
		"imunidade.permission", --anticheat
		"wall.permission", --anticheat
		"staff.permission"
	},
	["admin"] = {
		_config = {
			title = "admin"
		},
		"admin.permission",
		"imunidade.permission", --anticheat
		"wall.permission", --anticheat
		"staff.permission"
	},
	["mod"] = {
		_config = {
			title = "mod"
		},
		"mod.permission",
		"staff.permission"
	},
	["support"] = {
		_config = {
			title = "support"
		},
		"support.permission",
		"trial.permission",
		"staff.permission"
	},


	["off-founder"] = {
		_config = {
			title = "founder"
		},
		"off-founder.permission",
		"off-staff.permission"
	},
	["off-manager"] = {
		_config = {
			title = "manager"
		},
		"off-manager.permission",
		"off-staff.permission"
	},
	["off-admin"] = {
		_config = {
			title = "admin"
		},
		"off-admin.permission",
		"off-staff.permission"
	},
	["off-mod"] = {
		_config = {
			title = "mod"
		},
		"off-mod.permission",
		"off-staff.permission"
	},
	["off-support"] = {
		_config = {
			title = "support"
		},
		"off-support.permission",
		"off-staff.permission"
	},






--	["pass-basic"] = {
--		_config = {
--			title = "Básico",
--			gtype = "pass"
--		},
--		"basic.pass",
--		"pass.permission"
--	},
--
--	["pass-intermediate"] = {
--		_config = {
--			title = "Intermediário",
--			gtype = "pass"
--		},
--		"intermediate.pass",
--		"pass.permission"
--	},
--
--	["pass-advanced"] = {
--		_config = {
--			title = "Avançado",
--			gtype = "pass"
--		},
--		"advanced.pass",
--		"pass.permission"
--	},
--
--	["pass-plus"] = {
--		_config = {
--			title = "Plus",
--			gtype = "pass"
--		},
--		"plus.pass",
--		"pass.permission"
--	},


	["pass-bronze"] = {
		_config = {
			title = "Bronze"
		},
		"bronze.pass",
		"pass.permission"
	},

	["pass-prata"] = {
		_config = {
			title = "Prata"
		},
		"prata.pass",
		"pass.permission"
	},

	["pass-ouro"] = {
		_config = {
			title = "Ouro"
		},
		"ouro.pass",
		"pass.permission"
	},

	["pass-platina"] = {
		_config = {
			title = "Platina"
		},
		"platina.pass",
		"pass.permission"
	},

	["pass-amg"] = {
		_config = {
			title = "AMG"
		},
		"amg.pass",
		"pass.permission"
	},

----------------------------------------------------------------------
--- [ JUSTIÇA ] ------------------------------------------------------
----------------------------------------------------------------------

	["advogado"] = {
		_config = {
			title = "Advogado",
			gtype = "job"
		},
		"advogado.permission"
	},
	["off-advogado"] = {
		_config = {
			title = "F. Serviço - Advogado",
			gtype = "job"
		},
		"off-advogado.permission"
	},

	["juiz"] = {
		_config = {
			title = "Juiz",
			gtype = "job"
		},
		"juiz.permission"
	},
	["off-juiz"] = {
		_config = {
			title = "F. Serviço - Juiz",
			gtype = "job"
		},
		"off-juiz.permission"
	},

----------------------------------------------------------------------
--- [ POLICIA ] ------------------------------------------------------
----------------------------------------------------------------------
	-- [ LSPD - JOB ] --
--	["lspd"] = {
--		_config = {
--			title = "LS - Policia",
--			gtype = "job"
--		},
--		"lspd.permission",
--	},

	["policia"] = {
		_config = {
			title = "Policia AMG",
			gtype = "job"
		},
		"lspd.permission",
		"policiaamg.permission",
	},

	["tatica"] = {
		_config = {
			title = "Tática",
			gtype = "job"
		},
		"lspd.permission",
		"tatica.permission",
	},

	["investigativa"] = {
		_config = {
			title = "Investigativa",
			gtype = "job"
		},
		"lspd.permission",
		"investigativa.permission",
	},

--	["off-lspd"] = {
--		_config = {
--			title = "F. Serviço - LSPD",
--			gtype = "job"
--		},
--		"off-lspd.permission",
--	},

	["off-policia"] = {
		_config = {
			title = "F. Serviço - Policia",
			gtype = "job"
		},
		"off-lspd.permission",
		"off-policia.permission",
	},

	["off-tatica"] = {
		_config = {
			title = "F. Serviço - Tática",
			gtype = "job"
		},
		"off-lspd.permission",
		"off-tatica.permission",
	},

	["off-investigativa"] = {
		_config = {
			title = "F. Serviço - Investigativa",
			gtype = "job"
		},
		"off-lspd.permission",
		"off-investigativa.permission",
	},



-------------------------------------------------------------------------------
--- [ POLICIAS POSICAO ] ------------------------------------------------------
-------------------------------------------------------------------------------
	-- [ LSPD - POSITIONS ] --
--	["lspd-cadete"] = {
--		_config = {
--			title = "Cadete",
--			gtype = "position"
--		},
--		"cadete.permission",
--	},
--	["lspd-officerjr"] = {
--		_config = {
--			title = "Oficial Jr.",
--			gtype = "position"
--		},
--		"officerjr.permission",
--	},
--	["lspd-officersr"] = {
--		_config = {
--			title = "Oficial Sr.",
--			gtype = "position"
--		},
--		"officersr.permission",
--	},
--	["lspd-detective"] = {
--		_config = {
--			title = "Detetive",
--			gtype = "position"
--		},
--		"detective.permission",
--	},
--	["lspd-sargeant"] = {
--		_config = {
--			title = "Sargento",
--			gtype = "position"
--		},
--		"sargeant.permission",
--	},
--	["lspd-lieutenant"] = {
--		_config = {
--			title = "Tenente",
--			gtype = "position"
--		},
--		"lieutenant.permission",
--	},
--	["lspd-captain"] = {
--		_config = {
--			title = "Capitão",
--			gtype = "position"
--		},
--		"captain.permission",
--	},
--	["lspd-comissioner"] = {
--		_config = {
--			title = "Comissário",
--			gtype = "position"
--		},
--		"comissioner.permission",
--	},

--------------------------------------------------------------------------
--- [ POLICIA AMG ] ------------------------------------------------------
--------------------------------------------------------------------------
	["policia-recruta"] = {
		_config = {
			title = "Recruta",
			gtype = "position"
		},
		"policia-recruta.permission",
	},
	["policia-offrecruta"] = {
		_config = {
			title = "Recruta",
			gtype = "position"
		},
		"policia-offrecruta.permission",
	},
	["policia-soldado"] = {
		_config = {
			title = "Soldado",
			gtype = "position"
		},
		"policia-soldado.permission",
	},
	["policia-offsoldado"] = {
		_config = {
			title = "Soldado",
			gtype = "position"
		},
		"policia-offsoldado.permission",
	},
	["policia-cabo"] = {
		_config = {
			title = "Cabo",
			gtype = "position"
		},
		"policia-cabo.permission",
	},
	["policia-offcabo"] = {
		_config = {
			title = "Cabo",
			gtype = "position"
		},
		"policia-offcabo.permission",
	},
	["policia-sargento"] = {
		_config = {
			title = "Sargento",
			gtype = "position"
		},
		"policia-sargento.permission",
	},
	["policia-offsargento"] = {
		_config = {
			title = "Sargento",
			gtype = "position"
		},
		"policia-offsargento.permission",
	},
	["policia-tenente"] = {
		_config = {
			title = "Tenente",
			gtype = "position"
		},
		"policia-tenente.permission",
	},
	["policia-offtenente"] = {
		_config = {
			title = "Tenente",
			gtype = "position"
		},
		"policia-offtenente.permission",
	},
	["policia-capitao"] = {
		_config = {
			title = "Capitao",
			gtype = "position"
		},
		"policia-capitao.permission",
	},
	["policia-offcapitao"] = {
		_config = {
			title = "Capitao",
			gtype = "position"
		},
		"policia-offcapitao.permission",
	},
	["policia-major"] = {
		_config = {
			title = "Major",
			gtype = "position"
		},
		"policia-major.permission",
	},
	["policia-offmajor"] = {
		_config = {
			title = "Major",
			gtype = "position"
		},
		"policia-offmajor.permission",
	},
	["policia-coronel"] = {
		_config = {
			title = "Coronel",
			gtype = "position"
		},
		"policia-coronel.permission",
	},
	["policia-offcoronel"] = {
		_config = {
			title = "Coronel",
			gtype = "position"
		},
		"policia-offcoronel.permission",
	},
	["policia-subcomandante"] = {
		_config = {
			title = "Sub-Comandante",
			gtype = "position"
		},
		"policia-subcomandante.permission",
	},
	["policia-offsubcomandante"] = {
		_config = {
			title = "Sub-Comandante",
			gtype = "position"
		},
		"policia-offsubcomandante.permission",
	},
	["policia-comandante"] = {
		_config = {
			title = "Comandante",
			gtype = "position"
		},
		"policia-comandante.permission",
	},
	["policia-offcomandante"] = {
		_config = {
			title = "Comandante",
			gtype = "position"
		},
		"policia-offcomandante.permission",
	},
---------------------------------------------------------------------
--- [ TATICA ] ------------------------------------------------------
---------------------------------------------------------------------
	["tatica-recruta"] = {
		_config = {
			title = "Recruta",
			gtype = "position"
		},
		"tatica-recruta.permission",
	},
	["tatica-soldado"] = {
		_config = {
			title = "Soldado",
			gtype = "position"
		},
		"tatica-soldado.permission",
	},
	["tatica-cabo"] = {
		_config = {
			title = "Cabo",
			gtype = "position"
		},
		"tatica-cabo.permission",
	},
	["tatica-sargento"] = {
		_config = {
			title = "Sargento",
			gtype = "position"
		},
		"tatica-sargento.permission",
	},
	["tatica-tenente"] = {
		_config = {
			title = "Tenente",
			gtype = "position"
		},
		"tatica-tenente.permission",
	},
	["tatica-capitao"] = {
		_config = {
			title = "Capitao",
			gtype = "position"
		},
		"tatica-capitao.permission",
	},
	["tatica-major"] = {
		_config = {
			title = "Major",
			gtype = "position"
		},
		"tatica-major.permission",
	},
	["tatica-coronel"] = {
		_config = {
			title = "Coronel",
			gtype = "position"
		},
		"tatica-coronel.permission",
	},
	["tatica-subcomandante"] = {
		_config = {
			title = "Sub-Comandante",
			gtype = "position"
		},
		"tatica-subcomandante.permission",
	},
	["tatica-comandante"] = {
		_config = {
			title = "Comandante",
			gtype = "position"
		},
		"tatica-comandante.permission",
	},
----------------------------------------------------------------------------
--- [ INVESTIGATIVA ] ------------------------------------------------------
----------------------------------------------------------------------------
	["investigativa-investigador"] = {
		_config = {
			title = "Investigador",
			gtype = "position"
		},
		"investigativa-investigador.permission",
	},
	["investigativa-escrivao"] = {
		_config = {
			title = "Escrivão",
			gtype = "position"
		},
		"investigativa-escrivao.permission",
	},
	["investigativa-delegado"] = {
		_config = {
			title = "Delegado",
			gtype = "position"
		},
		"investigativa-delegado.permission",
	},



-----------------------------------------------------------------------
--- [ HOSPITAL ] ------------------------------------------------------
-----------------------------------------------------------------------
	-- [ EMS - JOB ] --
--	["ems"] = {
--		_config = {
--			title = "LS - Hospital",
--			gtype = "job"
--		},
--		"ems.permission",
--	}, 
--	["off-ems"] = {
--		_config = {
--			title = "F. Serviço - EMS",
--			gtype = "job"
--		},
--		"off-ems.permission",
--	}, 

	["hospital"] = {
		_config = {
			title = "Hospital AMG",
			gtype = "job"
		},
		"ems.permission",
		"hospitalamg.permission",
	}, 
	["off-hospital"] = {
		_config = {
			title = "F. Serviço - Hospital",
			gtype = "job"
		},
		"off-ems.permission",
		"off-hospitalamg.permission",
	}, 

--------------------------------------------------------------------------------
--- [ HOSPITAL POSICOES ] ------------------------------------------------------
--------------------------------------------------------------------------------
	-- [ EMS - POSITIONS ] --
--	["ems-intern"] = {
--		_config = {
--			title = "Estagiário(a)",
--			gtype = "position"
--		},
--		"intern.permission",
--	},
--
--	["ems-nurse"] = {
--		_config = {
--			title = "Enfermeiro(a)",
--			gtype = "position"
--		},
--		"nurse.permission",
--	},
--
--	["ems-paramedic"] = {
--		_config = {
--			title = "Paramédico(a)",
--			gtype = "position"
--		},
--		"nurse.permission",
--	},
--
--	["ems-medic"] = {
--		_config = {
--			title = "Médico(a)",
--			gtype = "position"
--		},
--		"medic.permission",
--	},
--
--	["ems-clinic"] = {
--		_config = {
--			title = "Clinico(a) Geral",
--			gtype = "position"
--		},
--		"clinic.permission",
--	},
--
--	["ems-vicedirector"] = {
--		_config = {
--			title = "Vice Diretor(a)",
--			gtype = "position"
--		},
--		"vicedirector.permission",
--	},
--
--	["ems-director"] = {
--		_config = {
--			title = "Diretor(a)",
--			gtype = "position"
--		},
--		"director.permission",
--	},

	["hospital-enfermeiro"] = {
		_config = {
			title = "Enfermeiro(a)",
			gtype = "position"
		},
		"enfermeiro.permission",
	},
	["hospital-pamedico"] = {
		_config = {
			title = "Paramédico(a)",
			gtype = "position"
		},
		"pamedico.permission",
	},
	["hospital-medico"] = {
		_config = {
			title = "Médico(a)",
			gtype = "position"
		},
		"medico.permission",
	},
	["hospital-clinicogeral"] = {
		_config = {
			title = "Clí. Geral(a)",
			gtype = "position"
		},
		"clinicogeral.permission",
	},
	["hospital-diretor"] = {
		_config = {
			title = "Diretor(a)",
			gtype = "position"
		},
		"diretor.permission",
	},
	["hospital-resgate"] = {
		_config = {
			title = "Resgate",
			gtype = "position"
		},
		"resgate.permission",
	},


-----------------------------------------------------------------------
--- [ MECANICA ] ------------------------------------------------------
-----------------------------------------------------------------------
	-- [ BENNYS - JOB ] --
	["bennys"] = {
		_config = {
			title = "LS - Benny's",
			gtype = "job"
		},
		"bennys.permission",
	},

	["off-bennys"] = {
		_config = {
			title = "F. Serviço - Benny's",
			gtype = "job"
		},
		"off-bennys.permission",
	},
--------------------------------------------------------------------------------
--- [ BENNYS POSICOES ] --------------------------------------------------------
--------------------------------------------------------------------------------
	-- [ BENNYS - POSITIONS ] --
	["bennys-tow"] = {
		_config = {
			title = "Guincho",
			gtype = "position"
		},
		"tow.permission",
	},

	["bennys-mechanic"] = {
		_config = {
			title = "Mecânico",
			gtype = "position"
		},
		"mechanic.permission",
	},

	["bennys-manager"] = {
		_config = {
			title = "Gerente",
			gtype = "position"
		},
		"bennysmanager.permission",
	},

	["bennys-ceo"] = {
		_config = {
			title = "C.E.O",
			gtype = "position"
		},
		"bennysceo.permission",
	},




	-- [ ILEGAL ] --
	-- [ GANGUES DE RUA ] --
--	-- [ Grove ] --
	["grove"] = {
		_config = {
			title = "Grove St.",
			gtype = "job"
		},
		"grove.permission",
		"ilegal.permission"
	},

	["l-grove"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-grove.permission",
	},

	["m-grove"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-grove.permission",
	},

	--[ VERDES ] --
	["verdes"] = {
		_config = {
			title = "Verdes",
			gtype = "job"
		},
		"verdes.permission",
		"ilegal.permission"
	},
	["chf-verdes"] = {
		_config = {
			title = "Chefe",
			gtype = "position"
		},
		"chf-verdes.permission",
	},
	["schf-verdes"] = {
		_config = {
			title = "Sub Chefe",
			gtype = "position"
		},
		"schf-verdes.permission",
	},
	["vp-verdes"] = {
		_config = {
			title = "Vapor",
			gtype = "position"
		},
		"vp-verdes.permission",
	},
	["fog-verdes"] = {
		_config = {
			title = "Fogueteiro",
			gtype = "position"
		},
		"fog-verdes.permission",
	},
	["av-verdes"] = {
		_config = {
			title = "Aviãozinho",
			gtype = "position"
		},
		"av-verdes.permission",
	},

	-- [ Ballas ] --
	["ballas"] = {
		_config = {
			title = "Ballas",
			gtype = "job"
		},
		"ballas.permission",
		"ilegal.permission"
	},

	["l-ballas"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-ballas.permission",
	},

	["m-ballas"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-ballas.permission",
	},

	--[ VERMELHOS ] --
	["vermelhos"] = {
		_config = {
			title = "Vermelhos",
			gtype = "job"
		},
		"vermelhos.permission",
		"ilegal.permission"
	},
	["chf-vermelhos"] = {
		_config = {
			title = "Chefe",
			gtype = "position"
		},
		"chf-vermelhos.permission",
	},
	["schf-vermelhos"] = {
		_config = {
			title = "Sub Chefe",
			gtype = "position"
		},
		"schf-vermelhos.permission",
	},
	["vp-vermelhos"] = {
		_config = {
			title = "Vapor",
			gtype = "position"
		},
		"vp-vermelhos.permission",
	},
	["fog-vermelhos"] = {
		_config = {
			title = "Fogueteiro",
			gtype = "position"
		},
		"fog-vermelhos.permission",
	},
	["av-vermelhos"] = {
		_config = {
			title = "Aviãozinho",
			gtype = "position"
		},
		"av-vermelhos.permission",
	},

	-- [ Vagos ] --
	["vagos"] = {
		_config = {
			title = "Vagos",
			gtype = "job"
		},
		"vagos.permission",
		"ilegal.permission"
	},

	["l-vagos"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-vagos.permission",
	},

	["m-vagos"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-vagos.permission",
	},

	--[ BRANCO ] --
	["brancos"] = {
		_config = {
			title = "Brancos",
			gtype = "job"
		},
		"brancos.permission",
		"ilegal.permission"
	},
	["chf-brancos"] = {
		_config = {
			title = "Chefe",
			gtype = "position"
		},
		"chf-brancos.permission",
	},
	["schf-brancos"] = {
		_config = {
			title = "Sub Chefe",
			gtype = "position"
		},
		"schf-brancos.permission",
	},
	["vp-brancos"] = {
		_config = {
			title = "Vapor",
			gtype = "position"
		},
		"vp-brancos.permission",
	},
	["fog-brancos"] = {
		_config = {
			title = "Fogueteiro",
			gtype = "position"
		},
		"fog-brancos.permission",
	},
	["av-brancos"] = {
		_config = {
			title = "Aviãozinho",
			gtype = "position"
		},
		"av-brancos.permission",
	},







	-- [ GANGUES DE ARMA/MUNIÇÃO ] --
	-- [ Bratva ] --

	["bratva"] = {
		_config = {
			title = "Bratva",
			gtype = "job"
		},
		"bratva.permission",
		"ilegal.permission"
	},

	["l-bratva"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-bratva.permission",
	},

	["m-bratva"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-bratva.permission",
	},

	-- [ LC ] --

	["ykz"] = {
		_config = {
			title = "Yakuza",
			gtype = "job"
		},
		"ykz.permission",
		"ilegal.permission"
	},

	["l-ykz"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-ykz.permission",
	},

	["m-ykz"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-ykz.permission",
	},

	-- [ M.C ] --

	["lost"] = {
		_config = {
			title = "Lost MC",
			gtype = "job"
		},
		"lost.permission",
		"ilegal.permission"
	},

	["l-lost"] = {
		_config = {
			title = "Líder",
			gtype = "position"
		},
		"l-lost.permission",
	},

	["m-lost"] = {
		_config = {
			title = "Membro",
			gtype = "position"
		},
		"m-lost.permission",
	},
}


cfg.users = {
	[1] = { "founder" }
}

cfg.selectors = {}

return cfg