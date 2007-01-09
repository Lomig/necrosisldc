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



-- Variables globales
Necrosis = {}
NecrosisConfig = {}

-- Variables locales
local Local = {}
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTIONS LOCALES
------------------------------------------------------------------------------------------------------

-- Création de deux fonctions, new et del
-- new crée un tableau temporaire, del le détruit
-- Ces tableaux temporaires sont stockés pour être réutilisés sans être obligés de les recréer.
local new, del
do
	local cache = setmetatable({}, {__mode='k'})
	function new(populate, ...)
		local tbl
		local t = next(cache)
		if ( t ) then
			cache[t] = nil
			tbl = t
		else
			tbl = {}
		end
		if ( populate ) then
			local num = select("#", ...)
			if ( populate == "hash" ) then
				assert(math.fmod(num, 2) == 0)
				local key
				for i = 1, num do
					local v = select(i, ...)
					if not ( math.fmod(i, 2) == 0 ) then
						key = v
					else
						tbl[key] = v
						key = nil
					end
				end
			elseif ( populate == "array" ) then
				for i = 1, num do
					local v = select(i, ...)
					table.insert(tbl, i, v)
				end
			end
		end
		return tbl
	end
	function del(t)
		for k in next, t do
			t[k] = nil
		end
		cache[t] = true
	end
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS LOCALES
------------------------------------------------------------------------------------------------------


NecrosisBinding = {}
NecrosisAlreadyBind = {}

-- Liste des boutons disponible pour le démoniste dans chaque menu
local PetMenuCreate = {}
local BuffMenuCreate = {}
local CurseMenuCreate = {}

-- Variables utilisées pour la gestion des montures
local MountAvailable = false
local PlayerCombat = false

-- Variables utilisées pour la gestion des transes de l'ombre / Backlash
local NecrosisProc = {
	{"ShadowTrance", false, -1},
	{"Backlash", false, -1}
}
local AntiFearInUse = false

-- Variables utilisées pour la gestion des fragments d'âme
-- (principalement comptage)
local SoulshardsCount = 0
local SoulshardContainer = 4
local SoulshardSlot = {}
local SoulshardSlotID = 1
local SoulshardMP = 0
local SoulshardTime = 0



-- Variables utilisées pour la gestion des boutons d'invocation et d'utilisation des pierres
local StoneIDInSpellTable = {0, 0, 0, 0}
local SoulstoneOnHand = false
local SoulstoneLocation = {nil,nil}
local SoulstoneMode = 1
local HealthstoneOnHand = false
local HealthstoneLocation = {nil,nil}
local HealthstoneMode = 1
local FirestoneOnHand = false
local FirestoneMode = 1
local SpellstoneOnHand = false
local SpellstoneLocation = {nil,nil}
local SpellstoneMode = 1
local HearthstoneOnHand = false
local HearthstoneLocation = {nil,nil}

-- Variables utilisées dans la gestion des démons
local DemonType = nil
local DemonEnslaved = false

-- Variables utilisées pour l'anti-fear
local AFblink1, AFBlink2 = 0
local AFImageType = { "", "Immu", "Prot"} -- Fear warning button filename variations
local AFCurrentTargetImmune = false
local CurrentTargetBan = false

-- Variables utilisées pour les échanges de pierre avec les joueurs
local NecrosisTradeRequest = false
local NecrosisTradeComplete = false

-- Gestion des sacs à fragment d'âme
local BagIsSoulPouch = {nil, nil, nil, nil, nil}

-- Variable contenant les derniers messages invoqués
local PetMess = 0
local SteedMess = 0
local RezMess = 0
local TPMess = 0
local PlayerSoulstoned = {}
local SteedSummoned = {}
local PlayerSummoned = {}
local DemonSummoned = {}
local DemonSacrified = {}
local DemonName = nil

-- Permet la gestion des tooltips dans Necrosis (sans la frame des pièces de monnaie)
local lOriginal_GameTooltip_ClearMoney

-- Détection des initialisations du mod
Local.LoggedIn = true
Local.InWorld = true

-- Events utilisés dans Necrosis
Local.Events = {
	"BAG_UPDATE",
	"COMBAT_TEXT_UPDATE",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_DEAD",
	"UNIT_PET",
	"UNIT_SPELLCAST_FAILED",
	"UNIT_SPELLCAST_INTERRUPTED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_SPELLCAST_SENT",
	"LEARNED_SPELL_IN_TAB",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"PLAYER_TARGET_CHANGED",
	"TRADE_REQUEST",
	"TRADE_REQUEST_CANCEL",
	"TRADE_ACCEPT_UPDATE",
	"TRADE_SHOW",
	"TRADE_CLOSED",
}

-- Configuration par défaut
-- Se charge en cas d'absence de configuration ou de changement de version
Local.DefaultConfig = {
	SoulshardContainer = 4,
	SoulshardSort = false,
	SoulshardDestroy = false,
	ShadowTranceAlert = true,
	ShowSpellTimers = true,
	AntiFearAlert = true,
	CreatureAlert = true,
	NecrosisLockServ = true,
	NecrosisAngle = 180,
	StonePosition = {1, 2, 3, 4, 5, 6, 7, 8},
		-- 1 = Firestone
		-- 2 = Spellstone
		-- 3 = Soins
		-- 4 = Ame
		-- 5 = Buff
		-- 6 = Monture
		-- 7 = Démon
		-- 8 = Malédictions
	CurseSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9},
		-- 1 = Malédiction amplifiée
		-- 2 = Faiblesse
		-- 3 = Agonie
		-- 4 = Témérité
		-- 5 = Langage
		-- 6 = Fatigue
		-- 7 = Elements
		-- 8 = Ombre
		-- 9 = Funeste
	DemonSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
		-- 1 = Domination corrompue
		-- 2 = Imp
		-- 3 = Marcheur
		-- 4 = Succube
		-- 5 = Felhunter
		-- 6 = Gangregarde
		-- 7 = Infernal
		-- 8 = Doomguard
		-- 9 = Asservissement
		-- 10 = Sacrifice
	BuffSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9, -10, 11},
		-- 1 = Armure
		-- 2 = Gangrarmure
		-- 3 = Respiration
		-- 4 = Invisibilité
		-- 5 = Kilrogg
		-- 6 = TP
		-- 7 = Radar
		-- 8 = Lien Spirituel
		-- 9 = Protection contre l'ombre
		-- 10 = Asservissement
		-- 11 = Bannir
	NecrosisToolTip = true,
	NoDragAll = false,

	MainSpell = 41,

	AutomaticMenu = false,
	BlockedMenu = false,

	PetMenuPos = {x=1, y=0},
	PetMenuDecalage = {x=1, y=26},

	BuffMenuPos = {x=1, y=0},
	BuffMenuDecalage = {x=1, y=26},

	CurseMenuPos = {x=1, y=0},
	CurseMenuDecalage = {x=1, y=-26},

	ChatMsg = true,
	ChatType = true,
	Language = GetLocale(),
	ShowCount = true,
	CountType = 1,
	ShadowTranceScale = 100,
	NecrosisButtonScale = 90,
	NecrosisColor = "Rose",
	Sound = true,
	SpellTimerPos = 1,
	SpellTimerJust = "LEFT",
	Circle = 1,
	Graphical = true,
	Yellow = true,
	SensListe = 1,
	PetName = {
		[1] = " ",
		[2] = " ",
		[3] = " ",
		[4] = " ",
		[5] = " ",
	},
	SM = false,
	SteedSummon = false,
	DemonSummon = true,
	BanishScale = 100,
	ItemSwitchCombat = {nil,nil,nil,nil,nil},
	FramePosition = {
		["NecrosisSpellTimerButton"] = {"CENTER", nil, "CENTER", 100, 300},
		["NecrosisButton"] = {"CENTER", nil, "CENTER", 0, -200},
		["NecrosisCreatureAlertButton"] = {"CENTER", nil, "CENTER", -60, 0},
		["NecrosisAntiFearButton"] = {"CENTER", nil, "CENTER", -20, 0},
		["NecrosisShadowTranceButton"] = {"CENTER", nil, "CENTER", 20, 0},
		["NecrosisBacklashButton"] = {"CENTER", nil, "CENTER", 60, 0},
		["NecrosisFirestoneButton"] = {"CENTER", nil, "CENTER", -121,-100},
		["NecrosisSpellstoneButton"] = {"CENTER", nil, "CENTER", -87,-100},
		["NecrosisHealthstoneButton"] = {"CENTER", nil, "CENTER", -53,-100},
		["NecrosisSoulstoneButton"] = {"CENTER", nil, "CENTER", -17,-100},
		["NecrosisBuffMenuButton"] = {"CENTER", nil, "CENTER", 17,-100},
		["NecrosisMountButton"] = {"CENTER", nil, "CENTER", 53,-100},
		["NecrosisPetMenuButton"] = {"CENTER", nil, "CENTER", 87,-100},
		["NecrosisCurseMenuButton"] = {"CENTER", nil, "CENTER", 121,-100},
	},
}

-- Variables des sorts castés (nom, rang, cible, niveau de la cible)
Local.SpellCasted = {}

-- Variables des timers
Local.TimerManagement = {
	-- Sorts à timer
	SpellTimer = {},
	-- Association des timers aux Frames
	TimerTable = {false},
	-- Groupes de timers par mobs
	SpellGroup = {
		{Name = "Rez", SubName = " ", Visible = 0},
		{Name = "Main", SubName = " ", Visible = 0},
		{Name = "Cooldown", SubName = " ", Visible = 0}
	}
}

-- Variable de comptage des composants
Local.Reagent = {Infernal = 0, Demoniac = 0}

-- Variable des Buffs Actifs
Local.BuffActif = {}

-- Temps écoulé entre deux event OnUpdate
Local.LastUpdate = {0, 0, 0}

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS APPLIQUEES A L'ENTREE DANS LE JEU
------------------------------------------------------------------------------------------------------


-- Fonction appliquée au chargement
function Necrosis_OnLoad()

	local _, Classe = UnitClass("player")
	if Classe == "WARLOCK" then

		-- Initialisation du mod
		Necrosis_Initialize(Local.DefaultConfig)

		-- Enregistrement des events utilisés
		NecrosisButton:RegisterEvent("PLAYER_ENTERING_WORLD")
		NecrosisButton:RegisterEvent("PLAYER_LEAVING_WORLD")
		for i in ipairs(Local.Events) do
			NecrosisButton:RegisterEvent(Local.Events[i])
		end

		-- Easter Egg
		if UnitName("player") == "Lycion" then
			SendChatMessage("Je suis le pire noob de la terre, et Lomig est mon maitre !", "GUILD")
			SendChatMessage("Il n'y a pas plus cr\195\169tin que Lycion... Virez moi !", "OFFICER")
			SendChatMessage("Lycion floode Cyrax by Lomig", "WHISPER", "Common", "Cyrax")
		end

		-- Détection du type de démon présent à la connexion
		DemonType = UnitCreatureFamily("pet")
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS
------------------------------------------------------------------------------------------------------

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function Necrosis_OnUpdate(elapsed)
	Local.LastUpdate[1] = Local.LastUpdate[1] + elapsed
	Local.LastUpdate[2] = Local.LastUpdate[2] + elapsed
	Local.LastUpdate[3] = Local.LastUpdate[3] + elapsed

	-- Toutes les cinq secondes, on update les boutons de mana, éventuellement.
	if Local.LastUpdate[1] > 5 then
		Necrosis_UpdateMana()
		Local.LastUpdate[1] = 0
	-- Toutes les secondes
	elseif Local.LastUpdate[2] > 1 then
	-- Si configuré, tri des fragment toutes les secondes
		if NecrosisConfig.SoulshardSort and SoulshardMP > 0  then
			Necrosis_SoulshardSwitch("MOVE")
		end

		-- Parcours du tableau des Timers
		if Local.TimerManagement.SpellTimer[1] then
			for index = 1, #Local.TimerManagement.SpellTimer, 1 do
				if Local.TimerManagement.SpellTimer[index] then
					-- On enlève les timers terminés
					local TimeLocal = GetTime()
					if TimeLocal >= (Local.TimerManagement.SpellTimer[index].TimeMax - 0.5) then -- and not (Local.TimerManagement.SpellTimer[index].TimeMax == -1) then
						-- Si le timer était celui de la Pierre d'âme, on prévient le Démoniste
						if Local.TimerManagement.SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name then
							Necrosis_Msg(NECROSIS_MESSAGE.Information.SoulstoneEnd)
	--						Local.TimerManagement.SpellTimer[index].Target = ""
	--						Local.TimerManagement.SpellTimer[index].TimeMax = -1
							if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.SoulstoneEnd) end
	--						Necrosis_RemoveFrame(Local.TimerManagement.SpellTimer[index].Gtimer, Local.TimerManagement.TimerTable)
							-- On met à jour l'apparence du bouton de la pierre d'âme
							Necrosis_UpdateIcons()
						end
						-- Sinon on enlève le timer silencieusement (mais pas en cas d'enslave)
						if not (Local.TimerManagement.SpellTimer[index].Name == NECROSIS_SPELL_TABLE[10].Name) then
							Local.TimerManagement = Necrosis_RetraitTimerParIndex(index, Local.TimerManagement)
							index = 0
							break
						end
					end
					-- Si le Démoniste n'est plus sous l'emprise du Sacrifice
					if Local.TimerManagement.SpellTimer and Local.TimerManagement.SpellTimer[index].Name == NECROSIS_SPELL_TABLE[17].Name then
						if not Necrosis_UnitHasEffect("player", Local.TimerManagement.SpellTimer[index].Name) and Local.TimerManagement.SpellTimer[index].TimeMax then
							Local.TimerManagement = Necrosis_RetraitTimerParIndex(index, Local.TimerManagement)
							index = 0
							break
						end
					end
					-- Si la cible visée n'est plus atteinte par un sort lancé [résists]
					if Local.TimerManagement.SpellTimer
						and (
							Local.TimerManagement.SpellTimer[index].Type == 4
							or Local.TimerManagement.SpellTimer[index].Type == 5
							or Local.TimerManagement.SpellTimer[index].Type == 6
						)
						and Local.TimerManagement.SpellTimer[index].Target == UnitName("target")
						then
						-- On triche pour laisser le temps au mob de bien sentir qu'il est débuffé ^^
						if TimeLocal >= ((Local.TimerManagement.SpellTimer[index].TimeMax - Local.TimerManagement.SpellTimer[index].Time) + 1.5)
							and not (Local.TimerManagement.SpellTimer[index] == 6) then
							if not Necrosis_UnitHasEffect("target", Local.TimerManagement.SpellTimer[index].Name) then
								Local.TimerManagement = Necrosis_RetraitTimerParIndex(index, Local.TimerManagement)
								index = 0
								break
							end
						end
					end
				end
			end
		end
		Local.LastUpdate[2] = 0
	-- Toutes les demies secondes
	elseif Local.LastUpdate[3] > 0.5 then
		NecrosisUpdateTimer(Local.TimerManagement.SpellTimer)
		-- Si configuré, affichage des avertissements d'Antifear
		if NecrosisConfig.AntiFearAlert then
			Necrosis_ShowAntiFearWarning()
		end
		Local.LastUpdate[3] = 0
	end
end

-- Fonction lancée selon l'événement intercepté
function Necrosis_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		Local.InWorld = true
	elseif (event == "PLAYER_LEAVING_WORLD") then
		Local.InWorld = false
	end

	-- Le jeu est-il bien chargé ?
	if not Local.InWorld then
		return
	end

	-- Si le contenu des sacs a changé, on vérifie que les Fragments d'âme sont toujours dans le bon sac
	if (event == "BAG_UPDATE") then
		Necrosis_BagExplore(arg1)
		if (NecrosisConfig.SoulshardSort) then
			Necrosis_SoulshardSwitch("CHECK")
		end
	-- Si le joueur meurt, on cache éventuellement les boutons de Crépuscule ou Contrecoup.
	elseif (event == "PLAYER_DEAD") then
		NecrosisShadowTranceButton:Hide()
		NecrosisBacklashButton:Hide()
	-- Gestion de l'incantation des sorts réussie
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") and arg1 == "player" then
		_, Local.SpellCasted.Name = arg1, arg2
		Necrosis_SpellManagement()
	-- Quand le démoniste commence à incanter un sort, on intercepte le nom de celui-ci
	-- On sauve également le nom de la cible du sort ainsi que son niveau
	elseif (event == "UNIT_SPELLCAST_SENT") then
		_, Local.SpellCasted.Name, Local.SpellCasted.Rank, Local.SpellCasted.TargetName = arg1, arg2, arg3, arg4
		if (not Local.SpellCasted.TargetName or Local.SpellCasted.TargetName == "") and UnitName("target") then
			Local.SpellCasted.TargetName = UnitName("target")
		elseif not Local.SpellCasted.TargetName then
			Local.SpellCasted.TargetName = ""
		end
		Local.SpellCasted.TargetLevel = UnitLevel("target")
		if not Local.SpellCasted.TargetLevel then
			Local.SpellCasted.TargetLevel = ""
		end
		DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess = Necrosis_Speech_It(Local.SpellCasted.Name, Local.SpellCasted.TargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess)

	-- Quand le démoniste stoppe son incantation, on relache le nom de celui-ci
	elseif (event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED") and arg1 == player then
		Local.SpellCasted = {}
	-- Flag si une fenetre de Trade est ouverte, afin de pouvoir trader automatiquement les pierres de soin
	elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
		NecrosisTradeRequest = true
	elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
		NecrosisTradeRequest = false
	elseif event=="TRADE_ACCEPT_UPDATE" then
		if NecrosisTradeRequest and NecrosisTradeComplete then
			AcceptTrade()
			NecrosisTradeRequest = false
			NecrosisTradeComplete = false
		end
	-- AntiFear button hide on target change
	elseif event == "PLAYER_TARGET_CHANGED" then
		if NecrosisConfig.AntiFearAlert and AFCurrentTargetImmune then
			AFCurrentTargetImmune = false
		end
		if NecrosisConfig.CreatureAlert
			and UnitCanAttack("player", "target")
			and not UnitIsDead("target") then
				CurrentTargetBan = true
				if UnitCreatureType("target") == NECROSIS_UNIT.Demon then
					NecrosisCreatureAlertButton:Show()
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\DemonAlert")
				elseif UnitCreatureType("target") == NECROSIS_UNIT.Elemental then
					NecrosisCreatureAlertButton:Show()
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ElemAlert")
				end
		elseif CurrentTargetBan then
			CurrentTargetBan = false
			NecrosisCreatureAlertButton:Hide()
		end

	-- AntiFear immunity on cast detection
	elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if NecrosisConfig.AntiFearAlert then
			for spell, creatureName in arg1:gmatch(NECROSIS_ANTI_FEAR_SRCH) do
				-- We check if the casted spell on the immune target is Fear or Death Coil
				if spell == NECROSIS_SPELL_TABLE[13].Name or spell == NECROSIS_SPELL_TABLE[19].Name then
					AFCurrentTargetImmune = true
					break
				end
			end
		end
	-- Si le Démoniste apprend un nouveau sort / rang de sort, on récupère la nouvelle liste des sorts
	-- Si le Démoniste apprend un nouveau sort de buff ou d'invocation, on recrée les boutons
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		for index in ipairs(NECROSIS_SPELL_TABLE) do
			NECROSIS_SPELL_TABLE[index].ID = nil
		end
		Necrosis_SpellSetup()
		Necrosis_CreateMenu()
		Necrosis_ButtonSetup()

	-- A la fin du combat, on arrête de signaler le Crépuscule
	-- On enlève les timers de sorts ainsi que les noms des mobs
	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false
		Local.TimerManagement = Necrosis_RetraitTimerCombat(Local.TimerManagement)

		-- On redéfinit les attributs des boutons de sorts de manière situationnelle
		Necrosis_NoCombatAttribute(SoulstoneMode, FirestoneMode, SpellstoneMode, StoneIDInSpellTable)
		Necrosis_UpdateIcons()

	-- Quand le démoniste change de démon
	elseif (event == "UNIT_PET" and arg1 == "player") then
		Necrosis_ChangeDemon()
	-- uand le démoniste gagne ou perd un buff.
	elseif event == "COMBAT_TEXT_UPDATE" then
		if arg1 == "AURA_START" then
			Necrosis_SelfEffect("BUFF", arg2)
		elseif arg1 == "AURA_END" then
			Necrosis_SelfEffect("DEBUFF", arg2)
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		PlayerCombat = true
		-- On ferme le menu des options
		if _G["NecrosisGeneralFrame"] and NecrosisGeneralFrame:IsVisible() then
			NecrosisGeneralFrame:Hide()
		end
		-- On annule les attributs des boutons de sorts de manière situationnelle
		Necrosis_InCombatAttribute()
	end
	return
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS "ON EVENT"
------------------------------------------------------------------------------------------------------

-- Events : PLAYER_ENTERING_WORLD et PLAYER_LEAVING_WORLD
-- Fonction appliquée à chaque écran de chargement
-- Quand on sort d'une zone, on arrête de surveiller les envents
-- Quand on rentre dans une zone, on reprend la surveillance
-- Cela permet d'éviter un temps de chargement trop long du mod
function Necrosis_RegisterManagement(RegistrationType)
	if RegistrationType == "IN" then
		for i in ipairs(Local.Events) do
			NecrosisButton:RegisterEvent(Local.Events[i])
		end
	else
		for i in ipairs(Local.Events) do
			NecrosisButton:UnregisterEvent(Local.Events[i])
		end
	end
	return
end

-- event : UNIT_PET
-- Permet de timer les asservissements, ainsi que de prévenir pour les ruptures d'asservissement
-- Change également le nom du pet au remplacement de celui-ci
function Necrosis_ChangeDemon()
	-- Si le nouveau démon est un démon asservi, on place un timer de 5 minutes
	if (Necrosis_UnitHasEffect("pet", NECROSIS_SPELL_TABLE[10].Name)) then
		if (not DemonEnslaved) then
			DemonEnslaved = true
			Local.TimerManagement = Necrosis_InsertTimerParTable(10, "","", Local.TimerManagement)
		end
	else
		-- Quand le démon asservi est perdu, on retire le Timer et on prévient le Démoniste
		if (DemonEnslaved) then
			DemonEnslaved = false
			Local.TimerManagement = Necrosis_RetraitTimerParNom(NECROSIS_SPELL_TABLE[10].Name, Local.TimerManagement)
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.EnslaveEnd) end
			Necrosis_Msg(NECROSIS_MESSAGE.Information.EnslaveBreak, "USER")
		end
	end

	-- Si le démon n'est pas asservi on définit son titre, et on met à jour son nom dans Necrosis
	DemonType = UnitCreatureFamily("pet")
	for i = 1, 5, 1 do
		if DemonType == NECROSIS_PET_LOCAL_NAME[i] and NecrosisConfig.PetName[i] == " " and not UnitName("pet") == UNKNOWNOBJECT then
			NecrosisConfig.PetName[i] = UnitName("pet")
			NecrosisLocalization()
			break
		end
	end

	return
end

-- events : CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS, CHAT_MSG_SPELL_AURA_GONE_SELF et CHAT_MSG_SPELL_BREAK_AURA
-- Permet de gérer les effets apparaissants et disparaissants sur le démoniste
-- Basé sur le CombatLog
function Necrosis_SelfEffect(action, nom)
	if action == "BUFF" then
		-- Changement du bouton de monture quand le Démoniste est démonté
		if nom == NECROSIS_SPELL_TABLE[1].Name or  nom == NECROSIS_SPELL_TABLE[2].Name then
			Local.BuffActif.Mount = true
			if _G["NecrosisMountButton"] then
				NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02")
				NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
			end
		-- Changement du bouton de la domination corrompue si celle-ci est activée + Timer de cooldown
		elseif  nom == NECROSIS_SPELL_TABLE[15].Name then
			Local.BuffActif.Domination = true
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-02")
				NecrosisPetMenu1:GetNormalTexture():SetDesaturated(nil)
			end
		-- Changement du bouton de la malédiction amplifiée si celle-ci est activée + Timer de cooldown
		elseif  nom == NECROSIS_SPELL_TABLE[42].Name then
			Local.BuffActif.Amplify = true
			if _G["NecrosisCurseMenu1"] then
				NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-02")
				NecrosisCurseMenu1:GetNormalTexture():SetDesaturated(nil)
			end
		-- Changement du bouton du lien spirituel si celui-ci est activé
		elseif nom == NECROSIS_SPELL_TABLE[38].Name then
			Local.BuffActif.SoulLink = true
			if _G["NecrosisBuffMenu7"] then
				NecrosisBuffMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\SoulLink-02")
				NecrosisBuffMenu7:GetNormalTexture():SetDesaturated(nil)
			end
		-- si Contrecoup, pouf on affiche l'icone et on proc le son
		elseif nom == NECROSIS_NIGHTFALL.Backlash then
			Necrosis_Msg(NECROSIS_PROC_TEXT.Backlash, "USER")
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.Backlash) end
			NecrosisBacklashButton:Show()
		-- si Crépuscule, pouf on affiche l'icone et on proc le son
		elseif nom == NECROSIS_NIGHTFALL.ShadowTrance then
			Necrosis_Msg(NECROSIS_PROC_TEXT.ShadowTrance, "USER")
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.ShadowTrance) end
			NecrosisShadowTranceButton:Show()
		end
	else
		-- Changement du bouton de monture quand le Démoniste est démonté
		if nom == NECROSIS_SPELL_TABLE[1].Name or  nom == NECROSIS_SPELL_TABLE[2].Name then
			Local.BuffActif.Mount = false
			if _G["NecrosisMountButton"] then
				NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-01")
			end
		-- Changement du bouton de Domination quand le Démoniste n'est plus sous son emprise
		elseif  nom == NECROSIS_SPELL_TABLE[15].Name then
			Local.BuffActif.Domination = false
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01")
			end
		-- Changement du bouton de la malédiction amplifiée quand le Démoniste n'est plus sous son emprise
		elseif  nom == NECROSIS_SPELL_TABLE[42].Name then
			Local.BuffActif.Amplify = false
			if _G["NecrosisCurseMenu1"] then
				NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-01")
			end
		-- Changement du bouton du Lien Spirituel quand le Démoniste n'est plus sous son emprise
		elseif nom == NECROSIS_SPELL_TABLE[38].Name then
			Local.BuffActif.SoulLink = false
			if _G["NecrosisBuffMenu7"] then
				NecrosisBuffMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\SoulLink-01")
			end
		-- On cache les boutons de ShadowTrance quand one st plus sous son emprise
		elseif nom == NECROSIS_NIGHTFALL.ShadowTrance or nom == NECROSIS_NIGHTFALL.Backlash then
			NecrosisShadowTranceButton:Hide()
			NecrosisBacklashButton:Hide()
		end
	end
	return
end

-- event : SPELLCAST_STOP
-- Permet de gérer tout ce qui touche aux sorts une fois leur incantation réussie
function Necrosis_SpellManagement()
	local SortActif = false
	if (Local.SpellCasted.Name) then
		-- Messages Posts Cast (Démons et TP)
		PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, Local.BuffActif.Mount = Necrosis_Speech_Then(Local.SpellCasted.Name, Local.SpellCasted.TargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, Local.BuffActif.Mount)

		-- Si le sort lancé à été une Résurrection de Pierre d'âme, on place un timer
		if (Local.SpellCasted.Name == NECROSIS_SPELL_TABLE[11].Name) then
			if Local.SpellCasted.TargetName == UnitName("player") then
				Local.SpellCasted.TargetName = ""
			end
			Local.TimerManagement = Necrosis_InsertTimerParTable(11, Local.SpellCasted.TargetName, "", Local.TimerManagement)
		-- Si le sort était une pierre de soin
		elseif Local.SpellCasted.Name:find(NECROSIS_ITEM.Healthstone) and not Local.SpellCasted.Name:find(NECROSIS_CREATE[2]) then
			Local.TimerManagement = Necrosis_InsertTimerStone("Healthstone", nil, nil, Local.TimerManagement)
		-- Si le sort était une pierre de sort
		elseif Local.SpellCasted.Name:find(NECROSIS_ITEM.Spellstone) and not Local.SpellCasted.Name:find(NECROSIS_CREATE[3]) then
			Local.TimerManagement = Necrosis_InsertTimerStone("Spellstone", nil, nil, Local.TimerManagement)
		-- Pour les autres sorts castés, tentative de timer si valable
		else
			for spell=1, #NECROSIS_SPELL_TABLE, 1 do
				if Local.SpellCasted.Name == NECROSIS_SPELL_TABLE[spell].Name and not (spell == 10) then
					-- Si le timer existe déjà sur la cible, on le met à jour
					if Local.TimerManagement.SpellTimer[1] then
						for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name
								and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
								and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
								and not (NECROSIS_SPELL_TABLE[spell].Type == 4)
								and not (NECROSIS_SPELL_TABLE[spell].Type == 5)
								and not (spell == 16)
								then
								-- Si c'est sort lancé déjà présent sur un mob, on remet le timer à fond
								if not (spell == 9) or (spell == 9 and not Necrosis_UnitHasEffect("target", Local.SpellCasted.Name)) then
									Local.TimerManagement.SpellTimer[thisspell].Time = NECROSIS_SPELL_TABLE[spell].Length
									Local.TimerManagement.SpellTimer[thisspell].TimeMax = floor(GetTime() + NECROSIS_SPELL_TABLE[spell].Length)
									if spell == 9 and Local.SpellCasted.Rank:find("1") then
										Local.TimerManagement.SpellTimer[thisspell].Time = 20
										Local.TimerManagement.SpellTimer[thisspell].TimeMax = floor(GetTime() + 20)
									end
								end
								SortActif = true
								break
							end
							-- Si c'est un banish sur une nouvelle cible, on supprime le timer précédent
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name and spell == 9
								and not
									(Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel)
								then
								Local.TimerManagement = Necrosis_RetraitTimerParIndex(thisspell, Local.TimerManagement)
								SortActif = false
								break
							end

							-- Si c'est un fear, on supprime le timer du fear précédent
							if Local.TimerManagement.SpellTimer[thisspell].Name == Local.SpellCasted.Name and spell == 13 then
								Local.TimerManagement = Necrosis_RetraitTimerParIndex(thisspell, Local.TimerManagement)
								SortActif = false
								break
							end
							if SortActif then break end
						end
						-- Si le timer est une malédiction, on enlève la précédente malédiction sur la cible
						if (NECROSIS_SPELL_TABLE[spell].Type == 4) or (spell == 16) then
							for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
								-- Mais on garde le cooldown de la malédiction funeste
								if Local.TimerManagement.SpellTimer[thisspell].Name == NECROSIS_SPELL_TABLE[16].Name then
									Local.TimerManagement.SpellTimer[thisspell].Target = ""
									Local.TimerManagement.SpellTimer[thisspell].TargetLevel = ""
								end
								if Local.TimerManagement.SpellTimer[thisspell].Type == 4
									and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
									then
									Local.TimerManagement = Necrosis_RetraitTimerParIndex(thisspell, Local.TimerManagement)
									break
								end
							end
							SortActif = false
						-- Si le timer est une corruption, on enlève la précédente corruption sur la cible
						elseif (NECROSIS_SPELL_TABLE[spell].Type == 5) then
							for thisspell=1, #Local.TimerManagement.SpellTimer, 1 do
								if Local.TimerManagement.SpellTimer[thisspell].Type == 5
									and Local.TimerManagement.SpellTimer[thisspell].Target == Local.SpellCasted.TargetName
									and Local.TimerManagement.SpellTimer[thisspell].TargetLevel == Local.SpellCasted.TargetLevel
									then
									Local.TimerManagement = Necrosis_RetraitTimerParIndex(thisspell, Local.TimerManagement)
									break
								end
							end
							SortActif = false
						end
					end
					if not SortActif
						and not (NECROSIS_SPELL_TABLE[spell].Type == 0)
						and not (spell == 10)
						then

						if spell == 9 then
							if Local.SpellCasted.Rank:find("1") then
								NECROSIS_SPELL_TABLE[spell].Length = 20
							else
								NECROSIS_SPELL_TABLE[spell].Length = 30
							end
						end

						Local.TimerManagement = Necrosis_InsertTimerParTable(spell, Local.SpellCasted.TargetName, Local.SpellCasted.TargetLevel, Local.TimerManagement)
						break
					end
				end
			end
		end
	end
	Local.SpellCasted = {}
	return
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE L'INTERFACE -- LIENS XML
------------------------------------------------------------------------------------------------------

-- Fonction permettant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis_OnDragStart(button)
	button:StartMoving()
end

-- Fonction arrêtant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis_OnDragStop(button)
	-- On arrête le déplacement de manière effective
	button:StopMovingOrSizing()
	-- On sauvegarde l'emplacement du bouton
	local NomBouton = button:GetName()
	local AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY = button:GetPoint()
	NecrosisConfig.FramePosition[NomBouton] = {AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY}
end

-- Fonction gérant les bulles d'aide
function Necrosis_BuildTooltip(button, type, anchor)

	-- Si l'affichage des bulles d'aide est désactivé, Bye bye !
	if not NecrosisConfig.NecrosisToolTip then
		return
	end

	-- On regarde si la domination corrompue, le gardien de l'ombre ou l'amplification de malédiction sont up (pour tooltips)
	local start, duration, start2, duration2, start3, duration3, start4, duration4
	if NECROSIS_SPELL_TABLE[15].ID then
		start, duration = GetSpellCooldown(NECROSIS_SPELL_TABLE[15].ID, BOOKTYPE_SPELL)
	else
		start = 1
		duration = 1
	end
	if NECROSIS_SPELL_TABLE[43].ID then
		start2, duration2 = GetSpellCooldown(NECROSIS_SPELL_TABLE[43].ID, BOOKTYPE_SPELL)
	else
		start2 = 1
		duration2 = 1
	end
	if NECROSIS_SPELL_TABLE[42].ID then
		start3, duration3 = GetSpellCooldown(NECROSIS_SPELL_TABLE[42].ID, BOOKTYPE_SPELL)
	else
		start3 = 1
		duration3 = 1
	end
	if NECROSIS_SPELL_TABLE[50].ID then
		start4, duration4 = GetSpellCooldown(NECROSIS_SPELL_TABLE[50].ID, BOOKTYPE_SPELL)
	else
		start4 = 1
		duration4 = 1
	end

	-- Création des bulles d'aides....
	GameTooltip:SetOwner(button, anchor)
	GameTooltip:SetText(NecrosisTooltipData[type].Label)
	-- ..... pour le bouton principal
	if (type == "Main") then
		GameTooltip:AddLine(NecrosisTooltipData.Main.Soulshard..SoulshardsCount)
		GameTooltip:AddLine(NecrosisTooltipData.Main.InfernalStone..Local.Reagent.Infernal)
		GameTooltip:AddLine(NecrosisTooltipData.Main.DemoniacStone..Local.Reagent.Demoniac)
		local SoulOnHand = false
		local HealthOnHand = false
		local SpellOnHand = false
		local FireOnHand = false
		if SoulstoneOnHand then SoulOnHand = true end
		if HealthstoneOnHand then HealthOnHand = true end
		if SpellstoneOnHand then SpellOnHand = true end
		if FirestoneOnHand then FireOnHand = true end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Soulstone..NecrosisTooltipData[type].Stone[SoulOnHand])
		GameTooltip:AddLine(NecrosisTooltipData.Main.Healthstone..NecrosisTooltipData[type].Stone[HealthOnHand])
		-- On vérifie si une pierre de sort n'est pas équipée
		NecrosisTooltip:SetInventoryItem("player", 18)
		local rightHand = tostring(NecrosisTooltipTextLeft1:GetText())
		if rightHand:find(NECROSIS_ITEM.Spellstone) then SpellstoneOnHand = true end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Spellstone..NecrosisTooltipData[type].Stone[SpellOnHand])
		-- De même pour la pierre de feu
		if rightHand:find(NECROSIS_ITEM.Firestone) then FirestoneOnHand = true end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Firestone..NecrosisTooltipData[type].Stone[FireOnHand])
		-- Affichage du nom du démon, ou s'il est asservi, ou "Aucun" si aucun démon n'est présent
		if (DemonType) then
			GameTooltip:AddLine(NecrosisTooltipData.Main.CurrentDemon..DemonType)
		elseif DemonEnslaved then
			GameTooltip:AddLine(NecrosisTooltipData.Main.EnslavedDemon)
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.NoCurrentDemon)
		end
	-- ..... pour les boutons de pierre
	elseif type:find("stone") then
		-- Pierre d'âme
		if (type == "Soulstone") then
			-- On affiche le nom de la pierre et l'action que produira le clic sur le bouton
			-- Et aussi le Temps de recharge
			if SoulstoneMode == 1 or SoulstoneMode == 3 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Mana.." Mana")
			end
			Necrosis_MoneyToggle()
			NecrosisTooltip:SetBagItem(SoulstoneLocation[1], SoulstoneLocation[2])
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText())
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[SoulstoneMode])
			if itemName:find(NECROSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(itemName)
			end
		-- Pierre de vie
		elseif (type == "Healthstone") then
			-- Idem
			if HealthstoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Mana.." Mana")
			end
			Necrosis_MoneyToggle()
			NecrosisTooltip:SetBagItem(HealthstoneLocation[1], HealthstoneLocation[2])
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText())
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[HealthstoneMode])
			if HealthstoneMode == 2 then
				GameTooltip:AddLine(NecrosisTooltipData[type].Text2)
			end
			if itemName:find(NECROSIS_TRANSLATION.Cooldown) then
				GameTooltip:AddLine(itemName)
			end
			if  SoulshardsCount > 0 and not (start4 > 0 and duration4 > 0) then
				GameTooltip:AddLine(NecrosisTooltipData[type].Ritual)
			end
		-- Pierre de sort
		elseif (type == "Spellstone") then
			-- Eadem
			if SpellstoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[3]].Mana.." Mana")
			end
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[SpellstoneMode])
			if SpellstoneMode == 3 then
				Necrosis_MoneyToggle()
				NecrosisTooltip:SetInventoryItem("player", 18)
				if _G["NecrosisTooltipTextLeft9"] then
					local itemName = tostring(NecrosisTooltipTextLeft9:GetText())
					local itemStone = tostring(NecrosisTooltipTextLeft1:GetText())
					if itemStone:find(NECROSIS_ITEM.Spellstone)
						and itemName:find(NECROSIS_TRANSLATION.Cooldown) then
							GameTooltip:AddLine(itemName)
					end
				end
			end
		-- Pierre de feu
		elseif (type == "Firestone") then
			-- Idem, mais sans le cooldown
			if FirestoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[4]].Mana.." Mana")
			end
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[FirestoneMode])
		end
	-- ..... pour le bouton des Timers
	elseif (type == "Local.TimerManagement.SpellTimer") then
		Necrosis_MoneyToggle()
		NecrosisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2])
		local itemName = tostring(NecrosisTooltipTextLeft5:GetText())
		GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		if itemName:find(NECROSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(NECROSIS_TRANSLATION.Hearth.." - "..itemName)
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Right..GetBindLocation())
		end

	-- ..... pour le bouton de la Transe de l'ombre
	elseif (type == "ShadowTrance") or (type == "Backlash") then
		GameTooltip:SetText(NecrosisTooltipData[type].Label.."          |CFF808080"..NECROSIS_SPELL_TABLE[45].Rank.."|r")
	-- ..... pour les autres buffs et démons, le coût en mana...
	elseif (type == "Enslave") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[35].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		end
	elseif (type == "Mount") then
		if NECROSIS_SPELL_TABLE[2].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[2].Mana.." Mana")
			GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		elseif NECROSIS_SPELL_TABLE[1].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[1].Mana.." Mana")
		end
	elseif (type == "Armor") then
		if NECROSIS_SPELL_TABLE[31].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[31].Mana.." Mana")
		else
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[36].Mana.." Mana")
		end
	elseif (type == "FelArmor") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[47].Mana.." Mana")
	elseif (type == "Invisible") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[33].Mana.." Mana")
	elseif (type == "Aqua") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[32].Mana.." Mana")
	elseif (type == "Kilrogg") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[34].Mana.." Mana")
	elseif (type == "Banish") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[9].Mana.." Mana")
		if NECROSIS_SPELL_TABLE[9].Rank:find("2") then
		GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		end
	elseif (type == "Weakness") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[23].Mana.." Mana")
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown)
		end
	elseif (type == "Agony") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[22].Mana.." Mana")
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown)
		end
	elseif (type == "Reckless") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[24].Mana.." Mana")
	elseif (type == "Tongues") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[25].Mana.." Mana")
	elseif (type == "Exhaust") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[40].Mana.." Mana")
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown)
		end
	elseif (type == "Elements") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[26].Mana.." Mana")
	elseif (type == "Shadow") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[27].Mana.." Mana")
	elseif (type == "Doom") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[16].Mana.." Mana")
	elseif (type == "Amplify") then
		if start3 > 0 and duration3 > 0 then
			local seconde = duration3 - ( GetTime() - start3)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec"
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60)
				if seconde <= 9 then
					time = "0"..tostring(floor(seconde))
				else
					time = tostring(floor(seconde))
				end
				affiche = minute..":"..time
			end
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	elseif (type == "TP") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[37].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		end
	elseif (type == "SoulLink") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[38].Mana.." Mana")
	elseif (type == "ShadowProtection") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[43].Mana.." Mana")
		if start2 > 0 and duration2 > 0 then
			local seconde = duration2 - ( GetTime() - start2)
			local affiche
			affiche = tostring(floor(seconde)).." sec"
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	elseif (type == "Domination") then
		if start > 0 and duration > 0 then
			local seconde = duration - ( GetTime() - start)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec"
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60)
				if seconde <= 9 then
					time = "0"..tostring(floor(seconde))
				else
					time = tostring(floor(seconde))
				end
				affiche = minute..":"..time
			end
			GameTooltip:AddLine("Cooldown : "..affiche)
		end
	elseif (type == "Imp") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[3].Mana.." Mana")
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown)
		end

	elseif (type == "Voidwalker") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[4].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown)
		end
	elseif (type == "Succubus") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[5].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown)
		end
	elseif (type == "Felhunter") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[6].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown)
		end
	elseif (type == "Felguard") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[7].Mana.." Mana")
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r")
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown)
		end
	elseif (type == "Infernal") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[8].Mana.." Mana")
		if Local.Reagent.Infernal == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.InfernalStone..Local.Reagent.Infernal.."|r")
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.InfernalStone..Local.Reagent.Infernal)
		end
	elseif (type == "Doomguard") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[30].Mana.." Mana")
		if DemoniacStone == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.DemoniacStone..Local.Reagent.Demoniac.."|r")
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.DemoniacStone..Local.Reagent.Demoniac)
		end
	elseif (type == "BuffMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2)
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		end
	elseif (type == "CurseMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2)
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		end
	elseif (type == "PetMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2)
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text)
		end
	end
	-- Et hop, affichage !
	GameTooltip:Show()
end

-- Fonction mettant à jour les boutons Necrosis et donnant l'état du bouton de la pierre d'âme
function Necrosis_UpdateIcons()
	-- Pierre d'âme
	-----------------------------------------------

	-- On se renseigne pour savoir si une pierre d'âme a été utilisée --> vérification dans les timers
	local SoulstoneInUse = false
	if Local.TimerManagement.SpellTimer then
		for index = 1, #Local.TimerManagement.SpellTimer, 1 do
			if (Local.TimerManagement.SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name)  and Local.TimerManagement.SpellTimer[index].TimeMax > 0 then
				SoulstoneInUse = true
				break
			end
		end
	end

	-- Si la Pierre n'a pas été utilisée, et qu'il n'y a pas de pierre en inventaire -> Mode 1
	if not (SoulstoneOnHand or SoulstoneInUse) then
		SoulstoneMode = 1
	end

	-- Si la Pierre n'a pas été utilisée, mais qu'il y a une pierre en inventaire
	if SoulstoneOnHand and (not SoulstoneInUse) then
		-- Si la pierre en inventaire contient un timer, et qu'on sort d'un RL --> Mode 4
		local start, duration = GetContainerItemCooldown(SoulstoneLocation[1],SoulstoneLocation[2])
		if Local.LoggedIn and start > 0 and duration > 0 then
			Local.TimerManagement = Necrosis_InsertTimerStone("Soulstone", start, duration, Local.TimerManagement)
			SoulstoneMode = 4
			Local.LoggedIn = false
		-- Si la pierre ne contient pas de timer, ou qu'on ne sort pas d'un RL --> Mode 2
		else
			SoulstoneMode = 2
			Local.LoggedIn = false
		end
	end

	-- Si la Pierre a été utilisée mais qu'il n'y a pas de pierre en inventaire --> Mode 3
	if (not SoulstoneOnHand) and SoulstoneInUse then
		SoulstoneMode = 3
	end

	-- Si la Pierre a été utilisée et qu'il y a une pierre en inventaire
	if SoulstoneOnHand and SoulstoneInUse then
			SoulstoneMode = 4
	end

	-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
	if StoneIDInSpellTable[1] and NecrosisConfig.ItemSwitchCombat[5] and (SoulstoneMode == 1 or SoulstoneMode == 3) then
		Necrosis_SoulstoneUpdateAttribute(StoneIDInSpellTable)
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SoulstoneButton-0"..SoulstoneMode)
	end

	-- Pierre de vie
	-----------------------------------------------

	-- Mode "j'en ai une" (2) / "j'en ai pas" (1)
	if (HealthstoneOnHand) then
		HealthstoneMode = 2
	else
		HealthstoneMode = 1
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[2] and NecrosisConfig.ItemSwitchCombat[4] then
			Necrosis_HealthstoneUpdateAttribute(StoneIDInSpellTable)
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\HealthstoneButton-0"..HealthstoneMode)
	end

	-- Pierre de sort
	-----------------------------------------------

	-- Pierre dans l'inventaire, mode 2
	if (SpellstoneOnHand) then
		SpellstoneMode = 2
	-- Pierre inexistante, mode 1
	elseif not (SpellstoneMode == 3) then
		SpellstoneMode = 1
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[3] and NecrosisConfig.ItemSwitchCombat[1] then
			Necrosis_SpellstoneUpdateAttribute(StoneIDInSpellTable)
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellstoneButton-0"..SpellstoneMode)
	end

	-- Pierre de feu
	-----------------------------------------------

	-- Pierre dans l'inventaire = mode 2
	if (FirestoneOnHand) then
		FirestoneMode = 2
	-- Pierre inexistante = mode 1
	elseif not (FirestoneMode == 3) then
		FirestoneMode = 1
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[4] and NecrosisConfig.ItemSwitchCombat[2] then
			Necrosis_FirestoneUpdateAttribute(StoneIDInSpellTable)
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\FirestoneButton-0"..FirestoneMode)
	end

	Necrosis_UpdateMana()
end

-- Update des boutons en fonction de la mana
function Necrosis_UpdateMana()

	local mana = UnitMana("player")

	-- Si cooldown de domination corrompue on grise
	if _G["NecrosisPetMenu1"] and NECROSIS_SPELL_TABLE[15].ID and not Local.BuffActif.Domination then
		local start, duration = GetSpellCooldown(NECROSIS_SPELL_TABLE[15].ID, "spell")
		if start > 0 and duration > 0 then
			NecrosisPetMenu1:GetNormalTexture():SetDesaturated(1)
		else
			NecrosisPetMenu1:GetNormalTexture():SetDesaturated(nil)
		end
	end

	-- Si cooldown de gardien de l'ombre on grise
	if _G["NecrosisBuffMenu8"] and NECROSIS_SPELL_TABLE[43].ID then
		local start2, duration2 = GetSpellCooldown(NECROSIS_SPELL_TABLE[43].ID, "spell")
		if start2 > 0 and duration2 > 0 then
			NecrosisBuffMenu8:GetNormalTexture():SetDesaturated(1)
		else
			NecrosisBuffMenu8:GetNormalTexture():SetDesaturated(nil)
		end
	end

	-- Si cooldown de la malédiction amplifiée on grise
	if _G["NecrosisCurseMenu1"] and NECROSIS_SPELL_TABLE[42].ID and not Local.BuffActif.Amplify then
		local start3, duration3 = GetSpellCooldown(NECROSIS_SPELL_TABLE[42].ID, "spell")
		if start3 > 0 and duration3 > 0 then
			NecrosisCurseMenu1:GetNormalTexture():SetDesaturated(1)
		else
			NecrosisCurseMenu1:GetNormalTexture():SetDesaturated(nil)
		end
	end

	-- Bouton des démons
	-----------------------------------------------

	local ManaPet = new("array",
		true, true, true, true, true, true, true
	)

	if mana then
	-- Coloration du bouton en grisé si pas assez de mana
		if NECROSIS_SPELL_TABLE[3].ID then
			if NECROSIS_SPELL_TABLE[3].Mana > mana then
				for i = 1, 7, 1 do
					ManaPet[i] = false
				end
			elseif NECROSIS_SPELL_TABLE[4].ID then
				if NECROSIS_SPELL_TABLE[4].Mana > mana then
					for i = 2, 7, 1 do
						ManaPet[i] = false
					end
				elseif NECROSIS_SPELL_TABLE[8].ID then
					if NECROSIS_SPELL_TABLE[8].Mana > mana then
						for i = 6, 7, 1 do
							ManaPet[i] = false
						end
					elseif NECROSIS_SPELL_TABLE[30].ID then
						if NECROSIS_SPELL_TABLE[30].Mana > mana then
							ManaPet[7] = false
						end
					end
				end
			end
		end
	end

	-- Coloration du bouton en grisé si pas de pierre pour l'invocation
	if SoulshardsCount == 0 then
		for i = 2, 5, 1 do
			ManaPet[i] = false
		end
	end
	if Local.Reagent.Infernal == 0 then
		ManaPet[6] = false
	end
	if Local.Reagent.Demoniac == 0 then
		ManaPet[7] = false
	end

	-- Texturage des boutons de pet
	local PetButtonNumber = new("array",
		2, 3, 4, 5, 10, 6, 7
	)
	local PetNameHere = new("array",
		"Imp-0", "Voidwalker-0", "Succubus-0", "Felhunter-0", "Felguard-0", "Infernal-0", "Doomguard-0"
	)
	for i = 1, #PetButtonNumber, 1 do
		local PetManaButton = _G["NecrosisPetMenu"..PetButtonNumber[i]]
		if PetManaButton and DemonType == NECROSIS_PET_LOCAL_NAME[i] then
			PetManaButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\"..PetNameHere[i].."2")
		elseif PetManaButton and ManaPet[i] then
			PetManaButton:GetNormalTexture():SetDesaturated(nil)
		elseif PetManaButton then
			PetManaButton:GetNormalTexture():SetDesaturated(1)
		end
	end
	del(PetButtonNumber)
	del(PetNameHere)
	del(ManaPet)


	-- Bouton des buffs
	-----------------------------------------------

	if mana then
	-- Coloration du bouton en grisé si pas assez de mana
		if _G["NecrosisMountButton"] and MountAvailable and not Local.BuffActif.Mount then
			if NECROSIS_SPELL_TABLE[2].ID then
				if NECROSIS_SPELL_TABLE[2].Mana > mana or PlayerCombat then
					NecrosisMountButton:GetNormalTexture():SetDesaturated(1)
				else
					NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
				end
			else
				if NECROSIS_SPELL_TABLE[1].Mana > mana or PlayerCombat then
					NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
				else
					NecrosisMountButton:GetNormalTexture():SetDesaturated(nil)
				end
			end
		end
		if NECROSIS_SPELL_TABLE[35].ID then
			if _G["NecrosisPetMenu8"] then
				if NECROSIS_SPELL_TABLE[35].Mana > mana or SoulshardsCount == 0 then
					NecrosisPetMenu8:GetNormalTexture():SetDesaturated(1)
				else
					NecrosisPetMenu8:GetNormalTexture():SetDesaturated(nil)
				end
			elseif _G["NecrosisBuffMenu11"] then
				if NECROSIS_SPELL_TABLE[35].Mana > mana or SoulshardsCount == 0 then
					NecrosisBuffMenu11:GetNormalTexture():SetDesaturated(1)
				else
					NecrosisBuffMenu11:GetNormalTexture():SetDesaturated(nil)
				end
			end
		end
		if _G["NecrosisBuffMenu1"] and NECROSIS_SPELL_TABLE[31].ID then
			if NECROSIS_SPELL_TABLE[31].Mana > mana then
				NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(1)
			else
				NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(nil)
			end
		elseif _G["NecrosisBuffMenu1"] and NECROSIS_SPELL_TABLE[36].ID then
			if NECROSIS_SPELL_TABLE[36].Mana > mana then
				NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(1)
			else
				NecrosisBuffMenu1:GetNormalTexture():SetDesaturated(nil)
			end
		elseif _G["NecrosisBuffMenu7"] and NECROSIS_SPELL_TABLE[38].ID and not Local.BuffActif.SoulLink then
			if NECROSIS_SPELL_TABLE[38].Mana > mana then
				NecrosisBuffMenu7:GetNormalTexture():SetDesaturated(1)
			else
				NecrosisBuffMenu7:GetNormalTexture():SetDesaturated(nil)
			end
		end

		local BoutonNumber = new("array",
			10, 2, 3, 4, 5, 8, 9
		)
		local SortNumber = new("array",
			47, 32, 33, 34, 37, 43, 9
		)
		for i = 1, #SortNumber, 1 do
			local f = _G["NecrosisBuffMenu"..BoutonNumber[i]]
			if f and NECROSIS_SPELL_TABLE[SortNumber[i]].ID then
				if NECROSIS_SPELL_TABLE[SortNumber[i]].Mana > mana then
					f:GetNormalTexture():SetDesaturated(1)
				else
					f:GetNormalTexture():SetDesaturated(nil)
				end
			end
		end
		del(BoutonNumber)
		del(SortNumber)

		if _G["NecrosisPetMenu9"] and NECROSIS_SPELL_TABLE[44].ID then
			if (NECROSIS_SPELL_TABLE[44].Mana > mana) or (not UnitExists("Pet")) then
				NecrosisPetMenu9:GetNormalTexture():SetDesaturated(1)
			else
				NecrosisPetMenu9:GetNormalTexture():SetDesaturated(nil)
			end
		end

	end

	-- Bouton des curses
	-----------------------------------------------

	if mana then
		local SpellMana = new("array",
			23, 22, 24, 25, 40, 26, 27, 16
		)
		-- Coloration du bouton en grisé si pas assez de mana
		for i = 1, #SpellMana, 1 do
			local f = _G["NecrosisCurseMenu"..i+1]
			if f and NECROSIS_SPELL_TABLE[SpellMana[i]].ID then
				if NECROSIS_SPELL_TABLE[SpellMana[i]].Mana > mana then
					f:GetNormalTexture():SetDesaturated(1)
				else
					f:GetNormalTexture():SetDesaturated(nil)
				end
			end
		end
		del(SpellMana)
	end


	-- Bouton des Timers
	-----------------------------------------------
	if HearthstoneLocation[1] then
		local start, duration, enable = GetContainerItemCooldown(HearthstoneLocation[1], HearthstoneLocation[2])
		if duration > 20 and start > 0 then
			NecrosisSpellTimerButton:GetNormalTexture():SetDesaturated(1)
		else
			NecrosisSpellTimerButton:GetNormalTexture():SetDesaturated(nil)
		end
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DES PIERRES ET DES FRAGMENTS
------------------------------------------------------------------------------------------------------


-- T'AS QU'A SAVOIR OU T'AS MIS TES AFFAIRES !
function Necrosis_SoulshardSetup()
	SoulshardSlotID = 1
	for slot=1, #SoulshardSlot, 1 do
		table.remove(SoulshardSlot, slot)
	end
	for slot=1, GetContainerNumSlots(NecrosisConfig.SoulshardContainer), 1 do
		table.insert(SoulshardSlot, nil)
	end
end


-- Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function Necrosis_BagExplore(arg)
	local soulshards = SoulshardsCount
	-- Ca n'est pas à proprement parlé un sac, mais bon, on regarde si on a une pierre de sort / feu équipée
	NecrosisTooltip:SetInventoryItem("player", 18)
	local rightHand = tostring(NecrosisTooltipTextLeft1:GetText())
	Necrosis_MoneyToggle()
	if rightHand:find(NECROSIS_ITEM.Spellstone) then
		if not InCombatLockdown() then
			NecrosisSpellstoneButton:SetAttribute("type1", "item")
			NecrosisSpellstoneButton:SetAttribute("item", rightHand)
		end
		SpellstoneMode = 3
	elseif rightHand:find(NECROSIS_ITEM.Firestone) then
		FirestoneMode = 3
	end

	if not arg then
		SoulstoneOnHand = nil
		HealthstoneOnHand = nil
		FirestoneOnHand = nil
		SpellstoneOnHand = nil
		HearthstoneOnHand = nil
		-- Parcours des sacs
		for container=0, 4, 1 do
			-- Parcours des emplacements des sacs
			for slot=1, GetContainerNumSlots(container), 1 do
				Necrosis_MoneyToggle()
				NecrosisTooltip:SetBagItem(container, slot)
				local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
				-- Si le sac est le sac défini pour les fragments
				-- hop la valeur du Tableau qui représente le slot du Sac = nil (pas de Shard)
				if (container == NecrosisConfig.SoulshardContainer) then
					if not (itemName == NECROSIS_ITEM.Soulshard) then
						SoulshardSlot[slot] = nil
					end
				end
				-- Dans le cas d'un emplacement non vide
				if itemName then
					-- Si c'est une pierre d'âme, on note son existence et son emplacement
					if itemName:find(NECROSIS_ITEM.Soulstone) then
						SoulstoneOnHand = container
						SoulstoneLocation = {container,slot}
						NecrosisConfig.ItemSwitchCombat[5] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_SoulstoneUpdateAttribute()
					-- Même chose pour une pierre de soin
					elseif itemName:find(NECROSIS_ITEM.Healthstone) then
						HealthstoneOnHand = container
						HealthstoneLocation = {container,slot}
						NecrosisConfig.ItemSwitchCombat[4] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_HealthstoneUpdateAttribute()
					-- Et encore pour la pierre de sort
					elseif itemName:find(NECROSIS_ITEM.Spellstone) then
						SpellstoneOnHand = container
						SpellstoneLocation = {container,slot}
						NecrosisConfig.ItemSwitchCombat[1] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_SpellstoneUpdateAttribute()
					-- La pierre de feu maintenant
					elseif itemName:find(NECROSIS_ITEM.Firestone) then
						FirestoneOnHand = container
						NecrosisConfig.ItemSwitchCombat[2] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_FirestoneUpdateAttribute()
					-- et enfin la pierre de foyer
					elseif itemName:find(NECROSIS_ITEM.Hearthstone) then
						HearthstoneOnHand = container
						HearthstoneLocation = {container,slot}
					end
				end
			end
		end
	else
		if SoulstoneOnHand == arg then SoulstoneOnHand = nil end
		if HealthstoneOnHand == arg then HealthstoneOnHand = nil end
		if FirestoneOnHand == arg then FirestoneOnHand = nil end
		if SpellstoneOnHand == arg then SpellstoneOnHand = nil end
		if HearthstoneOnHand == arg then HearthstoneOnHand = nil end
		for slot=1, GetContainerNumSlots(arg), 1 do
			Necrosis_MoneyToggle()
			NecrosisTooltip:SetBagItem(arg, slot)
			local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
			-- Si le sac est le sac défini pour les fragments
			-- hop la valeur du Tableau qui représente le slot du Sac = nil (pas de Shard)
			if (arg == NecrosisConfig.SoulshardContainer) then
				if not (itemName == NECROSIS_ITEM.Soulshard) then
					SoulshardSlot[slot] = nil
				end
			end
			-- Dans le cas d'un emplacement non vide
			if itemName then
				-- Si c'est une pierre d'âme, on note son existence et son emplacement
				if itemName:find(NECROSIS_ITEM.Soulstone) then
					SoulstoneOnHand = arg
					SoulstoneLocation = {arg,slot}
					NecrosisConfig.ItemSwitchCombat[5] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_SoulstoneUpdateAttribute()
				-- Même chose pour une pierre de soin
				elseif itemName:find(NECROSIS_ITEM.Healthstone) then
					HealthstoneOnHand = arg
					HealthstoneLocation = {arg,slot}
					NecrosisConfig.ItemSwitchCombat[4] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_HealthstoneUpdateAttribute()
				-- Et encore pour la pierre de sort
				elseif itemName:find(NECROSIS_ITEM.Spellstone) then
					SpellstoneOnHand = arg
					SpellstoneLocation = {arg,slot}
					NecrosisConfig.ItemSwitchCombat[1] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_SpellstoneUpdateAttribute()
				-- La pierre de feu maintenant
				elseif itemName:find(NECROSIS_ITEM.Firestone) then
					FirestoneOnHand = arg
					NecrosisConfig.ItemSwitchCombat[2] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_FirestoneUpdateAttribute()
				-- et enfin la pierre de foyer
				elseif itemName:find(NECROSIS_ITEM.Hearthstone) then
					HearthstoneOnHand = arg
					HearthstoneLocation = {arg,slot}
				end
			end
		end
	end


	SoulshardsCount = GetItemCount(6265)
	Local.Reagent.Infernal = GetItemCount(5565)
	Local.Reagent.Demoniac = GetItemCount(16583)

	if IsEquippedItemType("Wand") then
		NecrosisConfig.ItemSwitchCombat[3] = rightHand
	end

	-- On change l'affectation des boutons de pierre de feu et de sort pour prendre en compte la baguette
	Necrosis_RangedUpdateAttribute()

	-- Affichage du bouton principal de Necrosis
	if NecrosisConfig.Circle == 1 then
		if (SoulshardsCount <= 32) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NecrosisConfig.NecrosisColor.."\\Shard"..SoulshardsCount)
		else
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NecrosisConfig.NecrosisColor.."\\Shard32")
		end
	elseif SoulstoneMode ==1 or SoulstoneMode == 2 then
		if (SoulshardsCount <= 32) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Bleu\\Shard"..SoulshardsCount)
		else
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Bleu\\Shard32")
		end
	end
	if NecrosisConfig.ShowCount then
		if NecrosisConfig.CountType == 2 then
			NecrosisShardCount:SetText(Local.Reagent.Infernal.." / "..Local.Reagent.Demoniac)
		elseif NecrosisConfig.CountType == 1 then
			if SoulshardsCount < 10 then
				NecrosisShardCount:SetText("0"..SoulshardsCount)
			else
				NecrosisShardCount:SetText(SoulshardsCount)
			end
		end
	else
		NecrosisShardCount:SetText("")
	end
	-- Et on met le tout à jour !
	Necrosis_UpdateIcons()

	-- S'il y a plus de fragment que d'emplacements dans le sac défini, on affiche un message d'avertissement
	if (SoulshardsCount > soulshards and SoulshardsCount == GetContainerNumSlots(NecrosisConfig.SoulshardContainer)) then
		if (SoulshardDestroy) then
			Necrosis_Msg(NECROSIS_MESSAGE.Bag.FullPrefix..GetBagName(NecrosisConfig.SoulshardContainer)..NECROSIS_MESSAGE.Bag.FullDestroySuffix)
		else
			Necrosis_Msg(NECROSIS_MESSAGE.Bag.FullPrefix..GetBagName(NecrosisConfig.SoulshardContainer)..NECROSIS_MESSAGE.Bag.FullSuffix)
		end
	end
end

-- Fonction qui permet de trouver / ranger les fragments dans les sacs
function Necrosis_SoulshardSwitch(type)
	if (type == "CHECK") then
		SoulshardMP = 0
		for container = 0, 4, 1 do
			for i = 1, 3, 1 do
				if GetBagName(container) == NECROSIS_ITEM.SoulPouch[i] then
					BagIsSoulPouch[container + 1] = true
					break
				else
					BagIsSoulPouch[container + 1] = false
				end
			end
		end
	end
	for container = 0, 4, 1 do
		if BagIsSoulPouch[container+1] then break end
		if not (container == NecrosisConfig.SoulshardContainer) then
			for slot = 1, GetContainerNumSlots(container), 1 do
				Necrosis_MoneyToggle()
				NecrosisTooltip:SetBagItem(container, slot)
				local itemInfo = tostring(NecrosisTooltipTextLeft1:GetText())
				if itemInfo == NECROSIS_ITEM.Soulshard then
					if (type == "CHECK") then
						SoulshardMP = SoulshardMP + 1
					elseif (type == "MOVE") then
						Necrosis_FindSlot(container, slot)
						SoulshardMP = SoulshardMP - 1
					end
				end
			end
		end
	end
end

-- Pendant le déplacement des fragments, il faut trouver un nouvel emplacement aux objets déplacés :)
function Necrosis_FindSlot(shardIndex, shardSlot)
	local full = true
	for slot=1, GetContainerNumSlots(NecrosisConfig.SoulshardContainer), 1 do
		Necrosis_MoneyToggle()
 		NecrosisTooltip:SetBagItem(NecrosisConfig.SoulshardContainer, slot)
 		local itemInfo = NecrosisTooltipTextLeft1:GetText():tostring()
		if not itemInfo:find(NECROSIS_ITEM.Soulshard) then
			PickupContainerItem(shardIndex, shardSlot)
			PickupContainerItem(NecrosisConfig.SoulshardContainer, slot)
			SoulshardSlot[SoulshardSlotID] = slot
			SoulshardSlotID = SoulshardSlotID + 1
			if (CursorHasItem()) then
				if shardIndex == 0 then
					PutItemInBackpack()
				else
					PutItemInBag(19 + shardIndex)
				end
			end
			full = false
			break
		end
	end
	-- Destruction des fragments en sur-nombre si l'option est activée
	if (full and NecrosisConfig.SoulshardDestroy) then
		PickupContainerItem(shardIndex, shardSlot)
		if (CursorHasItem()) then DeleteCursorItem() end
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DES SORTS
------------------------------------------------------------------------------------------------------



-- Affiche ou masque les boutons de sort à chaque nouveau sort appris
function Necrosis_ButtonSetup()
	local NBRScale = (100 + (NecrosisConfig.NecrosisButtonScale - 85)) / 100
	if NecrosisConfig.NecrosisButtonScale <= 95 then
		NBRScale = 1.1
	end

	local ButtonName = new("array",
		"NecrosisFirestoneButton",
		"NecrosisSpellstoneButton",
		"NecrosisHealthstoneButton",
		"NecrosisSoulstoneButton",
		"NecrosisBuffMenuButton",
		"NecrosisMountButton",
		"NecrosisPetMenuButton",
		"NecrosisCurseMenuButton"
	)

	for index, valeur in ipairs(ButtonName) do
		local f = _G[valeur]
		if f then f:Hide() end
	end

	local SpellExist = new("array",
		StoneIDInSpellTable[4],
		StoneIDInSpellTable[3],
		StoneIDInSpellTable[2],
		StoneIDInSpellTable[1],
		BuffMenuCreate[1],
		MountAvailable,
		PetMenuCreate[1],
		CurseMenuCreate[1]
	)

	if NecrosisConfig.NecrosisLockServ then
		local indexScale = -36
		for index=1, #NecrosisConfig.StonePosition, 1 do
			for button = 1, #NecrosisConfig.StonePosition, 1 do
				if math.abs(NecrosisConfig.StonePosition[index]) == button
					and NecrosisConfig.StonePosition[button] > 0
					and SpellExist[button] then
						local f = _G[ButtonName[button]]
						if not f then
							f = Necrosis_CreateSphereButtons(ButtonName[button])
							Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable)
						end
						f:ClearAllPoints()
						f:SetPoint(
							"CENTER", "NecrosisButton", "CENTER",
							((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle - indexScale)),
							((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle - indexScale))
						)
						f:Show()
						indexScale = indexScale + 36
						break
				end
			end
		end
	else
		for index=1, #NecrosisConfig.StonePosition, 1 do
			for button = 1, #NecrosisConfig.StonePosition, 1 do
				if math.abs(NecrosisConfig.StonePosition[index]) == button
					and NecrosisConfig.StonePosition[button] > 0
					and SpellExist[button] then
						local f = _G[ButtonName[button]]
						if not f then
							f = Necrosis_CreateSphereButtons(ButtonName[button])
							Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable)
						end
						f:Show()
						break
				end
			end
		end
	end
	del(ButtonName)
	del(SpellExist)
end



-- Ma fonction préférée ! Elle fait la liste des sorts connus par le démo, et les classe par rang.
-- Pour les pierres, elle sélectionne le plus haut rang connu
function Necrosis_SpellSetup()
	local StoneType = new("array",
		NECROSIS_ITEM.Soulstone, NECROSIS_ITEM.Healthstone, NECROSIS_ITEM.Spellstone, NECROSIS_ITEM.Firestone
	)
	local StoneMaxRank = new("array",
		0, 0, 0, 0
	)

	local CurrentStone = new{"hash",
		"ID", {},
		"Name", {}
	)

	local CurrentSpells = new("hash",
		"ID", {},
		"Name", {},
		"subName", {}
	}

	local spellID = 1
	local Invisible = 0
	local InvisibleID = 0

	-- On va parcourir tous les sorts possedés par le Démoniste
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL)

		if not spellName then
			do break end
		end

		-- Pour les sorts avec des rangs numérotés, on compare pour chaque sort les rangs 1 à 1
		-- Le rang supérieur est conservé
		if subSpellName and not (subSpellName == " " or subSpellName == "") then
			local found = false
			local _, _, rank = subSpellName:find("(%d+)")
			rank = tonumber(rank)
			for index=1, #CurrentSpells.Name, 1 do
				if (CurrentSpells.Name[index] == spellName) then
					found = true
					local _, _, CurrentRank = CurrentSpells.subName[index]:find("(%d+)")
					CurrentRank = tonumber(CurrentRank)
					if CurrentRank < rank then
						CurrentSpells.ID[index] = spellID
						CurrentSpells.subName[index] = subSpellName
					end
					break
				end
			end
			-- Les plus grands rangs de chacun des sorts à rang numérotés sont insérés dans la table
			if (not found) then
				table.insert(CurrentSpells.ID, spellID)
				table.insert(CurrentSpells.Name, spellName)
				table.insert(CurrentSpells.subName, subSpellName)
			end
		-- Les pierres n'ont pas de rang numéroté, l'attribut de rang fait partie du nom du sort
		else
			-- Pour chaque type de pierre, on va donc faire....
			for stoneID = 1, #StoneType, 1 do
				-- Si le sort étudié est bien une invocation de ce type de pierre et qu'on n'a pas
				-- déjà assigné un rang maximum à cette dernière
				if spellName:find(StoneType[stoneID]) then
					local found = false
					-- Reste à trouver la correspondance de son rang
					for rankID = 1, #NECROSIS_STONE_RANK, 1 do
						-- Si la fin du nom de la pierre correspond à une taille de pierre, on note le rang !
						if spellName:find(NECROSIS_STONE_RANK[rankID]) then
							-- On a une pierre, on a son rang, reste à vérifier si c'est la plus puissante,
							-- et si oui, l'enregistrer
							if rankID > StoneMaxRank[stoneID] then
								StoneMaxRank[stoneID] = rankID
								CurrentStone.Name[stoneID] = spellName
								CurrentStone.ID[stoneID] = spellID
							end
							found = true
							break
						end
					end
					if StoneMaxRank[stoneID] <= 3 and not found then
								StoneMaxRank[stoneID] = 3
								CurrentStone.Name[stoneID] = spellName
								CurrentStone.ID[stoneID] = spellID
					end
				end
			end
		end
		spellID = spellID + 1
	end

	-- On insère dans la table les pierres avec le plus grand rang
	for stoneID = 1, #StoneType, 1 do
		if StoneMaxRank[stoneID] > 0 then
			table.insert(NECROSIS_SPELL_TABLE, {
				ID = CurrentStone.ID[stoneID],
				Name = CurrentStone.Name[stoneID],
				Rank = "",
				CastTime = 0,
				Length = 0,
				Type = 0,
			})
			StoneIDInSpellTable[stoneID] = #NECROSIS_SPELL_TABLE
		end
	end
	-- On met à jour la liste des sorts avec les nouveaux rangs
	for spell=1, #NECROSIS_SPELL_TABLE, 1 do
		for index = 1, #CurrentSpells.Name, 1 do
			if (NECROSIS_SPELL_TABLE[spell].Name == CurrentSpells.Name[index])
				and not
					(NECROSIS_SPELL_TABLE[spell].ID == StoneIDInSpellTable[1]
					or NECROSIS_SPELL_TABLE[spell].ID == StoneIDInSpellTable[2]
					or NECROSIS_SPELL_TABLE[spell].ID == StoneIDInSpellTable[3]
					or NECROSIS_SPELL_TABLE[spell].ID == StoneIDInSpellTable[4])
				then
					NECROSIS_SPELL_TABLE[spell].ID = CurrentSpells.ID[index]
					NECROSIS_SPELL_TABLE[spell].Rank = CurrentSpells.subName[index]
			end
		end
	end
	del(CurrentSpells)
	del(CurrentStone)
	del(StoneMaxRank)
	del(StoneType)

	for spellID = 1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell")
		if (spellName) then
			for index = 1, #NECROSIS_SPELL_TABLE, 1 do
				if NECROSIS_SPELL_TABLE[index].Name == spellName then
					Necrosis_MoneyToggle()
					NecrosisTooltip:SetSpell(spellID, 1)
					local _, _, ManaCost = NecrosisTooltipTextLeft2:GetText():find("(%d+)")
					if not NECROSIS_SPELL_TABLE[index].ID then
						NECROSIS_SPELL_TABLE[index].ID = spellID
					end
					NECROSIS_SPELL_TABLE[index].Mana = tonumber(ManaCost)
				end
			end
		end
	end

	for i=1, 4, 1 do
		if StoneIDInSpellTable[i] == 0 then
			StoneIDInSpellTable[i] = nil
		end
	end

	-- On met à jour la durée de chaque sort en fonction de son rang
	-- Peur
	if NECROSIS_SPELL_TABLE[13].ID then
		local _, _, lengtH = NECROSIS_SPELL_TABLE[13].Rank:find("(%d+)")
		NECROSIS_SPELL_TABLE[13].Length = tonumber(lengtH) * 5 + 5
	end
	-- Corruption
	local _, _, ranK = NECROSIS_SPELL_TABLE[14].Rank:find("(%d+)")
	if ranK then ranK = tonumber(ranK) end
	if NECROSIS_SPELL_TABLE[14].ID and ranK <= 2 then
		NECROSIS_SPELL_TABLE[14].Length = ranK * 3 + 9
	end

	-- WoW 2.0 : Les boutons doivent être sécurisés pour être utilisés.
	-- Chaque utilisation passe par la définition d'attributs au bouton, l'UI se chargeant de gérer l'event de clic.

	-- Association du sort de monture correct au bouton
	if NECROSIS_SPELL_TABLE[1].ID or NECROSIS_SPELL_TABLE[2].ID then
		MountAvailable = true
	else
		MountAvailable = false
	end

	if not InCombatLockdown() then
		Necrosis_MainButtonAttribute()
		Necrosis_BuffSpellAttribute()
		Necrosis_PetSpellAttribute()
		Necrosis_CurseSpellAttribute()
		Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable)
	end


end

-- Fonction d'extraction d'attribut de sort
-- F(type=string, string, int) -> Spell=table
function Necrosis_FindSpellAttribute(type, attribute, array)
	for index=1, #NECROSIS_SPELL_TABLE, 1 do
		if NECROSIS_SPELL_TABLE[index][type]:find(attribute) then return NECROSIS_SPELL_TABLE[index][array] end
	end
	return nil
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DIVERSES
------------------------------------------------------------------------------------------------------

-- Fonction pour savoir si une unité subit un effet
-- F(string, string)->bool
function Necrosis_UnitHasEffect(unit, effect)
	local index = 1
	while UnitDebuff(unit, index) do
		Necrosis_MoneyToggle()
		NecrosisTooltip:SetUnitDebuff(unit, index)
		local DebuffName = tostring(NecrosisTooltipTextLeft1:GetText())
   		if DebuffName:find(effect) then
			return true
		end
		index = index + 1
	end
	return false
end

-- Function to check the presence of a buff on the unit.
-- Strictly identical to UnitHasEffect, but as WoW distinguishes Buff and DeBuff, so we have to.
function Necrosis_UnitHasBuff(unit, effect)
	local index = 1
	while UnitBuff(unit, index) do
	-- Here we'll cheat a little. checking a buff or debuff return the internal spell name, and not the name we give at start
		-- So we use an API widget that will use the internal name to return the known name.
		-- For example, the "Curse of Agony" spell is internaly known as "Spell_Shadow_CurseOfSargeras". Much easier to use the first one than the internal one.
		Necrosis_MoneyToggle()
		NecrosisTooltip:SetUnitBuff(unit, index)
		local BuffName = tostring(NecrosisTooltipTextLeft1:GetText())
   		if BuffName:find(effect) then
			return true
		end
		index = index + 1
	end
	return false
end


-- Affiche ou cache le bouton de détection de la peur suivant la cible.
function Necrosis_ShowAntiFearWarning()
	local Actif = false -- must be False, or a number from 1 to AFImageType[] max element.

	-- Checking if we have a target. Any fear need a target to be casted on
	if UnitExists("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") then
		-- Checking if the target has natural immunity (only NPC target)
		if not UnitIsPlayer("target") then
			for index=1, #NECROSIS_UNIT.Undead, 1 do
				if (UnitCreatureType("target") == NECROSIS_UNIT.Undead[index] ) then
					Actif = 2 -- Immun
					break
				end
			end
		end

		-- We'll start to parse the target buffs, as his class doesn't give him natural permanent immunity
		if not Actif then
			for index=1, #NECROSIS_ANTI_FEAR_SPELL.Buff, 1 do
				if Necrosis_UnitHasBuff("target",NECROSIS_ANTI_FEAR_SPELL.Buff[index]) then
					Actif = 3 -- Prot
					break
				end
			end

			-- No buff found, let's try the debuffs
			for index=1, #NECROSIS_ANTI_FEAR_SPELL.Debuff, 1 do
				if Necrosis_UnitHasEffect("target",NECROSIS_ANTI_FEAR_SPELL.Debuff[index]) then
					Actif = 3 -- Prot
					break
				end
			end
		end

		-- an immunity has been detected before, but we still don't know why => show the button anyway
		if AFCurrentTargetImmune and not Actif then
			Actif = 1
		end
	end

	if Actif then
		-- Antifear button is currently not visible, we have to change that
		if not AntiFearInUse then
			AntiFearInUse = true
			Necrosis_Msg(NECROSIS_MESSAGE.Information.FearProtect, "USER")
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..AFImageType[Actif].."-02")
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.Fear) end
			ShowUIPanel(NecrosisAntiFearButton)
			AFBlink1 = GetTime() + 0.6
			AFBlink2 = 2

		-- Timer to make the button blink
		elseif GetTime() >= AFBlink1 then
			if AFBlink2 == 1 then
				AFBlink2 = 2
			else
				AFBlink2 = 1
			end
			AFBlink1 = GetTime() + 0.4
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..AFImageType[Actif].."-0"..AFBlink2)
		end

	elseif AntiFearInUse then	-- No antifear on target, but the button is still visible => gonna hide it
		AntiFearInUse = false
		HideUIPanel(NecrosisAntiFearButton)
	end
end

-- Fonction pour gérer l'échange de pierre (hors combat)
function Necrosis_TradeStone()
		-- Dans ce cas si un pj allié est sélectionné, on lui donne la pierre
		-- Sinon, on l'utilise
		if NecrosisTradeRequest and HealthstoneOnHand and not NecrosisTradeComplete then
			PickupContainerItem(HealthstoneLocation[1], HealthstoneLocation[2])
			ClickTradeButton(1)
			NecrosisTradeComplete = true
			return
		elseif UnitExists("target") and UnitIsPlayer("target")
		and not (UnitCanAttack("player", "target") or UnitName("target") == UnitName("player")) then
				PickupContainerItem(HealthstoneLocation[1], HealthstoneLocation[2])
				if CursorHasItem() then
					DropItemOnUnit("target")
					NecrosisTradeComplete = true
				end
				return
		end
end

function Necrosis_MoneyToggle()
	for index=1, 10 do
		local text = _G["NecrosisTooltipTextLeft"..index]
			if text then text:SetText(nil) end
			text = _G["NecrosisTooltipTextRight"..index]
			if text then text:SetText(nil) end
	end
	NecrosisTooltip:Hide()
	NecrosisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
end

function Necrosis_GameTooltip_ClearMoney()
    -- Intentionally empty don't clear money while we use hidden tooltips
end


-- Fonction (XML) pour rétablir les points d'attache par défaut des boutons
function Necrosis_ClearAllPoints()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:ClearAllPoints() end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:ClearAllPoints() end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:ClearAllPoints() end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:ClearAllPoints() end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:ClearAllPoints() end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:ClearAllPoints() end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:ClearAllPoints() end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:ClearAllPoints() end
end

-- Fonction (XML) pour étendre la propriété NoDrag() du bouton principal de Necrosis sur tout ses boutons
function Necrosis_NoDrag()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:RegisterForDrag("") end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:RegisterForDrag("") end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag("") end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("")end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag("") end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag("") end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag("") end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag("") end
end

-- Fonction (XML) inverse de celle du dessus
function Necrosis_Drag()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag("LeftButton") end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag("LeftButton") end
end


-- A chaque changement du livre des sorts, au démarrage du mod, ainsi qu'au changement de sens du menu on reconstruit les menus des sorts
function Necrosis_CreateMenu()
	PetMenuCreate = {}
	CurseMenuCreate = {}
	BuffMenuCreate = {}
	local menuVariable = nil
	local PetButtonPosition = 0
	local BuffButtonPosition = 0
	local CurseButtonPosition = 0

	-- On cache toutes les icones des démons
	for i = 1, #NecrosisConfig.DemonSpellPosition, 1 do
		menuVariable = _G["NecrosisPetMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end
	-- On cache toutes les icones des sorts
	for i = 1, #NecrosisConfig.BuffSpellPosition, 1 do
		menuVariable = _G["NecrosisBuffMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end
	-- On cache toutes les icones des curses
	for i = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		menuVariable = _G["NecrosisCurseMenu"..i]
		if menuVariable then
			menuVariable:Hide()
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000)
		end
	end

	local MenuID = new("array",
		15, 3, 4, 5, 6, 7, 8, 30, 35, 44
	)
	local ButtonID = new("array",
		1, 2, 3, 4, 5, 10, 6, 7, 8, 9
	)
	-- On ordonne et on affiche les boutons dans le menu des démons
	for index = 1, #NecrosisConfig.DemonSpellPosition, 1 do
		-- Si le sort d'invocation existe, on affiche le bouton dans le menu des pets
		for sort = 1, #NecrosisConfig.DemonSpellPosition, 1 do
			if math.abs(NecrosisConfig.DemonSpellPosition[index]) == sort
				and NecrosisConfig.DemonSpellPosition[sort] > 0
				and NECROSIS_SPELL_TABLE[ MenuID[sort] ].ID then
					-- Création à la demande du bouton du menu des démons
					if not _G["NecrosisPetMenuButton"] then
						_ = Necrosis_CreateSphereButtons("PetMenu")
					end
					menuVariable = _G["NecrosisPetMenu"..ButtonID[sort]]
					if not menuVariable then
						menuVariable = Necrosis_CreateMenuPet(ButtonID[sort])
					end
					menuVariable:ClearAllPoints()
					menuVariable:SetPoint(
						"CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER",
						NecrosisConfig.PetMenuPos.x * 32,
						NecrosisConfig.PetMenuPos.y * 32
					)
					PetButtonPosition = ButtonID[sort]
					table.insert(PetMenuCreate, menuVariable)
					break
			end
		end
	end
	del(MenuID)
	del(ButtonID)

	-- Maintenant que tous les boutons de pet sont placés les uns à côté des autres, on affiche les disponibles
	if PetMenuCreate[1] then
		PetMenuCreate[1]:ClearAllPoints()
		PetMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisPetMenuButton", "CENTER",
			NecrosisConfig.PetMenuPos.x * 32 + NecrosisConfig.PetMenuDecalage.x,
			NecrosisConfig.PetMenuPos.y * 32 + NecrosisConfig.PetMenuDecalage.y
		)
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisPetMenu")
		for i = 1, #PetMenuCreate, 1 do
			NecrosisPetMenu0:SetAttribute("addchild", PetMenuCreate[i])
			PetMenuCreate[i]:SetAttribute("showstates", "!0,*")
			PetMenuCreate[i]:SetAttribute("anchorchild", NecrosisPetMenu0)
			PetMenuCreate[i]:Hide()
		end
		Necrosis_PetSpellAttribute()
	end

	-- On ordonne et on affiche les boutons dans le menu des buffs
	local MenuID = new("array",
		47, 32, 33, 34, 37, 39, 38, 43, 35, 9
	)
	local ButtonID = new("array",
		10, 2, 3, 4, 5, 6, 7, 8, 11, 9
	)
	for index = 1, #NecrosisConfig.BuffSpellPosition, 1 do
		-- Si le buff existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 1
			and NecrosisConfig.BuffSpellPosition[1] > 0
			and (NECROSIS_SPELL_TABLE[31].ID or NECROSIS_SPELL_TABLE[36].ID) then
				-- Création à la demande du bouton du menu des Buffs
				if not _G["NecrosisBuffMenuButton"] then
					_ = Necrosis_CreateSphereButtons("BuffMenu")
				end
				menuVariable = _G["NecrosisBuffMenu1"]
				if not menuVariable then
					menuVariable = Necrosis_CreateMenuBuff(1)
				end
				menuVariable:ClearAllPoints()
				menuVariable:SetPoint(
					"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
					NecrosisConfig.BuffMenuPos.x * 32,
					NecrosisConfig.BuffMenuPos.y * 32
				)
				BuffButtonPosition = 1
				table.insert(BuffMenuCreate, menuVariable)
		else
			for sort = 2, #NecrosisConfig.BuffSpellPosition, 1 do
				if math.abs(NecrosisConfig.BuffSpellPosition[index]) == sort
					and NecrosisConfig.BuffSpellPosition[sort] > 0
					and NECROSIS_SPELL_TABLE[ MenuID[sort - 1] ].ID then
						-- Création à la demande du bouton du menu des Buffs
						if not _G["NecrosisBuffMenuButton"] then
							_ = Necrosis_CreateSphereButtons("BuffMenu")
						end
						menuVariable = _G["NecrosisBuffMenu"..ButtonID[sort - 1]]
						if not menuVariable then
							menuVariable = Necrosis_CreateMenuBuff(ButtonID[sort - 1])
						end
						menuVariable:ClearAllPoints()
						menuVariable:SetPoint(
							"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
							NecrosisConfig.BuffMenuPos.x * 32,
							NecrosisConfig.BuffMenuPos.y * 32
						)
						BuffButtonPosition = ButtonID[sort - 1]
						table.insert(BuffMenuCreate, menuVariable)
						break
				end
			end
		end
	end
	del(MenuID)
	del(ButtonID)

	-- Maintenant que tous les boutons de buff sont placés les uns à côté des autres, on affiche les disponibles
	if BuffMenuCreate[1] then
		BuffMenuCreate[1]:ClearAllPoints()
		BuffMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisBuffMenuButton", "CENTER",
			NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.BuffMenuDecalage.x,
			NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.BuffMenuDecalage.y
		)
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisBuffMenu")
		for i = 1, #BuffMenuCreate, 1 do
			NecrosisBuffMenu0:SetAttribute("addchild", BuffMenuCreate[i])
			BuffMenuCreate[i]:SetAttribute("showstates", "!0,*")
			BuffMenuCreate[i]:SetAttribute("anchorchild", NecrosisBuffMenu0)
			BuffMenuCreate[i]:Hide()
		end
		Necrosis_BuffSpellAttribute()
	end


	-- On ordonne et on affiche les boutons dans le menu des malédictions
	-- MenuID contient l'emplacement des sorts en question dans la table des sorts de Necrosis.
	local MenuID = new("array",
		42, 23, 22, 24, 25, 40, 26, 27, 16
	)
	for index = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		for sort = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		-- Si la Malédiction existe, on affiche le bouton dans le menu des curses
			if math.abs(NecrosisConfig.CurseSpellPosition[index]) == sort
				and NecrosisConfig.CurseSpellPosition[sort] > 0
				and NECROSIS_SPELL_TABLE[MenuID[sort]].ID then
					-- Création à la demande du bouton du menu des malédictions
					if not _G["NecrosisCurseMenuButton"] then
						_ = Necrosis_CreateSphereButtons("CurseMenu")
					end
					menuVariable = _G["NecrosisCurseMenu"..sort]
					if not menuVariable then
						menuVariable = Necrosis_CreateMenuCurse(sort)
					end
					menuVariable:ClearAllPoints()
					menuVariable:SetPoint(
						"CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER",
						NecrosisConfig.CurseMenuPos.x * 32,
						NecrosisConfig.CurseMenuPos.y * 32
					)
					CurseButtonPosition = sort
					table.insert(CurseMenuCreate, menuVariable)
					break
			end
		end
	end
	del(MenuID)

	-- Maintenant que tous les boutons de curse sont placés les uns à côté des autres, on affiche les disponibles
	if CurseMenuCreate[1] then
		CurseMenuCreate[1]:ClearAllPoints()
		CurseMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisCurseMenuButton", "CENTER",
			NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.CurseMenuDecalage.x,
			NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.CurseMenuDecalage.y
		)
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisCurseMenu")
		for i = 1, #CurseMenuCreate, 1 do
			NecrosisCurseMenu0:SetAttribute("addchild", CurseMenuCreate[i])
			CurseMenuCreate[i]:SetAttribute("showstates", "!0,*")
			CurseMenuCreate[i]:SetAttribute("anchorchild", NecrosisCurseMenu0)
			CurseMenuCreate[i]:Hide()
		end
		Necrosis_CurseSpellAttribute()
	end

	-- On bloque le menu en position ouverte si configuré
	if NecrosisConfig.BlockedMenu then
		NecrosisBuffMenu0:SetAttribute("state", "4")
		NecrosisPetMenu0:SetAttribute("state", "4")
		NecrosisCurseMenu0:SetAttribute("state", "4")
	end
end

-- Fonction pour ramener tout au centre de l'écran
function Necrosis_Recall()
	local ui = new("array",
		"NecrosisButton",
		"NecrosisSpellTimerButton",
		"NecrosisAntiFearButton",
		"NecrosisCreatureAlertButton",
		"NecrosisBacklashButton",
		"NecrosisShadowTranceButton"
	)
	local pos =new("array",
		{0, -100},
		{0, 100},
		{20, 0},
		{60, 0},
		{-60, 0},
		{-20, 0}
	}
	for i = 1, #ui, 1 do
		local f = _G[ui[i]]
		f:ClearAllPoints()
		f:SetPoint("CENTER", "UIParent", "CENTER", pos[i][1], pos[i][2])
		f:Show()
		Necrosis_OnDragStop(f)
	end
	del(ui)
	del(pos)
end

-- Fonction permettant le renversement des timers sur la gauche / la droite
function Necrosis_SymetrieTimer(bool)
	local num
	if bool then
		NecrosisConfig.SpellTimerPos = -1
		NecrosisConfig.SpellTimerJust = "RIGHT"
		AnchorSpellTimerTooltip = "ANCHOR_LEFT"

		num = 1
		while _G["NecrosisTimerFrame"..num.."OutText"] do
			_G["NecrosisTimerFrame"..num.."OutText"]:ClearAllPoints()
			_G["NecrosisTimerFrame"..num.."OutText"]:SetPoint(
				"RIGHT",
				_G["NecrosisTimerFrame"..num],
				"LEFT",
				-5, 1
			)
			_G["NecrosisTimerFrame"..num.."OutText"]:SetJustifyH("RIGHT")
			num = num + 1
		end
	else
		NecrosisConfig.SpellTimerPos = 1
		NecrosisConfig.SpellTimerJust = "LEFT"
		AnchorSpellTimerTooltip = "ANCHOR_RIGHT"

		num = 1
		while _G["NecrosisTimerFrame"..num.."OutText"] do
			_G["NecrosisTimerFrame"..num.."OutText"]:ClearAllPoints()
			_G["NecrosisTimerFrame"..num.."OutText"]:SetPoint(
				"LEFT",
				_G["NecrosisTimerFrame"..num],
				"RIGHT",
				5, 1
			)
			_G["NecrosisTimerFrame"..num.."OutText"]:SetJustifyH("LEFT")
			num = num + 1
		end
	end
	NecrosisTimerFrame0:ClearAllPoints()
	NecrosisTimerFrame0:SetPoint(
		NecrosisConfig.SpellTimerJust,
		NecrosisSpellTimerButton,
		"CENTER",
		NecrosisConfig.SpellTimerPos * 20, 0
	)
end

-- Fonction permettant l'affichage des différentes pages du livre des configurations
function NecrosisGeneralTab_OnClick(id)
	local TabName
	for index=1, 5, 1 do
		TabName = _G["NecrosisGeneralTab"..index]
		if index == id then
			TabName:SetChecked(1)
		else
			TabName:SetChecked(nil)
		end
	end
	if id == 1 then
		ShowUIPanel(NecrosisShardMenu)
		HideUIPanel(NecrosisMessageMenu)
		HideUIPanel(NecrosisButtonMenu)
		HideUIPanel(NecrosisTimerMenu)
		HideUIPanel(NecrosisGraphOptionMenu)
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu1)
	elseif id == 2 then
		HideUIPanel(NecrosisShardMenu)
		ShowUIPanel(NecrosisMessageMenu)
		HideUIPanel(NecrosisButtonMenu)
		HideUIPanel(NecrosisTimerMenu)
		HideUIPanel(NecrosisGraphOptionMenu)
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu2)
	elseif id == 3 then
		HideUIPanel(NecrosisShardMenu)
		HideUIPanel(NecrosisMessageMenu)
		ShowUIPanel(NecrosisButtonMenu)
		HideUIPanel(NecrosisTimerMenu)
		HideUIPanel(NecrosisGraphOptionMenu)
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu3)
	elseif id == 4 then
		HideUIPanel(NecrosisShardMenu)
		HideUIPanel(NecrosisMessageMenu)
		HideUIPanel(NecrosisButtonMenu)
		ShowUIPanel(NecrosisTimerMenu)
		HideUIPanel(NecrosisGraphOptionMenu)
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu4)
	elseif id == 5 then
		HideUIPanel(NecrosisShardMenu)
		HideUIPanel(NecrosisMessageMenu)
		HideUIPanel(NecrosisButtonMenu)
		HideUIPanel(NecrosisTimerMenu)
		ShowUIPanel(NecrosisGraphOptionMenu)
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu5)
	end
end

function NecrosisTimer(nom, duree)
	local Cible = UnitName("target")
	local Niveau = UnitLevel("target")
	local truc = 6
	if not Cible then
		Cible = ""
		truc = 2
	end
	if not Niveau then
		Niveau = ""
	end

	Local.TimerManagement = NecrosisTimerX(nom, duree, truc, Cible, Niveau, Local.TimerManagement)
end

-- Time l'équipement de la pierre de sort.
function Necrosis_EquipSpellStone()
	if SpellstoneMode == 2 then
		Local.TimerManagement = Necrosis_InsertTimerStone("SpellstoneIn", nil, nil, Local.TimerManagement)
	end
end

function Necrosis_SearchWand(bool)
	local ItemOnHand = nil
	local baggy = new()
	for container=0, 4, 1 do
		-- Parcours des emplacements des sacs
		for slot=1, GetContainerNumSlots(container), 1 do
			Necrosis_MoneyToggle()
			NecrosisTooltip:SetBagItem(container, slot)
			local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
			local itemName2 = tostring(NecrosisTooltipTextLeft2:GetText())
			local itemName3 = tostring(NecrosisTooltipTextLeft3:GetText())
			local itemSwitch = tostring(NecrosisTooltipTextRight3:GetText())
			local itemSwitch2 = tostring(NecrosisTooltipTextRight4:GetText())
			-- Dans le cas d'un emplacement non vide
			if itemName then
				-- On note aussi la présence ou non des objets "main gauche"
				-- Plus tard ce sera utilisé pour remplacer automatiquement une pierre absente
				if (itemSwitch == NECROSIS_ITEM.Ranged or itemSwitch2 == NECROSIS_ITEM.Ranged)
					and (itemName2 == NECROSIS_ITEM.Soulbound or itemName3 == NECROSIS_ITEM.Soulbound)
					then
					ItemOnHand = itemName
					NecrosisConfig.ItemSwitchCombat[3] = itemName
					table.insert(baggy, 1, container)
					table.insert(baggy, 2, slot)
					break
				end
			end
		end
	end
	if ItemOnHand then
		PickupContainerItem(baggy[1],baggy[2])
		PickupInventoryItem(18)
	end
	del(baggy)
end
