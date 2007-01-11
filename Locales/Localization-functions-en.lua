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
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Fear Ward",			-- Dwarf priest racial trait
		"Will of the Forsaken",		-- Forsaken racial trait
		"Fearless",			-- Trinket
		"Berzerker Rage",		-- Warrior Fury talent
		"Recklessness",			-- Warrior Fury talent
		"Death Wish",			-- Warrior Fury talent
		"Bestial Wrath",		-- Hunter Beast Mastery talent (pet only)
		"Ice Block",			-- Mage Ice talent
		"Divine Protection",		-- Paladin Holy buff
		"Divine Shield",		-- Paladin Holy buff
		"Tremor Totem",			-- Shaman totem
		"Abolish Magic"			-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Curse of Recklessness"		-- Warlock curse
	}
}

NECROSIS_UNIT = {
	["Undead"] = {
		"Undead"
	},
	["Demon"] = "Demon",
	["Elemental"] = "Elemental"
}

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "Your (.+) failed. (.+) is immune."

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Felsteed",		Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Dreadsteed",		Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Imp",			Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Voidwalker",		Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Succubus",		Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Felhunter",		Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Summon Felguard",		Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Inferno",			Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Banish",			Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Enslave Demon",			Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Soulstone Resurrection",	Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Immolate",			Length = 15,	Type = 6},
	[13] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fear",				Length = 15,	Type = 6},
	[14] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Corruption",			Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fel Domination",		Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Doom",			Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Shadowfury",			Length = 20,	Type = 3},
	[18] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Soul Fire",			Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Death Coil",			Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Shadowburn",			Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Conflagrate",			Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Agony",		Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Weakness",		Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Recklessness",		Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Tongues",		Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of the Elements",		Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Shadow",		Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Siphon Life",			Length = 30,	Type = 6},
	[29] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Howl of Terror",		Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual of Doom",		Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Demon Armor",			Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Unending Breath",		Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Detect Invisibility",			Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Eye of Kilrogg",		Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Enslave Demon",			Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Demon Skin",			Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual of Summoning",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Soul Link",			Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sense Demons",			Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Curse of Exhaustion",		Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Life Tap",			Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Amplify Curse",			Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Shadow Ward",			Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Demonic Sacrifice",		Length = 0,	Type = 0},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Shadow Bolt",			Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Unstable Affliction",		Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Fel Armor",			Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Seed of Corruption",		Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Soulshatter",			Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Ritual of Souls",		Length = 300,	Type = 3},
	[51] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Create Soulstone",	Length = 0,		Type = 0},
	[52] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Create Healthstone",		Length = 0,	Type = 0},
	[53] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Create Spellstone",		Length = 0,	Type = 0},
	[54] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Create Firestone",		Length = 0,	Type = 0},
}
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Soul Shard",
	["Soulstone"] = "Soulstone",
	["Healthstone"] = "Healthstone",
	["Spellstone"] = "Spellstone",
	["Firestone"] = "Firestone",
	["Ranged"] = "Wand",
	["Soulbound"] = "Soulbound",
	["InfernalStone"] = "Infernal Stone",
	["DemoniacStone"] = "Demonic Figurine",
	["Hearthstone"] = "Hearthstone",
	["SoulPouch"] = {"Soul Pouch", "Felcloth Bag", "Core Felcloth Bag"}
}


NECROSIS_NIGHTFALL = {
	["Backlash"] = "Backlash",
	["ShadowTrance"] = "Shadow Trance"
}

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Imp",
	[2] = "Voidwalker",
	[3] = "Succubus",
	[4] = "Felhunter",
	[5] = "Felguard",
	[6] = "Inferno",
	[7] = "Doomguard"
}

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Hearth"] = "Hearthstone",
	["Rank"] = "Rank",
	["Create"] = "Create"
}

end
