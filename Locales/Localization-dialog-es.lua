--[[
    Necrosis LdC
    Copyright (C) 2005-2006  Lom Enfroy

    This file is part of Necrosis LdC.

    NecrosisLdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]


------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig, Liadora et Nyx (Kael'Thas et Elune)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements spéciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_Es()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_Es()
	end

	NECROSIS_COOLDOWN = {
		["SpellstoneIn"] = "Piedra de Hechizo equipada",
		["Spellstone"] = "Tiempo de regeneraci\195\179n Piedra de Hechizo",
		["Healthstone"] = "Tiempo de regeneraci\195\179n Piedra de Salud"
	}

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "S\195\173",
				[false] = "No",
			},
			Hellspawn = {
				[true] = "On",
				[false] = "Off",
			},
			["Soulshard"] = "Fragmento(s) de Alma: ",
			["InfernalStone"] = "Piedra(s) Infernal(es): ",
			["DemoniacStone"] = "Figura(s) Demoníaca(s): ",
			["Soulstone"] = "\nPiedra de Alma: ",
			["Healthstone"] = "Piedra de Salud: ",
			["Spellstone"] = "Piedra de Hechizo: ",
			["Firestone"] = "Piedra de Fuego: ",
			["CurrentDemon"] = "Demonio: ",
			["EnslavedDemon"] = "Demonio: Esclavizado ",
			["NoCurrentDemon"] = "Demonio: Ninguno",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFPiedra de Alma|r",
			Text = {"Click derecho para crear","Click izquierdo para usar","Usada\nClick derecho para recrear","Esperando"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Piedra de Salud|r",
			Text = {"Click derecho para crear","Click izquierdo para usar"},
			Text2 = "Click central o Ctrl+Click izquierdo para comerciar",
			Ritual = "|c00FFFFFFShift+Click para empezar el Ritual de Almas|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFFPiedra de Hechizo|r",
			Text = {"Click derecho para crear","En el inventario\nClick central o Ctrl+Click izquierdo para equipar ","Equipado - Click izquierdo para usar\n Shift+Click para desequipar"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Piedra de Fuego|r",
			Text = {"Click derecho para crear","En el inventario\nClick izquierdo para equipar","Equipado - Shift+Click para desequipar"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFDuración de Hechizos|r",
			Text = "Hechizos activos en el objetivo",
			Right = "Click derecho para usar Piedra de Hogar a "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFTrance de las Sombras|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFFBacklash|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFDominio de lo Maldito|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFEsclavizar|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFArmadura Demon\195\173aca|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFFFel Armor|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFDetectar Invisibilidad|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFAliento Inagotable|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFOjo de Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFDesterrar|r",
			Text = "Click derecho para lanzar Rango 1"
		},
		["TP"] = {
			Label = "|c00FFFFFFRitual de Invocaci\195\179n|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFEnlace de Alma|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFResguardo contra las Sombras|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFDiablillo|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFFAbisario|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFS\195\186cubo|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFFMan\195\161fago|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFGuardia maldito|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFInferno|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFGuardia Apocal\195\173ptico|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFSacrificio Demon\195\173aco|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFAmplificar Maldici\195\179n|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFMaldici\195\179n de Debilidad|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFMaldici\195\179n de Agon\195\173a|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFMaldici\195\179n de la Temeridad|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFMaldici\195\179n de la Lengua|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFMaldici\195\179n de Agotamiento|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFMaldici\195\179n de los Elementos|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFMaldici\195\179n de las Sombras|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFMaldici\195\179n del Apocalipsis|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFCorcel|r",
			Text = "Click derecho para lanzar Rango 1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFFMen\195\186 de Hechizos|r",
			Text = "Click Derecho para mantener el men\195\186 abierto",
			Text2 = "Modo automático: Se cierra cuando sales de combate",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFFMen\195\186 de Demonio|r",
			Text = "Click Derecho para mantener el men\195\186 abierto",
			Text2 = "Modo automático: Se cierra cuando sales de combate",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFFMen\195\186 de Maldici\195\179n|r",
			Text = "Click Derecho para mantener el men\195\186 abierto",
			Text2 = "Modo automático: Se cierra cuando sales de combate",
		},
		["Radar"] = {
			Label = "|c00FFFFFFCaptar Demonios|r"
		},
		["AmplifyCooldown"] = "Click Derecho para amplificar maldici\195\179n",
		["DominationCooldown"] = "Click Derecho para invocaci\195\179n r\195\161pida",
	};

	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-Fr.mp3",
	};

	NECROSIS_PROC_TEXT = {
		["ShadowTrance"] = "<white>Tr<lightPurple1>a<lightPurple2>n<purple>c<darkPurple1>e<darkPurple2> de las S<darkPurple1>o<purple>m<lightPurple2>b<lightPurple1>r<white>as",
		["Backlash"] = "<white>B<lightPurple1>a<lightPurple2>c<purple>k<darkPurple1>l<darkPurple2>a<darkPurple1>s<purple>h"
	};


	NECROSIS_MESSAGE = {
		["Bag"] = {
			["FullPrefix"] = "\194\161 Tu ",
			["FullSuffix"] = " est\195\161 llena !",
			["FullDestroySuffix"] = " est\195\161 llena; \194\161 Los pr\195\179ximos Fragmentos de Alma ser\195\161n destruidos !",
			["SelectedPrefix"] = "Has seleccionado tu ",
			["SelectedSuffix"] = " para guardar tus fragmentos."
		},
		["Interface"] = {
			["Welcome"] = "<white>\194\161 /necro para mostrar el men\195\186 de preferencias !",
			["TooltipOn"] = "Consejos detallados activados" ,
			["TooltipOff"] = "Consejos detallados desactivados",
			["MessageOn"] = "Mensaje Chat activado",
			["MessageOff"] = "Mensaje Chat desactivado",
			["MessagePosition"] = "<- Los mensajes de Sistema de Necrosis aparecer\195\161n aqu\195\173 ->",
			["DefaultConfig"] = "<lightYellow>Configuraci\195\179n por defecto cargada.",
			["UserConfig"] = "<lightYellow>Configuraci\195\179n cargada."
		},
		["Help"] = {
			"/necro <lightOrange>recall<white> -- <lightBlue>Centrar Necrosis y todos los botones en el medio de la pantalla",
			"/necro <lightOrange>reset<white> -- <lightBlue>Reset Necrosis entirely",
			"/necro <lightOrange>sm<white> -- <lightBlue>Reemplazar los mensajes de Piedra de Alma e invocaci\195\179n por una versi\195\179n breve para Banda",
			"/necro <lightOrange>am<white> -- <lightBlue>Allows menus to be opened automatically when entering in combat",
			"/necro <lightOrange>bm<white> -- <lightBlue>Keep menus opened forever",
		},
		["Information"] = {
			["FearProtect"] = "\194\161\194\161\194\161 Tu objetivo tiene una protecci\195\179n contra miedo !!!",
			["EnslaveBreak"] = "Tu demonio rompi\195\179 sus cadenas...",
			["SoulstoneEnd"] = "<lightYellow>Tu Piedra de Alma se ha disipado."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "P\195\186rpura",
		["Blue"] = "Azul",
		["Pink"] = "Rosa",
		["Orange"] = "Naranja",
		["Turquoise"] = "Turquesa",
		["666"] = "666",
		["X"] = "X"
	};

	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Opciones de Fragmento",
		["Menu2"] = "Opciones de Mensaje",
		["Menu3"] = "Opciones de Bot\195\179n",
		["Menu4"] = "Opciones de Temporizador",
		["Menu5"] = "Opci\195\179nes Gr\195\161ficas",
		["MainRotation"] = "Selecci\195\179n de \195\161ngulo de Necrosis",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFnt|CFFFF99FFa|CFFFF50FFr|CFFFF00FFi|CFFB700B7o:",
		["ShardMenu2"] = "|CFFB700B7F|CFFFF00FFr|CFFFF50FFa|CFFFF99FFg|CFFFFC4FFme|CFFFF99FFn|CFFFF50FFt|CFFFF00FFo|CFFB700B7s:",
		["ShardMove"] = "Poner los Fragmentos en la bolsa seleccionada.",
		["ShardDestroy"] = "Destruir nuevos fragmentos si la bolsa est\195\161 llena",
		["SpellMenu1"] = "|CFFFF00FFH|CFFFF50FFe|CFFFF99FFc|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFz|CFFFF00FFo|CFFB700B7s:",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFu|CFFFF50FFg|CFFFF99FFa|CFFFFC4FFd|CFFFF99FFo|CFFB700B7r:",
		["TimerMenu"] = "|CFFB700B7T|CFFFF00FFe|CFFFF50FFm|CFFFF99FFp|CFFFFC4FFo|CFFFF99FFr|CFFFF50FFi|CFFFF00FFz|CFFB700B7ad|CFFFF00FFo|CFFFF50FFr|CFFFF99FFe|CFFFFC4FFs:",
		["TimerColor"] = "Textos de temporizador blancos en vez de amarillos",
		["TimerDirection"] = "Los temporizadores se incrementan ascendentemente",
		["TranseWarning"] = "Al\195\169rtame cuando entre en un Trance de las Sombras",
		["SpellTime"] = "Show the Spell Timer Button",
		["AntiFearWarning"] = "Av\195\173same cuando mi objetivo no pueda ser asustado",
		["GraphicalTimer"] = "Activar los indicadores de la duraci\195\179n de los hechizos",
		["TranceButtonView"] = "Perm\195\173teme ver los botones ocultos para arrastrarlos.",
		["ButtonLock"] = "Bloquear los botones alrededor de la Esfera Necrosis.",
		["MainLock"] = "Bloquear los botones y la Esfera Necrosis.",
		["BagSelect"] = "Selecci\195\179n de Contenedor de Fragmentos de Alma",
		["BuffMenu"] = "Poner el men\195\186 de hechizos a la izquierda",
		["PetMenu"] = "Poner el men\195\186 de mascota a la izquierda",
		["CurseMenu"] = "Poner el men\195\186 de maldici\195\179n a la izquierda",
		["STimerLeft"] = "Mostrar los temporizadores a la izquierda del bot\195\179n",
		["ShowCount"] = "Mostrar la contabilizaci\195\179n de Fragmentos Necrosis",
		["CountType"] = "Contabilizar el tipo de Piedra",
		["Circle"] = "Evento mostrado en la esfera gr\195\161fica",
		["Sound"] = "Activar sonidos",
		["ShowMessage"] = "Activar discursos aleatorios",
		["ShowDemonSummon"] = "Activar discursos aleatorios (demonio)",
		["ShowSteedSummon"] = "Activar discursos aleatorios (corcel)",
		["ChatType"] = "Mensajes de Necrosis como mensajes de sistema",
		["NecrosisSize"] = "Tama\195\177o del bot\195\179n Necrosis",
		["BanishSize"] = "Tama\195\177o del bot\195\179n Desterrar",
		["TranseSize"] = "Tama\195\177o de los botones de aviso",
		["Skin"] = "Piel de la Esfera Necrosis",
		["Show"] = {
			["Firestone"] = "Mostrar bot\195\179n Piedra de Fuego",
			["Spellstone"] = "Mostrar bot\195\179n Piedra de Hechizo",
			["Healthstone"] = "Mostrar bot\195\179n Piedra de Salud",
			["Soulstone"] = "Mostrar bot\195\179n Piedra de Alma",
			["Steed"] = "Mostrar bot\195\179n Corcel",
			["Buff"] = "Mostrar bot\195\179n del men\195\186 Hechizos",
			["Curse"] = "Mostrar bot\195\179n del men\195\186 Maldici\195\179n",
			["Demon"] = "Mostrar bot\195\179n del men\195\186 Demonio",
			["Tooltips"] = "Mostrar consejos detallados"
		},
		["Count"] = {
			["Shard"] = "Fragmentos de Alma",
			["Inferno"] = "Piedras de invocaci\195\179n de Demonio",
			["Rez"] = "Temporizador de Resurrecci\195\179n"
		}
	};

	NECROSIS_BINDING = {
		["Current"] = " est\195\161 actualmente asignado a ",
		["Confirm"] = "¿Quieres asignar ",
		["To"] = " a ",
		["Yes"] = "S\195\173",
		["No"] = "No",
		["InCombat"] = "Lo siento, no puedes cambiar la asignaci\195\179n de teclas mientras est\195\169s en combate.",
		["Binding"] = "Asignaciones",
		["Unbind"] = "Desasignar",
		["Cancel"] = "Cancelar",
		["Press"] = "Presiona la tecla a asignar...\n\n",
		["Now"] = "Actualmente: ",
		["NotBound"] = "No asignado",
	};

end
