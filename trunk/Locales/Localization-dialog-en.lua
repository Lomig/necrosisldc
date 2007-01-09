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
-- Skins et voix Fran�aises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements sp�ciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_En()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_En()
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
			Label = "|c0099CCFFSpellstone|r",
			Text = {"Right click to create","In Inventory\nMiddle click or Ctrl+left click to equip","Held in hand\nLeft click to user\nShift+clic to unequip"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Firestone|r",
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
			Label = "|c00FFFFFFBanish|r",
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
			Label = "|c00FFFFFFFelhunter|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFFelguard|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFInferno|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFDoomguard|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFDemonic sacrifice|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFAmplify Curse|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFCurse of Weakness|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFCurse of Agony|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFCurse of Recklessness|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFCurse of Tongues|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFCurse of Exhaustion|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFCurse of Elements|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFCurse of Shadow|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFCurse of Doom|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFSteed|r",
			Text = "Right click to cast Rank 1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFFSpell Menu|r",
			Text = "Right click to keep the menu open",
			Text2 = "Automatic Mode : Closing when leave combat",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFFDemon Menu|r",
			Text = "Right click to keep the menu open",
			Text2 = "Automatic Mode : Closing when leave combat",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFFCurse Menu|r",
			Text = "Right click to keep the menu open",
			Text2 = "Automatic Mode : Closing when leave combat",
		},
		["Radar"] = {
			Label = "|c00FFFFFFSense Demons|r"
		},
		["AmplifyCooldown"] = "Right click to amplify curse",
		["DominationCooldown"] = "Right click for fast summon",
	}

	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-Fr.mp3",
	};

	NECROSIS_PROC_TEXT = {
		["ShadowTrance"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e",
		["Backlash"] = "<white>B<lightPurple1>a<lightPurple2>c<purple>k<darkPurple1>l<darkPurple2>a<darkPurple1>s<purple>h"
	}


	NECROSIS_MESSAGE = {
		["Bag"] = {
			["FullPrefix"] = "Your ",
			["FullSuffix"] = " is full!",
			["FullDestroySuffix"] = " is full; Next shards will be destroyed!",
			["SelectedPrefix"] = "You have chosen your ",
			["SelectedSuffix"] = " to keep your shards."
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro to show the setting menu!",
			["TooltipOn"] = "Tooltips turned on" ,
			["TooltipOff"] = "Tooltips turned off",
			["MessageOn"] = "Chat messaging turned on",
			["MessageOff"] = "Chat messaging turned off",
			["MessagePosition"] = "<- System messages by Necrosis will appear here ->",
			["DefaultConfig"] = "<lightYellow>Default configuration loaded.",
			["UserConfig"] = "<lightYellow>Configuration loaded."
		},
		["Help"] = {
			"/necro <lightOrange>recall<white> -- <lightBlue>Center Necrosis and all buttons in the middle of the screen",
			"/necro <lightOrange>reset<white> -- <lightBlue>Reset Necrosis entirely",
			"/necro <lightOrange>sm<white> -- <lightBlue>Replace Soulstoning and summoning messages with a short raid-ready version",
			"/necro <lightOrange>am<white> -- <lightBlue>Allows menus to be opened automatically when entering in combat",
			"/necro <lightOrange>bm<white> -- <lightBlue>Keep menus opened forever",
		},
		["Information"] = {
			["FearProtect"] = "Your target has got fear protection!",
			["EnslaveBreak"] = "Your demon broke his chains...",
			["SoulstoneEnd"] = "<lightYellow>Your Soulstone has faded."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "Purple",
		["Blue"] = "Blue",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "Turquoise",
		["666"] = "666",
		["X"] = "X"
	}

	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Shard Settings",
		["Menu2"] = "Message Settings",
		["Menu3"] = "Button Settings",
		["Menu4"] = "Timer Settings",
		["Menu5"] = "Graphical Settings",
		["MainRotation"] = "Necrosis Angle Selection",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y:",
		["ShardMenu2"] = "|CFFB700B7S|CFFFF00FFh|CFFFF50FFa|CFFFF99FFr|CFFFFC4FFd C|CFFFF99FFo|CFFFF50FFu|CFFFF00FFn|CFFB700B7t:",
		["ShardMove"] = "Put shards in the selected bag.",
		["ShardDestroy"] = "Destroy all new shards if the bag is full.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls:",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr:",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs:",
		["TimerColor"] = "Show white instead of yellow timer texts",
		["TimerDirection"] = "Timers grow upwards",
		["TranseWarning"] = "Alert me when I enter a Trance State",
		["SpellTime"] = "Turn on the spell durations indicator",
		["AntiFearWarning"] = "Warn me when my target cannot be feared.",
		["GraphicalTimer"] = "Show graphical instead text timers",
		["TranceButtonView"] = "Let me see hidden buttons to drag them.",
		["ButtonLock"] = "Lock the buttons around the Necrosis Sphere.",
		["MainLock"] = "Lock buttons and the Necrosis Sphere.",
		["BagSelect"] = "Selection of Soul Shard Container",
		["BuffMenu"] = "Put buff menu on the left",
		["PetMenu"] = "Put pet menu on the left",
		["CurseMenu"] = "Put curse menu on the left",
		["STimerLeft"] = "Show timers on the left side of the button",
		["ShowCount"] = "Show the Shard count in Necrosis",
		["CountType"] = "Stone type counted",
		["Circle"] = "Event shown by the graphical sphere",
		["Sound"] = "Activate sounds",
		["ShowMessage"] = "Activate random speeches",
		["ShowDemonSummon"] = "Activate random speeches (demon)",
		["ShowSteedSummon"] = "Activate random speeches (steed)",
		["ChatType"] = "Declare Necrosis messages as system messages",
		["NecrosisSize"] = "Size of the Necrosis button",
		["BanishSize"] = "Size of the Banish button",
		["TranseSize"] = "Size of hidden buttons",
		["Skin"] = "Skin of the Necrosis Sphere",
		["Show"] = {
			["Firestone"] = "Show Firestone button",
			["Spellstone"] = "Show Spellstone button",
			["Healthstone"] = "Show Healthstone button",
			["Soulstone"] = "Show Soulstone button",
			["Steed"] = "Show Steed button",
			["Buff"] = "Show Spell menu button",
			["Curse"] = "Show Curse menu button",
			["Demon"] = "Show Demon menu button",
			["Tooltips"] = "Show tooltips"
		},
		["Count"] = {
			["Shard"] = "Soulshards",
			["Inferno"] = "Demon summoning stones",
			["Rez"] = "Resurrection Timer"
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
