--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
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
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2008-03-30 15:05:46 +1000 $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------

if ( GetLocale() == "ruRU" ) then

-- Table des sorts du démoniste
Necrosis.Spell = {
	[1] = {Name = "коня Скверны",		Length = 0,	Type = 0},
	[2] = {Name = "коня погибели",		Length = 0,	Type = 0},
	[3] = {Name = "Призыв беса",			Length = 0,	Type = 0},
	[4] = {Name = "Призыв демона Бездны",		Length = 0,	Type = 0},
	[5] = {Name = "Призыв суккуба",		Length = 0,	Type = 0},
	[6] = {Name = "Призыв охотника Скверны",		Length = 0,	Type = 0},
	[7] = {Name = "Призыв стража Скверны",		Length = 0,	Type = 0},
	[8] = {Name = "Инфернал",			Length = 3600,	Type = 3},
	[9] = {Name = "Изгнание",				Length = 30,	Type = 2},
	[10] = {Name = "Порабощение демона",			Length = 300,	Type = 2},
	[11] = {Name = "Воскрешение камнем души",	Length = 1800,	Type = 1},
	[12] = {Name = "Жертвенный огонь",			Length = 15,	Type = 6},
	[13] = {Name = "Страх",				Length = 15,	Type = 6},
	[14] = {Name = "Порча",			Length = 18,	Type = 5},
	[15] = {Name = "Господство Скверны",		Length = 900,	Type = 3},
	[16] = {Name = "Проклятие рока",			Length = 60,	Type = 3},
	[17] = {Name = "Испепеление",			Length = 20,	Type = 3},
	[18] = {Name = "Ожог души",			Length = 60,	Type = 3},
	[19] = {Name = "Лик смерти",			Length = 120,	Type = 3},
	[20] = {Name = "Ожог Тьмы",			Length = 15,	Type = 3},
	[21] = {Name = "Поджигание",			Length = 10,	Type = 3},
	[22] = {Name = "Проклятие агонии",		Length = 24,	Type = 4},
	[23] = {Name = "Проклятие слабости",		Length = 120,	Type = 4},
	[24] = {Name = "Проклятие безрассудства",		Length = 120,	Type = 4},
	[25] = {Name = "Проклятие косноязычия",		Length = 30,	Type = 4},
	[26] = {Name = "Проклятие стихий",		Length = 300,	Type = 4},
	[27] = {Name = "Проклятие тьмы",		Length = 300,	Type = 4},
	[28] = {Name = "Похищение жизни",			Length = 30,	Type = 6},
	[29] = {Name = "Вой ужаса",		Length = 40,	Type = 3},
	[30] = {Name = "Ритуал рока",		Length = 3600,	Type = 0},
	[31] = {Name = "Демонический доспех",			Length = 0,	Type = 0},
	[32] = {Name = "Нескончаемое дыхание",		Length = 0,	Type = 0},
	[33] = {Name = "Обнаружение невидимости",		Length = 0,	Type = 0},
	[34] = {Name = "Око Килрогга",		Length = 0,	Type = 0},
	[35] = {Name = "Порабощение демона",			Length = 0,	Type = 0},
	[36] = {Name = "Шкура демона",			Length = 0,	Type = 0},
	[37] = {Name = "Ритуал призывания",		Length = 0,	Type = 0},
	[38] = {Name = "Связка души",			Length = 0,	Type = 0},
	[39] = {Name = "Чутье на демонов",			Length = 0,	Type = 0},
	[40] = {Name = "Проклятие изнеможения",		Length = 12,	Type = 4},
	[41] = {Name = "Жизнеотвод",			Length = 0,	Type = 0},
	[42] = {Name = "Усиление проклятия",			Length = 180,	Type = 3},
	[43] = {Name = "Защита от темной магии",			Length = 30,	Type = 3},
	[44] = {Name = "Демоническое жертвоприношение",		Length = 0,	Type = 0},
	[45] = {Name = "Стрела Тьмы",			Length = 0,	Type = 0},
	[46] = {Name = "Нестабильное чернокнижие",		Length = 18,	Type = 6},
	[47] = {Name = "Доспех Скверны",			Length = 0,	Type = 0},
	[48] = {Name = "Семя порчи",		Length = 18,	Type = 5},
	[49] = {Name = "Раскол души",			Length = 300,	Type = 3},
	[50] = {Name = "Ритуал душ",		Length = 300,	Type = 3},
	[51] = {Name = "Создание камня души",		Length = 0,	Type = 0},
	[52] = {Name = "Создание камня здоровья",		Length = 0,	Type = 0},
	[53] = {Name = "Создание камня чар",		Length = 0,	Type = 0},
	[54] = {Name = "Создание камня огня",		Length = 0,	Type = 0},
	[55] = {Name = "Темный союз",			Length = 0,	Type = 0},
}
-- Type 0 = Pas de Timer
-- Type 1 = Timer permanent principal
-- Type 2 = Timer permanent
-- Type 3 = Timer de cooldown
-- Type 4 = Timer de malédiction
-- Type 5 = Timer de corruption
-- Type 6 = Timer de combat

for i in ipairs(Necrosis.Spell) do
	Necrosis.Spell[i].Rank = " "
end

-- Types d'unité des PnJ utilisés par Necrosis
Necrosis.Unit = {
	["Undead"] = "Нежить",
	["Demon"] = "Демон",
	["Elemental"] = "Дух стихии"
}

-- Traduction du nom des procs utilisés par Necrosis
Necrosis.Translation.Proc = {
	["Backlash"] = "Ответный удар",
	["ShadowTrance"] = "Теневой транс"
}

-- Traduction des noms des démons invocables
Necrosis.Translation.DemonName = {
	[1] = "Бес",
	[2] = "Демон Бездны",
	[3] = "Суккуба",
	[4] = "Охотник Скверны",
	[5] = "Страж Скверны",
	[6] = "Инферно",
	[7] = "Привратник Скверны"
}

-- Traduction du nom des objets utilisés par Necrosis
Necrosis.Translation.Item = {
	["Soulshard"] = "Осколок души",
	["Soulstone"] = "камень души",
	["Healthstone"] = "камень здоровья",
	["Spellstone"] = "камень чар",
	["Firestone"] = "камень огня",
	["Ranged"] = "Жезл",
	["Soulbound"] = "Персональный предмет",
	["InfernalStone"] = "Камень инфернала",
	["DemoniacStone"] = "Демоническая статуэтка",
	["Hearthstone"] = "Камень возвращения",
	["SoulPouch"] = {"Мешок душ", "Сумка из ткани Скверны", "Черная сумка теней"}
}

-- Traductions diverses
Necrosis.Translation.Misc = {
	["Cooldown"] = "Восстановление",
	["Rank"] = "Уровень",
	["Create"] = "Создание"
}

-- Gestion de la détection des cibles protégées contre la peur
Necrosis.AntiFear = {
	-- Buffs giving temporary immunity to fear effects
	["Buff"] = {
		"Защита от страха",		-- Dwarf priest racial trait
		"Воля отрекшихся",	-- Forsaken racial trait
		"Бесстрашие",		-- Trinket (Fearless)
		"Ярость берсерка",	-- Warrior Fury talent
		"Безрассудство",		-- Warrior Fury talent
		"Жажда смерти",		-- Warrior Fury talent
		"Звериный гнев",	-- Hunter Beast Mastery talent
		"Ледяная преграда",		-- Mage Ice talent
		"Божественная защита",	-- Paladin Holy buff
		"Божественный щит",	-- Paladin Holy buff
		"Тотем трепета",		-- Shaman totem
		"Abolish Magic"		-- Majordomo (NPC) spell
	},
	-- Debuffs and curses giving temporary immunity to fear effects
	["Debuff"] = {
		"Проклятие безрассудства"	-- Warlock curse
	}
}

end
