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
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- CHINESE TRADITIONAL VERSION TEXTS          --
--  2007/01/02
--  艾娜羅沙@奧妮克希亞
------------------------------------------------

function Necrosis:Localization_Dialog_Tw()

	function Necrosis:Localization()
	  self:Localization_Speech_Tw()
	end

	self.HealthstoneCooldown = "治療石冷卻時間"
	
	self.Localize = {
		["Utilisation"] = "Use",
		["Echange"] = "Trade",
	}

	self.TooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "是";
				[false] = "否";
			},
			Hellspawn = {
				[true] = "開";
				[false] = "關";
			},
			["Soulshard"] = "靈魂碎片：",
			["InfernalStone"] = "地獄火石：",
			["DemoniacStone"] = "惡魔雕像：",
			["Soulstone"] = "\n靈魂石：",
			["Healthstone"] = "治療石：",
			["Spellstone"] = "法術石：",
			["Firestone"] = "火焰石：",
			["CurrentDemon"] = "惡魔：",
			["EnslavedDemon"] = "惡魔：奴役",
			["NoCurrentDemon"] = "惡魔：無",
		},
		["Soulstone"] = {
			Text = {"製造","使用","已使用","等待中"}
		},
		["Healthstone"] = {
			Text = {"製造","使用"},
			Text2 = "按中鍵或是Ctrl-左鍵交易",
			Ritual = "|c00FFFFFFShift+左鍵施放靈魂儀式|r"
		},
		["Spellstone"] = {
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["Firestone"] = {
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF法術持續時間|r",
			Text = "啟用對目標的法術計時",
			Right = "右鍵使用爐石到"
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFF暗影冥思|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFF反衝|r"
		},
		["Banish"] = {
			Text = "按右鍵施放等級1"
		},
		["Imp"] = {
			Label = "|c00FFFFFF小鬼|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFF虛空行者|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFF魅魔|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFF地獄獵犬|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFF地獄守衛|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFF地獄火|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFF末日守衛|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF坐騎|r",
			Text = "右鍵施放等級1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFF法術選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFF惡魔選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFF詛咒選單|r",
			Text = "右鍵保持選單開啟",
			Text2 = "自動模式：脫離戰鬥後自動關閉",
		},
		["DominationCooldown"] = "右鍵快速召喚",
	}

	self.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-En.mp3",
	}

	NECROSIS_NIGHTFALL_TEXT = {
		["NoBoltSpell"] = "你沒有任何的暗影箭法術。",
		["Message"] = "<white>暗<lightPurple1>影<lightPurple2>冥<purple>思<darkPurple1>！<darkPurple2>暗<darkPurple1>影<purple>冥<lightPurple2>思<lightPurple1>！<white>！"
	}


	self.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "你的",
			["FullSuffix"] = " 滿了！",
			["FullDestroySuffix"] = "滿了；下個碎片將被摧毀！",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro 顯示設定功能表！",
			["TooltipOn"] = "打開提示" ,
			["TooltipOff"] = "關閉提示",
			["MessageOn"] = "打開聊天訊息通知",
			["MessageOff"] = "關閉聊天訊息通知",
			["DefaultConfig"] = "<lightYellow>預設配置已載入。",
			["UserConfig"] = "<lightYellow>配置已載入。"
		},
		["Help"] = {
			"/necro <lightOrange>recall<white> -- <lightBlue>將Necrosis和所有按鈕置於螢幕中央",
			"/necro <lightOrange>reset<white> -- <lightBlue>Reset Necrosis entirely",
		},
		["Information"] = {
			["FearProtect"] = "你的目標對恐懼免疫！",
			["EnslaveBreak"] = "惡魔擺脫奴役...",
			["SoulstoneEnd"] = "<lightYellow>你的靈魂石已失效"
		}
	}

	-- Gestion XML - Menu de configuration
	self.Config.Panel = {
		"資訊設定",
		"Sphere Settings",
		"按鈕設定",
		"Menus Settings",
		"計時器設定",
		"Miscellanious"
	}

	self.Config.Messages = {
		["Position"] = "<- 這裡將顯示Necrosis的系統訊息 ->",
		["Afficher les bulles d'aide"] = "顯示提示",
		["Afficher les messages dans la zone systeme"] = "宣告Necrosis訊息為系統訊息",
		["Activer les messages aleatoires de TP et de Rez"] = "顯示隨機訊息",
		["Utiliser des messages courts"] = "Use short messages",
		["Activer egalement les messages pour les Demons"] = "啟動隨機訊息 (惡魔)",
		["Activer egalement les messages pour les Montures"] = "啟動隨機訊息 (坐騎)",
		["Activer egalement les messages pour le Rituel des ames"] = "啟用靈魂儀式的隨機訊息",
		["Activer les sons"] = "開啟音效",
		["Alerter quand la cible est insensible a la peur"] = "當我的目標免疫恐懼時提醒我",
		["Alerter quand la cible peut etre banie ou asservie"] = "Warn when the target is banishable or enslavable",
		["M'alerter quand j'entre en Transe"] = "當我獲得暗影冥思效果時提醒我"
	}

	self.Config.Sphere = {
		["Taille de la sphere"] = "Necrosis按鈕的大小",
		["Skin de la pierre Necrosis"] = "Necrosis球體的外觀",
		["Evenement montre par la sphere"] = "球體事件顯示",
		["Sort caste par la sphere"] = "Spell casted by the Sphere",
		["Afficher le compteur numerique"] = "顯示碎片數量",
		["Type de compteur numerique"] = "計算石頭類型"
	}
	self.Config.Sphere.Colour = {
		"粉紅色",
		"藍色",
		"橘色",
		"青綠色",
		"紫色",
		"666",
		"X"
	}
	self.Config.Sphere.Count = {
		"靈魂碎片",
		"惡魔召喚石",
		"靈魂石冷卻計時",
		"Mana",
		"Health"
	}

	self.Config.Buttons = {
		["Rotation des boutons"] = "Buttons rotation",
		["Fixer les boutons autour de la sphere"] = "Stick buttons around the Sphere",
		["Utiliser mes propres montures"] = "Use my own mounts",
		["Choix des boutons a afficher"] = "Selection of buttons to be shown",
		["Monture - Clic gauche"] = "Mount - Left click",
		["Monture - Clic droit"] = "Mount - Right click",
	}
	self.Config.Buttons.Name = {
		"顯示火焰石按鈕",
		"顯示法術石按鈕",
		"顯示治療石按鈕",
		"顯示靈魂石按鈕",
		"顯示法術功能表按鈕",
		"顯示戰馬按鈕",
		"顯示惡魔召喚功能表按鈕",
		"顯示詛咒功能表按鈕",
	}

	self.Config.Menus = {
		["Options Generales"] = "General Options",
		["Menu des Buffs"] = "法術選單",
		["Menu des Demons"] = "惡魔選單",
		["Menu des Maledictions"] = "詛咒選單",
		["Afficher les menus en permanence"] = "Always show menus",
		["Afficher automatiquement les menus en combat"] = "Show automatically the menus while in combat",
		["Fermer le menu apres un clic sur un de ses elements"] = "Close a menu whenever you click on one of its items",
		["Orientation du menu"] = "Menu orientation",
		["Changer la symetrie verticale des boutons"] = "Change the vertical simetry of buttons",
		["Taille du bouton Banir"] = "放逐按鈕大小",
	}
	self.Config.Menus.Orientation = {
		"Horizontal",
		"Upwards",
		"Downwards"
	}

	self.Config.Timers = {
		["Type de timers"] = "Timer type",
		["Afficher le bouton des timers"] = "Show the Spell Timer Button",
		["Afficher les timers sur la gauche du bouton"] = "計時器在按鈕左邊",
		["Afficher les timers de bas en haut"] = "計時器向上增加",
	}
	self.Config.Timers.Type = {
		"No Timer",
		"Graphical",
		"Textual"
	}

	self.Config.Misc = {
		["Deplace les fragments"] = "將碎片放入選擇的包包",
		["Detruit les fragments si le sac plein"] = "如果包包滿了，摧毀所有新的碎片。",
		["Choix du sac contenant les fragments"] = "選擇靈魂碎片包包",
		["Nombre maximum de fragments a conserver"] = "Maximum number of shards to keep",
		["Verrouiller Necrosis sur l'interface"] = "鎖定Necrosis主體及周圍的按鈕。",
		["Afficher les boutons caches"] = "顯示隱藏的按鈕以便能拖曳它。",
		["Taille des boutons caches"] = "暗影冥思和反恐按鈕的大小"
	}

end
