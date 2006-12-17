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
-- Version 08.12.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_Es()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_Es()
	end

	NECROSIS_COOLDOWN = {
		["SpellstoneIn"] = "Spellstone equiped",
		["Spellstone"] = "Spellstone Cooldown",
		["Healthstone"] = "Healthstone Cooldown"
	}

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Yes",
				[false] = "No",
			},
			Hellspawn = {
				[true] = "On",
				[false] = "Off",
			},
			["Soulshard"] = "Soul Shard(s): ",
			["InfernalStone"] = "Infernal Stone(s): ",
			["DemoniacStone"] = "Demonic Figurine(s): ",
			["Soulstone"] = "\nSoulstone: ",
			["Healthstone"] = "Healthstone: ",
			["Spellstone"] = "Spellstone: ",
			["Firestone"] = "Firestone: ",
			["CurrentDemon"] = "Demon: ",
			["EnslavedDemon"] = "Demon: Enslaved",
			["NoCurrentDemon"] = "Demon: None",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"Right click to create","Left click to use","Used\nRight click to recreate","Waiting"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Healthstone|r",
			Text = {"Right click to create","Left click to use"},
			Text2 = "Middle click or Ctrl+left click to trade",
			Ritual = "|c00FFFFFFShift+Click to cast the Ritual of Souls|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFFPiedra de hechizo|r",
			Text = {"Right click to create","In Inventory\nMiddle click or Ctrl+left click to equip","Held in hand\nLeft click to user\nShift+clic to unequip"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Pirorroca|r",
			Text = {"Right click to create","In Inventory\nLeft click to equip","Held in hand\nShift+clic to unequip"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpell Durations|r",
			Text = "Active Spells on the target",
			Right = "Right click for Hearthstone to "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFShadow Trance|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFFBacklash|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFFel Domination|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFEnslave|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFDemon Armor|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFFFel Armor|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFDetect Invisibility|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFUnending Breath|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFEye of Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFDesterrar|r",
			Text = "Right click to cast Rank 1"
		},
		["TP"] = {
			Label = "|c00FFFFFFRitual of Summoning|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFSoul Link|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFShadow Ward|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFImp|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFFVoidwalker|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSuccubus|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFFMan\195\161fago|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFFelguard|r"
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
			Text = "Right click to cast Rank 1"
		},
		["Buff"] = {
			Label = "|c00FFFFFFMen\195\186 de Hechizos|r",
			Text = "Click Derecho para mantener el men\195\186 abierto"
		},
		["Pet"] = {
			Label = "|c00FFFFFFMen\195\186 de Demonio|r",
			Text = "Click Derecho para mantener el men\195\186 abierto"
		},
		["Curse"] = {
			Label = "|c00FFFFFFMen\195\186 de Maldici\195\179n|r",
			Text = "Click Derecho para mantener el men\195\186 abierto"
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
			"/necro recall -- Centrar Necrosis y todos los botones en el medio de la pantalla",
			"/necro sm -- Reemplazar los mensajes de Piedra de Alma e invocaci\195\179n por una versi\195\179n breve para Banda"
		},
		["Information"] = {
			["FearProtect"] = "\194\161\194\161\194\161 Tu objetivo tiene una protecci\195\179n contra miedo !!!!",
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
		["X"] = "X"
	};

	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Opciones de Fragmento",
		["Menu2"] = "Opciones de Mensaje",
		["Menu3"] = "Opciones de Bot\195\179n",
		["Menu4"] = "Opciones de Temporizador",
		["Menu5"] = "Opci\195\179nes Gr\195\161ficas",
		["MainRotation"] = "Selecci\195\179n de \195\161ngulo de Necrosis",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFnt|CFFFF99FFa|CFFFF50FFr|CFFFF00FFi|CFFB700B7o :",
		["ShardMenu2"] = "|CFFB700B7F|CFFFF00FFr|CFFFF50FFa|CFFFF99FFg|CFFFFC4FFme|CFFFF99FFn|CFFFF50FFt|CFFFF00FFo|CFFB700B7s :",
		["ShardMove"] = "Poner los Fragmentos en la bolsa seleccionada.",
		["ShardDestroy"] = "Destruir nuevos fragmentos si la bolsa est\195\161 llena",
		["SpellMenu1"] = "|CFFFF00FFH|CFFFF50FFe|CFFFF99FFc|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFz|CFFFF00FFo|CFFB700B7s :",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFu|CFFFF50FFg|CFFFF99FFa|CFFFFC4FFd|CFFFF99FFo|CFFB700B7r :",
		["TimerMenu"] = "|CFFB700B7T|CFFFF00FFe|CFFFF50FFm|CFFFF99FFp|CFFFFC4FFo|CFFFF99FFr|CFFFF50FFi|CFFFF00FFz|CFFB700B7ad|CFFFF00FFo|CFFFF50FFr|CFFFF99FFe|CFFFFC4FFs :",
		["TimerColor"] = "Textos de temporizador blancos en vez de amarillos",
		["TimerDirection"] = "Los temporizadores se incrementan ascendentemente",
		["TranseWarning"] = "Al\195\169rtame cuando entre en un Trance de las Sombras",
		["SpellTime"] = "Activar los indicadores de la duraci\195\179n de los hechizos",
		["AntiFearWarning"] = "Prevenme cuando mi objetivo no pueda ser asustado",
		["GraphicalTimer"] = "Mostrar temporizadores gr\195\161ficos en lugar de textos",
		["TranceButtonView"] = "Perm\195\173teme ver los botones ocultos para arrastrarlos.",
		["ButtonLock"] = "Bloquear los botones alrededor de la Esfera Necrosis.",
		["MainLock"] = "Bloquear los botones y la Esfera Necrosis.",
		["BagSelect"] = "Selecci\195\179n de Contenedor de Fragmentos de Alma",
		["BuffMenu"] = "Poner el men\195\186 de bufos a la izquierda",
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
		["TranseSize"] = "Tama\195\177o de los hidden botones",
		["Skin"] = "Piel de la Esfera Necrosis",
		["Show"] = {
			["Firestone"] = "Mostrar bot\195\179n Pirorroca",
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
		["Current"] = " is currently bound to ",
		["Confirm"] = "Do you want to bind ",
		["To"] = " to ",
		["Yes"] = "Yes",
		["No"] = "No",
		["InCombat"] = "Sorry, you can't change key bindings while in combat.",
		["Binding"] = "Bindings",
		["Unbind"] = "Unbind",
		["Cancel"] = "Cancel",
		["Press"] = "Press a key to bind...\n\n",
		["Now"] = "Currently: ",
		["NotBound"] = "Not Bound",
	};

end
