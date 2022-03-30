amGcfg = {}

-- tipo
-- 0 -> empresas legais
-- 1 -> empresas ilegais

amGcfg.empresas = {

     bennysceo = {
          tipo = 0,
          permission = "bennysceo.permission",
          cnpj = 1,
          produtos = {
               repairkit = 1000,
               pneu = 1000,
               militec = 1000
          }
     },

     bratva = {
          tipo = 1,
          permission = "l-bratva.permission",
          cnpj = 0,
          minloc = 6,
          maxloc = 10,
          produtos = {
               corpoak103 = 1000,
               corpoak47 = 1000,
               corpoak74 = 1000,
               corpomp5 = 1000,
               corpotec9 = 1000,
               corpom1911 = 1000,
               corpohk110 = 1000,
               corpoparafal = 1000,
               corpofiveseven = 1000,
               corpoglock = 1000,
               placametal = 1000,
               gatilho = 1000,
               molas = 1000
          }
     },

     lost = {
          tipo = 1,
          permission = "l-lost.permission",
          cnpj = 0,
          minloc = 1,
          maxloc = 5,
          produtos = {
               capsulas = 1000,
               polvora = 1000
          }
     }
}

amGcfg.contrabandistas = { 
     
     [1] = {
          point = {
               posIlegal = vector3(-3235.87,1323.12,2.37-0.6)
          },

          peds = {
               u_m_m_aldinapoli = {
                    animation = false,
                    loc = vector3(-3236.2,1326.97,1.9-1),
                    h = 206.00,
                    weapon = "weapon_assaultrifle"
               },
               g_m_m_armboss_01 = {
                    animation = true,
                    typeanim = "WORLD_HUMAN_SMOKING",
                    loc = vector3(-3237.0,1325.32,2.04-1),
                    h = 206.00
               },
               s_m_y_ammucity_01 = {
                    animation = false,
                    loc = vector3(-3238.49,1325.51,1.82-1),
                    h = 206.00,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               dinghy2 = {
                    loc = vector3(-3246.59,1333.22,-0.27),
                    h = 43.80,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = false
               }
          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(-3237.45,1322.58,2.34-1),
                    h = 100.00
               }
          }
     },

     [2] = {

          point = {
               posIlegal = vector3(-605.37,2108.27,127.26)
          },

          peds = {
               u_m_m_aldinapoli = {
                    animation = false,
                    loc = vector3(-604.94,2104.05,127.99-1),
                    h = 4.75,
                    weapon = "weapon_assaultrifle"
               },
               g_m_m_armboss_01 = {
                    animation = true,
                    typeanim = "WORLD_HUMAN_SMOKING",
                    loc = vector3(-603.59,2106.6,127.78-1),
                    h = 30.44
               },
               s_m_y_ammucity_01 = {
                    animation = false,
                    loc = vector3(-601.04,2108.2,127.99-1),
                    h = 70.70,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               baller6 = {
                    loc = vector3(-610.14,2106.77,126.74-1),
                    h = 106.12,
                    Ldoor = true,
                    Rdoor = true,
                    TLdoor = true,
                    TRdoor = true,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(-606.24,2107.77,127.18-1),
                    h = 286.16
               }
          }
     },

     [3] = {

          point = {
               posIlegal = vector3(-296.46,2822.88,59.26)
          },

          peds = {
               u_m_m_aldinapoli = {
                    animation = false,
                    loc = vector3(-300.5,2815.59,59.28-1),
                    h = 321.73,
                    weapon = "weapon_assaultrifle"
               },
               cs_priest = {
                    animation = false,
                    loc = vector3(-296.95,2816.43,59.11-1),
                    h = 321.73,
                    weapon = "weapon_battleaxe"
               },
               s_m_y_ammucity_01 = {
                    animation = false,
                    loc = vector3(-296.15,2812.55,59.03-1),
                    h = 321.73,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               lurcher = {
                    loc = vector3(-299.86,2825.0,59.02-1),
                    h = 55.32,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(-295.24,2821.65,59.14-1),
                    h = 286.16
               }
          }
     },

     [4] = {

          point = {
               posIlegal = vector3(-296.46,2822.88,59.26)
          },

          peds = {
               g_m_y_lost_03 = {
                    animation = false,
                    loc = vector3(87.39,3754.4,39.75-1),
                    h = 139.818,
                    weapon = "weapon_assaultrifle"
               },
               a_f_y_juggalo_01 = {
                    animation = false,
                    loc = vector3(84.28,3752.52,39.75-1),
                    h = 167.834,
                    weapon = "weapon_assaultrifle"
               },
               g_m_y_lost_02 = {
                    animation = false,
                    loc = vector3(83.02,3754.91,39.76-1),
                    h = 184.320,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               gburrito = {
                    loc = vector3(79.6,3755.98,41.81-1),
                    h = 22.00,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(81.22,3751.67,39.75-1),
                    h = 286.16
               }
          }
     },

     [5] = {

          point = {
               posIlegal = vector3(1013.33,2450.16,44.58)
          },

          peds = {
               s_m_m_dockwork_01 = {
                    animation = false,
                    loc = vector3(1017.84,2447.61,44.33-1),
                    h = 90.774,
                    weapon = "weapon_assaultrifle"
               },
               s_m_y_construct_01 = {
                    animation = false,
                    loc = vector3(1015.84,2444.79,44.29-1),
                    h = 95.357,
                    weapon = "weapon_assaultrifle"
               },
               s_m_y_dockwork_01 = {
                    animation = false,
                    loc = vector3(1018.35,2441.47,44.45-1),
                    h = 93.0,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               bison3 = {
                    loc = vector3(1017.37,2451.64,44.04-1),
                    h = 290,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(1013.33,2450.16,44.58-1),
                    h = 286.16
               }
          }
     },

     [6] = {

          point = {
               posIlegal = vector3(2782.36,1583.52,24.51)
          },

          peds = {
               player_two = {
                    animation = false,
                    loc = vector3(2782.49,1578.52,24.51-1),
                    h = 348.84,
                    weapon = "weapon_assaultrifle"
               },
               player_zero = {
                    animation = false,
                    loc = vector3(2785.76,1580.34,24.51-1),
                    h = 346.32,
                    weapon = "weapon_assaultrifle"
               },
               player_one = {
                    animation = false,
                    loc = vector3(2787.64,1577.14,24.51-1),
                    h = 347.78,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               kuruma2 = {
                    loc = vector3(2778.83,1581.78,24.25-1),
                    h = 117.41,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(2782.36,1583.52,24.51-1),
                    h = 286.16
               }
          }
     },

     [7] = {

          point = {
               posIlegal = vector3(2009.98,4988.09,41.35)
          },

          peds = {
               a_m_m_farmer_01 = {
                    animation = false,
                    loc = vector3(2004.87,4986.22,41.45-1),
                    h = 242.59,
                    weapon = "weapon_assaultrifle"
               },
               s_m_m_cntrybar_01 = {
                    animation = false,
                    loc = vector3(2003.03,4989.81,41.43-1),
                    h = 242.017,
                    weapon = "weapon_assaultrifle"
               },
               a_m_m_hillbilly_01 = {
                    animation = false,
                    loc = vector3(2002.69,4984.89,41.51-1),
                    h = 269.95,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               dloader = {
                    loc = vector3(2009.55,4992.68,40.98-1),
                    h = 349.587,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(2009.98,4988.09,41.35-1),
                    h = 286.16
               }
          }
     },

     [8] = {

          point = {
               posIlegal = vector3(-389.56,4344.97,56.71)
          },

          peds = {
               cs_paper = {
                    animation = false,
                    loc = vector3(-390.58,4349.89,57.44-1),
                    h = 189.4332,
                    weapon = "weapon_assaultrifle"
               },
               s_m_m_movprem_01 = {
                    animation = false,
                    loc = vector3(-388.65,4354.31,57.69-1),
                    h = 189.4332,
                    weapon = "weapon_assaultrifle"
               },
               cs_movpremf_01 = {
                    animation = false,
                    loc = vector3(-393.14,4353.39,57.69-1),
                    h = 189.4332,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               maverick = {
                    loc = vector3(-391.87,4361.73,58.43-1),
                    h = 187.067,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(-389.56,4344.97,56.71-1),
                    h = 286.16
               }
          }
     },

     [9] = {

          point = {
               posIlegal = vector3(-1806.59,3099.59,32.85)
          },

          peds = {
               s_m_y_blackops_03 = {
                    animation = false,
                    loc = vector3(-1803.13,3100.89,32.85-1),
                    h = 210.931,
                    weapon = "weapon_assaultrifle"
               },
               s_m_y_blackops_01 = {
                    animation = false,
                    loc = vector3(-1806.05,3100.66,32.85-1),
                    h = 212.404,
                    weapon = "weapon_assaultrifle"
               },
               s_m_y_marine_03 = {
                    animation = false,
                    loc = vector3(1803.53,3102.76,32.85-1),
                    h = 210.737,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               crusader = {
                    loc = vector3(-1809.41,3101.02,32.85-1),
                    h = 56.31,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(-1806.59,3099.59,32.85-1),
                    h = 286.16
               }
          }
     },
     
     [10] = {

          point = {
               posIlegal = vector3(2245.34,5592.52,53.65)
          },

          peds = {
               csb_prolsec = {
                    animation = false,
                    loc = vector3(2257.67,5602.46,53.8-1),
                    h = 161.95,
                    weapon = "weapon_assaultrifle"
               },
               s_m_m_armoured_01 = {
                    animation = false,
                    loc = vector3(2261.84,5605.87,54.32-1),
                    h = 165.87,
                    weapon = "weapon_assaultrifle"
               },
               s_m_m_armoured_02 = {
                    animation = false,
                    loc = vector3(2254.57,5605.27,53.64-1),
                    h = 165.87,
                    weapon = "weapon_compactrifle"
               }
          },

          vehicles = {
               stockade = {
                    loc = vector3(2245.91,5598.75,53.79-1),
                    h = 359.031,
                    Ldoor = false,
                    Rdoor = false,
                    TLdoor = false,
                    TRdoor = false,
                    Pdoor = true
               }

          },

          objects = {
               prop_box_wood02a ={
                    loc = vector3(2245.34,5592.52,53.65-1),
                    h = 286.16
               }
          }
     }




--<-- Loc 7 -->
--
--
--Boss 1082.92,3006.91,41.23 == 279.941 s_m_m_pilot_01
--
--Soldado1 1079.65,3003.5,41.37 == 287.127 g_popov
--
--Soldado2 1078.34,3007.91,41.37 == 279.028 ig_stevehains
--
--cuban800 1071.17,3003.82,42.29 == 282.822
--
--caixa 1079.82,3009.79,41.3
--
--<-- Loc 8 -->
--
--Boss 2376.29,2564.59,46.67 == 277.351 a_m_y_hippy_01
--
--Soldado1 2373.34,2565.97,46.67 == 281.2525 u_m_y_hippie_01
--
--Soldado2 2374.23,2562.57,46.67 == 274.5442 a_f_y_hippie_01
--
--
--surfer 22373.59,2570.98,48.47 == 10.598
--
--caixa 2375.78,2569.04,46.67
--
--<-- Loc 9 -->
--
--Boss -2269.41,3446.98,31.62 == 89.33 a_m_m_hasjew_01 
--
--Soldado1 -2264.71,3444.36,31.67 == 90 s_m_m_highsec_0
--
--Soldado2   -2265.07,3451.28,31.37 == 95.010  s_m_m_highsec_02
--
--cognoscenti2 -2268.29,3457.62,32.77 == 324.080
--
--caixa -2270.79,3454.22,31.35
--
--<-- Loc 10-->
--
--Boss -1137.9,4924.4,220.14 == 261.6911 a_f_m_fatcult_01
--
--Soldado1 -1140.76,4928.12,220.41 == 260.964 a_m_o_acult_01
--
--Soldado2 -1141.45,4922.09,220.25 == 2644.824 a_m_y_acult_02
--
--bodhi2 -1133.5,4914.25,219.82 == 201.2477
--
--caixa -1135.36,4918.5,219.88




}



return amGcfg