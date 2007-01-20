--[[
    Necrosis LdC
    Copyright (C) 2005-2006  Lom Enfroy

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
-- Par Lomig, Liadora et Nyx (Kael'Thas et Elune)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
-- Version Allemande par Geschan
-- Remerciements spéciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- CHINESE TRADITIONAL VERSION TEXTS          --
--  2007/01/02
--  艾娜羅沙@奧妮克希亞
------------------------------------------------

function Necrosis:Localization_Dialog_Tw()

	function NecrosisLocalization()
	  self:Localization_Speech_Tw()
	end

	NECROSIS_COOLDOWN = {
		["SpellstoneIn"] = "法術石已裝備",
		["Spellstone"] = "法術石冷卻時間",
		["Healthstone"] = "治療石冷卻時間"
	}

	NecrosisTooltipData = {
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
			Label = "|c00FF99FF靈魂石|r",
			Text = {"製造","使用","已使用","等待中"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33治療石|r",
			Text = {"製造","使用"},
			Text2 = "按中鍵或是Ctrl-左鍵交易",
			Ritual = "|c00FFFFFFShift+左鍵施放靈魂儀式|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFF法術石|r",
			Text = {"右鍵製造","在包包\n按中鍵或是Ctrl-左鍵裝備","裝備在副手\n左鍵給玩家\nShift+左鍵取下裝備"}
		},
		["Firestone"] = {
			Label = "|c00FF4444火焰石|r",
			Text = {"右鍵製造","在包包\n按中鍵或是Ctrl-左鍵裝備","裝備在副手\nShift+左鍵取下裝備"}
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
		["Domination"] = {
			Label = "|c00FFFFFF惡魔支配|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFF奴役惡魔|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFF魔甲術|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFF獄甲術|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFF偵測隱形|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFF魔息術|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFF基爾羅格之眼|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFF放逐術|r",
			Text = "按右鍵施放等級1"
		},
		["TP"] = {
			Label = "|c00FFFFFF召喚儀式|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFF靈魂鏈結|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFF防護暗影結界|r"
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
		["Sacrifice"] = {
			Label = "|c00FFFFFF惡魔犧牲|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFF詛咒增幅|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFF虛弱詛咒|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFF痛苦詛咒|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFF魯莽詛咒|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFF語言詛咒|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFF疲勞詛咒|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFF元素詛咒|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFF暗影詛咒|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFF厄運詛咒|r"
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
		["Radar"] = {
			Label = "|c00FFFFFF感知惡魔|r"
		},
		["AmplifyCooldown"] = "右鍵詛咒增幅",
		["DominationCooldown"] = "右鍵快速召喚",
	}

	NECROSIS_SOUND = {
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


	NECROSIS_MESSAGE = {
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
			"/necro <lightOrange>am<white> -- <lightBlue>Allows menus to be opened automatically when entering in combat",
			"/necro <lightOrange>bm<white> -- <lightBlue>Keep menus opened forever",
			"/necro <lightOrange>cm<white> -- <lightBlue>Close the menu when you click on one of its buttons",
		},
		["Information"] = {
			["FearProtect"] = "你的目標對恐懼免疫！",
			["EnslaveBreak"] = "惡魔擺脫奴役...",
			["SoulstoneEnd"] = "<lightYellow>你的靈魂石已失效"
		}
	}

	-- Gestion XML - Menu de configuration
	Necrosis.Config.Panel = {
		"碎片設定",
		"資訊設定",
		"按鈕設定",
		"計時器設定",
		"圖像設定"
	}

	Necrosis.Config.Messages = {
		["Position"] = "<- 這裡將顯示Necrosis的系統訊息 ->",
		["Afficher les bulles d'aide"] = "顯示提示",
		["Afficher les messages dans la zone systeme"] = "宣告Necrosis訊息為系統訊息",
		["Activer les messages aleatoires de TP et de Rez"] = "顯示隨機訊息",
		["Utiliser des messages courts"] = "Use short messages",
		["Activer egalement les messages pour les Demons"] = "啟動隨機訊息 (惡魔)",
		["Activer egalement les messages pour les Montures"] = "啟動隨機訊息 (坐騎)",
		["Activer les sons"] = "開啟音效",
		["Alerter quand la cible est insensible a la peur"] = "當我的目標免疫恐懼時提醒我",
		["Alerter quand la cible peut etre banie ou asservie"] = "Warn when the target is banishable or enslavable",
		["M'alerter quand j'entre en Transe"] = "當我獲得暗影冥思效果時提醒我"
	}

	Necrosis.Config.Sphere = {
		["Rotation de Necrosis"] = "Necrosis角度選擇",
		["Skin de la pierre Necrosis"] = "Necrosis球體的外觀",
		["Evenement montre par la sphere"] = "球體事件顯示",
		["Sort caste par la sphere"] = "Spell casted by the Sphere",
		["Afficher le compteur numerique"] = "顯示碎片數量",
		["Type de compteur numerique"] = "計算石頭類型"
	}
	Necrosis.Config.Sphere.Colour = {
		"粉紅色",
		"藍色",
		"橘色",
		"青綠色",
		"紫色",
		"666",
		"X"
	}
	Necrosis.Config.Sphere.Count = {
		"靈魂碎片",
		"惡魔召喚石",
		"靈魂石冷卻計時",
		"Mana",
		"Health"
	}

	Necrosis.Config.Timers = {
		["Type de timers"] = "Timer type",
		["Afficher le bouton des timers"] = "Show the Spell Timer Button",
		["Afficher les timers sur la gauche du bouton"] = "計時器在按鈕左邊",
		["Afficher les timers de bas en haut"] = "計時器向上增加",
	}
	Necrosis.Config.Timers.Type = {
		"No Timer",
		"Graphical",
		"Textual"
	}

	NECROSIS_CONFIGURATION = {
		["ShardMenu"] = "|CFFB700B7背包|CFFB700B7 :",--"|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ShardMenu2"] = "|CFFB700B7碎片|CFFB700B7 :",--"|CFFB700B7S|CFFFF00FFh|CFFFF50FFa|CFFFF99FFr|CFFFFC4FFd C|CFFFF99FFo|CFFFF50FFu|CFFFF00FFn|CFFB700B7t :",
		["ShardMove"] = "將碎片放入選擇的包包",
		["ShardDestroy"] = "如果包包滿了，摧毀所有新的碎片。",
		["SpellMenu1"] = "|CFFB700B7法術|CFFFFC4FF :",--"|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7玩家|CFFFF99FF :",
		["TimerMenu"] = "|CFFB700B7圖形計時器|CFFFF99FF :",
		["TimerColor"] = "計時器以白色來取代黃色文字",
		["GraphicalTimer"] = "打開法術計時器。",
		["TranceButtonView"] = "顯示隱藏的按鈕以便能拖曳它。",
		["ButtonLock"] = "鎖定Necrosis主體周圍的按鈕。",
		["MainLock"] = "鎖定Necrosis主體及周圍的按鈕。",
		["BagSelect"] = "選擇靈魂碎片包包",
		["BuffMenu"] = "增益功能表在按鈕左邊",
		["PetMenu"] = "寵物功能表在按鈕左邊",
		["CurseMenu"] = "詛咒功能表在按鈕左邊",
		["NecrosisSize"] = "Necrosis按鈕的大小",
		["BanishSize"] = "放逐按鈕大小",
		["TranseSize"] = "暗影冥思和反恐按鈕的大小",
		["Show"] = {
			["Firestone"] = "顯示火焰石按鈕",
			["Spellstone"] = "顯示法術石按鈕",
			["Healthstone"] = "顯示治療石按鈕",
			["Soulstone"] = "顯示靈魂石按鈕",
			["Steed"] = "顯示戰馬按鈕",
			["Buff"] = "顯示法術功能表按鈕",
			["Curse"] = "顯示詛咒功能表按鈕",
			["Demon"] = "顯示惡魔召喚功能表按鈕",
		},
	}

	NECROSIS_BINDING = {
		["Current"] = "目前設定在",
		["Confirm"] = "你想要設定",
		["To"] = "於",
		["Yes"] = "是",
		["No"] = "否",
		["InCombat"] = "抱歉，你不能在戰鬥中改變按鍵設定。",
		["Binding"] = "按鍵設定",
		["Unbind"] = "取消按鍵",
		["Cancel"] = "取消",
		["Press"] = "請按想要的按鍵組合...\n\n",
		["Now"] = "目前：",
		["NotBound"] = "未設定",
	}

end
