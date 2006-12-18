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
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "esES" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Bufos que dan inmunidad temporal a los efectos de miedo
	["Buff"] = {
		"Custodia de miedo",			-- Dwarf priest racial trait
		"Voluntad de los Renegados.",		-- Forsaken racial trait
		"Audacia",				-- Trinket
		"Ira rabiosa",				-- Warrior Fury talent
		"Temeridad",				-- Warrior Fury talent
		"Deseo de la muerte",			-- Warrior Fury talent
		"C\195\179lera de las bestias",		-- Hunter Beast Mastery talent (pet only)
		"Bloqueo de hielo",			-- Mage Ice talent
		"Protecci\195\179n divina",		-- Paladin Holy buff
		"Escudo divino",			-- Paladin Holy buff
		"T\195\179tem de tremor",		-- Shaman totem
		"Suprimir magia"			-- Majordomo (NPC) spell
		--  "T\195\179tem derribador" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debufos y maldiciones que dan inmunidad temporal a los efectos de miedo
	["Debuff"] = {
		"Maldici\195\179n de Temeridad"		-- Warlock curse
	}
};

NECROSIS_UNIT = {
	["Undead"] = {
		"No-muerto"
	};
	["Demon"] = "Demon";
	["Elemental"] = "Elemental";
}

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "Your (.+) failed. (.+) is immune."

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar a corcel vil",			Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar a corcel nefasto",		Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar diablillo",			Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar a abisario",			Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar s\195\186cubo",			Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar man\195\161fago",		Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocar guardia maldito",		Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Inferno",				Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Desterrar",				Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Esclavizar demonio",			Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Resurrecci\195\179n con piedra de alma",		Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Inmolar",				Length = 15,	Type = 6},
	[13] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Miedo",					Length = 15,	Type = 6},
	[14] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Corrupci\195\179n",			Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Dominio de lo maldito",			Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldición del Apocalipsis",		Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sacrificio",				Length = 30,	Type = 3},
	[18] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fuego de alma",				Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Espiral de la muerte",			Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Quemadura de las Sombras",		Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Conflagrar",				Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de agon\195\173a",	Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de debilidads",	Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de temeridad",		Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de las Lenguas",	Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de los Elementos",	Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de las Sombras",	Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Drenar Vida",				Length = 30,	Type = 6},
	[29] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Aullido de terror",			Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual de Perdici\195\179n",		Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Armadura Demon\195\173aca",		Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Aliento inagotable",			Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invisibilidad",				Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ojo de Kilrogg",			Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Esclavizar demonio",				Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Piel de Demonio",			Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual de invocaci\195\179n",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Enlace de Alma",			Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sentir Demonios",			Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Maldici\195\179n de Agotamiento",	Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Trasfusi\195\179n de vida",		Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Amplificar maldici\195\179n",		Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Resguardo contra las Sombras",		Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sacrificio demon\195\173aco",		Length = 0,	Type = 0},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Descarga de las Sombras",		Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Aflicci\195\179n inestable",		Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Armadura vil",				Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Semilla de corrupci\195\179n",		Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Despedazar alma",			Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual de almas",			Length = 300,	Type = 3},
	[51] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Furia de las Sombras",			Length = 20,	Type = 3},
};
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Fragmento de Alma",
	["Soulstone"] = "Piedra de alma",
	["Healthstone"] = "Piedra de salud",
	["Spellstone"] = "Piedra de hechizo",
	["Firestone"] = "Piedra de fuego",
	["Ranged"] = "Varita",
	["Soulbound"] = "Se liga al equiparlo",
	["InfernalStone"] = "Piedra infernal",
	["DemoniacStone"] = "Figura demoniaca",
	["Hearthstone"] = "Piedra de hogar",
	["SoulPouch"] = {"Faltriquera de almas", "Bolsa de tela de inferi", "Bolsa de tela de inferi del n\195\186cleo"}
};


NECROSIS_STONE_RANK = {
	[1] = " (Menor)",	-- Rank Minor
	[2] = " (Inferior)",	-- Rank Lesser
	[3] = "",		-- Rank Intermediate, no name
	[4] = " (Superior)",	-- Rank Greater
	[5] = " (Sublime)",	-- Rank Major
	[6] = " (Master)",	-- Rank Master
};

NECROSIS_NIGHTFALL = {
	["BoltName"] = "Descarga",
	["ShadowTrance"] = "Trance de las Sombras"
};

NECROSIS_CREATE = {
	[1] = "Crear piedra de alma",
	[2] = "Crear piedra de salud",
	[3] = "Crear piedra de hechizos",
	[4] = "Crear pirorroca"
};

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Diablillo",
	[2] = "Abisario",
	[3] = "S\195\186cubo",
	[4] = "Man\195\161fago",
	[5] = "Guardia maldito",
	[6] = "Inferno",
	[7] = "Guardia apocal\195\173ptico"
};

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Tiempo de regeneraci\195\179n restante",
	["Hearth"] = "Piedra de hogar",
	["Rank"] = "Rango",
	["Invisible"] = "Detectar invisibilidad",
	["LesserInvisible"] = "Detectar invisibilidad inferior",
	["GreaterInvisible"] = "Detectar invisibilidad superior",
	["SoulLinkGain"] = "Ganas Enlace de Alma.",
	["SacrificeGain"] = "Ganas Sacrifio.",
};

end
