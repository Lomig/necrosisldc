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
-- Version Allemande par Geschan
-- Remerciements spéciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- VERSION FRANCAISE DES FONCTIONS --
------------------------------------------------

if ( GetLocale() == "frFR" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Gardien de peur",				-- Dwarf priest racial trait
		"Volont\195\169 des r\195\169prouv\195\169",	-- Forsaken racial trait
		"Sans peur",					-- Trinket
		"Furie Berzerker",				-- Warrior Fury talent
		"T\195\169m\195\169rit\195\169",		-- Warrior Fury talent
		"Souhait mortel",				-- Warrior Fury talent
		"Courroux bestial",				-- Hunter Beast Mastery talent (pet only)
		"Carapace de glace",				-- Mage Ice talent
		"Protection divine",				-- Paladin Holy buff
		"Bouclier divin",				-- Paladin Holy buff
		"Totem de s\195\169isme",			-- Shaman totem
		"Abolir la magie"				-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Mal\195\169diction de t\195\169m\195\169rit\195\169"		-- Warlock curse
	}
}

NECROSIS_UNIT = {
	["Undead"] = {
		"Mort-vivant"
	},
	["Demon"] = "D\195\169mon",
	["Elemental"] = "El\195\169mentaire",
}

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un palefroi corrompu",			Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un destrier de l'effroi",			Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un diablotin",				Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un marcheur du Vide",			Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'une succube",				Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un chasseur corrompu",			Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Invocation d'un gangregarde",				Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Inferno",						Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Bannir",						Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Asservir d\195\169mon",					Length = 3000,	Type = 2},
	[11] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "R\195\169surrection de Pierre d'\195\162me",		Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Immolation",						Length = 15,	Type = 6},
	[13] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Peur",							Length = 15,	Type = 6},
	[14] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Corruption",						Length = 17,	Type = 5},
	[15] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Domination corrompue",					Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction funeste",				Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Furie de l'ombre",					Length = 20,	Type = 3},
	[18] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Feu de l'\195\162me",					Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Voile mortel",						Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Br\195\187lure de l'ombre",				Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Conflagration",						Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction d'agonie",				Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de faiblesse",			Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de t\195\169m\195\169rit\195\169",	Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction des langages",			Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction des \195\169l\195\169ments",		Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de l'ombre",				Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Siphon de vie",						Length = 30,	Type = 6},
	[29] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Hurlement de terreur",					Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Rituel de mal\195\169diction",				Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Armure d\195\169moniaque",				Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Respiration interminable",				Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\169tection de l'invisibilit\195\169",		Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Oeil de Kilrogg",					Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Asservir d\195\169mon",					Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Peau de d\195\169mon",					Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Rituel d'invocation",					Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Lien spirituel",					Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "D\195\169tection des d\195\169mons",			Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction de fatigue",				Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Connexion",						Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Mal\195\169diction amplifi\195\169e",			Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Gardien de l'ombre",					Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Sacrifice d\195\169moniaque",				Length = 0,	Type = 0},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Trait de l'ombre",					Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Affliction instable",					Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Gangrarmure",						Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Graine de Corruption",					Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Brise-\195\162me",					Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Rituel des \195\162mes",				Length = 300,	Type = 3},
	[51] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Cr\195\169ation de Pierre d'\195\162me",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Cr\195\169ation de Pierre de soins",			Length = 0,	Type = 0},
	[53] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Cr\195\169ation de Pierre de sort",			Length = 0,	Type = 0},
	[54] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "Cr\195\169ation de Pierre de feu",			Length = 0,	Type = 0},
}
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "Fragment d'\195\162me",
	["Soulstone"] = "Pierre d'\195\162me",
	["Healthstone"] = "Pierre de soins",
	["Spellstone"] = "Pierre de sort",
	["Firestone"] = "Pierre de feu",
	["Ranged"] = "Baguette",
	["Soulbound"] = "Li\195\169",
	["InfernalStone"] = "Pierre infernale",
	["DemoniacStone"] = "Figurine d\195\169moniaque",
	["Hearthstone"] = "Pierre de foyer",
	["SoulPouch"] = {"Bourse d'\195\162me", "Sac en gangr\195\169toffe", "Sac en gangr\195\169toffe du Magma"}
}

NECROSIS_NIGHTFALL = {
	["Backlash"] = "Contrecoup",
	["ShadowTrance"] = "Transe de l'ombre",
}

NECROSIS_PET_LOCAL_NAME = {
	[1] = "Diablotin",
	[2] = "Marcheur du Vide",
	[3] = "Succube",
	[4] = "Chasseur corrompu",
	[5] = "Gangregarde",
	[6] = "Infernal",
	[7] = "Garde funeste"
}

NECROSIS_TRANSLATION = {
	["Cooldown"] = "Temps",
	["Hearth"] = "Pierre de foyer",
	["Rank"] = "Rang",
	["Create"] = "Cr\195\169ation"
}

end
