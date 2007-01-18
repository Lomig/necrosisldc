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
-- VERSION FRANCAISE DES TEXTES --
------------------------------------------------

function Necrosis:Localization_Dialog_Fr()

	function NecrosisLocalization()
		self:Localization_Speech_Fr();
	end

	NECROSIS_COOLDOWN = {
		["SpellstoneIn"] = "Pierre de sort \195\169quip\195\169e",
		["Spellstone"] = "Cooldown Pierre de sort",
		["Healthstone"] = "Temps de recharge Pierre de soins"
	};

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Oui";
				[false] = "Non";
			},
			Hellspawn = {
				[true] = "On";
				[false] = "Off";
			},
			["Soulshard"] = "Fragment(s) d'\195\162me : ",
			["InfernalStone"] = "Pierre(s) infernale(s) : ",
			["DemoniacStone"] = "Pierre(s) d\195\169moniaque(s) : ",
			["Soulstone"] = "\nPierre d'\195\162me : ",
			["Healthstone"] = "Pierre de soins : ",
			["Spellstone"] = "Pierre de sort : ",
			["Firestone"] = "Pierre de feu : ",
			["CurrentDemon"] = "Demon : ",
			["EnslavedDemon"] = "Demon : Asservi",
			["NoCurrentDemon"] = "Demon : Aucun",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFPierre d'\195\162me|r",
			Text = {"Clic droit pour cr\195\169er","Clic gauche pour utiliser","Utilis\195\169e\nClic droit pour recr\195\169er","En attente"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Pierre de soins|r",
			Text = {"Clic droit pour cr\195\169er","Clic gauche pour utiliser"},
			Text2 = "Clic du milieu ou Ctrl+clic gauche pour \195\169changer",
			Ritual = "|c00FFFFFFShift+Clic pour le rituel des \195\162mes|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFFPierre de sort|r",
			Text = {"Clic droit pour cr\195\169er","En inventaire\nClic milieu ou Ctrl+clic gauche pour \195\169quiper","Tenue en main\nClic gauche pour utiliser\nShift+clic pour d\195\169s\195\169quiper"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Pierre de feu|r",
			Text = {"Clic droit pour cr\195\169er","En inventaire\nClic gauche pour \195\169quiper","Tenue en main\nShift+clic pour d\195\169s\195\169quiper"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFDur\195\169e des sorts|r",
			Text = "Sorts actifs sur la cible",
			Right = "Clic droit pour pierre de foyer vers "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFTranse de l'ombre|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFFContrecoup|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFDomination corrompue|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFAsservissement|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFArmure d\195\169moniaque|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFFGangrarmure|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFD\195\169tection de l'invisibilit\195\169|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFRespiration interminable|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFOeil de Kilrogg|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFBannir|r",
			Text = "Clic droit pour Rang 1"
		},
		["TP"] = {
			Label = "|c00FFFFFFRituel d'invocation|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFLien spirituel|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFGardien de l'ombre|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFDiablotin|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFFMarcheur \195\169th\195\169r\195\169|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFSuccube|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFFChasseur corrompu|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFGangregarde|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFInfernal|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFGarde funeste|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFSacrifice d\195\169moniaque|r"
		},
		["Amplify"] = {
			Label = "|c00FFFFFFMal\195\169diction amplifi\195\169e|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFMal\195\169diction de faiblesse|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFMal\195\169diction d'agonie|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFMal\195\169diction de t\195\169m\195\169rit\195\169|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFMal\195\169diction des langages|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFMal\195\169diction de fatigue|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFMal\195\169diction des \195\169l\195\169ments|r"
		},
		["Shadow"] = {
			Label = "|c00FFFFFFMal\195\169diction de l'ombre|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFMal\195\169diction funeste|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFMonture|r",
			Text = "Clic droit pour Rang 1"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFFMenu des sorts|r",
			Text = "Clic droit pour laisser ouvert",
			Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFFMenu des d\195\169mons|r",
			Text = "Clic droit pour laisser ouvert",
			Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFFMenu des mal\195\169dictions|r",
			Text = "Clic droit pour laisser ouvert",
			Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
		},
		["Radar"] = {
			Label = "|c00FFFFFFD\195\169tection des d\195\169mons|r"
		},
		["AmplifyCooldown"] = "Clic droit pour amplifier la mal\195\169diction",
		["DominationCooldown"] = "Clic droit pour invocation rapide",
	};

	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-Fr.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-Fr.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-Fr.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-Fr.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-Fr.mp3",
	};

	NECROSIS_PROC_TEXT = {
		["ShadowTrance"] = "<white>T<lightPurple1>r<lightPurple2>a<purple>n<darkPurple1>s<darkPurple2>e d<darkPurple1>e l<purple>'<lightPurple2>o<lightPurple1>m<white>b<lightPurple1>r<lightPurple2>e";
		["Backlash"] = "<white>C<lightPurple1>o<lightPurple2>n<purple>t<darkPurple1>r<darkPurple2>e<darkPurple1>c<purple>o<lightPurple2>u<lightPurple1>p"
	};


	NECROSIS_MESSAGE = {
		["Bag"] = {
			["FullPrefix"] = "Votre ",
			["FullSuffix"] = " est plein !",
			["FullDestroySuffix"] = " est plein ; Les prochains fragments seront detruits !",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necro pour les options !",
			["TooltipOn"] = "Bulles d'aide activ\195\169es" ,
			["TooltipOff"] = "Bulles d'aide d\195\169sactiv\195\169es",
			["MessageOn"] = "Messages Pierre d'\195\162me et Invocation de joueur activ\195\169s",
			["MessageOff"] = "Messages Pierre d'\195\162me et Invocation de joueur desactiv\195\169s",
			["MessagePosition"] = "<- position des messages systeme Necrosis ->",
			["DefaultConfig"] = "<lightYellow>Configuration par defaut charg\195\169e.",
			["UserConfig"] = "<lightYellow>Configuration charg\195\169e"
		},
		["Help"] = {
			"/necro <lightOrange>recall<white> -- <lightBlue>Centre Necrosis et tous les boutons au milieu de l'\195\169cran",
			"/necro <lightOrange>reset<white> -- <lightBlue>R\195\169initialise totalement Necrosis",
			"/necro <lightOrange>sm<white> -- <lightBlue>Remplace les messages de pierre d'\195\162me et d'invocation par des versions courtes sp\195\169ciales raid",
			"/necro <lightOrange>am<white> -- <lightBlue>Permet aux menus de s'ouvrir automatiquement en d\195\169but de combat, et de se refermer pendant la r\195\169g\195\169n\195\169ration",
			"/necro <lightOrange>bm<white> -- <lightBlue>Permet aux menus de rester bloqu\195\169s en position ouverte",
			"/necro <lightOrange>cm<white> -- <lightBlue>ferme les menus lorsqu'on clique sur un de leurs boutons",
			"/necro <lightOrange>tt<white> -- <lightBlue>Affiche les timers texte",
		},
		["Information"] = {
			["FearProtect"] = "La cible est prot\195\168g\195\169e contre la peur !!!!",
			["EnslaveBreak"] = "Votre D\195\169mon a bris\195\169 ses chaines...",
			["SoulstoneEnd"] = "<lightYellow>Votre Pierre d'\195\162me vient de s'eteindre."
		}
	};


	-- Gestion XML - Menu de configuration
	Necrosis.Config.Panel = {
		"Configuration des fragments",
		"Configuration des fragments",
		"Configuration des boutons",
		"Configuration des timers",
		"Configuration graphique"
	}

	Necrosis.Config.Sphere.Colour = {
		"Rose",
		"Bleu",
		"Orange",
		"Turquoise",
		"Violet",
		"666",
		"X"
	}

	NECROSIS_CONFIGURATION = {
		["MainRotation"] = "Rotation de Necrosis",
		["ShardMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFen|CFFFFC4FFt|CFFFF99FFa|CFFFF50FFi|CFFFF00FFr|CFFB700B7e :",
		["ShardMenu2"] = "|CFFB700B7C|CFFFF00FFo|CFFFF50FFm|CFFFF99FFp|CFFFFC4FFt|CFFFF99FFe|CFFFF50FFu|CFFFF00FFr :",
		["ShardMove"] = "D\195\169place les fragments dans le sac specifi\195\169",
		["ShardDestroy"] = "D\195\169truit les fragments si sac plein",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFo|CFFFF50FFr|CFFFF99FFt|CFFFFC4FFs :",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFo|CFFFF50FFu|CFFFF99FFe|CFFFFC4FFu|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFr|CFFFF99FFs G|CFFFF50FFr|CFFFF00FFa|CFFB700B7ph|CFFFF00FFi|CFFFF50FFq|CFFFF99FFue|CFFFFC4FFs :",
		["TranseWarning"] = "M'alerter quand j'entre en Transe",
		["SpellTime"] = "Affiche le bouton des Timers",
		["AntiFearWarning"] = "M'alerter quand ma cible \195\160 un 'anti fear'",
		["GraphicalTimer"] = "Affiche la gestion des dur\195\169es de sorts",
		["TimerColor"] = "Affiche le texte des timers en blanc",
		["TimerDirection"] = "Ajouter les timers en haut des pr\195\169c\195\169dents",
		["TranceButtonView"] = "Affichage des boutons cach\195\169s pour les d\195\169placer",
		["ButtonLock"] = "Verrouiller les boutons sur la sphere Necrosis",
		["MainLock"] = "Verrouiller les boutons des Pierres et Necrosis",
		["BagSelect"] = "Choix du sac contenant les fragments",
		["BuffMenu"] = "Afficher le menu des buffs vers la gauche",
		["PetMenu"] = "Afficher le menu des d\195\169mons vers la gauche",
		["CurseMenu"] = "Afficher le menu des mal\195\169dictions vers la gauche",
		["STimerLeft"] = "Afficher les timers sur la gauche du bouton",
		["ShowCount"] = "Afficher le compteur de fragments",
		["CountType"] = "Type de compteur",
		["Circle"] = "Ev\195\168nement montr\195\169 par la sph\195\168re graphique",
		["ShowMessage"] = "Active les messages al\195\169atoires d'invocation",
		["ShowDemonSummon"] = "Active les messages pour les D\195\169mons",
		["ShowSteedSummon"] = "Active les messages pour la Monture",
		["ChatType"] = "Les messages = des messages syst\195\168mes",
		["Sound"] = "Activer les sons",
		["NecrosisSize"] = "Taille de la pierre Necrosis",
		["BanishSize"] = "Taille du bouton Banish",
		["TranseSize"] = "Taille des boutons cach\195\169s",
		["Skin"] = "Skin de la pierre Necrosis",
		["Show"] = {
			["Firestone"] = "Afficher le bouton des Pierres de feu",
			["Spellstone"] = "Afficher le bouton des Pierres de sort",
			["Healthstone"] = "Afficher le bouton des Pierres de soin",
			["Soulstone"] = "Afficher le bouton des Pierres d'\195\162me",
			["Steed"] = "Afficher le bouton de la Monture",
			["Buff"] = "Affiche le bouton des Buffs",
			["Curse"] = "Affiche le bouton des Mal\195\169dictions",
			["Demon"] = "Affiche le bouton d'invocation des D\195\169mons",
			["Tooltips"] = "Affiche les bulles d'aides"
		},
		["Count"] = {
			"Fragments d'\195\162me",
			"Pierres d'invocations",
			"Timer de Rez",
			"Mana",
			"Sant\195\169"
		}
	};
	NECROSIS_BINDING = {
		["Current"] = " est actuellement associ\195\169 \195\160 ",
		["Confirm"] = "Voulez-vous associer ",
		["To"] = " \195\160 ",
		["Yes"] = "Oui",
		["No"] = "Non",
		["InCombat"] = "D\195\169sol\195\169, vous ne pouvez pas changer les raccourcis claviers en combat.",
		["Binding"] = "Raccourcis",
		["Unbind"] = "Supprimer",
		["Cancel"] = "Annuler",
		["Press"] = "Appuyez sur la touche\n\n\195\160 associer...\n\n\n\n",
		["Now"] = "Actuellement : ",
		["NotBound"] = "Non affect\195\169e",
	};

end
