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
-- Version 04.12.2006-1
------------------------------------------------------------------------------------------------------




------------------------------------------------
-- Chinese Simplified VERSION FUNCTIONS--
--  2006/01/02
--  艾娜羅沙@奧妮克希亞/TW
------------------------------------------------

if ( GetLocale() == "zhCN" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"恐惧防护结界",			-- Dwarf priest racial trait
		"亡灵意志",		-- Forsaken racial trait
		"反恐惧",			-- Trinket
		"狂怒",		-- Warrior Fury talent
		"鲁莽",			-- Warrior Fury talent
		"死亡之愿",			-- Warrior Fury talent
		"狂野怒火",		-- Hunter Beast Mastery talent (pet only)
		"寒冰屏障",			-- Mage Ice talent
		"圣佑术",		-- Paladin Holy buff
		"圣盾术",		-- Paladin Holy buff
		"战栗图腾",			-- Shaman totem
		"废除魔法"			-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"鲁莽诅咒"		-- Warlock curse
	}
}

NECROSIS_ANTI_FEAR_UNIT = {
	["Undead"] = {
		"亡灵",
	},
	["Demon"] = "恶魔",
	["Elemental"] = "元素"
}

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤地狱战马",		Length = 0,	Type = 0,	TexturePrefix = nil},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤恐惧战马",		Length = 0,	Type = 0,	TexturePrefix = nil},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤小鬼",		Length = 0,	Type = 0,	TexturePrefix = "Imp"},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤虚空行者",		Length = 0,	Type = 0,	TexturePrefix = "Voidwalker"},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤魅魔",		Length = 0,	Type = 0,	TexturePrefix = "Succubus"},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤地狱猎犬",		Length = 0,	Type = 0,	TexturePrefix = "Felhunter"},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影箭",			Length = 0,	Type = 0,	TexturePrefix = nil},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "地狱火",			Length = 3600,	Type = 3,	TexturePrefix = "Infernal"},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "放逐术",			Length = 30,	Type = 2,	TexturePrefix = "Banish"},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "奴役恶魔",		Length = 3000,	Type = 2,	TexturePrefix = nil},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "灵魂石复活",		Length = 1800,	Type = 1,	TexturePrefix = nil},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "献祭",			Length = 15,	Type = 5,	TexturePrefix = nil},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恐惧术",			Length = 15,	Type = 5,	TexturePrefix = nil},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "腐蚀术",			Length = 17,	Type = 5,	TexturePrefix = nil},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恶魔支配",		Length = 900,	Type = 3,	TexturePrefix = "Domination"},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "厄运诅咒",		Length = 60,	Type = 3,	TexturePrefix = "Doom"},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "牺牲",			Length = 30,	Type = 3,	TexturePrefix = nil},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "灵魂之火",		Length = 60,	Type = 3,	TexturePrefix = nil},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "死亡缠绕",		Length = 120,	Type = 3,	TexturePrefix = nil},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影灼烧",		Length = 15,	Type = 3,	TexturePrefix = nil},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "燃烧",			Length = 10,	Type = 3,	TexturePrefix = nil},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "痛苦诅咒",		Length = 24,	Type = 4,	TexturePrefix = "Agony"},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "虚弱诅咒",		Length = 120,	Type = 4,	TexturePrefix = "Weakness"},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "鲁莽诅咒",		Length = 120,	Type = 4,	TexturePrefix = "Reckless"},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "语言诅咒",		Length = 30,	Type = 4,	TexturePrefix = "Tongues"},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "元素诅咒",		Length = 300,	Type = 4,	TexturePrefix = "Elements"},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "暗影诅咒",		Length = 300,	Type = 4,	TexturePrefix = "Shadow"},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "生命虹吸",		Length = 30,	Type = 5,	TexturePrefix = nil},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恐惧嚎叫",		Length = 40,	Type = 3,	TexturePrefix = nil},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "末日仪式",		Length = 3600,	Type = 0,	TexturePrefix = "Doomguard"},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔甲术",			Length = 0,	Type = 0,	TexturePrefix = "ArmureDemo"},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔息术",		Length = 0,		Type = 0,	TexturePrefix = "Aqua"},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "隐形",			Length = 0,	Type = 0,	TexturePrefix = "Invisible"},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "基尔罗格之眼",		Length = 0,	Type = 0,	TexturePrefix = "Kilrogg"},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "奴役恶魔",		Length = 0,	Type = 0,	TexturePrefix = "Enslave"},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恶魔皮肤",		Length = 0,	Type = 0,	TexturePrefix = nil},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "召唤仪式",		Length = 0,	Type = 0,	TexturePrefix = nil},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "灵魂链接",		Length = 0,	Type = 0,	TexturePrefix = "Lien"},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "感知恶魔",		Length = 0,	Type = 0,	TexturePrefix = "Radar"},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "疲劳诅咒",		Length = 12,	Type = 4,	TexturePrefix = "Exhaust"},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "生命分流",		Length = 0,	Type = 0,	TexturePrefix = nil},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "诅咒增幅",		Length = 180,	Type = 3,	TexturePrefix = "Amplify"},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "防护暗影结界",		Length = 30,	Type = 3,	TexturePrefix = "ShadowWard"},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "恶魔牺牲",		Length = 0,	Type = 0,	TexturePrefix = "Sacrifice"},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "暗影箭",			Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "痛苦动荡",	Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "狱甲术",		Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "腐蚀种子",	Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "灵魂",		Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "灵魂典礼",	Length = 300,	Type = 3},
	[51] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "灵魂石",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "治疗石",		Length = 0,	Type = 0},
	[53] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "法术石",		Length = 0,	Type = 0},
	[54] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "火焰石",		Length = 0,	Type = 0},
}

-- Type 0 = No Timer
-- Type 1 = Main permanent Timer
-- Type 2 = Permanent Timer
-- Type 3 = Timer of cooldown
-- Type 4 = Timer of maldiction
-- Type 5 = Timer of fight
-- Type 6 = Timer of combat

NECROSIS_ITEM = {
	["Soulshard"] = "灵魂碎片",
	["Soulstone"] = "灵魂石",
	["Healthstone"] = "治疗石",
	["Spellstone"] = "法术石",
	["Firestone"] = "火焰石",
	["Offhand"] = "装备在副手",
	["Twohand"] = "双手",
	["InfernalStone"] = "地狱火石",
	["DemoniacStone"] = "恶魔雕像",
	["Hearthstone"] = "炉石",
	["SoulPouch"] = {"灵魂袋", "恶魔布包", "熔火恶魔布包"}
}


NECROSIS_NIGHTFALL = {
	["Backlash"] = "反冲",
	["ShadowTrance"] = "暗影冥思"
}

NECROSIS_PET_LOCAL_NAME = {
	[1] = "小鬼",
	[2] = "虚空行者",
	[3] = "魅魔",
	[4] = "地狱猎犬",
	[5] = "地狱火",
	[6] = "末日守卫",
	[7] = "厄运守卫"
}

NECROSIS_TRANSLATION = {
	["Cooldown"] = "冷却时间",
	["Hearth"] = "炉石",
	["Rank"] = "等级",
	["Create"] = ""
}

end
