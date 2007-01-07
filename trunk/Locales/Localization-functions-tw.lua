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
-- Version 04.12.2006-1
------------------------------------------------------------------------------------------------------




------------------------------------------------
-- Chinese Traditional VERSION FUNCTIONS      --
--  2007/01/02
--  艾娜羅沙@奧妮克希亞
------------------------------------------------

if ( GetLocale() == "zhTW" ) then

NECROSIS_ANTI_FEAR_SPELL = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"恐懼防護結界",	-- Dwarf priest racial trait
		"不死族意志",	-- Forsaken racial trait
		"反恐懼",	-- Trinket
		"狂怒",		-- Warrior Fury talent
		"魯莽",		-- Warrior Fury talent
		"死亡之願",	-- Warrior Fury talent
		"狂野怒火",	-- Hunter Beast Mastery talent (pet only)
		"寒冰屏障",	-- Mage Ice talent
		"聖佑術",	-- Paladin Holy buff
		"聖盾術",	-- Paladin Holy buff
		"戰慄圖騰",	-- Shaman totem
		"廢除魔法"	-- Majordomo (NPC) spell
		--  "Grounding Totem" is not considerated, as it can remove other spell than fear, and only one each 10 sec.
	},

	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"魯莽詛咒"	-- Warlock curse
	}
}

NECROSIS_ANTI_FEAR_UNIT = {
	["Undead"] = {
		"不死族"
	},
	["Demon"] = "惡魔",
	["Elemental"] = "元素"
}

-- Word to search for spell immunity. First (.+) replace the spell's name, 2nd (.+) replace the creature's name
NECROSIS_ANTI_FEAR_SRCH = "你的(.+)施放失敗。(.+)對此免疫。"

NECROSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚地獄戰馬",		Length = 0,	Type = 0},
	[2] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚恐懼戰馬",		Length = 0,	Type = 0},
	[3] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚小鬼",		Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚虛空行者",		Length = 0,	Type = 0},
	[5] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚魅魔",		Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚地獄獵犬",		Length = 0,	Type = 0},
	[7] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚地獄守衛",	Length = 0,	Type = 0},
	[8] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "地獄火",			Length = 3600,	Type = 3},
	[9] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "放逐術",			Length = 30,	Type = 2},
	[10] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "奴役惡魔",		Length = 30000,	Type = 2},
	[11] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "靈魂石復活",		Length = 1800,	Type = 1},
	[12] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "獻祭",			Length = 15,	Type = 5},
	[13] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "恐懼術",			Length = 15,	Type = 5},
	[14] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "腐蝕術",			Length = 18,	Type = 5},
	[15] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "惡魔支配",		Length = 900,	Type = 3},
	[16] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "厄運詛咒",		Length = 60,	Type = 3},
	[17] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "犧牲",			Length = 30,	Type = 3},
	[18] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "靈魂之火",		Length = 60,	Type = 3},
	[19] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "死亡纏繞",		Length = 120,	Type = 3},
	[20] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "暗影灼燒",		Length = 15,	Type = 3},
	[21] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "燃燒",			Length = 10,	Type = 3},
	[22] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "痛苦詛咒",		Length = 24,	Type = 4},
	[23] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "虛弱詛咒",		Length = 120,	Type = 4},
	[24] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "魯莽詛咒",		Length = 120,	Type = 4},
	[25] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "語言詛咒",		Length = 30,	Type = 4},
	[26] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "元素詛咒",		Length = 300,	Type = 4},
	[27] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "暗影詛咒",		Length = 300,	Type = 4},
	[28] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "生命虹吸",		Length = 30,	Type = 5},
	[29] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "恐懼嚎叫",		Length = 40,	Type = 3},
	[30] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "末日儀式",		Length = 3600,	Type = 0},
	[31] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "魔甲術",			Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "魔息術",			Length = 0,	Type = 0},
	[33] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "隱形",			Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "基爾羅格之眼",		Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "奴役惡魔",		Length = 0,	Type = 0},
	[36] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "惡魔皮膚",		Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "召喚儀式",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "靈魂鏈結",		Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "感知惡魔",		Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "疲勞詛咒",	Length = 12,	Type = 4},
	[41] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "生命分流",		Length = 0,	Type = 0},
	[42] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "詛咒增幅",		Length = 180,	Type = 3},
	[43] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "防護暗影結界",		Length = 30,	Type = 3},
	[44] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "惡魔犧牲",		Length = 0,	Type = 0},
	[45] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "暗影箭",			Length = 0,	Type = 0},
	[46] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "痛苦動盪",	Length = 18,	Type = 6},
	[47] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "獄甲術",		Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "腐蝕種子",	Length = 18,	Type = 5},
	[49] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "靈魂",		Length = 300,	Type = 3},
	[50] = {ID = nil, Rank = " ", CastTime = nil, Mana = nil,
		Name = "靈魂典禮",	Length = 300,	Type = 3},
}

-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de mal嶮iction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

NECROSIS_ITEM = {
	["Soulshard"] = "靈魂碎片",
	["Soulstone"] = "靈魂石",
	["Healthstone"] = "治療石",
	["Spellstone"] = "法術石",
	["Firestone"] = "火焰石",
	["Ranged"] = "魔杖",
	["Soulbound"] = "舍取后绑定",
	["InfernalStone"] = "地獄火石",
	["DemoniacStone"] = "惡魔雕像",
	["Hearthstone"] = "爐石",
	["SoulPouch"] = {"靈魂袋", "惡魔布包", "熔火惡魔布包"}
}


NECROSIS_STONE_RANK = {
	[1] = "初級",		-- Rank Minor
	[2] = "次級",		-- Rank Lesser
	[3] = "Lomig is cute",		-- Rank Intermediate, no name
	[4] = "強效",		-- Rank Greater
	[5] = "極效",		-- Rank Major
	[6] = "Master",	-- Rank Master
}

NECROSIS_NIGHTFALL = {
	["Backlash"] = "反衝",
	["ShadowTrance"] = "暗影冥思"
}
--NECROSIS_STONE_CREATE = "製造";
NECROSIS_CREATE = {
	[1] = "靈魂石",
	[2] = "治療石",
	[3] = "法術石",
	[4] = "火焰石"
}

NECROSIS_PET_LOCAL_NAME = {
	[1] = "小鬼",
	[2] = "虛空行者",
	[3] = "魅魔",
	[4] = "地獄獵犬",
	[5] = "地獄火",
	[6] = "末日守衛",
	[7] = "厄運守衛"
}

NECROSIS_TRANSLATION = {
	["Cooldown"] = "冷卻時間",
	["Hearth"] = "爐石",
	["Rank"] = "等級",
	["Invisible"] = "偵測隱形",
	["LesserInvisible"] = "偵測次級隱形",
	["GreaterInvisible"] = "偵測強效隱形",
	["SoulLinkGain"] = "你獲得了靈魂鏈結的效果。",
}

end
