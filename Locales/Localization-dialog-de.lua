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
-- GERMAN VERSION TEXTS --
------------------------------------------------

function Necrosis_Localization_Dialog_De()

	function NecrosisLocalization()
		Necrosis_Localization_Speech_De();
	end

	NECROSIS_COOLDOWN = {
		["SpellstoneIn"] = "Zauberstein ausr\195\188sten",
		["Spellstone"] = "Zauberstein Cooldown",
		["Healthstone"] = "Gesundheitsstein Cooldown"
	};

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Ja";
				[false] = "Nein";
			},
			Hellspawn = {
				[true] = "An";
				[false] = "Aus";
			},
			["Soulshard"] = "Seelensplitter : ",
			["InfernalStone"] = "H\195\182llensteine : ",
			["DemoniacStone"] = "D\195\164monen-Statuetten : ",
			["Soulstone"] = "\nSeelenstein : ",
			["Healthstone"] = "Gesundheitsstein : ",
			["Spellstone"] = "Zauberstein: ",
			["Firestone"] = "Feuerstein : ",
			["CurrentDemon"] = "D\195\164mon : ",
			["EnslavedDemon"] = "D\195\164mon : Versklavter",
			["NoCurrentDemon"] = "D\195\164mon : Keiner",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSeelenstein|r",
			Text = {"Rechte Maustaste zum herstellen","Linke Maustaste zum benutzten","Benutzt\nRechte Maustaste zum wiederherstellen","Warten"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Gesundheitsstein|r",
			Text = {"Rechte Maustaste zum herstellen","Linke Maustaste zum benutzten"},
			Text2 = "Mittlerer Maustaste oder Strg+rechte Maustaste zum handeln",
			Ritual = "|c00FFFFFFShift+Klick um das Ritual der Seelen zu zaubern|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFFZauberstein|r",
			Text = {"Rechte Maustaste zum herstellen","Im Inventar\nMittlere Maustaste oder Strg+linke Maustaste zum ausr\195\188sten","Ausger\195\188stet - Linke Maustaste zum benutzten\nShift+Klick um abzulegen"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Feuerstein|r",
			Text = {"Rechte Maustaste zum herstellen","Im Inventar\nMittlere Maustaste zum ausr\195\188sten","Ausger\195\188stet\nShift+Klick um abzulegen"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpruchdauer|r",
			Text = "Aktive Spr\195\188che auf dem Ziel\n",
			Right = "Rechtsklick f\195\188r Ruhestein nach "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFSchatten Trance|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFFHeimzahlen|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFTeufelsbeherrschung|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFVersklavt|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFD\195\164monenr\195\188stung|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFFTeufelsr\195\188stung|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFUnsichtbarkeit entdecken|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFUnendlicher Atem|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFAuge von Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFVerbannen|r",
			Text = "Rechtsklick f\195\188r Rang 1"
		},
		["TP"] = {
			Label = "|c00FFFFFFRitual der Beschw\195\182rung|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFSeelenverbindung|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFSchattenzauberschutz|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFWichtel|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFFLeerwandler|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSukkubus|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFFTeufelsj\195\164ger|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFTeufelswache|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFH\195\182llenbestie|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFVerdammniswache|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFD\195\164monenopferung|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFFluch verst\195\164rken|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFFluch der Schw\195\164che|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFFluch der Pein|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFFluch der Tollk\195\188hnheit|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFFluch der Sprachen|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFFluch der Ersch\195\182pfung|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFFluch der Elemente|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFFluch der Schatten|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFFluch der Verdammnis|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFMount|r",
			Text = "Rechtsklick f\195\188r Rang 1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFFSpruch Men\195\188|r",
			Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
			Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFFD\195\164monen Men\195\188|r",
			Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
			Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFFFluch Men\195\188|r",
			Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
			Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
		},
		["Radar"] = {
			Label = "|c00FFFFFFD\195\164monen sp\195\188ren|r"
		},
		["AmplifyCooldown"] = "Mit der rechten Taste klicken um den n\195\164chsten Fluch zu verst\195\164rken",
		["DominationCooldown"] = "Mit der rechten Taste klicken f\195\188r eine schnelle Beschw\195\182rung",
	};


	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-Fr.mp3",
	};


	NECROSIS_PROC_TEXT = {
		["ShadowTrance"] = "<white>S<lightPurple1>c<lightPurple2>h<purple>a<darkPurple1>tt<darkPurple2>en<darkPurple1>tr<purple>a<lightPurple2>n<lightPurple1>c<white>e",
		["Backlash"] = "<white>H<lightPurple1>e<lightPurple2>i<purple>m<darkPurple1>z<darkPurple2>a<darkPurple1>h<purple>l<lightPurple2>e<lightPurple1>n"
	};

	NECROSIS_MESSAGE = {
		["Bag"] = {
			["FullPrefix"] = "Dein ",
			["FullSuffix"] = " ist voll !",
			["FullDestroySuffix"] = " ist voll; folgende Seelensplitter werden zerst\195\182rt !",
			["SelectedPrefix"] = "Du hast deinen ",
			["SelectedSuffix"] = " f\195\188r deine Seelensplitter gew\195\164hlt."
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro f\195\188r das Einstellungsmen\195\188.",
			["TooltipOn"] = "Tooltips an" ,
			["TooltipOff"] = "Tooltips aus",
			["MessageOn"] = "Chat Nachrichten an",
			["MessageOff"] = "Chat Nachrichten aus",
			["MessagePosition"] = "<- Hier werden Nachrichten von Necrosis erscheinen ->",
			["DefaultConfig"] = "<lightYellow>Standard-Einstellungen geladen.",
			["UserConfig"] = "<lightYellow>Einstellungen geladen."
		},
		["Help"] = {
			"/necro recall -- Zentriere Necrosis und alle Buttons in der Mitte des Bildschirms",
			"/necro sm -- Ersetze Seelenstein- und Beschw\195\182rungs-Zufallsnachrichten durch eine kurze, raidgeeignete Version"
		},
		["Information"] = {
			["FearProtect"] = "Dein Ziel hat Fear-Protection!!!",
			["EnslaveBreak"] = "Dein D\195\164mon hat seine Ketten gebrochen...",
			["SoulstoneEnd"] = "<lightYellow>Dein Seelenstein ist ausgelaufen."
		}
	};


	-- Gestion XML - Menu de configuration

	NECROSIS_COLOR_TOOLTIP = {
		["Purple"] = "Lila",
		["Blue"] = "Blau",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "T\195\188rkis",
		["X"] = "X"
	};

	NECROSIS_CONFIGURATION = {
		["Menu1"] = "Splitter Einstellungen",
		["Menu2"] = "Nachrichten Einstellungen",
		["Menu3"] = "Buttons Einstellungen",
		["Menu4"] = "Timer Einstellungen",
		["Menu5"] = "Graphische Einstellungen",
		["MainRotation"] = "Necrosis Rotiationseinstellung",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFa|CFFFF00FFr :",
		["ShardMenu2"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFl|CFFFF99FFi|CFFFFC4FFtt|CFFFF99FFe|CFFFF50FFr :",
		["ShardMove"] = "Lege die Seelensplitter in die ausgew\195\164hlte Tasche.",
		["ShardDestroy"] = "Zerst\195\182re neue Seelensplitter, wenn die Tasche voll ist.",
		["SpellMenu1"] = "|CFFB700B7Z|CFFFF00FFa|CFFFF50FFu|CFFFFC4FFb|CFFFF99FFe|CFFFF50FFr :",
		["SpellMenu2"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFi|CFFFF99FFe|CFFFFC4FFl|CFFFF99FFe|CFFFF50FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFs|CFFFF00FFc|CFFB700B7he T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFF00FFr :",
		["TranseWarning"] = "Warnung, wenn Schattentrance eintritt",
		["SpellTime"] = "Spruchdauer anzeigen",
		["AntiFearWarning"] = "Warnung, wenn Ziel immun gegen\195\188ber Fear ist",
		["TranceButtonView"] = "Zeige versteckte Buttons um sie zu verschieben",
		["GraphicalTimer"] = "Verwende graphische Timer anstelle von Texttimern",
		["TimerColor"] = "Zeige wei\195\159en Text in Timern anstelle von gelbem Text",
		["TimerDirection"] = "Neue Timer oberhalb der bestehenden Timer anzeigen",
		["ButtonLock"] = "Sperre die Buttons um die Necrosis Sph\195\164re",
		["MainLock"] = "Sperre die Buttons und die Necrosis Sph\195\164re",
		["BagSelect"] = "W\195\164hle die Seelensplitter-Tasche",
		["BuffMenu"] = "Setze das Spruch Men\195\188 nach links",
		["CurseMenu"] = "Setze das Fluch Men\195\188 nach links",
		["PetMenu"] = "Setze das Diener Men\195\188 nach links",
		["STimerLeft"] = "Zeige die Timer auf der linken Seite des Knopfes",
		["ShowCount"] = "Zeige die Anzahl der Seelensplitter in Necrosis",
		["CountType"] = "Stein Typ gez\195\164hlt",
		["Circle"] = "Anzeige in der grafischen Sph\195\164re",
		["Sound"] = "Aktiviere Sounds",
		["ShowMessage"] = "Zuf\195\164llige Spr\195\188che",
		["ShowDemonSummon"] = "Zuf\195\164llige Spr\195\188che (D\195\164mon)",
		["ShowSteedSummon"] = "Zuf\195\164llige Spr\195\188che (Mount)",
		["ChatType"] = "Necrosis Nachrichten als\nSystem-Nachrichten anzeigen",
		["NecrosisSize"] = "Gr\195\182\195\159e des Necrosis Button",
		["BanishSize"] = "Gr\195\182\195\159e des Verbannen Button",
		["TranseSize"] = "Gr\195\182\195\159e des versteckten Buttons",
		["Skin"] = "Aussehen der Necrosis Sph\195\164re",
		["Show"] = {
			["Firestone"] = "Zeige den Feuerstein Button",
			["Spellstone"] = "Zeige den Zauberstein Button",
			["Healthstone"] = "Zeige den Gesundheitsstein Button",
			["Soulstone"] = "Zeige den Seelenstein Button",
			["Steed"] = "Zeige den Mount Button",
			["Buff"] = "Zeige den Spruch Men\195\188 Button",
			["Demon"] = "Zeige den D\195\164monen Men\195\188 Button",
			["Curse"] = "Zeige den Fluch Men\195\188 Button",
			["Tooltips"] = "Zeige Tooltips"
		},
		["Count"] = {
			["Shard"] = "Seelensplitter",
			["Inferno"] = "D\195\164monenen-Beschw\195\182rungs-Steine",
			["Rez"] = "Wiederbelebungs-Timer"
		}
	};

	NECROSIS_BINDING = {
		["Current"] = "  ist im Moment gebunden an ",
		["Confirm"] = "M\195\182chtest du eine neue Bindung der Taste ",
		["To"] = " an ",
		["Yes"] = "Ja",
		["No"] = "Nein",
		["InCombat"] = "Es tut mir leid, du kannst Tastenk\195\188rzel nicht im Kampf binden..",
		["Binding"] = "Tastenk\195\188rzel",
		["Unbind"] = "Verbindung l\195\182sen",
		["Cancel"] = "Abbrechen",
		["Press"] = "Dr\195\188cke zu bindende Taste...\n\n",
		["Now"] = "Aktuell: ",
		["NotBound"] = "Nicht gebunden",
	};
end
