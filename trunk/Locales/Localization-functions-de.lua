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
-- Version 07.12.2006-1
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- GERMAN  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "deDE" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs die temporäre Immunität gegenüber Furcht geben
	["Buff"] = {
		"Furchtzauberschutz",		-- Dwarf priest racial trait
		"Wille der Verlassenen",	-- Forsaken racial trait
		"Furchtlos",			-- Trinket
		"Berserkerwut",			-- Warrior Fury talent
		"Tollk\195\188hnheit",		-- Warrior Fury talent
		"Todeswunsch",			-- Warrior Fury talent
		"Zorn des Wildtieres",		-- Hunter Beast Mastery talent (pet only)
		"Eisblock",			-- Mage Ice talent
		"G\195\182ttlicher Schutz",	-- Paladin Holy buff
		"Gottesschild",			-- Paladin Holy buff
		"Totem des Erdsto\195\159es",	-- Shaman totem
		"Abolish Magic"			-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Fluch der Tollk\195\188hnheit"		-- Warlock curse
	}
};

NECROSIS_UNIT = {
	["Undead"] = {
		"Untoter"
	};
	["Demon"] = "D\195\164mon";
	["Elemental"] = "Elementar";
}

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "(.+) war ein Fehlschlag. (.+) ist immun."

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Teufelsross beschw\195\182ren",		Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schreckensross herbeirufen",		Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Wichtel beschw\195\182ren",		Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Leerwandler beschw\195\182ren",		Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sukkubus beschw\195\182ren",		Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Teufelsj\195\164ger beschw\195\182ren",	Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Teufelswache beschw\195\182ren",	Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Inferno",				Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Verbannen",				Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monensklave",			Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Seelenstein-Auferstehung",		Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Feuerbrand",				Length = 15,	Type = 6},
	[13] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Furcht",				Length = 15,	Type = 6},
	[14] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Verderbnis",				Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Teufelsbeherrschung",			Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Verdammnis",			Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schattenfurie",				Length = 20,	Type = 3},
	[18] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Seelenfeuer",				Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Todesmantel",				Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schattenbrand",				Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Feuersbrunst",				Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Pein",			Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Schw\195\164che",		Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Tollk\195\188hnheit",		Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Sprachen",			Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Elemente",			Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Schatten",			Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Lebensentzug",				Length = 30,	Type = 6},
	[29] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schreckengeh\195\164ul",		Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual der Verdammnis",			Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monenr\195\188stung",		Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Unendlicher Atem",			Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Unsichtbarkeit entdecken",			Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Auge von Kilrogg",			Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monensklave",			Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monenhaut",			Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual der Beschw\195\182rung",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Seelenverbindung",			Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monen sp\195\188ren",		Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch der Ersch\195\182pfung",		Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Aderlass",				Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fluch verst\195\164rken",		Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schattenzauberschutz",			Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\164monische Opferung",		Length = 0,	Type = 0},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Schattenblitz",				Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Instabiles Gebrechen",			Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Teufelsr\195\188stung",			Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Saat der Verderbnis",			Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Seele brechen",				Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual der Seelen",			Length = 300,	Type = 3},
};
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Seelensplitter",
	["Soulstone"] = "Seelenstein",
	["Healthstone"] = "Gesundheitsstein",
	["Spellstone"] = "Zauberstein",
	["Firestone"] = "Feuerstein",
	["Ranged"] = "Zauberstab",
	["Soulbound"] = "Soulbound",
	["InfernalStone"] = "H\195\182llenstein",
	["DemoniacStone"] = "D\195\164monenstatuette",
	["Hearthstone"] = "Ruhestein",
	["SoulPouch"] = {"Seelenbeutel", "Teufelsstofftasche", "Kernteufelsstofftasche"}
};


NECROSIS_STONE_RANK = {
	[1] = "schwach",	-- Rank Minor
	[2] = "gering",	-- Rank Lesser
	[3] = "Lomig ist schön",		-- Rank Intermediate, no name
	[4] = "gro\195\159",	-- Rank Greater
	[5] = "erheblich",	-- Rank Major
	[6] = "meisterlich",	-- Rank Master
};

NECROSIS_NIGHTFALL = {
	["Backlash"] = "Heimzahlen",
	["ShadowTrance"] = "Schattentrance"
};

NECROSIS_CREATE = {
	[1] = "Seelenstein herstellen",
	[2] = "Gesundheitsstein herstellen",
	[3] = "Zauberstein herstellen",
	[4] = "Feuerstein herstellen"
};

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Wichtel",
	[2] = "Leerwandler",
	[3] = "Sukkubus",
	[4] = "Teufelsj\195\164ger",
	[5] = "Teufelswache",
	[6] = "H\195\182llenbestie",
	[7] = "Verdammniswache"
};

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Hearth"] = "Ruhestein",
	["Rank"] = "Rang",
	["SoulLinkGain"] = "Du bekommst Seelenverbindung.",
};

end
