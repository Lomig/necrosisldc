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
-- Version 09.12.2006-3
------------------------------------------------------------------------------------------------------

-- Configuration par défaut
-- Se charge en cas d'absence de configuration ou de changement de version
Default_NecrosisConfig = {
	Version = NecrosisData.Version;
	SoulshardContainer = 4;
	SoulshardSort = false;
	SoulshardDestroy = false;
	ShadowTranceAlert = true;
	ShowSpellTimers = true;
	AntiFearAlert = true;
	CreatureAlert = true;
	NecrosisLockServ = true;
	NecrosisAngle = 180;
	StonePosition = {1, 2, 3, 4, 5, 6, 7, 8};
		-- 1 = Firestone
		-- 2 = Spellstone
		-- 3 = Soins
		-- 4 = Ame
		-- 5 = Buff
		-- 6 = Monture
		-- 7 = Démon
		-- 8 = Malédictions
	CurseSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9};
		-- 1 = Malédiction amplifiée
		-- 2 = Faiblesse
		-- 3 = Agonie
		-- 4 = Témérité
		-- 5 = Langage
		-- 6 = Fatigue
		-- 7 = Elements
		-- 8 = Ombre
		-- 9 = Funeste
	DemonSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
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
	BuffSpellPosition = {1, 2, 3, 4, 5, 6, 7, 8, 9, -10, 11};
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
	NecrosisToolTip = true;
	NoDragAll = false;

	AutomaticMenu = false;
	PetMenuPos = {x=1, y=0};
	PetMenuDecalage = {x=1, y=26};

	BuffMenuPos = {x=1, y=0};
	BuffMenuDecalage = {x=1, y=26};

	CurseMenuPos = {x=1, y=0};
	CurseMenuDecalage = {x=1, y=-26};

	ChatMsg = true;
	ChatType = true;
	NecrosisLanguage = GetLocale();
	ShowCount = true;
	CountType = 1;
	ShadowTranceScale = 100;
	NecrosisButtonScale = 90;
	NecrosisColor = "Rose";
	Sound = true;
	SpellTimerPos = 1;
	SpellTimerJust = "LEFT";
	Circle = 1;
	Graphical = true;
	Yellow = true;
	SensListe = 1;
	PetName = {
		[1] = " ",
		[2] = " ",
		[3] = " ",
		[4] = " ",
		[5] = " ",
	};
	DominationUp = false;
	AmplifyUp = false;
	SM = false;
	SteedSummon = false;
	DemonSummon = true;
	BanishScale = 100;
	ItemSwitchCombat = {nil,nil,nil,nil,nil};
	CurseBlock = false;
	PetBlock = false;
	BuffBlock = false;
	FramePosition = {
		["NecrosisSpellTimerButton"] = {"CENTER", nil, "CENTER", 100, 300},
		["NecrosisButton"] = {"CENTER", nil, "CENTER", 0, -200},
		["NecrosisCreatureAlertButton"] = {"CENTER", nil, "CENTER", -60, 0},
		["NecrosisAntiFearButton"] = {"CENTER", nil, "CENTER", -20, 0},
		["NecrosisShadowTranceButton"] = {"CENTER", nil, "CENTER", 20, 0},
		["NecrosisBacklashButton"] = {"CENTER", nil, "CENTER", 60, 0}
	};
};

NecrosisConfig = {};
NecrosisBinding = {};
NecrosisAlreadyBind = {};

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0);

-- Détection des initialisations du mod
local NecrosisRL = true;

-- Initialisation des variables utilisées par Necrosis pour la gestion des sorts lancés
local SpellCastName = nil;
local SpellCastUnit = nil;
local SpellCastRank = nil;
local SpellTargetName = nil;
local SpellTargetLevel = nil;
local SpellCastTime = 0;

-- Initialisation des tableaux gérant les Timers
-- Un pour les sorts à timer, l'autre pour les groupes de mobs
-- Le dernier permet l'association d'un timer à une frame graphique
SpellTimer = {};
local SpellGroup = {
	Name = {"Rez", "Main", "Cooldown"},
	SubName = {" ", " ", " "},
	Visible = {true, true, true}
};

local TimerTable = {};
for i = 1, 30, 1 do
	TimerTable[i] = false;
end

-- Liste des boutons disponible pour le démoniste dans chaque menu
local PetMenuCreate = {};
local BuffMenuCreate = {};
local CurseMenuCreate = {};

-- Variables utilisées pour la gestion des montures
local MountAvailable = false;
local NecrosisMounted = false;
local PlayerCombat = false;

-- Variables utilisées pour la gestion des transes de l'ombre / Backlash
local NecrosisProc = {
	{"ShadowTrance", false, -1},
	{"Backlash", false, -1}
};
local AntiFearInUse = false;

-- Variables utilisées pour la gestion des fragments d'âme
-- (principalement comptage)
local SoulshardsCount = 0;
local SoulshardContainer = 4;
local SoulshardSlot = {};
local SoulshardSlotID = 1;
local SoulshardMP = 0;
local SoulshardTime = 0;

-- Variables utilisées pour la gestion des composants d'invocation
-- (principalement comptage)
local InfernalStoneCount = 0;
local DemoniacStoneCount = 0;


-- Variables utilisées pour la gestion des boutons d'invocation et d'utilisation des pierres
local StoneIDInSpellTable = {0, 0, 0, 0}
local SoulstoneOnHand = false;
local SoulstoneLocation = {nil,nil};
local SoulstoneMode = 1;
local HealthstoneOnHand = false;
local HealthstoneLocation = {nil,nil};
local HealthstoneMode = 1;
local FirestoneOnHand = false;
local FirestoneMode = 1;
local SpellstoneOnHand = false;
local SpellstoneLocation = {nil,nil};
local SpellstoneMode = 1;
local HearthstoneOnHand = false;
local HearthstoneLocation = {nil,nil};

-- Variables utilisées dans la gestion des démons
local DemonType = nil;
local DemonEnslaved = false;

-- Variables utilisées pour l'anti-fear
local AFblink1, AFBlink2 = 0;
local AFImageType = { "", "Immu", "Prot"}; -- Fear warning button filename variations
local AFCurrentTargetImmune = false;
local CurrentTargetBan = false;

-- Variables utilisées pour les échanges de pierre avec les joueurs
local NecrosisTradeRequest = false;

-- Gestion des sacs à fragment d'âme
local BagIsSoulPouch = {nil, nil, nil, nil, nil};

-- Variable contenant les derniers messages invoqués
local PetMess = 0
local SteedMess = 0
local RezMess = 0
local TPMess = 0
local PlayerSoulstoned = {};
local SteedSummoned = {};
local PlayerSummoned = {};
local DemonSummoned = {};
local DemonSacrified = {};
local DemonName = nil;

-- Permet la gestion des tooltips dans Necrosis (sans la frame des pièces de monnaie)
local lOriginal_GameTooltip_ClearMoney;

local Necrosis_In = true;
local LastUpdate = 0;
local LastUpdate2 = 0;

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS APPLIQUEES A L'ENTREE DANS LE JEU
------------------------------------------------------------------------------------------------------


-- Fonction appliquée au chargement
function Necrosis_OnLoad()

	local _, Classe = UnitClass("player");
	if Classe == "WARLOCK" then

		-- Initialisation du mod
		Necrosis_Initialize();

		-- Enregistrement des événements interceptés par Necrosis
		NecrosisButton:RegisterEvent("PLAYER_ENTERING_WORLD");
		NecrosisButton:RegisterEvent("PLAYER_LEAVING_WORLD");
		NecrosisButton:RegisterEvent("BAG_UPDATE");
		NecrosisButton:RegisterEvent("COMBAT_TEXT_UPDATE");
		NecrosisButton:RegisterEvent("PLAYER_REGEN_DISABLED");
		NecrosisButton:RegisterEvent("PLAYER_REGEN_ENABLED");
		NecrosisButton:RegisterEvent("UNIT_PET");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_FAILED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_SENT");
		NecrosisButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
		NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		NecrosisButton:RegisterEvent("PLAYER_TARGET_CHANGED");
		NecrosisButton:RegisterEvent("TRADE_REQUEST");
		NecrosisButton:RegisterEvent("TRADE_REQUEST_CANCEL");
		NecrosisButton:RegisterEvent("TRADE_SHOW");
		NecrosisButton:RegisterEvent("TRADE_CLOSED");

		-- Easter Egg
		if UnitName("player") == "Lycion" then
			SendChatMessage("Je suis le pire noob de la terre, et Lomig est mon maitre !", "GUILD");
			SendChatMessage("Il n'y a pas plus cr\195\169tin que Lycion... Virez moi !", "OFFICER");
			SendChatMessage("Lycion floode Cyrax by Lomig", "WHISPER", "Common", "Cyrax");
		end

		-- Détection du type de démon présent à la connexion
		DemonType = UnitCreatureFamily("pet");
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS
------------------------------------------------------------------------------------------------------

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function Necrosis_OnUpdate(elapsed)
	LastUpdate = LastUpdate + elapsed;
	LastUpdate2 = LastUpdate2 + elapsed;

	-- Toutes les secondes
	if LastUpdate > 1 then
	-- Si configuré, tri des fragment toutes les secondes
		if NecrosisConfig.SoulshardSort and SoulshardMP > 0  then
			Necrosis_SoulshardSwitch("MOVE");
		end
		LastUpdate = 0;
	end

	-- Toutes les demies secondes
	if LastUpdate2 > 0.5 then
		-- Si configuré, affichage des avertissements d'Antifear
		if NecrosisConfig.AntiFearAlert then
			Necrosis_ShowAntiFearWarning();
		end
		LastUpdate2 = 0;
	end

	local curTime = GetTime();

	-- Gestion du Timer des sorts
	if (not NecrosisSpellTimerButton:IsVisible()) then
		ShowUIPanel(NecrosisSpellTimerButton);
	end
	local display = "";

	if NecrosisConfig.CountType == 3 then
		NecrosisShardCount:SetText("");
	end
	local update = false;
	if ((curTime - SpellCastTime) >= 1) then
		SpellCastTime = curTime;
		update = true;
	end

	-- Parcours du tableau des Timers
	local GraphicalTimer = {texte = {}, TimeMax = {}, Time = {}, titre = {}, temps = {}, Gtimer = {}};
	if SpellTimer then
		for index = 1, #SpellTimer, 1 do
			if SpellTimer[index] then
				if (GetTime() <= SpellTimer[index].TimeMax) then
					-- Création de l'affichage des timers
					display, SpellGroup, GraphicalTimer, TimerTable = Necrosis_DisplayTimer(display, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable);
				end
				-- Action toutes les secondes
				if (update) then
					-- On enlève les timers terminés
					local TimeLocal = GetTime();
					if TimeLocal >= (SpellTimer[index].TimeMax - 0.5) and SpellTimer[index].TimeMax ~= -1 then
						-- Si le timer était celui de la Pierre d'âme, on prévient le Démoniste
						if SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name then
							Necrosis_Msg(NECROSIS_MESSAGE.Information.SoulstoneEnd);
							SpellTimer[index].Target = "";
							SpellTimer[index].TimeMax = -1;
							if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.SoulstoneEnd); end
							Necrosis_RemoveFrame(SpellTimer[index].Gtimer, TimerTable);
							-- On met à jour l'apparence du bouton de la pierre d'âme
							Necrosis_UpdateIcons();
						-- Sinon on enlève le timer silencieusement (mais pas en cas d'enslave)
						elseif SpellTimer[index].Name ~= NECROSIS_SPELL_TABLE[10].Name then
							SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
							index = 0;
							break;
						end
					end
					-- Si le Démoniste n'est plus sous l'emprise du Sacrifice
					if SpellTimer and SpellTimer[index].Name == NECROSIS_SPELL_TABLE[17].Name then -- Sacrifice
						if not Necrosis_UnitHasEffect("player", SpellTimer[index].Name) and SpellTimer[index].TimeMax ~= nil then
							SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
							index = 0;
							break;
						end
					end
					-- Si la cible visée n'est plus atteinte par un sort lancé [résists]
					if SpellTimer and (SpellTimer[index].Type == 4 or SpellTimer[index].Type == 5 or SpellTimer[index].Type == 6)
						and SpellTimer[index].Target == UnitName("target")
						then
						-- On triche pour laisser le temps au mob de bien sentir qu'il est débuffé ^^
						if TimeLocal >= ((SpellTimer[index].TimeMax - SpellTimer[index].Time) + 1.5)
							and SpellTimer[index] ~= 6 then
							if not Necrosis_UnitHasEffect("target", SpellTimer[index].Name) then
								SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
								index = 0;
								break;
							end
						end
					end
				end
			end
		end
	else
		for i = 1, 10, 1 do
			local frameItem = _G["NecrosisTarget"..i.."Text"];
			if frameItem:IsShown() then
				frameItem:Hide();
			end
		end
	end

	if NecrosisConfig.ShowSpellTimers or NecrosisConfig.Graphical then
		-- Si affichage de timer texte
		if not NecrosisConfig.Graphical then
			-- Coloration de l'affichage des timers
			display = Necrosis_MsgAddColor(display);
			-- Affichage des timers
			NecrosisListSpells:SetText(display);
		else
			NecrosisListSpells:SetText("");
		end
		for i = 4, #SpellGroup.Name do
			SpellGroup.Visible[i] = false;
		end
	else
		if (NecrosisSpellTimerButton:IsVisible()) then
			NecrosisListSpells:SetText("");
			HideUIPanel(NecrosisSpellTimerButton);
		end
	end
end

-- Fonction lancée selon l'événement intercepté
function Necrosis_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		Necrosis_In = true;
	elseif (event == "PLAYER_LEAVING_WORLD") then
		Necrosis_In = false;
	end

	-- Traditionnel test : Le joueur est-il bien Démoniste ?
	-- Le jeu est-il bine chargé ?
	if not Necrosis_In then
		return;
	end

	-- Si le contenu des sacs a changé, on vérifie que les Fragments d'âme sont toujours dans le bon sac
	if (event == "BAG_UPDATE") then
		Necrosis_BagExplore(arg1);
		if (NecrosisConfig.SoulshardSort) then
			Necrosis_SoulshardSwitch("CHECK");
		end
	-- Gestion de l'incantation des sorts réussie
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
		SpellCastUnit, SpellCastName = arg1, arg2
		if SpellCastUnit == "player" then
			Necrosis_SpellManagement();
		end
	-- Quand le démoniste commence à incanter un sort, on intercepte le nom de celui-ci
	-- On sauve également le nom de la cible du sort ainsi que son niveau
	elseif (event == "UNIT_SPELLCAST_SENT") then
		_, SpellCastName, SpellCastRank, SpellTargetName = arg1, arg2, arg3, arg4;
		if (not SpellTargetName or SpellTargetName == "") and UnitName("target") then
			SpellTargetName = UnitName("target");
		elseif not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
		DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess = Necrosis_Speech_It(SpellCastName, SpellTargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess);

		if SpellCastName == NECROSIS_SPELL_TABLE[15].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[30].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[35].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[44].Name
			then
			AlphaPetMenu = 1;
			AlphaPetVar = GetTime() + 3;
		end
		if SpellCastName == NECROSIS_SPELL_TABLE[42].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[22].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[23].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[24].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[25].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[26].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[27].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[40].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[16].Name
			then
			AlphaCurseMenu = 1;
			AlphaCurseVar = GetTime() + 3;
		end
		if SpellCastName == NECROSIS_SPELL_TABLE[31].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[32].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[33].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[34].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[35].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[36].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[38].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[39].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[43].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[9].Name
			then
			AlphaBuffMenu = 1;
			AlphaBuffVar = GetTime() + 3;
		end
	-- Quand le démoniste stoppe son incantation, on relache le nom de celui-ci
	elseif (event == "UNIT_SPELLCAST_FAILED") or (event == "UNIT_SPELLCAST_INTERRUPTED") then
		if arg1 == "player" then
			SpellCastName = nil;
			SpellCastRank = nil;
			SpellTargetName = nil;
			SpellTargetLevel = nil;
		end
	-- Flag si une fenetre de Trade est ouverte, afin de pouvoir trader automatiquement les pierres de soin
	elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
		NecrosisTradeRequest = true;
	elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
		NecrosisTradeRequest = false;
	-- AntiFear button hide on target change
	elseif event == "PLAYER_TARGET_CHANGED" then
		if NecrosisConfig.AntiFearAlert and AFCurrentTargetImmune then
			AFCurrentTargetImmune = false;
		end
		if NecrosisConfig.CreatureAlert
			and UnitCanAttack("player", "target")
			and not UnitIsDead("target") then
				CurrentTargetBan = true;
				if UnitCreatureType("target") == NECROSIS_UNIT.Demon then
					NecrosisCreatureAlertButton:Show();
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\DemonAlert");
				elseif UnitCreatureType("target") == NECROSIS_UNIT.Elemental then
					NecrosisCreatureAlertButton:Show();
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ElemAlert");
				end
		elseif CurrentTargetBan then
			CurrentTargetBan = false;
			NecrosisCreatureAlertButton:Hide();
		end

	-- AntiFear immunity on cast detection
	elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE" then
		if NecrosisConfig.AntiFearAlert then
			for spell, creatureName in string.gmatch(arg1, NECROSIS_ANTI_FEAR_SRCH) do
				-- We check if the casted spell on the immune target is Fear or Death Coil
				if spell == NECROSIS_SPELL_TABLE[13].Name or spell == NECROSIS_SPELL_TABLE[19].Name then
					AFCurrentTargetImmune = true;
					break;
				end
			end
		end
	-- Si le Démoniste apprend un nouveau sort / rang de sort, on récupère la nouvelle liste des sorts
	-- Si le Démoniste apprend un nouveau sort de buff ou d'invocation, on recrée les boutons
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		for index in ipairs(NECROSIS_SPELL_TABLE) do
			NECROSIS_SPELL_TABLE[index].ID = nil;
		end
		Necrosis_SpellSetup();
		Necrosis_CreateMenu();
		Necrosis_ButtonSetup();

	-- A la fin du combat, on arrête de signaler le Crépuscule
	-- On enlève les timers de sorts ainsi que les noms des mobs
	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false;
		SpellGroup, SpellTimer, TimerTable = Necrosis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable);
		for i = 1, 10, 1 do
			local frameItem = _G["NecrosisTarget"..i.."Text"];
			if frameItem:IsShown() then
				frameItem:Hide();
			end
		end
		-- On redéfinit les attributs des boutons de sorts de manière situationnelle
		Necrosis_NoCombatAttribute(SoulstoneMode, FirestoneMode, SpellstoneMode, StoneIDInSpellTable) ;
		Necrosis_UpdateIcons();

	-- Quand le démoniste change de démon
	elseif (event == "UNIT_PET" and arg1 == "player") then
		Necrosis_ChangeDemon();
	-- uand le démoniste gagne ou perd un buff.
	elseif event == "COMBAT_TEXT_UPDATE" then
		local Effet, NomEffet = arg1, arg2;
		if Effet == "AURA_START" then
			Necrosis_SelfEffect("BUFF", NomEffet);
		elseif Effet == "AURA_END" then
			Necrosis_SelfEffect("DEBUFF", NomEffet);
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		PlayerCombat = true;

		-- On annule les attributs des boutons de sorts de manière situationnelle
		Necrosis_InCombatAttribute();
	end
	return;
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
		NecrosisButton:RegisterEvent("BAG_UPDATE");
		NecrosisButton:RegisterEvent("COMBAT_TEXT_UPDATE");
		NecrosisButton:RegisterEvent("PLAYER_REGEN_DISABLED");
		NecrosisButton:RegisterEvent("PLAYER_REGEN_ENABLED");
		NecrosisButton:RegisterEvent("UNIT_PET");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_FAILED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		NecrosisButton:RegisterEvent("UNIT_SPELLCAST_SENT");
		NecrosisButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
		NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		NecrosisButton:RegisterEvent("PLAYER_TARGET_CHANGED");
		NecrosisButton:RegisterEvent("TRADE_REQUEST");
		NecrosisButton:RegisterEvent("TRADE_REQUEST_CANCEL");
		NecrosisButton:RegisterEvent("TRADE_SHOW");
		NecrosisButton:RegisterEvent("TRADE_CLOSED");
	else
		NecrosisButton:UnregisterEvent("BAG_UPDATE");
		NecrosisButton:UnRegisterEvent("COMBAT_TEXT_UPDATE");
		NecrosisButton:UnregisterEvent("PLAYER_REGEN_DISABLED");
		NecrosisButton:UnregisterEvent("PLAYER_REGEN_ENABLED");
		NecrosisButton:UnregisterEvent("UNIT_PET");
		NecrosisButton:UnRegisterEvent("UNIT_SPELLCAST_FAILED");
		NecrosisButton:UnRegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		NecrosisButton:UnRegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		NecrosisButton:UnRegisterEvent("UNIT_SPELLCAST_SENT");
		NecrosisButton:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		NecrosisButton:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		NecrosisButton:UnregisterEvent("PLAYER_TARGET_CHANGED");
		NecrosisButton:UnregisterEvent("TRADE_REQUEST");
		NecrosisButton:UnregisterEvent("TRADE_REQUEST_CANCEL");
		NecrosisButton:UnregisterEvent("TRADE_SHOW");
		NecrosisButton:UnregisterEvent("TRADE_CLOSED");
	end
	return;
end

-- event : UNIT_PET
-- Permet de timer les asservissements, ainsi que de prévenir pour les ruptures d'asservissement
-- Change également le nom du pet au remplacement de celui-ci
function Necrosis_ChangeDemon()
	-- Si le nouveau démon est un démon asservi, on place un timer de 5 minutes
	if (Necrosis_UnitHasEffect("pet", NECROSIS_SPELL_TABLE[10].Name)) then
		if (not DemonEnslaved) then
			DemonEnslaved = true;
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerParTable(10, "","", SpellGroup, SpellTimer, TimerTable);
		end
	else
		-- Quand le démon asservi est perdu, on retire le Timer et on prévient le Démoniste
		if (DemonEnslaved) then
			DemonEnslaved = false;
			SpellTimer, TimerTable = Necrosis_RetraitTimerParNom(NECROSIS_SPELL_TABLE[10].Name, SpellTimer, TimerTable);
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.EnslaveEnd); end
			Necrosis_Msg(NECROSIS_MESSAGE.Information.EnslaveBreak, "USER");
		end
	end

	-- Si le démon n'est pas asservi on définit son titre, et on met à jour son nom dans Necrosis
	DemonType = UnitCreatureFamily("pet");
	for i = 1, 5, 1 do
		if DemonType == NECROSIS_PET_LOCAL_NAME[i] and NecrosisConfig.PetName[i] == " " and UnitName("pet") ~= UNKNOWNOBJECT then
			NecrosisConfig.PetName[i] = UnitName("pet");
			NecrosisLocalization();
			break;
		end
	end

	return;
end

-- events : CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS, CHAT_MSG_SPELL_AURA_GONE_SELF et CHAT_MSG_SPELL_BREAK_AURA
-- Permet de gérer les effets apparaissants et disparaissants sur le démoniste
-- Basé sur le CombatLog
function Necrosis_SelfEffect(action, nom)
	if action == "BUFF" then
		-- Changement du bouton de monture quand le Démoniste est démonté
		if nom == NECROSIS_SPELL_TABLE[1].Name or  nom == NECROSIS_SPELL_TABLE[2].Name then
			NecrosisMounted = true;
			if _G["NecrosisMountButton"] then
				NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02");
			end
		-- Changement du bouton de la domination corrompue si celle-ci est activée + Timer de cooldown
		elseif  nom == NECROSIS_SPELL_TABLE[15].Name then
			DominationUp = true;
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-02");
			end
		-- Changement du bouton de la malédiction amplifiée si celle-ci est activée + Timer de cooldown
		elseif  nom == NECROSIS_SPELL_TABLE[42].Name then
			AmplifyUp = true;
			if _G["NecrosisCurseMenu1"] then
				NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-02");
			end
		-- si Contrecoup, pouf on affiche l'icone et on proc le son
		elseif nom == NECROSIS_NIGHTFALL.Backlash then
			Necrosis_Msg(NECROSIS_PROC_TEXT.Backlash, "USER");
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.Backlash); end
			NecrosisBacklashButton:Show();
		-- si Crépuscule, pouf on affiche l'icone et on proc le son
		elseif nom == NECROSIS_NIGHTFALL.ShadowTrance then
			Necrosis_Msg(NECROSIS_PROC_TEXT.ShadowTrance, "USER");
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.ShadowTrance); end
			NecrosisShadowTranceButton:Show();
		end
	else
		-- Changement du bouton de monture quand le Démoniste est démonté
		if nom == NECROSIS_SPELL_TABLE[1].Name or  nom == NECROSIS_SPELL_TABLE[2].Name then
			NecrosisMounted = false;
			if _G["NecrosisMountButton"] then
				NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-01");
			end
		-- Changement du bouton de Domination quand le Démoniste n'est plus sous son emprise
		elseif  nom == NECROSIS_SPELL_TABLE[15].Name then
			DominationUp = false;
			if _G["NecrosisPetMenu1"] then
				NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01");
			end
		-- Changement du bouton de la malédiction amplifiée quand le Démoniste n'est plus sous son emprise
		elseif  nom == NECROSIS_SPELL_TABLE[42].Name then
			AmplifyUp = false;
			if _G["NecrosisCurseMenu1"] then
				NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-01");
			end
		-- On cache les boutons de ShadowTrance quand one st plus sous son emprise
		elseif nom == NECROSIS_NIGHTFALL.ShadowTrance or nom == NECROSIS_NIGHTFALL.Backlash then
			NecrosisShadowTranceButton:Hide();
			NecrosisBacklashButton:Hide();
		end
	end
	return;
end

-- event : SPELLCAST_STOP
-- Permet de gérer tout ce qui touche aux sorts une fois leur incantation réussie
function Necrosis_SpellManagement()
	local SortActif = false;
	if (SpellCastName) then
		-- Messages Posts Cast (Démons et TP)
		PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, NecrosisMounted = Necrosis_Speech_Then(SpellCastName, SpellTargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, NecrosisMounted);

		-- Si le sort lancé à été une Résurrection de Pierre d'âme, on place un timer
		if (SpellCastName == NECROSIS_SPELL_TABLE[11].Name) then
			if SpellTargetName == UnitName("player") then
				SpellTargetName = "";
			end
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerParTable(11, SpellTargetName, "", SpellGroup, SpellTimer, TimerTable);
		-- Si le sort était une pierre de soin
		elseif string.find(SpellCastName, NECROSIS_ITEM.Healthstone) and not string.find(SpellCastName, NECROSIS_CREATE[2]) then
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerStone("Healthstone", nil, nil, SpellGroup, SpellTimer, TimerTable);
		-- Si le sort était une pierre de sort
		elseif string.find(SpellCastName, NECROSIS_ITEM.Spellstone) and not string.find(SpellCastName, NECROSIS_CREATE[3]) then
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerStone("Spellstone", nil, nil, SpellGroup, SpellTimer, TimerTable);
		-- Pour les autres sorts castés, tentative de timer si valable
		else
			for spell=1, #NECROSIS_SPELL_TABLE, 1 do
				if SpellCastName == NECROSIS_SPELL_TABLE[spell].Name and not (spell == 10) then
					-- Si le timer existe déjà sur la cible, on le met à jour
					for thisspell=1, #SpellTimer, 1 do
						if SpellTimer[thisspell].Name == SpellCastName
							and SpellTimer[thisspell].Target == SpellTargetName
							and SpellTimer[thisspell].TargetLevel == SpellTargetLevel
							and NECROSIS_SPELL_TABLE[spell].Type ~= 4
							and NECROSIS_SPELL_TABLE[spell].Type ~= 5
							and spell ~= 16
							then
							-- Si c'est sort lancé déjà présent sur un mob, on remet le timer à fond
							if spell ~= 9 or (spell == 9 and not Necrosis_UnitHasEffect("target", SpellCastName)) then
								SpellTimer[thisspell].Time = NECROSIS_SPELL_TABLE[spell].Length;
								SpellTimer[thisspell].TimeMax = floor(GetTime() + NECROSIS_SPELL_TABLE[spell].Length);
								if spell == 9 and string.find(SpellCastRank, "1") then
									SpellTimer[thisspell].Time = 20;
									SpellTimer[thisspell].TimeMax = floor(GetTime() + 20);
								end
							end
							SortActif = true;
							break;
						end
						-- Si c'est un banish sur une nouvelle cible, on supprime le timer précédent
						if SpellTimer[thisspell].Name == SpellCastName and spell == 9
							and
								(SpellTimer[thisspell].Target ~= SpellTargetName
								or SpellTimer[thisspell].TargetLevel ~= SpellTargetLevel)
							then
							SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
							SortActif = false;
							break;
						end

						-- Si c'est un fear, on supprime le timer du fear précédent
						if SpellTimer[thisspell].Name == SpellCastName and spell == 13 then
							SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
							SortActif = false;
							break;
						end
						if SortActif then break; end
					end
					-- Si le timer est une malédiction, on enlève la précédente malédiction sur la cible
					if (NECROSIS_SPELL_TABLE[spell].Type == 4) or (spell == 16) then
						for thisspell=1, #SpellTimer, 1 do
							-- Mais on garde le cooldown de la malédiction funeste
							if SpellTimer[thisspell].Name == NECROSIS_SPELL_TABLE[16].Name then
								SpellTimer[thisspell].Target = "";
								SpellTimer[thisspell].TargetLevel = "";
							end
							if SpellTimer[thisspell].Type == 4
								and SpellTimer[thisspell].Target == SpellTargetName
								and SpellTimer[thisspell].TargetLevel == SpellTargetLevel
								then
								SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
								break;
							end
						end
						SortActif = false;
					end
					-- Si le timer est une corruption, on enlève la précédente corruption sur la cible
					if (NECROSIS_SPELL_TABLE[spell].Type == 5) then
						for thisspell=1, #SpellTimer, 1 do
							if SpellTimer[thisspell].Type == 5
								and SpellTimer[thisspell].Target == SpellTargetName
								and SpellTimer[thisspell].TargetLevel == SpellTargetLevel
								then
								SpellTimer, TimerTable = Necrosis_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
								break;
							end
						end
						SortActif = false;
					end
					if not SortActif
						and NECROSIS_SPELL_TABLE[spell].Type ~= 0
						and spell ~= 10
						then

						if spell == 9 then
							if string.find(SpellCastRank, "1") then
								NECROSIS_SPELL_TABLE[spell].Length = 20;
							else
								NECROSIS_SPELL_TABLE[spell].Length = 30;
							end
						end

						SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerParTable(spell, SpellTargetName, SpellTargetLevel, SpellGroup, SpellTimer, TimerTable);
						break;
					end
				end
			end
		end
	end
	SpellCastName = nil;
	SpellCastRank = nil;
	return;
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE L'INTERFACE -- LIENS XML
------------------------------------------------------------------------------------------------------

-- Fonction permettant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis_OnDragStart(button)
	button:StartMoving();
end

-- Fonction arrêtant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis_OnDragStop(button)
	-- On arrête le déplacement de manière effective
	button:StopMovingOrSizing();
	-- On sauvegarde l'emplacement du bouton
	local NomBouton = button:GetName();
	local AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY = button:GetPoint();
	NecrosisConfig.FramePosition[NomBouton] = {AncreBouton, BoutonParent, AncreParent, BoutonX, BoutonY};
end

-- Fonction alternant Timers graphiques et Timers textes
function Necrosis_HideGraphTimer()
	for i = 1, 30, 1 do
		local elements = {"Text", "Bar", "Texture", "OutText"}
		if NecrosisConfig.Graphical then
			if TimerTable[i] then
				for j = 1, 4, 1 do
					frameItem = _G["NecrosisTimer"..i..elements[j]];
					frameItem:Show();
				end
			end
		else
			for j = 1, 4, 1 do
				frameName = "NecrosisTimer"..i..elements[j];
				frameItem = _G["NecrosisTimer"..i..elements[j]];
				frameItem:Hide();
			end
		end
	end
end

-- Fonction gérant les bulles d'aide
function Necrosis_BuildTooltip(button, type, anchor)

	-- Si l'affichage des bulles d'aide est désactivé, Bye bye !
	if not NecrosisConfig.NecrosisToolTip then
		return;
	end

	-- On regarde si la domination corrompue, le gardien de l'ombre ou l'amplification de malédiction sont up (pour tooltips)
	local start, duration, start2, duration2, start3, duration3, start4, duration4
	if NECROSIS_SPELL_TABLE[15].ID then
		start, duration = GetSpellCooldown(NECROSIS_SPELL_TABLE[15].ID, BOOKTYPE_SPELL);
	else
		start = 1;
		duration = 1;
	end
	if NECROSIS_SPELL_TABLE[43].ID then
		start2, duration2 = GetSpellCooldown(NECROSIS_SPELL_TABLE[43].ID, BOOKTYPE_SPELL);
	else
		start2 = 1;
		duration2 = 1;
	end
	if NECROSIS_SPELL_TABLE[42].ID then
		start3, duration3 = GetSpellCooldown(NECROSIS_SPELL_TABLE[42].ID, BOOKTYPE_SPELL);
	else
		start3 = 1;
		duration3 = 1;
	end
	if NECROSIS_SPELL_TABLE[50].ID then
		start4, duration4 = GetSpellCooldown(NECROSIS_SPELL_TABLE[50].ID, BOOKTYPE_SPELL);
	else
		start4 = 1;
		duration4 = 1;
	end

	-- Création des bulles d'aides....
	GameTooltip:SetOwner(button, anchor);
	GameTooltip:SetText(NecrosisTooltipData[type].Label);
	-- ..... pour le bouton principal
	if (type == "Main") then
		GameTooltip:AddLine(NecrosisTooltipData.Main.Soulshard..SoulshardsCount);
		GameTooltip:AddLine(NecrosisTooltipData.Main.InfernalStone..InfernalStoneCount);
		GameTooltip:AddLine(NecrosisTooltipData.Main.DemoniacStone..DemoniacStoneCount);
		local SoulOnHand = false;
		local HealthOnHand = false;
		local SpellOnHand = false;
		local FireOnHand = false;
		if SoulstoneOnHand then SoulOnHand = true end
		if HealthstoneOnHand then HealthOnHand = true end
		if SpellstoneOnHand then SpellOnHand = true end
		if FirestoneOnHand then FireOnHand = true end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Soulstone..NecrosisTooltipData[type].Stone[SoulOnHand]);
		GameTooltip:AddLine(NecrosisTooltipData.Main.Healthstone..NecrosisTooltipData[type].Stone[HealthOnHand]);
		-- On vérifie si une pierre de sort n'est pas équipée
		NecrosisTooltip:SetInventoryItem("player", 18);
		local rightHand = tostring(NecrosisTooltipTextLeft1:GetText());
		if string.find(rightHand, NECROSIS_ITEM.Spellstone) then SpellstoneOnHand = true; end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Spellstone..NecrosisTooltipData[type].Stone[SpellOnHand]);
		-- De même pour la pierre de feu
		if string.find(rightHand, NECROSIS_ITEM.Firestone) then FirestoneOnHand = true; end
		GameTooltip:AddLine(NecrosisTooltipData.Main.Firestone..NecrosisTooltipData[type].Stone[FireOnHand]);
		-- Affichage du nom du démon, ou s'il est asservi, ou "Aucun" si aucun démon n'est présent
		if (DemonType) then
			GameTooltip:AddLine(NecrosisTooltipData.Main.CurrentDemon..DemonType);
		elseif DemonEnslaved then
			GameTooltip:AddLine(NecrosisTooltipData.Main.EnslavedDemon);
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.NoCurrentDemon);
		end
	-- ..... pour les boutons de pierre
	elseif (string.find(type, "stone")) then
		-- Pierre d'âme
		if (type == "Soulstone") then
			-- On affiche le nom de la pierre et l'action que produira le clic sur le bouton
			-- Et aussi le Temps de recharge
			if SoulstoneMode == 1 or SoulstoneMode == 3 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Mana.." Mana");
			end
			Necrosis_MoneyToggle();
			NecrosisTooltip:SetBagItem(SoulstoneLocation[1], SoulstoneLocation[2]);
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText());
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[SoulstoneMode]);
			if string.find(itemName, NECROSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(itemName);
			end
		-- Pierre de vie
		elseif (type == "Healthstone") then
			-- Idem
			if HealthstoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Mana.." Mana");
			end
			Necrosis_MoneyToggle();
			NecrosisTooltip:SetBagItem(HealthstoneLocation[1], HealthstoneLocation[2]);
			local itemName = tostring(NecrosisTooltipTextLeft6:GetText());
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[HealthstoneMode]);
			if HealthstoneMode == 2 then
				GameTooltip:AddLine(NecrosisTooltipData[type].Text2);
			end
			if string.find(itemName, NECROSIS_TRANSLATION.Cooldown) then
				GameTooltip:AddLine(itemName);
			end
			if  SoulshardsCount > 0 and not (start4 > 0 and duration4 > 0) then
				GameTooltip:AddLine(NecrosisTooltipData[type].Ritual);
			end
		-- Pierre de sort
		elseif (type == "Spellstone") then
			-- Eadem
			if SpellstoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[3]].Mana.." Mana");
			end
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[SpellstoneMode]);
			if SpellstoneMode == 3 then
				Necrosis_MoneyToggle();
				NecrosisTooltip:SetInventoryItem("player", 18);
				local itemName = tostring(NecrosisTooltipTextLeft9:GetText());
				local itemStone = tostring(NecrosisTooltipTextLeft1:GetText());
				if (string.find(itemStone, NECROSIS_ITEM.Spellstone)
					and string.find(itemName, NECROSIS_TRANSLATION.Cooldown)) then
						GameTooltip:AddLine(itemName);
				end
			end
		-- Pierre de feu
		elseif (type == "Firestone") then
			-- Idem, mais sans le cooldown
			if FirestoneMode == 1 then
				GameTooltip:AddLine(NECROSIS_SPELL_TABLE[StoneIDInSpellTable[4]].Mana.." Mana");
			end
			GameTooltip:AddLine(NecrosisTooltipData[type].Text[FirestoneMode]);
		end
	-- ..... pour le bouton des Timers
	elseif (type == "SpellTimer") then
		Necrosis_MoneyToggle();
		NecrosisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		local itemName = tostring(NecrosisTooltipTextLeft5:GetText());
		GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		if string.find(itemName, NECROSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(NECROSIS_TRANSLATION.Hearth.." - "..itemName);
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Right..GetBindLocation());
		end

	-- ..... pour le bouton de la Transe de l'ombre
	elseif (type == "ShadowTrance") or (type == "Backlash") then
		GameTooltip:SetText(NecrosisTooltipData[type].Label.."          |CFF808080"..NECROSIS_SPELL_TABLE[45].Rank.."|r");
	-- ..... pour les autres buffs et démons, le coût en mana...
	elseif (type == "Enslave") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[35].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		end
	elseif (type == "Mount") then
		if NECROSIS_SPELL_TABLE[2].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[2].Mana.." Mana");
			GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		elseif NECROSIS_SPELL_TABLE[1].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[1].Mana.." Mana");
		end
	elseif (type == "Armor") then
		if NECROSIS_SPELL_TABLE[31].ID then
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[31].Mana.." Mana");
		else
			GameTooltip:AddLine(NECROSIS_SPELL_TABLE[36].Mana.." Mana");
		end
	elseif (type == "FelArmor") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[47].Mana.." Mana");
	elseif (type == "Invisible") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[33].Mana.." Mana");
	elseif (type == "Aqua") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[32].Mana.." Mana");
	elseif (type == "Kilrogg") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[34].Mana.." Mana");
	elseif (type == "Banish") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[9].Mana.." Mana");
		if string.find(NECROSIS_SPELL_TABLE[9].Rank, "2") then
		GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		end
	elseif (type == "Weakness") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[23].Mana.." Mana");
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown);
		end
	elseif (type == "Agony") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[22].Mana.." Mana");
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown);
		end
	elseif (type == "Reckless") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[24].Mana.." Mana");
	elseif (type == "Tongues") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[25].Mana.." Mana");
	elseif (type == "Exhaust") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[40].Mana.." Mana");
		if not (start3 > 0 and duration3 > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.AmplifyCooldown);
		end
	elseif (type == "Elements") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[26].Mana.." Mana");
	elseif (type == "Shadow") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[27].Mana.." Mana");
	elseif (type == "Doom") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[16].Mana.." Mana");
	elseif (type == "Amplify") then
		if start3 > 0 and duration3 > 0 then
			local seconde = duration3 - ( GetTime() - start3)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec";
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60);
				if seconde <= 9 then
					time = "0"..tostring(floor(seconde));
				else
					time = tostring(floor(seconde));
				end
				affiche = minute..":"..time;
			end
			GameTooltip:AddLine("Cooldown : "..affiche);
		end
	elseif (type == "TP") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[37].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		end
	elseif (type == "SoulLink") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[38].Mana.." Mana");
	elseif (type == "ShadowProtection") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[43].Mana.." Mana");
		if start2 > 0 and duration2 > 0 then
			local seconde = duration2 - ( GetTime() - start2)
			local affiche
			affiche = tostring(floor(seconde)).." sec";
			GameTooltip:AddLine("Cooldown : "..affiche);
		end
	elseif (type == "Domination") then
		if start > 0 and duration > 0 then
			local seconde = duration - ( GetTime() - start)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec";
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60);
				if seconde <= 9 then
					time = "0"..tostring(floor(seconde));
				else
					time = tostring(floor(seconde));
				end
				affiche = minute..":"..time;
			end
			GameTooltip:AddLine("Cooldown : "..affiche);
		end
	elseif (type == "Imp") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[3].Mana.." Mana");
		if not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown);
		end

	elseif (type == "Voidwalker") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[4].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown);
		end
	elseif (type == "Succubus") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[5].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown);
		end
	elseif (type == "Felhunter") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[6].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown);
		end
	elseif (type == "Felguard") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[7].Mana.." Mana");
		if SoulshardsCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.Soulshard..SoulshardsCount.."|r");
		elseif not (start > 0 and duration > 0) then
			GameTooltip:AddLine(NecrosisTooltipData.DominationCooldown);
		end
	elseif (type == "Infernal") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[8].Mana.." Mana");
		if InfernalStoneCount == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.InfernalStone..InfernalStoneCount.."|r");
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.InfernalStone..InfernalStoneCount);
		end
	elseif (type == "Doomguard") then
		GameTooltip:AddLine(NECROSIS_SPELL_TABLE[30].Mana.." Mana");
		if DemoniacStone == 0 then
			GameTooltip:AddLine("|c00FF4444"..NecrosisTooltipData.Main.DemoniacStone..DemoniacStoneCount.."|r");
		else
			GameTooltip:AddLine(NecrosisTooltipData.Main.DemoniacStone..DemoniacStoneCount);
		end
	elseif (type == "BuffMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2);
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		end
	elseif (type == "CurseMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2);
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		end
	elseif (type == "PetMenu") then
		if PlayerCombat and NecrosisConfig.AutomaticMenu then
			GameTooltip:AddLine(NecrosisTooltipData[type].Text2);
		else
			GameTooltip:AddLine(NecrosisTooltipData[type].Text);
		end
	end
	-- Et hop, affichage !
	GameTooltip:Show();
end

-- Fonction mettant à jour les boutons Necrosis et donnant l'état du bouton de la pierre d'âme
function Necrosis_UpdateIcons()
	-- Pierre d'âme
	-----------------------------------------------

	-- On se renseigne pour savoir si une pierre d'âme a été utilisée --> vérification dans les timers
	local SoulstoneInUse = false;
	if SpellTimer then
		for index = 1, #SpellTimer, 1 do
			if (SpellTimer[index].Name == NECROSIS_SPELL_TABLE[11].Name)  and SpellTimer[index].TimeMax > 0 then
				SoulstoneInUse = true;
				break;
			end
		end
	end

	-- Si la Pierre n'a pas été utilisée, et qu'il n'y a pas de pierre en inventaire -> Mode 1
	if not (SoulstoneOnHand or SoulstoneInUse) then
		SoulstoneMode = 1;
	end

	-- Si la Pierre n'a pas été utilisée, mais qu'il y a une pierre en inventaire
	if SoulstoneOnHand and (not SoulstoneInUse) then
		-- Si la pierre en inventaire contient un timer, et qu'on sort d'un RL --> Mode 4
		local start, duration = GetContainerItemCooldown(SoulstoneLocation[1],SoulstoneLocation[2]);
		if NecrosisRL and start > 0 and duration > 0 then
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerStone("Soulstone", start, duration, SpellGroup, SpellTimer, TimerTable);
			SoulstoneMode = 4;
			NecrosisRL = false;
		-- Si la pierre ne contient pas de timer, ou qu'on ne sort pas d'un RL --> Mode 2
		else
			SoulstoneMode = 2;
			NecrosisRL = false;
		end
	end

	-- Si la Pierre a été utilisée mais qu'il n'y a pas de pierre en inventaire --> Mode 3
	if (not SoulstoneOnHand) and SoulstoneInUse then
		SoulstoneMode = 3;
	end

	-- Si la Pierre a été utilisée et qu'il y a une pierre en inventaire
	if SoulstoneOnHand and SoulstoneInUse then
			SoulstoneMode = 4;
	end

	-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
	if StoneIDInSpellTable[1]  and NecrosisConfig.ItemSwitchCombat[5] and (SoulstoneMode == 1 or SoulstoneMode == 3) then
		Necrosis_SoulstoneUpdateAttribute(StoneIDInSpellTable);
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SoulstoneButton-0"..SoulstoneMode);
	end

	-- Pierre de vie
	-----------------------------------------------

	-- Mode "j'en ai une" (2) / "j'en ai pas" (1)
	if (HealthstoneOnHand) then
		HealthstoneMode = 2;
	else
		HealthstoneMode = 1;
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[2] and NecrosisConfig.ItemSwitchCombat[4] then
			Necrosis_HealthstoneUpdateAttribute(StoneIDInSpellTable);
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\HealthstoneButton-0"..HealthstoneMode);
	end

	-- Pierre de sort
	-----------------------------------------------

	-- Si la pierre est équipée, mode 3
	local rightHand = GetInventoryItemTexture("player", 18);
	if (rightHand == "Interface\\Icons\\INV_Misc_Gem_Sapphire_01") then
		SpellstoneMode = 3;
	else
		-- Pierre dans l'inventaire, mode 2
		if (SpellstoneOnHand) then
			SpellstoneMode = 2;
		-- Pierre inexistante, mode 1
		else
			SpellstoneMode = 1;
			-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
			if StoneIDInSpellTable[3] and NecrosisConfig.ItemSwitchCombat[1] then
				Necrosis_SpellstoneUpdateAttribute(StoneIDInSpellTable);
			end
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellstoneButton-0"..SpellstoneMode);
	end

	-- Pierre de feu
	-----------------------------------------------

	-- Pierre équipée = mode 3
	if (rightHand == "Interface\\Icons\\INV_Misc_Gem_Bloodstone_02") then
		FirestoneMode = 3;
	-- Pierre dans l'inventaire = mode 2
	elseif (FirestoneOnHand) then
		FirestoneMode = 2;
	-- Pierre inexistante = mode 1
	else
		FirestoneMode = 1;
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[4] and NecrosisConfig.ItemSwitchCombat[2] then
			Necrosis_FirestoneUpdateAttribute(StoneIDInSpellTable);
		end
	end

	-- Affichage de l'icone liée au mode
	if _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\FirestoneButton-0"..FirestoneMode);
	end


	-- Bouton des démons
	-----------------------------------------------
	local mana = UnitMana("player");

	local ManaPet = {"1", "1", "1", "1", "1", "1", "1"};

	-- Si cooldown de domination corrompue on grise
	if _G["NecrosisPetMenu1"] and NECROSIS_SPELL_TABLE[15].ID and not DominationUp then
		local start, duration = GetSpellCooldown(NECROSIS_SPELL_TABLE[15].ID, "spell");
		if start > 0 and duration > 0 then
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-03");
		else
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01");
		end
	end

	-- Si cooldown de gardien de l'ombre on grise
	if _G["NecrosisBuffMenu8"] and NECROSIS_SPELL_TABLE[43].ID then
		local start2, duration2 = GetSpellCooldown(NECROSIS_SPELL_TABLE[43].ID, "spell");
		if start2 > 0 and duration2 > 0 then
			NecrosisBuffMenu8:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ShadowProtection-03");
		else
			NecrosisBuffMenu8:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ShadowProtection-01");
		end
	end

	-- Si cooldown de la malédiction amplifiée on grise
	if _G["NecrosisCurseMenu1"] and NECROSIS_SPELL_TABLE[42].ID and not AmplifyUp then
		local start3, duration3 = GetSpellCooldown(NECROSIS_SPELL_TABLE[42].ID, "spell");
		if start3 > 0 and duration3 > 0 then
			NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-03");
		else
			NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-01");
		end
	end

	if mana ~= nil then
	-- Coloration du bouton en grisé si pas assez de mana
		if NECROSIS_SPELL_TABLE[3].ID then
			if NECROSIS_SPELL_TABLE[3].Mana > mana then
				for i = 1, 7, 1 do
					ManaPet[i] = "3";
				end
			elseif NECROSIS_SPELL_TABLE[4].ID then
				if NECROSIS_SPELL_TABLE[4].Mana > mana then
					for i = 2, 7, 1 do
						ManaPet[i] = "3";
					end
				elseif NECROSIS_SPELL_TABLE[8].ID then
					if NECROSIS_SPELL_TABLE[8].Mana > mana then
						for i = 6, 7, 1 do
							ManaPet[i] = "3";
						end
					elseif NECROSIS_SPELL_TABLE[30].ID then
						if NECROSIS_SPELL_TABLE[30].Mana > mana then
							ManaPet[7] = "3";
						end
					end
				end
			end
		end
	end

	-- Coloration du bouton en grisé si pas de pierre pour l'invocation
	if SoulshardsCount == 0 then
		for i = 2, 5, 1 do
			ManaPet[i] = "3";
		end
	end
	if InfernalStoneCount == 0 then
		ManaPet[6] = "3";
	end
	if DemoniacStoneCount == 0 then
		ManaPet[7] = "3";
	end

	-- Texturage des boutons de pet
	local PetButtonNumber = {2, 3, 4, 5, 10, 6, 7};
	local PetNameHere = {"Imp-0", "Voidwalker-0", "Succubus-0", "Felhunter-0", "Felguard-0", "Infernal-0", "Doomguard-0"};
	for i = 1, #PetButtonNumber, 1 do
		local PetManaButton = _G["NecrosisPetMenu"..PetButtonNumber[i]];
		if PetManaButton and DemonType == NECROSIS_PET_LOCAL_NAME[i] then
			PetManaButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\"..PetNameHere[i].."2");
		elseif PetManaButton then
			PetManaButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\"..PetNameHere[i]..ManaPet[i]);
		end
	end


	-- Bouton des buffs
	-----------------------------------------------

	if mana then
	-- Coloration du bouton en grisé si pas assez de mana
		if _G["NecrosisMountButton"] and MountAvailable and not NecrosisMounted then
			if NECROSIS_SPELL_TABLE[2].ID then
				if NECROSIS_SPELL_TABLE[2].Mana > mana or PlayerCombat then
					NecrosisMountButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\MountButton-03");
				else
					NecrosisMountButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\MountButton-01");
				end
			else
				if NECROSIS_SPELL_TABLE[1].Mana > mana or PlayerCombat then
					NecrosisMountButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\MountButton-03");
				else
					NecrosisMountButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\MountButton-01");
				end
			end
		end
		if NECROSIS_SPELL_TABLE[35].ID then
			if _G["NecrosisPetMenu8"] then
				if NECROSIS_SPELL_TABLE[35].Mana > mana or SoulshardsCount == 0 then
					NecrosisPetMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-03");
				else
					NecrosisPetMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-01");
				end
			elseif _G["NecrosisBuffMenu11"] then
				if NECROSIS_SPELL_TABLE[35].Mana > mana or SoulshardsCount == 0 then
					NecrosisBuffMenu11:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-03");
				else
					NecrosisBuffMenu11:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-01");
				end
			end
		end
		if _G["NecrosisBuffMenu1"] and NECROSIS_SPELL_TABLE[31].ID then
			if NECROSIS_SPELL_TABLE[31].Mana > mana then
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Armor-03");
			else
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Armor-01");
			end
		elseif _G["NecrosisBuffMenu1"] and NECROSIS_SPELL_TABLE[36].ID then
			if NECROSIS_SPELL_TABLE[36].Mana > mana then
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Armor-03");
			else
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Armor-01");
			end
		end

		local BoutonNumber = {10, 2, 3, 4, 5, 7, 8, 9};
		local BoutonTexture = {"FelArmor", "Aqua", "Invisible", "Kilrogg", "TP", "SoulLink", "ShadowProtection", "Banish"};
		local SortNumber = {47, 32, 33, 34, 37, 38, 43, 9}
		for i = 1, #SortNumber, 1 do
			local f = _G["NecrosisBuffMenu"..BoutonNumber[i]];
			if f and NECROSIS_SPELL_TABLE[SortNumber[i]].ID then
				if NECROSIS_SPELL_TABLE[SortNumber[i]].Mana > mana then
					f:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..BoutonTexture[i].."-03");
				else
					f:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..BoutonTexture[i].."-01");
				end
			end
		end

		if _G["NecrosisPetMenu9"] and NECROSIS_SPELL_TABLE[44].ID then
			if (NECROSIS_SPELL_TABLE[44].Mana > mana) or (not UnitExists("Pet")) then
				NecrosisPetMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Sacrifice-03");
			else
				NecrosisPetMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Sacrifice-01");
			end
		end

	end

	-- Bouton des curses
	-----------------------------------------------

	if mana then
		local SpellMana = {23, 22, 24, 25, 40, 26, 27, 16};
		local NameMana = {"Weakness", "Agony", "Reckless", "Tongues", "Exhaust", "Elements", "Shadow", "Doom"};
		-- Coloration du bouton en grisé si pas assez de mana
		for i = 1, #SpellMana, 1 do
			local f = _G["NecrosisCurseMenu"..i+1];
			if f and NECROSIS_SPELL_TABLE[SpellMana[i]].ID then
				if NECROSIS_SPELL_TABLE[SpellMana[i]].Mana > mana then
					f:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NameMana[i].."-03");
				else
					f:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NameMana[i].."-01");
				end
			end
		end
	end


	-- Bouton des Timers
	-----------------------------------------------
	if HearthstoneLocation[1] then
		local start, duration, enable = GetContainerItemCooldown(HearthstoneLocation[1], HearthstoneLocation[2]);
		if duration > 20 and start > 0 then
			NecrosisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Cooldown");
		else
			NecrosisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Normal");
		end
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DES PIERRES ET DES FRAGMENTS
------------------------------------------------------------------------------------------------------


-- T'AS QU'A SAVOIR OU T'AS MIS TES AFFAIRES !
function Necrosis_SoulshardSetup()
	SoulshardSlotID = 1;
	for slot=1, #SoulshardSlot, 1 do
		table.remove(SoulshardSlot, slot);
	end
	for slot=1, GetContainerNumSlots(NecrosisConfig.SoulshardContainer), 1 do
		table.insert(SoulshardSlot, nil);
	end
end


-- Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function Necrosis_BagExplore(arg)
	local soulshards = SoulshardsCount
	-- Ca n'est pas à proprement parlé un sac, mais bon, on regarde si on a une pierre de sort / feu équipée
	NecrosisTooltip:SetInventoryItem("player", 18);
	local rightHand = tostring(NecrosisTooltipTextLeft1:GetText());
	Necrosis_MoneyToggle();
	if string.find(rightHand, NECROSIS_ITEM.Spellstone) then
		NecrosisSpellstoneButton:SetAttribute("type1", "item");
		NecrosisSpellstoneButton:SetAttribute("item", rightHand);
		SpellstoneMode = 3;
	elseif string.find(rightHand, NECROSIS_ITEM.Firestone) then
		FirestoneMode = 3;
	end

	if not arg then
		SoulstoneOnHand = nil;
		HealthstoneOnHand = nil;
		FirestoneOnHand = nil;
		SpellstoneOnHand = nil;
		HearthstoneOnHand = nil;
		-- Parcours des sacs
		for container=0, 4, 1 do
			-- Parcours des emplacements des sacs
			for slot=1, GetContainerNumSlots(container), 1 do
				Necrosis_MoneyToggle();
				NecrosisTooltip:SetBagItem(container, slot);
				local itemName = tostring(NecrosisTooltipTextLeft1:GetText());
				-- Si le sac est le sac défini pour les fragments
				-- hop la valeur du Tableau qui représente le slot du Sac = nil (pas de Shard)
				if (container == NecrosisConfig.SoulshardContainer) then
					if itemName ~= NECROSIS_ITEM.Soulshard then
						SoulshardSlot[slot] = nil;
					end
				end
				-- Dans le cas d'un emplacement non vide
				if itemName then
					-- Si c'est une pierre d'âme, on note son existence et son emplacement
					if string.find(itemName, NECROSIS_ITEM.Soulstone) then
						SoulstoneOnHand = container;
						SoulstoneLocation = {container,slot};
						NecrosisConfig.ItemSwitchCombat[5] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_SoulstoneUpdateAttribute();
					-- Même chose pour une pierre de soin
					elseif string.find(itemName, NECROSIS_ITEM.Healthstone) then
						HealthstoneOnHand = container;
						HealthstoneLocation = {container,slot};
						NecrosisConfig.ItemSwitchCombat[4] = itemName

						-- On attache des actions au bouton de la pierre
						Necrosis_HealthstoneUpdateAttribute();
					-- Et encore pour la pierre de sort
					elseif string.find(itemName, NECROSIS_ITEM.Spellstone) then
						SpellstoneOnHand = container;
						SpellstoneLocation = {container,slot};
						NecrosisConfig.ItemSwitchCombat[1] = itemName;

						-- On attache des actions au bouton de la pierre
						Necrosis_SpellstoneUpdateAttribute();
					-- La pierre de feu maintenant
					elseif string.find(itemName, NECROSIS_ITEM.Firestone) then
						FirestoneOnHand = container;
						NecrosisConfig.ItemSwitchCombat[2] = itemName;

						-- On attache des actions au bouton de la pierre
						Necrosis_FirestoneUpdateAttribute();
					-- et enfin la pierre de foyer
					elseif string.find(itemName, NECROSIS_ITEM.Hearthstone) then
						HearthstoneOnHand = container;
						HearthstoneLocation = {container,slot};
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
			Necrosis_MoneyToggle();
			NecrosisTooltip:SetBagItem(arg, slot);
			local itemName = tostring(NecrosisTooltipTextLeft1:GetText());
			-- Si le sac est le sac défini pour les fragments
			-- hop la valeur du Tableau qui représente le slot du Sac = nil (pas de Shard)
			if (arg == NecrosisConfig.SoulshardContainer) then
				if itemName ~= NECROSIS_ITEM.Soulshard then
					SoulshardSlot[slot] = nil;
				end
			end
			-- Dans le cas d'un emplacement non vide
			if itemName then
				-- Si c'est une pierre d'âme, on note son existence et son emplacement
				if string.find(itemName, NECROSIS_ITEM.Soulstone) then
					SoulstoneOnHand = arg;
					SoulstoneLocation = {arg,slot};
					NecrosisConfig.ItemSwitchCombat[5] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_SoulstoneUpdateAttribute();
				-- Même chose pour une pierre de soin
				elseif string.find(itemName, NECROSIS_ITEM.Healthstone) then
					HealthstoneOnHand = arg;
					HealthstoneLocation = {arg,slot};
					NecrosisConfig.ItemSwitchCombat[4] = itemName

					-- On attache des actions au bouton de la pierre
					Necrosis_HealthstoneUpdateAttribute();
				-- Et encore pour la pierre de sort
				elseif string.find(itemName, NECROSIS_ITEM.Spellstone) then
					SpellstoneOnHand = arg;
					SpellstoneLocation = {arg,slot};
					NecrosisConfig.ItemSwitchCombat[1] = itemName;

					-- On attache des actions au bouton de la pierre
					Necrosis_SpellstoneUpdateAttribute();
				-- La pierre de feu maintenant
				elseif string.find(itemName, NECROSIS_ITEM.Firestone) then
					FirestoneOnHand = arg;
					NecrosisConfig.ItemSwitchCombat[2] = itemName;

					-- On attache des actions au bouton de la pierre
					Necrosis_FirestoneUpdateAttribute();
				-- et enfin la pierre de foyer
				elseif string.find(itemName, NECROSIS_ITEM.Hearthstone) then
					HearthstoneOnHand = arg;
					HearthstoneLocation = {arg,slot};
				end
			end
		end
	end


	SoulshardsCount = GetItemCount(6265);
	InfernalStoneCount = GetItemCount(5565);
	DemoniacStoneCount = GetItemCount(16583);

	if IsEquippedItemType("Wand") then
		NecrosisConfig.ItemSwitchCombat[3] = rightHand;
	end

	-- On change l'affectation des boutons de pierre de feu et de sort pour prendre en compte la baguette
	Necrosis_RangedUpdateAttribute();

	-- Affichage du bouton principal de Necrosis
	if NecrosisConfig.Circle == 1 then
		if (SoulshardsCount <= 32) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NecrosisConfig.NecrosisColor.."\\Shard"..SoulshardsCount);
		else
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..NecrosisConfig.NecrosisColor.."\\Shard32");
		end
	elseif SoulstoneMode ==1 or SoulstoneMode == 2 then
		if (SoulshardsCount <= 32) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Bleu\\Shard"..SoulshardsCount);
		else
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Bleu\\Shard32");
		end
	end
	if NecrosisConfig.ShowCount then
		if NecrosisConfig.CountType == 2 then
			NecrosisShardCount:SetText(InfernalStoneCount.." / "..DemoniacStoneCount);
		elseif NecrosisConfig.CountType == 1 then
			if SoulshardsCount < 10 then
				NecrosisShardCount:SetText("0"..SoulshardsCount);
			else
				NecrosisShardCount:SetText(SoulshardsCount);
			end
		end
	else
		NecrosisShardCount:SetText("");
	end
	-- Et on met le tout à jour !
	Necrosis_UpdateIcons();

	-- S'il y a plus de fragment que d'emplacements dans le sac défini, on affiche un message d'avertissement
	if (SoulshardsCount > soulshards and SoulshardsCount == GetContainerNumSlots(NecrosisConfig.SoulshardContainer)) then
		if (SoulshardDestroy) then
			Necrosis_Msg(NECROSIS_MESSAGE.Bag.FullPrefix..GetBagName(NecrosisConfig.SoulshardContainer)..NECROSIS_MESSAGE.Bag.FullDestroySuffix);
		else
			Necrosis_Msg(NECROSIS_MESSAGE.Bag.FullPrefix..GetBagName(NecrosisConfig.SoulshardContainer)..NECROSIS_MESSAGE.Bag.FullSuffix);
		end
	end
end

-- Fonction qui permet de trouver / ranger les fragments dans les sacs
function Necrosis_SoulshardSwitch(type)
	if (type == "CHECK") then
		SoulshardMP = 0;
		for container = 0, 4, 1 do
			for i = 1, 3, 1 do
				if GetBagName(container) == NECROSIS_ITEM.SoulPouch[i] then
					BagIsSoulPouch[container + 1] = true;
					break;
				else
					BagIsSoulPouch[container + 1] = false;
				end
			end
		end
	end
	for container = 0, 4, 1 do
		if BagIsSoulPouch[container+1] then break; end
		if container ~= NecrosisConfig.SoulshardContainer then
			for slot=1, GetContainerNumSlots(container), 1 do
				Necrosis_MoneyToggle();
				NecrosisTooltip:SetBagItem(container, slot);
				local itemInfo = tostring(NecrosisTooltipTextLeft1:GetText());
				if itemInfo == NECROSIS_ITEM.Soulshard then
					if (type == "CHECK") then
						SoulshardMP = SoulshardMP + 1;
					elseif (type == "MOVE") then
						Necrosis_FindSlot(container, slot);
						SoulshardMP = SoulshardMP - 1;
					end
				end
			end
		end
	end
end

-- Pendant le déplacement des fragments, il faut trouver un nouvel emplacement aux objets déplacés :)
function Necrosis_FindSlot(shardIndex, shardSlot)
	local full = true;
	for slot=1, GetContainerNumSlots(NecrosisConfig.SoulshardContainer), 1 do
		Necrosis_MoneyToggle();
 		NecrosisTooltip:SetBagItem(NecrosisConfig.SoulshardContainer, slot);
 		local itemInfo = tostring(NecrosisTooltipTextLeft1:GetText());
		if string.find(itemInfo, NECROSIS_ITEM.Soulshard) == nil then
			PickupContainerItem(shardIndex, shardSlot);
			PickupContainerItem(NecrosisConfig.SoulshardContainer, slot);
			SoulshardSlot[SoulshardSlotID] = slot;
			SoulshardSlotID = SoulshardSlotID + 1
			if (CursorHasItem()) then
				if shardIndex == 0 then
					PutItemInBackpack();
				else
					PutItemInBag(19 + shardIndex);
				end
			end
			full = false;
			break;
		end
	end
	-- Destruction des fragments en sur-nombre si l'option est activée
	if (full and NecrosisConfig.SoulshardDestroy) then
		PickupContainerItem(shardIndex, shardSlot);
		if (CursorHasItem()) then DeleteCursorItem(); end
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DES SORTS
------------------------------------------------------------------------------------------------------



-- Affiche ou masque les boutons de sort à chaque nouveau sort appris
function Necrosis_ButtonSetup()
	local NBRScale = (100 + (NecrosisConfig.NecrosisButtonScale - 85)) / 100;
	if NecrosisConfig.NecrosisButtonScale <= 95 then
		NBRScale = 1.1;
	end

	local ButtonName = {
		"NecrosisFirestoneButton",
		"NecrosisSpellstoneButton",
		"NecrosisHealthstoneButton",
		"NecrosisSoulstoneButton",
		"NecrosisBuffMenuButton",
		"NecrosisMountButton",
		"NecrosisPetMenuButton",
		"NecrosisCurseMenuButton"
	};

	for index, valeur in ipairs(ButtonName) do
		local f = _G[valeur];
		if f then f:Hide(); end
	end

	local SpellExist = {
		StoneIDInSpellTable[4],
		StoneIDInSpellTable[3],
		StoneIDInSpellTable[2],
		StoneIDInSpellTable[1],
		BuffMenuCreate[1],
		MountAvailable,
		PetMenuCreate[1],
		CurseMenuCreate[1]
	};

	if NecrosisConfig.NecrosisLockServ then
		local indexScale = -36;
		Necrosis_ClearAllPoints();
		for index=1, #NecrosisConfig.StonePosition, 1 do
			for button = 1, #NecrosisConfig.StonePosition, 1 do
				if math.abs(NecrosisConfig.StonePosition[index]) == button
					and NecrosisConfig.StonePosition[button] > 0
					and SpellExist[button] then
						local f = _G[ButtonName[button]];
						if not f then
							f = Necrosis_CreateSphereButtons(ButtonName[button]);
							Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable);
						end
						f:SetPoint(
							"CENTER", "NecrosisButton", "CENTER",
							((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle - indexScale)),
							((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle - indexScale))
						);
						f:Show();
						indexScale = indexScale + 36;
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
						local f = _G[ButtonName[button]];
						if not f then
							f = Necrosis_CreateSphereButtons(ButtonName[button]);
							Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable);
						end
						f:Show();
						break
				end
			end
		end
	end
end



-- Ma fonction préférée ! Elle fait la liste des sorts connus par le démo, et les classe par rang.
-- Pour les pierres, elle sélectionne le plus haut rang connu
function Necrosis_SpellSetup()
	local StoneType = {NECROSIS_ITEM.Soulstone, NECROSIS_ITEM.Healthstone, NECROSIS_ITEM.Spellstone, NECROSIS_ITEM.Firestone};
	local StoneMaxRank = {0, 0, 0, 0};

	local CurrentStone = {
		ID = {},
		Name = {},
		subName = {}
	};

	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	};

	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- On va parcourir tous les sorts possedés par le Démoniste
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);

		if not spellName then
			do break end
		end

		-- Pour les sorts avec des rangs numérotés, on compare pour chaque sort les rangs 1 à 1
		-- Le rang supérieur est conservé
		if (string.find(subSpellName, NECROSIS_TRANSLATION.Rank)) then
			local found = false;
			local rank = tonumber(strsub(subSpellName, 6, strlen(subSpellName)));
			for index=1, #CurrentSpells.Name, 1 do
				if (CurrentSpells.Name[index] == spellName) then
			found = true;
					if (CurrentSpells.subName[index] < rank) then
						CurrentSpells.ID[index] = spellID;
						CurrentSpells.subName[index] = rank;
					end
					break;
				end
			end
			-- Les plus grands rangs de chacun des sorts à rang numérotés sont insérés dans la table
			if (not found) then
				table.insert(CurrentSpells.ID, spellID);
				table.insert(CurrentSpells.Name, spellName);
				table.insert(CurrentSpells.subName, rank);
			end
		end

		-- Test du Rang de la détection d'invisibilité
		if spellName == NECROSIS_TRANSLATION.GreaterInvisible then
			Invisible = 3;
			InvisibleID = spellID;
		elseif spellName == NECROSIS_TRANSLATION.Invisible and Invisible ~= 3 then
			Invisible = 2;
			InvisibleID = spellID;
		elseif spellName == NECROSIS_TRANSLATION.LesserInvisible and Invisible ~= 3 and Invisible ~= 2 then
			Invisible = 1;
			InvisibleID = spellID;
		end

		-- Les pierres n'ont pas de rang numéroté, l'attribut de rang fait partie du nom du sort
		-- Pour chaque type de pierre, on va donc faire....
		for stoneID=1, #StoneType, 1 do
			-- Si le sort étudié est bien une invocation de ce type de pierre et qu'on n'a pas
			-- déjà assigné un rang maximum à cette dernière
			if (string.find(spellName, StoneType[stoneID]))
				and StoneMaxRank[stoneID] ~= #NECROSIS_STONE_RANK
				then
				-- Récupération de la fin du nom de la pierre, contenant son rang
				local stoneSuffix = string.sub(spellName, string.len(NECROSIS_CREATE[stoneID]) + 1);
				-- Reste à trouver la correspondance de son rang
				for rankID=1, #NECROSIS_STONE_RANK, 1 do
					-- Si la fin du nom de la pierre correspond à une taille de pierre, on note le rang !
					if string.lower(stoneSuffix) == string.lower(NECROSIS_STONE_RANK[rankID]) then
						-- On a une pierre, on a son rang, reste à vérifier si c'est la plus puissante,
						-- et si oui, l'enregistrer
						if rankID > StoneMaxRank[stoneID] then
							StoneMaxRank[stoneID] = rankID;
							CurrentStone.Name[stoneID] = spellName;
							CurrentStone.subName[stoneID] = NECROSIS_STONE_RANK[rankID];
							CurrentStone.ID[stoneID] = spellID;
						end
						break
					end
				end
			end
		end

		spellID = spellID + 1;
	end

	-- On insère dans la table les pierres avec le plus grand rang
	for stoneID=1, #StoneType, 1 do
		if StoneMaxRank[stoneID] ~= 0 then
			table.insert(NECROSIS_SPELL_TABLE, {
				ID = CurrentStone.ID[stoneID],
				Name = CurrentStone.Name[stoneID],
				Rank = 0,
				CastTime = 0,
				Length = 0,
				Type = 0,
			});
			StoneIDInSpellTable[stoneID] = #NECROSIS_SPELL_TABLE;
		end
	end
	-- On met à jour la liste des sorts avec les nouveaux rangs
	for spell=1, #NECROSIS_SPELL_TABLE, 1 do
		for index = 1, #CurrentSpells.Name, 1 do
			if (NECROSIS_SPELL_TABLE[spell].Name == CurrentSpells.Name[index])
				and NECROSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[1]
				and NECROSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[2]
				and NECROSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[3]
				and NECROSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[4]
				then
					NECROSIS_SPELL_TABLE[spell].ID = CurrentSpells.ID[index];
					NECROSIS_SPELL_TABLE[spell].Rank = CurrentSpells.subName[index];
			end
		end
	end

	for spellID=1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell");
		if (spellName) then
			for index=1, #NECROSIS_SPELL_TABLE, 1 do
				if NECROSIS_SPELL_TABLE[index].Name == spellName then
					Necrosis_MoneyToggle();
					NecrosisTooltip:SetSpell(spellID, 1);
					local _, _, ManaCost = string.find(NecrosisTooltipTextLeft2:GetText(), "(%d+)");
					if not NECROSIS_SPELL_TABLE[index].ID then
						NECROSIS_SPELL_TABLE[index].ID = spellID;
					end
					NECROSIS_SPELL_TABLE[index].Mana = tonumber(ManaCost);
				end
			end
		end
	end

	for i=1, 4, 1 do
		if StoneIDInSpellTable[i] == 0 then
			StoneIDInSpellTable[i] = nil;
		end
	end

	-- Insertion du plus haut rang de détection d'invisibilité connu
	if Invisible >= 1 then
		NECROSIS_SPELL_TABLE[33].ID = InvisibleID;
		NECROSIS_SPELL_TABLE[33].Rank = " ";
		NECROSIS_SPELL_TABLE[33].CastTime = 0;
		NECROSIS_SPELL_TABLE[33].Length = 0;
		Necrosis_MoneyToggle();
		NecrosisTooltip:SetSpell(InvisibleID, 1);
		local _, _, ManaCost = string.find(NecrosisTooltipTextLeft2:GetText(), "(%d+)");
		NECROSIS_SPELL_TABLE[33].Mana = tonumber(ManaCost);
	end

	-- Maintenant qu'on connait tous les sorts, on recupère leur véritable nom coté client
	-- (utile pour les pierres invoquées ou l'invisibilité par exemple)
		for spellID=1, #NECROSIS_SPELL_TABLE, 1 do
		if NECROSIS_SPELL_TABLE[spellID].ID then
			local spellName, spellRank = GetSpellName(NECROSIS_SPELL_TABLE[spellID].ID, "spell");
			NECROSIS_SPELL_TABLE[spellID].Name = spellName;
			NECROSIS_SPELL_TABLE[spellID].Rank = spellRank;
		end
	end

	-- On met à jour la durée de chaque sort en fonction de son rang
	-- Peur
	if NECROSIS_SPELL_TABLE[13].ID ~= nil then
		NECROSIS_SPELL_TABLE[13].Length = string.find(NECROSIS_SPELL_TABLE[13].Rank, "(%d+)") * 5 + 5;
	end
	-- Corruption
	if NECROSIS_SPELL_TABLE[14].ID ~= nil and string.find(NECROSIS_SPELL_TABLE[14].Rank, "(%d+)") <= 2 then
		NECROSIS_SPELL_TABLE[14].Length = string.find(NECROSIS_SPELL_TABLE[14].Rank, "(%d+)") * 3 + 9;
	end

	-- WoW 2.0 : Les boutons doivent être sécurisés pour être utilisés.
	-- Chaque utilisation passe par la définition d'attributs au bouton, l'UI se chargeant de gérer l'event de clic.

	-- Association du sort de monture correct au bouton
	if NECROSIS_SPELL_TABLE[1].ID or NECROSIS_SPELL_TABLE[2].ID then
		MountAvailable = true;
	else
		MountAvailable = false;
	end

	if not InCombatLockdown() then
		Necrosis_MainButtonAttribute();
		Necrosis_BuffSpellAttribute();
		Necrosis_PetSpellAttribute();
		Necrosis_CurseSpellAttribute();
		Necrosis_StoneAttribute(StoneIDInSpellTable, MountAvailable);
	end


end

-- Fonction d'extraction d'attribut de sort
-- F(type=string, string, int) -> Spell=table
function Necrosis_FindSpellAttribute(type, attribute, array)
	for index=1, #NECROSIS_SPELL_TABLE, 1 do
		if string.find(NECROSIS_SPELL_TABLE[index][type], attribute) then return NECROSIS_SPELL_TABLE[index][array]; end
	end
	return nil;
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DIVERSES
------------------------------------------------------------------------------------------------------

-- Fonction pour savoir si une unité subit un effet
-- F(string, string)->bool
function Necrosis_UnitHasEffect(unit, effect)
	local index = 1;
	while UnitDebuff(unit, index) do
		Necrosis_MoneyToggle();
		NecrosisTooltip:SetUnitDebuff(unit, index);
		local DebuffName = tostring(NecrosisTooltipTextLeft1:GetText());
   		if (string.find(DebuffName, effect)) then
			return true;
		end
		index = index+1;
	end
	return false;
end

-- Function to check the presence of a buff on the unit.
-- Strictly identical to UnitHasEffect, but as WoW distinguishes Buff and DeBuff, so we have to.
function Necrosis_UnitHasBuff(unit, effect)
	local index = 1;
	while UnitBuff(unit, index) do
	-- Here we'll cheat a little. checking a buff or debuff return the internal spell name, and not the name we give at start
		-- So we use an API widget that will use the internal name to return the known name.
		-- For example, the "Curse of Agony" spell is internaly known as "Spell_Shadow_CurseOfSargeras". Much easier to use the first one than the internal one.
		Necrosis_MoneyToggle();
		NecrosisTooltip:SetUnitBuff(unit, index);
		local BuffName = tostring(NecrosisTooltipTextLeft1:GetText());
   		if (string.find(BuffName, effect)) then
			return true;
		end
		index = index+1;
	end
	return false;
end


-- Affiche ou cache le bouton de détection de la peur suivant la cible.
function Necrosis_ShowAntiFearWarning()
	local Actif = false; -- must be False, or a number from 1 to AFImageType[] max element.

	-- Checking if we have a target. Any fear need a target to be casted on
	if UnitExists("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") then
		-- Checking if the target has natural immunity (only NPC target)
		if not UnitIsPlayer("target") then
			for index=1, #NECROSIS_UNIT.Undead, 1 do
				if (UnitCreatureType("target") == NECROSIS_UNIT.Undead[index] ) then
					Actif = 2; -- Immun
					break;
				end
			end
		end

		-- We'll start to parse the target buffs, as his class doesn't give him natural permanent immunity
		if not Actif then
			for index=1, #NECROSIS_ANTI_FEAR_SPELL.Buff, 1 do
				if Necrosis_UnitHasBuff("target",NECROSIS_ANTI_FEAR_SPELL.Buff[index]) then
					Actif = 3; -- Prot
					break;
				end
			end

			-- No buff found, let's try the debuffs
			for index=1, #NECROSIS_ANTI_FEAR_SPELL.Debuff, 1 do
				if Necrosis_UnitHasEffect("target",NECROSIS_ANTI_FEAR_SPELL.Debuff[index]) then
					Actif = 3; -- Prot
					break;
				end
			end
		end

		-- an immunity has been detected before, but we still don't know why => show the button anyway
		if AFCurrentTargetImmune and not Actif then
			Actif = 1;
		end
	end

	if Actif then
		-- Antifear button is currently not visible, we have to change that
		if not AntiFearInUse then
			AntiFearInUse = true;
			Necrosis_Msg(NECROSIS_MESSAGE.Information.FearProtect, "USER");
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..AFImageType[Actif].."-02");
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.Fear); end
			ShowUIPanel(NecrosisAntiFearButton);
			AFBlink1 = GetTime() + 0.6;
			AFBlink2 = 2;

		-- Timer to make the button blink
		elseif GetTime() >= AFBlink1 then
			if AFBlink2 == 1 then
				AFBlink2 = 2;
			else
				AFBlink2 = 1;
			end
			AFBlink1 = GetTime() + 0.4;
			NecrosisAntiFearButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\AntiFear"..AFImageType[Actif].."-0"..AFBlink2);
		end

	elseif AntiFearInUse then	-- No antifear on target, but the button is still visible => gonna hide it
		AntiFearInUse = false;
		HideUIPanel(NecrosisAntiFearButton);
	end
end

-- Fonction pour gérer l'échange de pierre (hors combat)
function Necrosis_TradeStone()
		-- Dans ce cas si un pj allié est sélectionné, on lui donne la pierre
		-- Sinon, on l'utilise
		if NecrosisTradeRequest and HealthstoneOnHand then
			PickupContainerItem(HealthstoneLocation[1], HealthstoneLocation[2]);
			ClickTradeButton(1);
			NecrosisTradeRequest = false;
			return;
		elseif (UnitExists("target") and UnitIsPlayer("target") and (not UnitCanAttack("player", "target")) and UnitName("target") ~= UnitName("player")) then
			PickupContainerItem(HealthstoneLocation[1], HealthstoneLocation[2]);
        		if ( CursorHasItem() ) then
            			DropItemOnUnit("target");
			end
			return;
		end
end

function Necrosis_MoneyToggle()
	for index=1, 10 do
		local text = _G["NecrosisTooltipTextLeft"..index];
			if text then text:SetText(nil); end
			text = _G["NecrosisTooltipTextRight"..index];
			if text then text:SetText(nil); end
	end
	NecrosisTooltip:Hide();
	NecrosisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
end

function Necrosis_GameTooltip_ClearMoney()
    -- Intentionally empty; don't clear money while we use hidden tooltips
end


-- Fonction (XML) pour rétablir les points d'attache par défaut des boutons
function Necrosis_ClearAllPoints()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:ClearAllPoints(); end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:ClearAllPoints(); end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:ClearAllPoints(); end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:ClearAllPoints(); end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:ClearAllPoints(); end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:ClearAllPoints(); end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:ClearAllPoints(); end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:ClearAllPoints(); end
end

-- Fonction (XML) pour étendre la propriété NoDrag() du bouton principal de Necrosis sur tout ses boutons
function Necrosis_NoDrag()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:RegisterForDrag(""); end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:RegisterForDrag(""); end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag(""); end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("");end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag(""); end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag(""); end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag(""); end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag(""); end
end

-- Fonction (XML) inverse de celle du dessus
function Necrosis_Drag()
	if  _G["NecrosisFirestoneButton"] then NecrosisFirestoneButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisSpellstoneButton"] then NecrosisSpellstoneButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisHealthstoneButton"] then NecrosisHealthstoneButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisSoulstoneButton"] then NecrosisSoulstoneButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisMountButton"] then NecrosisMountButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:RegisterForDrag("LeftButton"); end
	if  _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:RegisterForDrag("LeftButton"); end
end


-- A chaque changement du livre des sorts, au démarrage du mod, ainsi qu'au changement de sens du menu on reconstruit les menus des sorts
function Necrosis_CreateMenu()
	PetMenuCreate = {};
	CurseMenuCreate = {};
	BuffMenuCreate = {};
	local menuVariable = nil;
	local PetButtonPosition = 0;
	local BuffButtonPosition = 0;
	local CurseButtonPosition = 0;

	-- On cache toutes les icones des démons
	for i = 1, #NecrosisConfig.DemonSpellPosition, 1 do
		menuVariable = _G["NecrosisPetMenu"..i];
		if menuVariable then
			menuVariable:Hide();
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000);
		end
	end
	-- On cache toutes les icones des sorts
	for i = 1, #NecrosisConfig.BuffSpellPosition, 1 do
		menuVariable = _G["NecrosisBuffMenu"..i];
		if menuVariable then 
			menuVariable:Hide();
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000);
		end
	end
	-- On cache toutes les icones des curses
	for i = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		menuVariable = _G["NecrosisCurseMenu"..i];
		if menuVariable then
			menuVariable:Hide();
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisButton", "CENTER", 3000, 3000);
		end
	end

	local MenuID = {15, 3, 4, 5, 6, 7, 8, 30, 35, 44};
	local ButtonID = {1, 2, 3, 4, 5, 10, 6, 7, 8, 9};
	-- On ordonne et on affiche les boutons dans le menu des démons
	for index = 1, #NecrosisConfig.DemonSpellPosition, 1 do
		-- Si le sort d'invocation existe, on affiche le bouton dans le menu des pets
		for sort = 1, #NecrosisConfig.DemonSpellPosition, 1 do
			if math.abs(NecrosisConfig.DemonSpellPosition[index]) == sort
				and NecrosisConfig.DemonSpellPosition[sort] > 0
				and NECROSIS_SPELL_TABLE[ MenuID[sort] ].ID then
					-- Création à la demande du bouton du menu des démons
					if not _G["NecrosisPetMenuButton"] then
						_ = Necrosis_CreateSphereButtons("PetMenu");
					end
					menuVariable = _G["NecrosisPetMenu"..ButtonID[sort]];
					if not menuVariable then
						menuVariable = Necrosis_CreateMenuPet(ButtonID[sort]);
					end
					menuVariable:ClearAllPoints();
					menuVariable:SetPoint(
						"CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER",
						NecrosisConfig.PetMenuPos.x * 32,
						NecrosisConfig.PetMenuPos.y * 32
					);
					PetButtonPosition = ButtonID[sort];
					table.insert(PetMenuCreate, menuVariable);
					break;
			end
		end
	end

	-- Maintenant que tous les boutons de pet sont placés les uns à côté des autres, on affiche les disponibles
	if PetMenuCreate[1] then
		PetMenuCreate[1]:ClearAllPoints();
		PetMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisPetMenuButton", "CENTER",
			NecrosisConfig.PetMenuPos.x * 32 + NecrosisConfig.PetMenuDecalage.x,
			NecrosisConfig.PetMenuPos.y * 32 + NecrosisConfig.PetMenuDecalage.y
		);
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisPetMenu");
		for i = 1, #PetMenuCreate, 1 do
			NecrosisPetMenu0:SetAttribute("addchild", PetMenuCreate[i]);
			PetMenuCreate[i]:SetAttribute("showstates", "!0,*");
			PetMenuCreate[i]:SetAttribute("anchorchild", NecrosisPetMenu0);
			PetMenuCreate[i]:Hide();
		end
		Necrosis_PetSpellAttribute();
	end

	-- On ordonne et on affiche les boutons dans le menu des buffs
	local MenuID = {47, 32, 33, 34, 37, 39, 38, 43, 35, 9};
	local ButtonID = {10, 2, 3, 4, 5, 6, 7, 8, 11, 9};
	for index = 1, #NecrosisConfig.BuffSpellPosition, 1 do
		-- Si le buff existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 1
			and NecrosisConfig.BuffSpellPosition[1] > 0
			and (NECROSIS_SPELL_TABLE[31].ID or NECROSIS_SPELL_TABLE[36].ID) then
				-- Création à la demande du bouton du menu des Buffs
				if not _G["NecrosisBuffMenuButton"] then
					_ = Necrosis_CreateSphereButtons("BuffMenu");
				end
				menuVariable = _G["NecrosisBuffMenu1"];
				if not menuVariable then
					menuVariable = Necrosis_CreateMenuBuff(1);
				end
				menuVariable:ClearAllPoints();
				menuVariable:SetPoint(
					"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
					NecrosisConfig.BuffMenuPos.x * 32,
					NecrosisConfig.BuffMenuPos.y * 32
				);
				BuffButtonPosition = 1;
				table.insert(BuffMenuCreate, menuVariable);
		else
			for sort = 2, #NecrosisConfig.BuffSpellPosition, 1 do
				if math.abs(NecrosisConfig.BuffSpellPosition[index]) == sort
					and NecrosisConfig.BuffSpellPosition[sort] > 0
					and NECROSIS_SPELL_TABLE[ MenuID[sort - 1] ].ID then
						-- Création à la demande du bouton du menu des Buffs
						if not _G["NecrosisBuffMenuButton"] then
							_ = Necrosis_CreateSphereButtons("BuffMenu");
						end
						menuVariable = _G["NecrosisBuffMenu"..ButtonID[sort - 1]];
						if not menuVariable then
							menuVariable = Necrosis_CreateMenuBuff(ButtonID[sort - 1]);
						end
						menuVariable:ClearAllPoints();
						menuVariable:SetPoint(
							"CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER",
							NecrosisConfig.BuffMenuPos.x * 32,
							NecrosisConfig.BuffMenuPos.y * 32
						);
						BuffButtonPosition = ButtonID[sort - 1];
						table.insert(BuffMenuCreate, menuVariable);
						break;
				end
			end
		end
	end

	-- Maintenant que tous les boutons de buff sont placés les uns à côté des autres, on affiche les disponibles
	if BuffMenuCreate[1] then
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisBuffMenuButton", "CENTER",
			NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.BuffMenuDecalage.x,
			NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.BuffMenuDecalage.y
		);
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisBuffMenu");
		for i = 1, #BuffMenuCreate, 1 do
			NecrosisBuffMenu0:SetAttribute("addchild", BuffMenuCreate[i]);
			BuffMenuCreate[i]:SetAttribute("showstates", "!0,*");
			BuffMenuCreate[i]:SetAttribute("anchorchild", NecrosisBuffMenu0);
			BuffMenuCreate[i]:Hide();
		end
		Necrosis_BuffSpellAttribute();
	end


	-- On ordonne et on affiche les boutons dans le menu des malédictions
	-- MenuID contient l'emplacement des sorts en question dans la table des sorts de Necrosis.
	local MenuID = {42, 23, 22, 24, 25, 40, 26, 27, 16};
	for index = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		for sort = 1, #NecrosisConfig.CurseSpellPosition, 1 do
		-- Si la Malédiction existe, on affiche le bouton dans le menu des curses
			if math.abs(NecrosisConfig.CurseSpellPosition[index]) == sort
				and NecrosisConfig.CurseSpellPosition[sort] > 0
				and NECROSIS_SPELL_TABLE[MenuID[sort]].ID then
					-- Création à la demande du bouton du menu des malédictions
					if not _G["NecrosisCurseMenuButton"] then
						_ = Necrosis_CreateSphereButtons("CurseMenu");
					end
					menuVariable = _G["NecrosisCurseMenu"..sort];
					if not menuVariable then
						menuVariable = Necrosis_CreateMenuCurse(sort);
					end
					menuVariable:ClearAllPoints();
					menuVariable:SetPoint(
						"CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER",
						NecrosisConfig.CurseMenuPos.x * 32,
						NecrosisConfig.CurseMenuPos.y * 32
					);
					CurseButtonPosition = sort;
					table.insert(CurseMenuCreate, menuVariable);
					break
			end
		end
	end

	-- Maintenant que tous les boutons de curse sont placés les uns à côté des autres, on affiche les disponibles
	if CurseMenuCreate[1] then
		CurseMenuCreate[1]:ClearAllPoints();
		CurseMenuCreate[1]:SetPoint(
			"CENTER", "NecrosisCurseMenuButton", "CENTER",
			NecrosisConfig.BuffMenuPos.x * 32 + NecrosisConfig.CurseMenuDecalage.x,
			NecrosisConfig.BuffMenuPos.y * 32 + NecrosisConfig.CurseMenuDecalage.y
		);
		-- Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
		Necrosis_MenuAttribute("NecrosisCurseMenu");
		for i = 1, #CurseMenuCreate, 1 do
			NecrosisCurseMenu0:SetAttribute("addchild", CurseMenuCreate[i]);
			CurseMenuCreate[i]:SetAttribute("showstates", "!0,*");
			CurseMenuCreate[i]:SetAttribute("anchorchild", NecrosisCurseMenu0);
			CurseMenuCreate[i]:Hide();
		end
		Necrosis_CurseSpellAttribute();
	end
end

-- Fonction pour ramener tout au centre de l'écran
function Necrosis_Recall()
	local ui = {
		"NecrosisButton",
		"NecrosisSpellTimerButton", 
		"NecrosisAntiFearButton",
		"NecrosisCreatureAlertButton",
		"NecrosisBacklashButton",
		"NecrosisShadowTranceButton"
	};
	local pos = {
		{0, -100};
		{0, 100};
		{20, 0};
		{60, 0};
		{-60, 0};
		{-20, 0};
	};
	for i = 1, #ui, 1 do
		local f = _G[ui[i]];
		f:ClearAllPoints();
		f:SetPoint("CENTER", "UIParent", "CENTER", pos[i][1], pos[i][2]);
		f:Show();
		Necrosis_OnDragStop(f);
	end
end

-- Fonction permettant l'affichage des différentes pages du livre des configurations
function NecrosisGeneralTab_OnClick(id)
	local TabName;
	for index=1, 5, 1 do
		TabName = _G["NecrosisGeneralTab"..index];
		if index == id then
			TabName:SetChecked(1);
		else
			TabName:SetChecked(nil);
		end
	end
	if id == 1 then
		ShowUIPanel(NecrosisShardMenu);
		HideUIPanel(NecrosisMessageMenu);
		HideUIPanel(NecrosisButtonMenu);
		HideUIPanel(NecrosisTimerMenu);
		HideUIPanel(NecrosisGraphOptionMenu);
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu1);
	elseif id == 2 then
		HideUIPanel(NecrosisShardMenu);
		ShowUIPanel(NecrosisMessageMenu);
		HideUIPanel(NecrosisButtonMenu);
		HideUIPanel(NecrosisTimerMenu);
		HideUIPanel(NecrosisGraphOptionMenu);
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu2);
	elseif id == 3 then
		HideUIPanel(NecrosisShardMenu);
		HideUIPanel(NecrosisMessageMenu);
		ShowUIPanel(NecrosisButtonMenu);
		HideUIPanel(NecrosisTimerMenu);
		HideUIPanel(NecrosisGraphOptionMenu);
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu3);
	elseif id == 4 then
		HideUIPanel(NecrosisShardMenu);
		HideUIPanel(NecrosisMessageMenu);
		HideUIPanel(NecrosisButtonMenu);
		ShowUIPanel(NecrosisTimerMenu);
		HideUIPanel(NecrosisGraphOptionMenu);
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu4);
	elseif id == 5 then
		HideUIPanel(NecrosisShardMenu);
		HideUIPanel(NecrosisMessageMenu);
		HideUIPanel(NecrosisButtonMenu);
		HideUIPanel(NecrosisTimerMenu);
		ShowUIPanel(NecrosisGraphOptionMenu);
		NecrosisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		NecrosisGeneralPageText:SetText(NECROSIS_CONFIGURATION.Menu5);
	end
end

function NecrosisTimer(nom, duree)
	local Cible = UnitName("target");
	local Niveau = UnitLevel("target");
	local truc = 6;
	if not Cible then
		Cible = "";
		truc = 2;
	end
	if not Niveau then
		Niveau = "";
	end

	SpellGroup, SpellTimer, TimerTable = NecrosisTimerX(nom, duree, truc, Cible, Niveau, SpellGroup, SpellTimer, TimerTable);
end

-- Time l'équipement de la pierre de sort.
function Necrosis_EquipSpellStone()
	if SpellstoneMode == 2 then
		SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerStone("SpellstoneIn", nil, nil, SpellGroup, SpellTimer, TimerTable);
	end
end

function Necrosis_SearchWand(bool)
	local ItemOnHand = nil;
	local baggy={nil,nil};
	for container=0, 4, 1 do
		-- Parcours des emplacements des sacs
		for slot=1, GetContainerNumSlots(container), 1 do
			Necrosis_MoneyToggle();
			NecrosisTooltip:SetBagItem(container, slot);
			local itemName = tostring(NecrosisTooltipTextLeft1:GetText());
			local itemName2 = tostring(NecrosisTooltipTextLeft2:GetText());
			local itemName3 = tostring(NecrosisTooltipTextLeft3:GetText());
			local itemSwitch = tostring(NecrosisTooltipTextRight3:GetText());
			local itemSwitch2 = tostring(NecrosisTooltipTextRight4:GetText());
			-- Dans le cas d'un emplacement non vide
			if itemName then
				-- On note aussi la présence ou non des objets "main gauche"
				-- Plus tard ce sera utilisé pour remplacer automatiquement une pierre absente
				if (itemSwitch == NECROSIS_ITEM.Ranged or itemSwitch2 == NECROSIS_ITEM.Ranged)
					and (itemName2 == NECROSIS_ITEM.Soulbound or itemName3 == NECROSIS_ITEM.Soulbound)
					then
					ItemOnHand = itemName;
					NecrosisConfig.ItemSwitchCombat[3] = itemName
					baggy = {container, slot};
					break
				end
			end
		end
	end
	if ItemOnHand then
		PickupContainerItem(baggy[1],baggy[2]);
		PickupInventoryItem(18);
	end
end
