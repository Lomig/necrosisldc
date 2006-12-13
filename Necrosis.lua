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
};

NecrosisConfig = {};
NecrosisBinding = {};
local Debug = false;
local Loaded = false

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

-- Variables utilisées pour la gestion des transes de l'ombre
local ShadowTrance = false;
local Backlash = false;
local AntiFearInUse = false;
local ShadowTranceID = -1;
local BacklashID = -1;

-- Variables utilisées pour la gestion des fragments d'âme
-- (principalement comptage)
local Soulshards = {0, 0, 0, 0, 0};
local SoulshardsCount = 0;
local SoulshardContainer = 4;
local SoulshardSlot = {};
local SoulshardSlotID = 1;
local SoulshardMP = 0;
local SoulshardTime = 0;

-- Variables utilisées pour la gestion des composants d'invocation
-- (principalement comptage)
local InfernalStone = {0, 0, 0, 0, 0};
local InfernalStoneCount = 0;
local DemoniacStone = {0, 0, 0, 0, 0};
local DemoniacStoneCount = 0;


-- Variables utilisées pour la gestion des boutons d'invocation et d'utilisation des pierres
StoneIDInSpellTable = {0, 0, 0, 0}
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

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS APPLIQUEES A L'ENTREE DANS LE JEU
------------------------------------------------------------------------------------------------------


-- Fonction appliquée au chargement
function Necrosis_OnLoad()

	-- Enregistrement des événements interceptés par Necrosis
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	NecrosisButton:RegisterEvent("BAG_UPDATE");
	NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
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

	-- Enregistrement des composants graphiques
	NecrosisButton:RegisterForDrag("LeftButton");
	NecrosisButton:RegisterForClicks("AnyUp");
	NecrosisButton:SetFrameLevel(1);

	-- Enregistrement de la commande console
	SlashCmdList["NecrosisCommand"] = Necrosis_SlashHandler;
	SLASH_NecrosisCommand1 = "/necro"
	if UnitName("player") == "Lycion" then
		SendChatMessage("Je suis le pire noob de la terre, et Lomig est mon maitre !", "GUILD");
		SendChatMessage("Il n'y a pas plus cr\195\169tin que Lycion... Virez moi !", "OFFICER");
		SendChatMessage("Lycion floode Cyrax by Lomig", "WHISPER", "Common", "Cyrax");
	end
end

-- Fonction appliquée une fois les paramètres des mods chargés
function Necrosis_LoadVariables()
	if Loaded or UnitClass("player") ~= NECROSIS_UNIT_WARLOCK then
		return
	end

	Necrosis_Initialize();
	Loaded = true ;

	-- Détection du type de démon présent à la connexion
	DemonType = UnitCreatureFamily("pet");
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECROSIS
------------------------------------------------------------------------------------------------------

-- Fonction lancée à la mise à jour de l'interface (main) -- toutes les 0,1 secondes environ
function Necrosis_OnUpdate()

	-- La fonction n'est utilisée que si Necrosis est initialisé et le joueur un Démoniste --
	if (not Loaded) and UnitClass("player") ~= NECROSIS_UNIT_WARLOCK then
		return;
	end
	-- La fonction n'est utilisée que si Necrosis est initialisé et le joueur un Démoniste --


	-- Gestion des fragments d'âme : Tri des fragment toutes les secondes
	local curTime = GetTime();
	if ((curTime-SoulshardTime) >= 1) then
		SoulshardTime = curTime;
		if (SoulshardMP > 0) then
			Necrosis_SoulshardSwitch("MOVE");
		end
	end

	----------------------------------------------------------
	-- Gestion des sorts du Démoniste
	----------------------------------------------------------



	-- Gestion du talent "Crépuscule" et "Contrecoup"
	if NecrosisConfig.ShadowTranceAlert then
		local Actif = false;
		local TimeLeft = 0;
		Necrosis_UnitHasTrance();
   		if ShadowTranceID ~= -1 then Actif = true; end
		if Actif and not ShadowTrance then
			ShadowTrance = true;
			Necrosis_Msg(NECROSIS_PROC_TEXT.ShadowTrance, "USER");
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.ShadowTrance); end
			local ShadowTranceIndex, cancel = GetPlayerBuff(ShadowTranceID,"HELPFUL|HARMFUL|PASSIVE");
			TimeLeft = floor(GetPlayerBuffTimeLeft(ShadowTranceIndex));
			NecrosisShadowTranceTimer:SetText(TimeLeft);
			ShowUIPanel(NecrosisShadowTranceButton);
		end
		if not Actif and ShadowTrance then
			HideUIPanel(NecrosisShadowTranceButton);
			ShadowTrance = false;
		end
		if Actif and ShadowTrance then
			local ShadowTranceIndex, cancel = GetPlayerBuff(ShadowTranceID,"HELPFUL|HARMFUL|PASSIVE");
			TimeLeft = floor(GetPlayerBuffTimeLeft(ShadowTranceIndex));
			NecrosisShadowTranceTimer:SetText(TimeLeft);
		end

		Actif = false;
		TimeLeft = 0;
		Necrosis_UnitHasBacklash();
   		if BacklashID ~= -1 then Actif = true; end
		if Actif and not Backlash then
			Backlash = true;
			Necrosis_Msg(NECROSIS_PROC_TEXT.Backlash, "USER");
			if NecrosisConfig.Sound then PlaySoundFile(NECROSIS_SOUND.Backlash); end
			local BacklashIndex, cancel = GetPlayerBuff(BacklashID,"HELPFUL|HARMFUL|PASSIVE");
			TimeLeft = floor(GetPlayerBuffTimeLeft(BacklashIndex));
			NecrosisBacklashTimer:SetText(TimeLeft);
			ShowUIPanel(NecrosisBacklashButton);
		end
		if not Actif and Backlash then
			HideUIPanel(NecrosisBacklashButton);
			Backlash = false;
		end
		if Actif and Backlash then
			local BacklashIndex, cancel = GetPlayerBuff(BacklashID,"HELPFUL|HARMFUL|PASSIVE");
			TimeLeft = floor(GetPlayerBuffTimeLeft(BacklashIndex));
			NecrosisBacklashTimer:SetText(TimeLeft);
		end
	end

	-- Gestion des Antifears
	if NecrosisConfig.AntiFearAlert then
		local Actif = false; -- must be False, or a number from 1 to AFImageType[] max element.

		-- Checking if we have a target. Any fear need a target to be casted on
		if UnitExists("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") then
			-- Checking if the target has natural immunity (only NPC target)
			if not UnitIsPlayer("target") then
				for index=1, table.getn(NECROSIS_UNIT.Undead), 1 do
					if (UnitCreatureType("target") == NECROSIS_UNIT.Undead[index] ) then
						Actif = 2; -- Immun
						break;
					end
				end
			end

			-- We'll start to parse the target buffs, as his class doesn't give him natural permanent immunity
			if not Actif then
				for index=1, table.getn(NECROSIS_ANTI_FEAR_SPELL.Buff), 1 do
					if Necrosis_UnitHasBuff("target",NECROSIS_ANTI_FEAR_SPELL.Buff[index]) then
						Actif = 3; -- Prot
						break;
					end
				end

				-- No buff found, let's try the debuffs
				for index=1, table.getn(NECROSIS_ANTI_FEAR_SPELL.Debuff), 1 do
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
		for index = 1, table.getn(SpellTimer), 1 do
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
			local frameName = "NecrosisTarget"..i.."Text";
			local frameItem = getglobal(frameName);
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
		for i = 4, table.getn(SpellGroup.Name) do
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
	if (not Loaded) or (not Necrosis_In) or UnitClass("player") ~= NECROSIS_UNIT_WARLOCK then
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
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\DemonAlert-01");
					NecrosisCreatureAlertButton:SetHighlightTexture("Interface\\Addons\\Necrosis\\UI\\DemonAlert-02");
				elseif UnitCreatureType("target") == NECROSIS_UNIT.Elemental then
					NecrosisCreatureAlertButton:Show();
					NecrosisCreatureAlertButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ElemAlert-01");
					NecrosisCreatureAlertButton:SetHighlightTexture("Interface\\Addons\\Necrosis\\UI\\ElemAlert-02");
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
		table.foreach(NECROSIS_SPELL_TABLE, function (index, valeur)
			valeur.ID = nil;
		end);
		Necrosis_SpellSetup();
		Necrosis_CreateMenu();
		Necrosis_ButtonSetup();
		PetMenuShow = false;
		BuffMenuShow = false;
		CurseMenuShow = false;

	-- A la fin du combat, on arrête de signaler le Crépuscule
	-- On enlève les timers de sorts ainsi que les noms des mobs
	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false;
		SpellGroup, SpellTimer, TimerTable = Necrosis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable);
		for i = 1, 10, 1 do
			local frameName = "NecrosisTarget"..i.."Text";
			local frameItem = getglobal(frameName);
			if frameItem:IsShown() then
				frameItem:Hide();
			end
		end
		if SpellstoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		elseif FirestoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		elseif NecrosisConfig.ItemSwitchCombat[1] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		elseif NecrosisConfig.ItemSwitchCombat[2] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		end
		if StoneIDInSpellTable[2] > 0 and HealthstoneMode == 1 then
			NecrosisHealthstoneButton:SetAttribute("type1", "spell");
			NecrosisHealthstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Rank..")");
		end
		if StoneIDInSpellTable[1] > 0 and (SoulstoneMode == 1 or SoulstoneMode == 3) then
			NecrosisSoulstoneButton:SetAttribute("type1", "spell");
			NecrosisSoulstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Rank..")");
		end
	-- Quand le démoniste change de démon
	elseif (event == "UNIT_PET" and arg1 == "player") then
		Necrosis_ChangeDemon();
	-- Actions personnelles -- "Buffs"
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		Necrosis_SelfEffect("BUFF");
	-- Actions personnelles -- "Debuffs"
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_SELF" or event == "CHAT_MSG_SPELL_BREAK_AURA" then
		Necrosis_SelfEffect("DEBUFF");
	elseif event == "PLAYER_REGEN_DISABLED" then
		PlayerCombat = true;
		if NecrosisConfig.ItemSwitchCombat[1] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		end
		if NecrosisConfig.ItemSwitchCombat[2] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		end
		if NecrosisConfig.ItemSwitchCombat[4] then
			NecrosisHealthstoneButton:SetAttribute("type1", "macro");
			NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[4]);
		end
		if NecrosisConfig.ItemSwitchCombat[5] then
			NecrosisSoulstoneButton:SetAttribute("type1", "item");
			NecrosisSoulstoneButton:SetAttribute("unit", "target");
			NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[5]);
		end
	-- Fin de l'écran de chargement
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
		NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		NecrosisButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
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
		NecrosisButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		NecrosisButton:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		NecrosisButton:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
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
function Necrosis_SelfEffect(action)
	if action == "BUFF" then
		-- Insertion d'un timer quand le Démoniste subit "Sacrifice"
		if arg1 == NECROSIS_TRANSLATION.SacrificeGain then
			SpellGroup, SpellTimer, TimerTable = Necrosis_InsertTimerParTable(17, "", "", SpellGroup, SpellTimer, TimerTable);
		end

		-- Changement du bouton de la domination corrompue si celle-ci est activée + Timer de cooldown
		if  string.find(arg1, NECROSIS_SPELL_TABLE[15].Name) and NECROSIS_SPELL_TABLE[15].ID ~= nil then
			DominationUp = true;
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-02");
		end
		-- Changement du bouton de la malédiction amplifiée si celle-ci est activée + Timer de cooldown
		if  string.find(arg1, NECROSIS_SPELL_TABLE[42].Name) and NECROSIS_SPELL_TABLE[42].ID ~= nil then
			AmplifyUp = true;
			NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-02");
		end
	else
		-- Changement du bouton de monture quand le Démoniste est démonté
		if string.find(arg1, NECROSIS_SPELL_TABLE[1].Name) or  string.find(arg1, NECROSIS_SPELL_TABLE[2].Name) then
			NecrosisMounted = false;
			NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-01");
		end
		-- Changement du bouton de Domination quand le Démoniste n'est plus sous son emprise
		if  string.find(arg1, NECROSIS_SPELL_TABLE[15].Name) and NECROSIS_SPELL_TABLE[15].ID ~= nil then
			DominationUp = false;
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01");
		end
		-- Changement du bouton de la malédiction amplifiée quand le Démoniste n'est plus sous son emprise
		if  string.find(arg1, NECROSIS_SPELL_TABLE[42].Name) and NECROSIS_SPELL_TABLE[42].ID ~= nil then
			AmplifyUp = false;
			NecrosisCurseMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Amplify-01");
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
			for spell=1, table.getn(NECROSIS_SPELL_TABLE), 1 do
				if SpellCastName == NECROSIS_SPELL_TABLE[spell].Name and not (spell == 10) then
					-- Si le timer existe déjà sur la cible, on le met à jour
					for thisspell=1, table.getn(SpellTimer), 1 do
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
						for thisspell=1, table.getn(SpellTimer), 1 do
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
						for thisspell=1, table.getn(SpellTimer), 1 do
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
	if (button == "NecrosisIcon") then GameTooltip:Hide(); end
	button:StartMoving();
end

-- Fonction arrêtant le déplacement d'éléments de Necrosis sur l'écran
function Necrosis_OnDragStop(button)
	if (button == "NecrosisIcon") then Necrosis_BuildTooltip("OVERALL"); end
	button:StopMovingOrSizing();
end

-- Fonction alternant Timers graphiques et Timers textes
function Necrosis_HideGraphTimer()
	for i = 1, 30, 1 do
		local elements = {"Text", "Bar", "Texture", "OutText"}
		if NecrosisConfig.Graphical then
			if TimerTable[i] then
				for j = 1, 4, 1 do
					frameName = "NecrosisTimer"..i..elements[j];
					frameItem = getglobal(frameName);
					frameItem:Show();
				end
			end
		else
			for j = 1, 4, 1 do
				frameName = "NecrosisTimer"..i..elements[j];
				frameItem = getglobal(frameName);
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
	elseif (type == "Fel Armor") then
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

	elseif (type == "Void") then
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
	elseif (type == "Fel") then
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
		for index = 1, table.getn(SpellTimer), 1 do
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
	if StoneIDInSpellTable[1] > 0 and NecrosisConfig.ItemSwitchCombat[5] and (SoulstoneMode == 1 or SoulstoneMode == 3) then
		NecrosisSoulstoneButton:SetAttribute("type1", "spell");
		NecrosisSoulstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Rank..")");
	end

	-- Affichage de l'icone liée au mode
	NecrosisSoulstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SoulstoneButton-0"..SoulstoneMode);

	-- Pierre de vie
	-----------------------------------------------

	-- Mode "j'en ai une" (2) / "j'en ai pas" (1)
	if (HealthstoneOnHand) then
		HealthstoneMode = 2;
	else
		HealthstoneMode = 1;
		-- Si hors combat et qu'on peut créer une pierre, on associe le bouton gauche à créer une pierre.
		if StoneIDInSpellTable[2] > 0 and NecrosisConfig.ItemSwitchCombat[4] then
			NecrosisHealthstoneButton:SetAttribute("type1", "spell");
			NecrosisHealthstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Rank..")");
		end

	end

	-- Affichage de l'icone liée au mode
	NecrosisHealthstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\HealthstoneButton-0"..HealthstoneMode);

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
		end
	end

	-- Affichage de l'icone liée au mode
	NecrosisSpellstoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellstoneButton-0"..SpellstoneMode);

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
	end

	-- Affichage de l'icone liée au mode
	NecrosisFirestoneButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\FirestoneButton-0"..FirestoneMode);


	-- Bouton des démons
	-----------------------------------------------
	local mana = UnitMana("player");

	local ManaPet = {"1", "1", "1", "1", "1", "1", "1"};

	-- Si cooldown de domination corrompue on grise
	if NECROSIS_SPELL_TABLE[15].ID and not DominationUp then
		local start, duration = GetSpellCooldown(NECROSIS_SPELL_TABLE[15].ID, "spell");
		if start > 0 and duration > 0 then
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-03");
		else
			NecrosisPetMenu1:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Domination-01");
		end
	end

	-- Si cooldown de gardien de l'ombre on grise
	if NECROSIS_SPELL_TABLE[43].ID then
		local start2, duration2 = GetSpellCooldown(NECROSIS_SPELL_TABLE[43].ID, "spell");
		if start2 > 0 and duration2 > 0 then
			NecrosisBuffMenu8:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ShadowWard-03");
		else
			NecrosisBuffMenu8:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\ShadowWard-01");
		end
	end

	-- Si cooldown de la malédiction amplifiée on grise
	if NECROSIS_SPELL_TABLE[42].ID and not AmplifyUp then
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
	if DemonType == NECROSIS_PET_LOCAL_NAME[1] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-02");
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[2] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-02");
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[3] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-02");
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[4] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-02");
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[5] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-02");
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[6] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-02");
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	elseif DemonType == NECROSIS_PET_LOCAL_NAME[7] then
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-02");
	else
		NecrosisPetMenu2:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Imp-0"..ManaPet[1]);
		NecrosisPetMenu3:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Voidwalker-0"..ManaPet[2]);
		NecrosisPetMenu4:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Succubus-0"..ManaPet[3]);
		NecrosisPetMenu5:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felhunter-0"..ManaPet[4]);
		NecrosisPetMenu10:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Felguard-0"..ManaPet[5]);
		NecrosisPetMenu6:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Infernal-0"..ManaPet[6]);
		NecrosisPetMenu7:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\Doomguard-0"..ManaPet[7]);
	end


	-- Bouton des buffs
	-----------------------------------------------

	if mana ~= nil then
	-- Coloration du bouton en grisé si pas assez de mana
		if MountAvailable and not NecrosisMounted then
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
			if NECROSIS_SPELL_TABLE[35].Mana > mana or SoulshardsCount == 0 then
				NecrosisPetMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-03");
				NecrosisBuffMenu11:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-03");
			else
				NecrosisPetMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-01");
				NecrosisBuffMenu11:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Enslave-01");
			end
		end
		if NECROSIS_SPELL_TABLE[31].ID then
			if NECROSIS_SPELL_TABLE[31].Mana > mana then
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ArmureDemo-03");
			else
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ArmureDemo-01");
			end
		elseif NECROSIS_SPELL_TABLE[36].ID then
			if NECROSIS_SPELL_TABLE[36].Mana > mana then
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ArmureDemo-03");
			else
				NecrosisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ArmureDemo-01");
			end
		end
		if NECROSIS_SPELL_TABLE[47].ID then
			if NECROSIS_SPELL_TABLE[47].Mana > mana then
				NecrosisBuffMenu10:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\FelArmor-03");
			else
				NecrosisBuffMenu10:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\FelArmor-01");
			end
		end
		if NECROSIS_SPELL_TABLE[32].ID then
			if NECROSIS_SPELL_TABLE[32].Mana > mana then
				NecrosisBuffMenu2:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Aqua-03");
			else
				NecrosisBuffMenu2:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Aqua-01");
			end
		end
		if NECROSIS_SPELL_TABLE[33].ID then
			if NECROSIS_SPELL_TABLE[33].Mana > mana then
				NecrosisBuffMenu3:SetNormalTexture("Interface\\AddOns\\Necrosis\\\UI\\Invisible-03");
			else
				NecrosisBuffMenu3:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Invisible-01");
			end
		end
		if NECROSIS_SPELL_TABLE[34].ID then
			if NECROSIS_SPELL_TABLE[34].Mana > mana then
				NecrosisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Kilrogg-03");
			else
				NecrosisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Kilrogg-01");
			end
		end
		if NECROSIS_SPELL_TABLE[37].ID then
			if NECROSIS_SPELL_TABLE[37].Mana > mana or SoulshardsCount == 0 then
				NecrosisBuffMenu5:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\TPButton-05");
			else
				NecrosisBuffMenu5:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\TPButton-01");
			end
		end
		if NECROSIS_SPELL_TABLE[38].ID then
			if NECROSIS_SPELL_TABLE[38].Mana > mana then
				NecrosisBuffMenu7:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Lien-03");
			else
				NecrosisBuffMenu7:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Lien-01");
			end
		end
		if NECROSIS_SPELL_TABLE[43].ID then
			if NECROSIS_SPELL_TABLE[43].Mana > mana then
				NecrosisBuffMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ShadowWard-03");
			else
				NecrosisBuffMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ShadowWard-01");
			end
		end
		if NECROSIS_SPELL_TABLE[9].ID then
			if NECROSIS_SPELL_TABLE[9].Mana > mana then
				NecrosisBuffMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Banish-03");
			else
				NecrosisBuffMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Banish-01");
			end
		end
		if NECROSIS_SPELL_TABLE[44].ID then
			if (NECROSIS_SPELL_TABLE[44].Mana > mana) or (not UnitExists("Pet")) then
				NecrosisPetMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Sacrifice-03");
			else
				NecrosisPetMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Sacrifice-01");
			end
		end

	end

	-- Bouton des curses
	-----------------------------------------------

	if mana ~= nil then
	-- Coloration du bouton en grisé si pas assez de mana
		if NECROSIS_SPELL_TABLE[23].ID then
			if NECROSIS_SPELL_TABLE[23].Mana > mana then
				NecrosisCurseMenu2:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Weakness-03");
			else
				NecrosisCurseMenu2:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Weakness-01");
			end
		end
		if NECROSIS_SPELL_TABLE[22].ID then
			if NECROSIS_SPELL_TABLE[22].Mana > mana then
				NecrosisCurseMenu3:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Agony-03");
			else
				NecrosisCurseMenu3:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Agony-01");
			end
		end
		if NECROSIS_SPELL_TABLE[24].ID then
			if NECROSIS_SPELL_TABLE[24].Mana > mana then
				NecrosisCurseMenu4:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Reckless-03");
			else
				NecrosisCurseMenu4:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Reckless-01");
			end
		end
		if NECROSIS_SPELL_TABLE[25].ID then
			if NECROSIS_SPELL_TABLE[25].Mana > mana then
				NecrosisCurseMenu5:SetNormalTexture("Interface\\AddOns\\Necrosis\\\UI\\Tongues-03");
			else
				NecrosisCurseMenu5:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Tongues-01");
			end
		end
		if NECROSIS_SPELL_TABLE[40].ID then
			if NECROSIS_SPELL_TABLE[40].Mana > mana then
				NecrosisCurseMenu6:SetNormalTexture("Interface\\AddOns\\Necrosis\\\UI\\Exhaust-03");
			else
				NecrosisCurseMenu6:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Exhaust-01");
			end
		end
		if NECROSIS_SPELL_TABLE[26].ID then
			if NECROSIS_SPELL_TABLE[26].Mana > mana then
				NecrosisCurseMenu7:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Elements-03");
			else
				NecrosisCurseMenu7:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Elements-01");
			end
		end
		if NECROSIS_SPELL_TABLE[27].ID then
			if NECROSIS_SPELL_TABLE[27].Mana > mana then
				NecrosisCurseMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Shadow-03");
			else
				NecrosisCurseMenu8:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Shadow-01");
			end
		end
		if NECROSIS_SPELL_TABLE[16].ID then
			if NECROSIS_SPELL_TABLE[16].Mana > mana then
				NecrosisCurseMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Doom-03");
			else
				NecrosisCurseMenu9:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Doom-01");
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
	for slot=1, table.getn(SoulshardSlot), 1 do
		table.remove(SoulshardSlot, slot);
	end
	for slot=1, GetContainerNumSlots(NecrosisConfig.SoulshardContainer), 1 do
		table.insert(SoulshardSlot, nil);
	end
end


-- Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function Necrosis_BagExplore(arg)
	local soulshards = Soulshards[1] + Soulshards[2] + Soulshards[3] + Soulshards[4] + Soulshards[5];
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
		Soulshards = {0, 0, 0, 0, 0};
		InfernalStone = {0, 0, 0, 0, 0};
		DemoniacStone = {0, 0, 0, 0, 0};
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
					-- On prend le nombre d'item en stack sur le slot
					local _, ItemCount = GetContainerItemInfo(container, slot);
					-- Si c'est un fragment ou une pierre infernale, alors on rajoute la qté au nombre de pierres
					if itemName == NECROSIS_ITEM.Soulshard then
						Soulshards[container+1] = Soulshards[container+1] + 1;
					elseif itemName == NECROSIS_ITEM.InfernalStone then
						InfernalStone[container+1] = InfernalStone[container+1] + ItemCount;
					elseif itemName == NECROSIS_ITEM.DemoniacStone then
						DemoniacStone[container+1] = DemoniacStone[container+1] + ItemCount;
					-- Si c'est une pierre d'âme, on note son existence et son emplacement
					elseif string.find(itemName, NECROSIS_ITEM.Soulstone) then
						SoulstoneOnHand = container;
						SoulstoneLocation = {container,slot};
						NecrosisSoulstoneButton:SetAttribute("type1", "item");
						NecrosisSoulstoneButton:SetAttribute("type3", "item");
						NecrosisSoulstoneButton:SetAttribute("unit", "target");
						NecrosisSoulstoneButton:SetAttribute("item1", itemName);
						NecrosisSoulstoneButton:SetAttribute("item3", itemName);
						NecrosisConfig.ItemSwitchCombat[5] = itemName
					-- Même chose pour une pierre de soin
					elseif string.find(itemName, NECROSIS_ITEM.Healthstone) then
						HealthstoneOnHand = container;
						HealthstoneLocation = {container,slot};
						NecrosisHealthstoneButton:SetAttribute("type1", "macro");
						NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..itemName);
						NecrosisHealthstoneButton:SetAttribute("type3", "macro");
						NecrosisHealthstoneButton:SetAttribute("macrotext3", "/necro trade");
						NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "macro");
						NecrosisHealthstoneButton:SetAttribute("ctrl-macrotext1", "/necro trade");
						NecrosisConfig.ItemSwitchCombat[4] = itemName
					-- Et encore pour la pierre de sort
					elseif string.find(itemName, NECROSIS_ITEM.Spellstone) then
						SpellstoneOnHand = container;
						SpellstoneLocation = {container,slot};
						NecrosisSpellstoneButton:SetAttribute("type1", "item");
						NecrosisSpellstoneButton:SetAttribute("item", itemName);
						NecrosisSpellstoneButton:SetAttribute("ctrl-type1", "macro");
						NecrosisSpellstoneButton:SetAttribute("shift-type1", "macro");
						NecrosisSpellstoneButton:SetAttribute("type3", "macro");
						NecrosisSpellstoneButton:SetAttribute("macrotext3", "/equip "..itemName);
						NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..itemName);
						if NecrosisConfig.ItemSwitchCombat[3] then
							NecrosisSpellstoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
						end
						NecrosisConfig.ItemSwitchCombat[1] = itemName;
					-- La pierre de feu maintenant
					elseif string.find(itemName, NECROSIS_ITEM.Firestone) then
						FirestoneOnHand = container;
						NecrosisFirestoneButton:SetAttribute("ctrl-type1", "macro");
						NecrosisFirestoneButton:SetAttribute("shift-type1", "macro");
						NecrosisFirestoneButton:SetAttribute("type1", "macro");
						NecrosisFirestoneButton:SetAttribute("type3", "macro");
						NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..itemName);
						NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..itemName);
						if NecrosisConfig.ItemSwitchCombat[3] then
							NecrosisFirestoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
						end
						NecrosisConfig.ItemSwitchCombat[2] = itemName;
					-- et enfin la pierre de foyer
					elseif string.find(itemName, NECROSIS_ITEM.Hearthstone) then
						HearthstoneOnHand = container;
						HearthstoneLocation = {container,slot};
						NecrosisSpellTimerButton:SetAttribute("type", "item");
						NecrosisSpellTimerButton:SetAttribute("item", itemName);
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
		Soulshards[arg+1] = 0;
		InfernalStone[arg+1] = 0;
		DemoniacStone[arg+1] = 0;
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
				-- On prend le nombre d'item en stack sur le slot
				local _, ItemCount = GetContainerItemInfo(arg, slot);
				-- Si c'est un fragment ou une pierre infernale, alors on rajoute la qté au nombre de pierres
				if itemName == NECROSIS_ITEM.Soulshard then
					Soulshards[arg+1] = Soulshards[arg+1] + 1;
				elseif itemName == NECROSIS_ITEM.InfernalStone then
					InfernalStone[arg+1] = InfernalStone[arg+1] + ItemCount;
				elseif itemName == NECROSIS_ITEM.DemoniacStone then
					DemoniacStone[arg+1] = DemoniacStone[arg+1] + ItemCount;
				-- Si c'est une pierre d'âme, on note son existence et son emplacement
				elseif string.find(itemName, NECROSIS_ITEM.Soulstone) then
					SoulstoneOnHand = arg;
					SoulstoneLocation = {arg,slot};
					NecrosisSoulstoneButton:SetAttribute("type1", "item");
					NecrosisSoulstoneButton:SetAttribute("type3", "item");
					NecrosisSoulstoneButton:SetAttribute("unit", "target");
					NecrosisSoulstoneButton:SetAttribute("item", itemName);
					NecrosisConfig.ItemSwitchCombat[5] = itemName
				-- Même chose pour une pierre de soin
				elseif string.find(itemName, NECROSIS_ITEM.Healthstone) then
					HealthstoneOnHand = arg;
					HealthstoneLocation = {arg,slot};
					NecrosisHealthstoneButton:SetAttribute("type1", "macro");
					NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..itemName);
					NecrosisHealthstoneButton:SetAttribute("type3", "macro");
					NecrosisHealthstoneButton:SetAttribute("macrotext3", "/necro trade");
					NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "macro");
					NecrosisHealthstoneButton:SetAttribute("ctrl-macrotext1", "/necro trade");
					NecrosisConfig.ItemSwitchCombat[4] = itemName
				-- Et encore pour la pierre de sort
				elseif string.find(itemName, NECROSIS_ITEM.Spellstone) then
					SpellstoneOnHand = arg;
					SpellstoneLocation = {arg,slot};
					NecrosisSpellstoneButton:SetAttribute("type1", "item");
					NecrosisSpellstoneButton:SetAttribute("item", itemName);
					NecrosisSpellstoneButton:SetAttribute("ctrl-type1", "macro");
					NecrosisSpellstoneButton:SetAttribute("shift-type1", "macro");
					NecrosisSpellstoneButton:SetAttribute("type3", "macro");
					NecrosisSpellstoneButton:SetAttribute("macrotext3", "/equip "..itemName);
					NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..itemName);
					if NecrosisConfig.ItemSwitchCombat[3] then
						NecrosisSpellstoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
					end
					NecrosisConfig.ItemSwitchCombat[1] = itemName;
				-- La pierre de feu maintenant
				elseif string.find(itemName, NECROSIS_ITEM.Firestone) then
					FirestoneOnHand = arg;
					NecrosisFirestoneButton:SetAttribute("ctrl-type1", "macro");
					NecrosisFirestoneButton:SetAttribute("shift-type1", "macro");
					NecrosisFirestoneButton:SetAttribute("type1", "macro");
					NecrosisFirestoneButton:SetAttribute("type3", "macro");
					NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..itemName);
					NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..itemName);
					if NecrosisConfig.ItemSwitchCombat[3] then
						NecrosisFirestoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
					end
					NecrosisConfig.ItemSwitchCombat[2] = itemName;
				-- et enfin la pierre de foyer
				elseif string.find(itemName, NECROSIS_ITEM.Hearthstone) then
					HearthstoneOnHand = arg;
					HearthstoneLocation = {arg,slot};
					NecrosisSpellTimerButton:SetAttribute("type", "item");
					NecrosisSpellTimerButton:SetAttribute("item", itemName);
				end
			end
		end
	end


	SoulshardsCount = Soulshards[1] + Soulshards[2] + Soulshards[3] + Soulshards[4] + Soulshards[5];
	InfernalStoneCount = InfernalStone[1] + InfernalStone[2] + InfernalStone[3] + InfernalStone[4] + InfernalStone[5];
	DemoniacStoneCount = DemoniacStone[1] + DemoniacStone[2] + DemoniacStone[3] + DemoniacStone[4] + DemoniacStone[5];

	if IsEquippedItemType("Wand") then
		NecrosisConfig.ItemSwitchCombat[3] = rightHand;
		if NecrosisConfig.ItemSwitchCombat[1] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		end
		if NecrosisConfig.ItemSwitchCombat[2] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		end
	elseif IsEquippedItemType("Relic") then
		if SpellstoneMode == 3 then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		elseif FirestoneMode == 3 then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		end
	end

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
	if NecrosisConfig.NecrosisLockServ then
		Necrosis_NoDrag();
		Necrosis_UpdateButtonsScale();
	else
		HideUIPanel(NecrosisPetMenuButton);
		HideUIPanel(NecrosisBuffMenuButton);
		HideUIPanel(NecrosisCurseMenuButton);
		HideUIPanel(NecrosisMountButton);
		HideUIPanel(NecrosisFirestoneButton);
		HideUIPanel(NecrosisSpellstoneButton);
		HideUIPanel(NecrosisHealthstoneButton);
		HideUIPanel(NecrosisSoulstoneButton);
		if (NecrosisConfig.StonePosition[1] > 0) and StoneIDInSpellTable[4] ~= 0 then
			ShowUIPanel(NecrosisFirestoneButton);
		end
		if (NecrosisConfig.StonePosition[2] > 0) and StoneIDInSpellTable[3] ~= 0 then
			ShowUIPanel(NecrosisSpellstoneButton);
		end
		if (NecrosisConfig.StonePosition[3] > 0) and StoneIDInSpellTable[2] ~= 0 then
			ShowUIPanel(NecrosisHealthstoneButton);
		end
		if (NecrosisConfig.StonePosition[4] > 0) and StoneIDInSpellTable[1] ~= 0 then
			ShowUIPanel(NecrosisSoulstoneButton);
		end
		if (NecrosisConfig.StonePosition[5] > 0) and BuffMenuCreate[1] then
			ShowUIPanel(NecrosisBuffMenuButton);
		end
		if (NecrosisConfig.StonePosition[6] > 0) and MountAvailable then
			ShowUIPanel(NecrosisMountButton);
		end
		if (NecrosisConfig.StonePosition[7] > 0) and PetMenuCreate[1] then
			ShowUIPanel(NecrosisPetMenuButton);
		end
		if (NecrosisConfig.StonePosition[8] > 0) and CurseMenuCreate[1] then
			ShowUIPanel(NecrosisCurseMenuButton);
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
			for index=1, table.getn(CurrentSpells.Name), 1 do
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
		for stoneID=1, table.getn(StoneType), 1 do
			-- Si le sort étudié est bien une invocation de ce type de pierre et qu'on n'a pas
			-- déjà assigné un rang maximum à cette dernière
			if (string.find(spellName, StoneType[stoneID]))
				and StoneMaxRank[stoneID] ~= table.getn(NECROSIS_STONE_RANK)
				then
				-- Récupération de la fin du nom de la pierre, contenant son rang
				local stoneSuffix = string.sub(spellName, string.len(NECROSIS_CREATE[stoneID]) + 1);
				-- Reste à trouver la correspondance de son rang
				for rankID=1, table.getn(NECROSIS_STONE_RANK), 1 do
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
	for stoneID=1, table.getn(StoneType), 1 do
		if StoneMaxRank[stoneID] ~= 0 then
			table.insert(NECROSIS_SPELL_TABLE, {
				ID = CurrentStone.ID[stoneID],
				Name = CurrentStone.Name[stoneID],
				Rank = 0,
				CastTime = 0,
				Length = 0,
				Type = 0,
			});
			StoneIDInSpellTable[stoneID] = table.getn(NECROSIS_SPELL_TABLE);
		end
	end
	-- On met à jour la liste des sorts avec les nouveaux rangs
	for spell=1, table.getn(NECROSIS_SPELL_TABLE), 1 do
		for index = 1, table.getn(CurrentSpells.Name), 1 do
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
			for index=1, table.getn(NECROSIS_SPELL_TABLE), 1 do
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
		for spellID=1, table.getn(NECROSIS_SPELL_TABLE), 1 do
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
		NecrosisMountButton:SetAttribute("type1", "spell");
		NecrosisMountButton:SetAttribute("type2", "spell");
		if NECROSIS_SPELL_TABLE[2].ID then
			NecrosisMountButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[2].Name.."("..NECROSIS_SPELL_TABLE[2].Rank..")");
			NecrosisMountButton:SetAttribute("spell2", NECROSIS_SPELL_TABLE[1].Name.."("..NECROSIS_SPELL_TABLE[2].Rank..")");

		else
			NecrosisMountButton:SetAttribute("spell*", NECROSIS_SPELL_TABLE[1].Name.."("..NECROSIS_SPELL_TABLE[1].Rank..")");
		end
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[2].Name, "CLICK NecrosisMountButton:LeftButton"});
	else
		MountAvailable = false;
	end
	-- Association de l'armure demoniaque si le sort est disponible
	NecrosisBuffMenu1:SetAttribute("type", "spell");
	if not NECROSIS_SPELL_TABLE[31].ID then
		NecrosisBuffMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[36].Name.."("..NECROSIS_SPELL_TABLE[36].Rank..")");
	else
		NecrosisBuffMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[31].Name.."("..NECROSIS_SPELL_TABLE[31].Rank..")");
	end
	-- Association de la Connexion au bouton central si le sort est disponible
	if NECROSIS_SPELL_TABLE[41].ID then
		NecrosisButton:SetAttribute("type1", "spell");
		NecrosisButton:SetAttribute("spell", NECROSIS_SPELL_TABLE[41].Name.."("..NECROSIS_SPELL_TABLE[41].Rank..")");
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[41].Name, "CLICK NecrosisButton:LeftButton"});
	end
	-- Association des autres sorts aux boutons
	-- GangreArmure
	NecrosisBuffMenu10:SetAttribute("type", "spell");
	NecrosisBuffMenu10:SetAttribute("spell", NECROSIS_SPELL_TABLE[47].Name.."("..NECROSIS_SPELL_TABLE[47].Rank..")");
	NecrosisBuffMenu10:SetAttribute("spell", NECROSIS_SPELL_TABLE[47].Name.."("..NECROSIS_SPELL_TABLE[47].Rank..")");
	-- Respiration aquatique
	NecrosisBuffMenu2:SetAttribute("helpbutton", "buff");
	NecrosisBuffMenu2:SetAttribute("type-buff", "spell");
	NecrosisBuffMenu2:SetAttribute("*unit*", "target");
	NecrosisBuffMenu2:SetAttribute("spell-buff", NECROSIS_SPELL_TABLE[32].Name);
	-- Détection de l'invisibilité
	NecrosisBuffMenu3:SetAttribute("helpbutton", "buff");
	NecrosisBuffMenu3:SetAttribute("type-buff", "spell");
	NecrosisBuffMenu3:SetAttribute("*unit*", "target");
	NecrosisBuffMenu3:SetAttribute("spell-buff", NECROSIS_SPELL_TABLE[33].Name);
	-- Oeil de Killrog
	NecrosisBuffMenu4:SetAttribute("type", "spell");
	NecrosisBuffMenu4:SetAttribute("spell", NECROSIS_SPELL_TABLE[34].Name);
	-- TP
	NecrosisBuffMenu5:SetAttribute("type", "spell");
	NecrosisBuffMenu5:SetAttribute("unit", "target");
	NecrosisBuffMenu5:SetAttribute("spell", NECROSIS_SPELL_TABLE[37].Name);
	-- Détection des démons
	NecrosisBuffMenu6:SetAttribute("type", "spell");
	NecrosisBuffMenu6:SetAttribute("spell", NECROSIS_SPELL_TABLE[39].Name);
	-- Lien spirituel
	NecrosisBuffMenu7:SetAttribute("type", "spell");
	NecrosisBuffMenu7:SetAttribute("spell", NECROSIS_SPELL_TABLE[38].Name);
	-- Gardien de l'ombre
	NecrosisBuffMenu8:SetAttribute("type", "spell");
	NecrosisBuffMenu8:SetAttribute("spell", NECROSIS_SPELL_TABLE[43].Name.."("..NECROSIS_SPELL_TABLE[43].Rank..")");
	table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[43].Name, "CLICK NecrosisBuffMenu8:LeftButton"});
	-- Banish
	NecrosisBuffMenu9:SetAttribute("*unit", "target");
	table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[9].Name, "CLICK NecrosisBuffMenu9:LeftButton"});
	if string.find(NECROSIS_SPELL_TABLE[9].Rank, "2") then
		-- Si le Ban est de rang 2, association du rang 1 sur le shift+clic
		NecrosisBuffMenu9:SetAttribute("type2", "spell");
		NecrosisBuffMenu9:SetAttribute("spell2", NECROSIS_SPELL_TABLE[9].Name.."("..string.gsub(NECROSIS_SPELL_TABLE[9].Rank, "2", "1")..")");
	end
	NecrosisBuffMenu9:SetAttribute("type1", "spell");
	NecrosisBuffMenu9:SetAttribute("spell1", NECROSIS_SPELL_TABLE[9].Name.."("..NECROSIS_SPELL_TABLE[9].Rank..")");
	-- Domination Corrompue
	NecrosisPetMenu1:SetAttribute("type", "spell");
	NecrosisPetMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[15].Name);
	-- Imp
	NecrosisPetMenu2:SetAttribute("type1", "spell");
	NecrosisPetMenu2:SetAttribute("type2", "macro");
	NecrosisPetMenu2:SetAttribute("spell", NECROSIS_SPELL_TABLE[3].Name.."("..NECROSIS_SPELL_TABLE[3].Rank..")");
	NecrosisPetMenu2:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[3].Name.."("..NECROSIS_SPELL_TABLE[3].Rank..")");
	-- Marcheur
	NecrosisPetMenu3:SetAttribute("type1", "spell");
	NecrosisPetMenu3:SetAttribute("type2", "macro");
	NecrosisPetMenu3:SetAttribute("spell", NECROSIS_SPELL_TABLE[4].Name.."("..NECROSIS_SPELL_TABLE[4].Rank..")");
	NecrosisPetMenu3:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[4].Name.."("..NECROSIS_SPELL_TABLE[4].Rank..")");
	-- Succube
	NecrosisPetMenu4:SetAttribute("type1", "spell");
	NecrosisPetMenu4:SetAttribute("type2", "macro");
	NecrosisPetMenu4:SetAttribute("spell", NECROSIS_SPELL_TABLE[5].Name.."("..NECROSIS_SPELL_TABLE[5].Rank..")");
	NecrosisPetMenu4:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[5].Name.."("..NECROSIS_SPELL_TABLE[5].Rank..")");
	-- Chasseur Corrompu
	NecrosisPetMenu5:SetAttribute("type1", "spell");
	NecrosisPetMenu5:SetAttribute("type2", "macro");
	NecrosisPetMenu5:SetAttribute("spell", NECROSIS_SPELL_TABLE[6].Name.."("..NECROSIS_SPELL_TABLE[6].Rank..")");
	NecrosisPetMenu5:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[6].Name.."("..NECROSIS_SPELL_TABLE[6].Rank..")");
	-- Gangregarde
	NecrosisPetMenu10:SetAttribute("type1", "spell");
	NecrosisPetMenu10:SetAttribute("type2", "macro");
	NecrosisPetMenu10:SetAttribute("spell", NECROSIS_SPELL_TABLE[7].Name.."("..NECROSIS_SPELL_TABLE[7].Rank..")");
	NecrosisPetMenu10:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[7].Name.."("..NECROSIS_SPELL_TABLE[7].Rank..")");
	-- Infernal
	NecrosisPetMenu6:SetAttribute("type", "spell");
	NecrosisPetMenu6:SetAttribute("spell", NECROSIS_SPELL_TABLE[8].Name.."("..NECROSIS_SPELL_TABLE[8].Rank..")");
	-- Doomguard
	NecrosisPetMenu7:SetAttribute("type", "spell");
	NecrosisPetMenu7:SetAttribute("spell", NECROSIS_SPELL_TABLE[30].Name);
	-- Enslave
	NecrosisPetMenu8:SetAttribute("type", "spell");
	NecrosisPetMenu8:SetAttribute("spell", NECROSIS_SPELL_TABLE[35].Name.."("..NECROSIS_SPELL_TABLE[35].Rank..")");
	NecrosisBuffMenu11:SetAttribute("type", "spell");
	NecrosisBuffMenu11:SetAttribute("spell", NECROSIS_SPELL_TABLE[35].Name.."("..NECROSIS_SPELL_TABLE[35].Rank..")");
	-- Sacrifice
	NecrosisPetMenu9:SetAttribute("type", "spell");
	NecrosisPetMenu9:SetAttribute("spell", NECROSIS_SPELL_TABLE[44].Name);

	-- Malédiction amplifiée
	NecrosisCurseMenu1:SetAttribute("type", "spell");
	NecrosisCurseMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[42].Name);
	-- Malédiction de faiblesse
	NecrosisCurseMenu2:SetAttribute("harmbutton1", "debuff");
	NecrosisCurseMenu2:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu2:SetAttribute("unit", "target");
	NecrosisCurseMenu2:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[23].Name.."("..NECROSIS_SPELL_TABLE[23].Rank..")");
	NecrosisCurseMenu2:SetAttribute("harmbutton2", "amplif");
	NecrosisCurseMenu2:SetAttribute("type-amplif", "macro");
	NecrosisCurseMenu2:SetAttribute("macrotext-amplif", "/cast "..NECROSIS_SPELL_TABLE[42].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[23].Name.."("..NECROSIS_SPELL_TABLE[23].Rank..")");
	-- Malédiction d'agonie
	NecrosisCurseMenu3:SetAttribute("harmbutton1", "debuff");
	NecrosisCurseMenu3:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu3:SetAttribute("unit", "target");
	NecrosisCurseMenu3:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[22].Name.."("..NECROSIS_SPELL_TABLE[22].Rank..")");
	NecrosisCurseMenu3:SetAttribute("harmbutton2", "amplif");
	NecrosisCurseMenu3:SetAttribute("type-amplif", "macro");
	NecrosisCurseMenu3:SetAttribute("macrotext-amplif", "/cast "..NECROSIS_SPELL_TABLE[42].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[22].Name.."("..NECROSIS_SPELL_TABLE[22].Rank..")");
	-- Malédiction de témérité
	NecrosisCurseMenu4:SetAttribute("harmbutton", "debuff");
	NecrosisCurseMenu4:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu4:SetAttribute("unit", "target");
	NecrosisCurseMenu4:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[24].Name.."("..NECROSIS_SPELL_TABLE[24].Rank..")");
	-- Malédiction des langages
	NecrosisCurseMenu5:SetAttribute("harmbutton", "debuff");
	NecrosisCurseMenu5:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu5:SetAttribute("unit", "target");
	NecrosisCurseMenu5:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[25].Name.."("..NECROSIS_SPELL_TABLE[25].Rank..")");
	-- Malédiction de fatigue
	NecrosisCurseMenu6:SetAttribute("harmbutton1", "debuff");
	NecrosisCurseMenu6:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu6:SetAttribute("unit", "target");
	NecrosisCurseMenu6:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[40].Name.."("..NECROSIS_SPELL_TABLE[40].Rank..")");
	NecrosisCurseMenu6:SetAttribute("harmbutton2", "amplif");
	NecrosisCurseMenu6:SetAttribute("type-amplif", "macro");
	NecrosisCurseMenu6:SetAttribute("macrotext-amplif", "/cast "..NECROSIS_SPELL_TABLE[42].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[40].Name.."("..NECROSIS_SPELL_TABLE[40].Rank..")");
	-- Malédiction des éléments
	NecrosisCurseMenu7:SetAttribute("harmbutton", "debuff");
	NecrosisCurseMenu7:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu7:SetAttribute("unit", "target");
	NecrosisCurseMenu7:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[26].Name.."("..NECROSIS_SPELL_TABLE[26].Rank..")");
	-- Malédiction des ombres
	NecrosisCurseMenu8:SetAttribute("harmbutton", "debuff");
	NecrosisCurseMenu8:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu8:SetAttribute("unit", "target");
	NecrosisCurseMenu8:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[27].Name.."("..NECROSIS_SPELL_TABLE[27].Rank..")");
	-- Malédiction des ténèbres
	NecrosisCurseMenu9:SetAttribute("harmbutton", "debuff");
	NecrosisCurseMenu9:SetAttribute("type-debuff", "spell");
	NecrosisCurseMenu9:SetAttribute("unit", "target");
	NecrosisCurseMenu9:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[16].Name.."("..NECROSIS_SPELL_TABLE[16].Rank..")");

	-- Création de pierres sur le clique droit
	-- Soulstone
	if StoneIDInSpellTable[1] > 0 then
		NecrosisSoulstoneButton:SetAttribute("type2", "spell");
		NecrosisSoulstoneButton:SetAttribute("spell2", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Rank..")");
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[StoneIDInSpellTable[1]].Name, "CLICK NecrosisSoulstoneButton:RightButton"});
		table.insert(NecrosisBinding, {NECROSIS_ITEM.Soulstone, "CLICK NecrosisSoulstoneButton:LeftButton"});
	end
	-- Healthstone
	if StoneIDInSpellTable[2] > 0 then
		NecrosisHealthstoneButton:SetAttribute("type2", "spell");
		NecrosisHealthstoneButton:SetAttribute("spell2", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Rank..")");
		NecrosisHealthstoneButton:SetAttribute("shift-type*", "spell");
		NecrosisHealthstoneButton:SetAttribute("shift-spell*", NECROSIS_SPELL_TABLE[50].Name);
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Name, "CLICK NecrosisHealthstoneButton:RightButton"});
		table.insert(NecrosisBinding, {NECROSIS_ITEM.Healthstone, "CLICK NecrosisHealthstoneButton:LeftButton"});
	end
	-- Spellstone
	if StoneIDInSpellTable[3] > 0 then
		NecrosisSpellstoneButton:SetAttribute("type2", "spell");
		NecrosisSpellstoneButton:SetAttribute("spell", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[3]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[3]].Rank..")");
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[StoneIDInSpellTable[3]].Name, "CLICK NecrosisSpellstoneButton:RightButton"});
		table.insert(NecrosisBinding, {NECROSIS_ITEM.Spellstone, "CLICK NecrosisSpellstoneButton:LeftButton"});
	end
	-- Firestone
	if StoneIDInSpellTable[4] > 0 then
		NecrosisFirestoneButton:SetAttribute("type2", "spell");
		NecrosisFirestoneButton:SetAttribute("spell", NECROSIS_SPELL_TABLE[StoneIDInSpellTable[4]].Name.."("..NECROSIS_SPELL_TABLE[StoneIDInSpellTable[4]].Rank..")");
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[StoneIDInSpellTable[4]].Name, "CLICK NecrosisFirestoneButton:RightButton"});
		table.insert(NecrosisBinding, {NECROSIS_ITEM.Firestone, "CLICK NecrosisFirestoneButton:LeftButton"});
	end
end

-- Fonction d'extraction d'attribut de sort
-- F(type=string, string, int) -> Spell=table
function Necrosis_FindSpellAttribute(type, attribute, array)
	for index=1, table.getn(NECROSIS_SPELL_TABLE), 1 do
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


-- Permet de reconnaitre quand le joueur gagne Crépuscule / Transe de l'ombre
function Necrosis_UnitHasTrance()
	local ID = -1;
	for buffID = 1, 25, 1 do
		local buffTexture = GetPlayerBuffTexture(buffID);
		if buffTexture == nil then break end
		if strfind(buffTexture, "Spell_Shadow_Twilight") then
			ID = buffID;
			break
		end
	end
	ShadowTranceID = ID;
end

-- Permet de reconnaitre quand le joueur gagne Contrecoup
function Necrosis_UnitHasBacklash()
	local ID = -1;
	for buffID = 1, 25, 1 do
		local buffTexture = GetPlayerBuffTexture(buffID);
		if buffTexture == nil then break end
		if strfind(buffTexture, "Spell_Fire_PlayingWithFire") then
			ID = buffID;
			break
		end
	end
	BacklashID = ID;
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
		local text = getglobal("NecrosisTooltipTextLeft"..index);
			if text then text:SetText(nil); end
			text = getglobal("NecrosisTooltipTextRight"..index);
			if text then text:SetText(nil); end
	end
	NecrosisTooltip:Hide();
	NecrosisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
end

function Necrosis_GameTooltip_ClearMoney()
    -- Intentionally empty; don't clear money while we use hidden tooltips
end


-- Fonction pour placer les boutons autour de Necrosis (et pour grossir / retracir l'interface...)
function Necrosis_UpdateButtonsScale()
	local NBRScale = (100 + (NecrosisConfig.NecrosisButtonScale - 85)) / 100;
	if NecrosisConfig.NecrosisButtonScale <= 95 then
		NBRScale = 1.1;
	end
	if NecrosisConfig.NecrosisLockServ then
		Necrosis_ClearAllPoints();
		HideUIPanel(NecrosisPetMenuButton);
		HideUIPanel(NecrosisBuffMenuButton);
		HideUIPanel(NecrosisCurseMenuButton);
		HideUIPanel(NecrosisMountButton);
		HideUIPanel(NecrosisFirestoneButton);
		HideUIPanel(NecrosisSpellstoneButton);
		HideUIPanel(NecrosisHealthstoneButton);
		HideUIPanel(NecrosisSoulstoneButton);
		local indexScale = -36;
		for index=1, table.getn(NecrosisConfig.StonePosition), 1 do
			if math.abs(NecrosisConfig.StonePosition[index]) == 1 and NecrosisConfig.StonePosition[1] > 0 and StoneIDInSpellTable[4] ~= 0 then
				NecrosisFirestoneButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisFirestoneButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 2 and NecrosisConfig.StonePosition[2] > 0 and StoneIDInSpellTable[3] ~= 0 then
				NecrosisSpellstoneButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisSpellstoneButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 3 and NecrosisConfig.StonePosition[3] > 0 and StoneIDInSpellTable[2] ~= 0 then
				NecrosisHealthstoneButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisHealthstoneButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 4 and NecrosisConfig.StonePosition[4] > 0 and StoneIDInSpellTable[1] ~= 0 then
				NecrosisSoulstoneButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisSoulstoneButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 5 and NecrosisConfig.StonePosition[5] > 0 and BuffMenuCreate[1] then
				NecrosisBuffMenuButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisBuffMenuButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 6 and NecrosisConfig.StonePosition[6] > 0 and MountAvailable then
				NecrosisMountButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisMountButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 7 and NecrosisConfig.StonePosition[7] > 0 and PetMenuCreate[1] then
				NecrosisPetMenuButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisPetMenuButton);
				indexScale = indexScale + 36;
			end
			if math.abs(NecrosisConfig.StonePosition[index]) == 8 and NecrosisConfig.StonePosition[8] > 0 and CurseMenuCreate[1] then
				NecrosisCurseMenuButton:SetPoint("CENTER", "NecrosisButton", "CENTER", ((40 * NBRScale) * cos(NecrosisConfig.NecrosisAngle-indexScale)), ((40 * NBRScale) * sin(NecrosisConfig.NecrosisAngle-indexScale)));
				ShowUIPanel(NecrosisCurseMenuButton);
				indexScale = indexScale + 36;
			end
		end
	end
end



-- Fonction (XML) pour rétablir les points d'attache par défaut des boutons
function Necrosis_ClearAllPoints()
	NecrosisFirestoneButton:ClearAllPoints();
	NecrosisSpellstoneButton:ClearAllPoints();
	NecrosisHealthstoneButton:ClearAllPoints();
	NecrosisSoulstoneButton:ClearAllPoints();
	NecrosisMountButton:ClearAllPoints();
	NecrosisPetMenuButton:ClearAllPoints();
	NecrosisBuffMenuButton:ClearAllPoints();
	NecrosisCurseMenuButton:ClearAllPoints();
end

-- Fonction (XML) pour étendre la propriété NoDrag() du bouton principal de Necrosis sur tout ses boutons
function Necrosis_NoDrag()
	NecrosisFirestoneButton:RegisterForDrag("");
	NecrosisSpellstoneButton:RegisterForDrag("");
	NecrosisHealthstoneButton:RegisterForDrag("");
	NecrosisSoulstoneButton:RegisterForDrag("");
	NecrosisMountButton:RegisterForDrag("");
	NecrosisPetMenuButton:RegisterForDrag("");
	NecrosisBuffMenuButton:RegisterForDrag("");
	NecrosisCurseMenuButton:RegisterForDrag("");
end

-- Fonction (XML) inverse de celle du dessus
function Necrosis_Drag()
	NecrosisFirestoneButton:RegisterForDrag("LeftButton");
	NecrosisSpellstoneButton:RegisterForDrag("LeftButton");
	NecrosisHealthstoneButton:RegisterForDrag("LeftButton");
	NecrosisSoulstoneButton:RegisterForDrag("LeftButton");
	NecrosisMountButton:RegisterForDrag("LeftButton");
	NecrosisPetMenuButton:RegisterForDrag("LeftButton");
	NecrosisBuffMenuButton:RegisterForDrag("LeftButton");
	NecrosisCurseMenuButton:RegisterForDrag("LeftButton");
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
	for i = 1, table.getn(NecrosisConfig.DemonSpellPosition), 1 do
		menuVariable = getglobal("NecrosisPetMenu"..i);
		menuVariable:ClearAllPoints();
		menuVariable:Hide();
	end
	-- On cache toutes les icones des sorts
	for i = 1, table.getn(NecrosisConfig.BuffSpellPosition), 1 do
		menuVariable = getglobal("NecrosisBuffMenu"..i);
		menuVariable:ClearAllPoints();
		menuVariable:Hide();
	end
	-- On cache toutes les icones des curses
	for i = 1, table.getn(NecrosisConfig.CurseSpellPosition), 1 do
		menuVariable = getglobal("NecrosisCurseMenu"..i);
		menuVariable:ClearAllPoints();
		menuVariable:Hide();
	end

	-- On ordonne et on affiche les boutons dans le menu des démons
	for index = 1, table.getn(NecrosisConfig.DemonSpellPosition), 1 do
		-- Si le sort de Domination corrompue existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 1 and NecrosisConfig.DemonSpellPosition[1] > 0 and NECROSIS_SPELL_TABLE[15].ID then
			menuVariable = getglobal("NecrosisPetMenu1");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 1;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Diablotin existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 2 and NecrosisConfig.DemonSpellPosition[2] > 0 and NECROSIS_SPELL_TABLE[3].ID then
			menuVariable = getglobal("NecrosisPetMenu2");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 2;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Marcheur existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 3 and NecrosisConfig.DemonSpellPosition[3] > 0 and NECROSIS_SPELL_TABLE[4].ID then
			menuVariable = getglobal("NecrosisPetMenu3");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 3;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Succube existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 4 and NecrosisConfig.DemonSpellPosition[4] > 0 and NECROSIS_SPELL_TABLE[5].ID then
			menuVariable = getglobal("NecrosisPetMenu4");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 4;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Felhunter existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 5 and NecrosisConfig.DemonSpellPosition[5] > 0 and NECROSIS_SPELL_TABLE[6].ID then
			menuVariable = getglobal("NecrosisPetMenu5");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 5;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Felguard existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 6 and NecrosisConfig.DemonSpellPosition[6] > 0 and NECROSIS_SPELL_TABLE[7].ID then
			menuVariable = getglobal("NecrosisPetMenu10");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 10;
			table.insert(PetMenuCreate, menuVariable);
		end

		-- Si l'invocation de l'Infernal existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 7 and NecrosisConfig.DemonSpellPosition[7] > 0 and NECROSIS_SPELL_TABLE[8].ID then
			menuVariable = getglobal("NecrosisPetMenu6");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 6;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'invocation du Doomguard existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 8 and NecrosisConfig.DemonSpellPosition[8] > 0 and NECROSIS_SPELL_TABLE[30].ID then
			menuVariable = getglobal("NecrosisPetMenu7");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 7;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si l'asservissement existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 9 and NecrosisConfig.DemonSpellPosition[9] > 0 and NECROSIS_SPELL_TABLE[35].ID then
			menuVariable = getglobal("NecrosisPetMenu8");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 8;
			table.insert(PetMenuCreate, menuVariable);
		end
		-- Si le sacrifice démoniaque existe, on affiche le bouton dans le menu des pets
		if math.abs(NecrosisConfig.DemonSpellPosition[index]) == 10 and NecrosisConfig.DemonSpellPosition[10] > 0 and NECROSIS_SPELL_TABLE[44].ID then
			menuVariable = getglobal("NecrosisPetMenu9");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisPetMenu"..PetButtonPosition, "CENTER", NecrosisConfig.PetMenuPos.x * 32, NecrosisConfig.PetMenuPos.y * 32);
			PetButtonPosition = 9;
			table.insert(PetMenuCreate, menuVariable);
		end
	end


	-- Maintenant que tous les boutons de pet sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	if PetMenuCreate[1] then
		NecrosisPetMenu0:ClearAllPoints();
		NecrosisPetMenu0:SetPoint("CENTER", "NecrosisPetMenuButton", "CENTER", 3000, 3000);
		for i = 1, table.getn(PetMenuCreate), 1 do
			ShowUIPanel(PetMenuCreate[i]);
		end
	end

	-- On ordonne et on affiche les boutons dans le menu des buffs
	for index = 1, table.getn(NecrosisConfig.BuffSpellPosition), 1 do
		-- Si l'Armure Démoniaque existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 1 and NecrosisConfig.BuffSpellPosition[1] > 0 and (NECROSIS_SPELL_TABLE[31].ID or NECROSIS_SPELL_TABLE[36].ID) then
			menuVariable = getglobal("NecrosisBuffMenu1");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 1;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si la Gangrarmure existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 2 and NecrosisConfig.BuffSpellPosition[2] > 0 and NECROSIS_SPELL_TABLE[47].ID then
			menuVariable = getglobal("NecrosisBuffMenu10");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 10;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si la respiration interminable existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 3 and NecrosisConfig.BuffSpellPosition[3] > 0 and NECROSIS_SPELL_TABLE[32].ID then
			menuVariable = getglobal("NecrosisBuffMenu2");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 2;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si la détection de l'invisibilité existe, on affiche le bouton dans le menu des buffs (au plus haut rang)
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 4 and NecrosisConfig.BuffSpellPosition[4] > 0 and NECROSIS_SPELL_TABLE[33].ID then
			menuVariable = getglobal("NecrosisBuffMenu3");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 3;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si l'oeil de Kilrogg, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 5 and NecrosisConfig.BuffSpellPosition[5] > 0 and NECROSIS_SPELL_TABLE[34].ID then
			menuVariable = getglobal("NecrosisBuffMenu4");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 4;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si l'invocation de joueur existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 6 and NecrosisConfig.BuffSpellPosition[6] > 0 and NECROSIS_SPELL_TABLE[37].ID then
			menuVariable = getglobal("NecrosisBuffMenu5");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 5;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si le Radar à démon existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 7 and NecrosisConfig.BuffSpellPosition[7] > 0 and NECROSIS_SPELL_TABLE[39].ID then
			menuVariable = getglobal("NecrosisBuffMenu6");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 6;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si le Lien Spirituel existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 8 and NecrosisConfig.BuffSpellPosition[8] > 0 and NECROSIS_SPELL_TABLE[38].ID then
			menuVariable = getglobal("NecrosisBuffMenu7");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 7;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si la protection contre les ombres existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 9 and NecrosisConfig.BuffSpellPosition[9] > 0 and NECROSIS_SPELL_TABLE[43].ID then
			menuVariable = getglobal("NecrosisBuffMenu8");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 8;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si l'enslave existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 10 and NecrosisConfig.BuffSpellPosition[10] > 0 and NECROSIS_SPELL_TABLE[35].ID then
			menuVariable = getglobal("NecrosisBuffMenu11");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * 32, NecrosisConfig.BuffMenuPos.y * 32);
			BuffButtonPosition = 11;
			table.insert(BuffMenuCreate, menuVariable);
		end
		-- Si le banissement existe, on affiche le bouton dans le menu des buffs
		if math.abs(NecrosisConfig.BuffSpellPosition[index]) == 11 and NecrosisConfig.BuffSpellPosition[11] > 0 and NECROSIS_SPELL_TABLE[9].ID then
			menuVariable = getglobal("NecrosisBuffMenu9");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisBuffMenu"..BuffButtonPosition, "CENTER", NecrosisConfig.BuffMenuPos.x * (17 + menuVariable:GetWidth() / 2 - 4 * (NecrosisConfig.BanishScale / 10) * (1 - 27/32)), NecrosisConfig.BuffMenuPos.y * (17 + menuVariable:GetWidth() / 2 - 4 * (NecrosisConfig.BanishScale / 10) * (1 - 27/32)));
			BuffButtonPosition = 9;
			table.insert(BuffMenuCreate, menuVariable);
		end
	end

	-- Maintenant que tous les boutons de buff sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	NecrosisBuffMenu0:ClearAllPoints();
	NecrosisBuffMenu0:SetPoint("CENTER", "NecrosisPetMenuButton", "CENTER", 3000, 3000);
	for i = 1, table.getn(BuffMenuCreate), 1 do
		ShowUIPanel(BuffMenuCreate[i]);
	end


	-- On ordonne et on affiche les boutons dans le menu des malédictions
	for index = 1, table.getn(NecrosisConfig.CurseSpellPosition), 1 do
		-- Si la Malédiction amplifiée existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 1 and NecrosisConfig.CurseSpellPosition[1] > 0 and NECROSIS_SPELL_TABLE[42].ID then
			menuVariable = getglobal("NecrosisCurseMenu1");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 1;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction de faiblesse existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 2 and NecrosisConfig.CurseSpellPosition[2] > 0 and NECROSIS_SPELL_TABLE[23].ID then
			menuVariable = getglobal("NecrosisCurseMenu2");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 2;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction d'agonie existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 3 and NecrosisConfig.CurseSpellPosition[3] > 0 and NECROSIS_SPELL_TABLE[22].ID then
			menuVariable = getglobal("NecrosisCurseMenu3");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 3;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction de témérité existe, on affiche le bouton dans le menu des curses (au plus haut rang)
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 4 and NecrosisConfig.CurseSpellPosition[4] > 0 and NECROSIS_SPELL_TABLE[24].ID then
			menuVariable = getglobal("NecrosisCurseMenu4");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 4;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction des languages existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 5 and NecrosisConfig.CurseSpellPosition[5] > 0 and NECROSIS_SPELL_TABLE[25].ID then
			menuVariable = getglobal("NecrosisCurseMenu5");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 5;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction de fatigue existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 6 and NecrosisConfig.CurseSpellPosition[6] > 0 and NECROSIS_SPELL_TABLE[40].ID then
			menuVariable = getglobal("NecrosisCurseMenu6");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 6;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction des éléments existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 7 and NecrosisConfig.CurseSpellPosition[7] > 0 and NECROSIS_SPELL_TABLE[26].ID then
			menuVariable = getglobal("NecrosisCurseMenu7");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 7;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction de l'ombre, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 8 and NecrosisConfig.CurseSpellPosition[8] > 0 and NECROSIS_SPELL_TABLE[27].ID then
			menuVariable = getglobal("NecrosisCurseMenu8");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 8;
			table.insert(CurseMenuCreate, menuVariable);
		end
		-- Si la Malédiction funeste existe, on affiche le bouton dans le menu des curses
		if math.abs(NecrosisConfig.CurseSpellPosition[index]) == 9 and NecrosisConfig.CurseSpellPosition[9] > 0 and NECROSIS_SPELL_TABLE[16].ID then
			menuVariable = getglobal("NecrosisCurseMenu9");
			menuVariable:ClearAllPoints();
			menuVariable:SetPoint("CENTER", "NecrosisCurseMenu"..CurseButtonPosition, "CENTER", NecrosisConfig.CurseMenuPos.x * 32, NecrosisConfig.CurseMenuPos.y * 32);
			CurseButtonPosition = 9;
			table.insert(CurseMenuCreate, menuVariable);
		end
	end

	-- Maintenant que tous les boutons de curse sont placés les uns à côté des autres (hors de l'écran), on affiche les disponibles
	if CurseMenuCreate[1] then
		NecrosisCurseMenu0:ClearAllPoints();
		NecrosisCurseMenu0:SetPoint("CENTER", "NecrosisCurseMenuButton", "CENTER", 3000, 3000);
		for i = 1, table.getn(CurseMenuCreate), 1 do
			ShowUIPanel(CurseMenuCreate[i]);
		end
	end
end

-- Fonction permettant l'affichage des différentes pages du livre des configurations
function NecrosisGeneralTab_OnClick(id)
	local TabName;
	for index=1, 5, 1 do
		TabName = getglobal("NecrosisGeneralTab"..index);
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
