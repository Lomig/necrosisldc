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
-- Version 15.12.2006-1
------------------------------------------------------------------------------------------------------

-- On d�finit G comme �tant le tableau contenant toutes les frames existantes.
local _G = getfenv(0);


function Necrosis_CreateWarlockUI()

------------------------------------------------------------------------------------------------------
-- BOUTON DU TIMER DES SORTS
------------------------------------------------------------------------------------------------------

	-- Cr�ation du bouton de Timer des sorts
	local frame = CreateFrame("Button", "NecrosisSpellTimerButton", UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetFrameStrata("MEDIUM");
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(34);
	frame:SetHeight(34);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Normal");
	frame:SetPushedTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Pushed");
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Highlight");
	frame:Show();

	-- Cr�ation de la liste des Timers Textes
	local FontString = frame:CreateFontString("NecrosisListSpells", nil, "GameFontNormalSmall");

	-- D�finition de ses attributs
	FontString:SetJustifyH("LEFT");
	FontString:SetPoint("LEFT", "NecrosisSpellTimerButton", "LEFT", 23, 0);
	FontString:SetTextColor(1, 1, 1);

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnLoad", function()
		this:RegisterForDrag("LeftButton");
		this:RegisterForClicks("RightButtonUp");
	end);
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, "SpellTimer", AnchorSpellTimerTooltip); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);


------------------------------------------------------------------------------------------------------
-- SPHERE NECROSIS
------------------------------------------------------------------------------------------------------

	-- Cr�ation du bouton principal de Necrosis
	local frame = CreateFrame("Button", "NecrosisButton", UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetFrameLevel(1);
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(58);
	frame:SetHeight(58);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Shard");
	frame:RegisterForDrag("LeftButton");
	frame:RegisterForClicks("AnyUp");
	frame:Show();

	-- Cr�ation du compteur de fragments d'�me
	local FontString = frame:CreateFontString("NecrosisShardCount", nil, "GameFontNormal");

	-- D�finition de ses attributs
	FontString:SetText("00");
	FontString:SetPoint("CENTER");
	FontString:SetTextColor(1, 1, 1);

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEvent", function() Necrosis_OnEvent(event); end);
	frame:SetScript("OnUpdate", function() Necrosis_OnUpdate(); end);
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, "Main", "ANCHOR_LEFT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);

end


------------------------------------------------------------------------------------------------------
-- BOUTON DES PIERRES ET DE LA MONTURE
------------------------------------------------------------------------------------------------------

local function Necrosis_CreateStoneButton(stone)
	-- Cr�ation du bouton de la pierre
	local frame = CreateFrame("Button", "Necrosis"..stone.."Button", UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(34);
	frame:SetHeight(34);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..stone.."Button-01");
	if i == 1 then
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\SoulstoneButton-04");
	elseif i == 5 then
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\MountButton-02");
	else
		frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..stone.."Button-03");
	end
	frame:RegisterForDrag("LeftButton");
	frame:RegisterForClicks("AnyUp");
	frame:Show();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, stone, "ANCHOR_LEFT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function()
		if not NecrosisLockServ then
			Necrosis_OnDragStart(this);
		end
	end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);

	-- Attributs sp�cifiques � la pierre d'�me
	-- Ils permettent de caster la pierre sur soi si pas de cible et hors combat
	if stone == "Soulstone" then
		frame:SetScript("PreClick", function()
			if not (InCombatLockdown() or UnitIsFriend("player","target")) then
				this:SetAttribute("unit", "player");
			end
		end);
		frame:SetScript("PostClick", function()
			if not InCombatLockdown() then
				this:SetAttribute("unit", "target")
			end
		end);
	end

	return frame
end


------------------------------------------------------------------------------------------------------
-- BOUTONS DES MENUS
------------------------------------------------------------------------------------------------------

local function Necrosis_CreateMenuButton(button)
	-- Creaton du bouton d'ouverture du menu
	local frame = CreateFrame("Button", "Necrosis"..button.."Button", UIParent, "SecureAnchorUpDownTemplate");

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(34);
	frame:SetHeight(34);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..button.."Button-01");
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..button.."Button-02");
	frame:RegisterForDrag("LeftButton");
	frame:RegisterForClicks("AnyUp");
	frame:Show();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, button, "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function()
		if not NecrosisLockServ then
			Necrosis_OnDragStart(this);
		end
	end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);

	-- Header du bouton
	_ = CreateFrame("Frame", "Necrosis"..button.."0", frame, "SecureStateHeaderTemplate");

	return frame
end


------------------------------------------------------------------------------------------------------
-- MENU DES BUFFS
------------------------------------------------------------------------------------------------------

-- Boutons du menu des buffs
local BuffName = {"Armor", "Aqua", "Invisible", "Kilrogg", "TP", "Radar", "SoulLink", "ShadowProtection", "Banish", "FelArmor", "Enslave"};
for i, v in ipairs(BuffName) do
	-- Creaton du bouton
	local frame = CreateFrame("Button", "NecrosisBuffMenu"..i, UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-01");
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-02");
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	frame:Hide();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, v, "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
end

-- Attributs sp�ciaux pour les buffs castables sur les autres joueurs
for i = 2, 3, 1 do
	local f = _G["NecrosisBuffMenu"..i];

	f:SetScript("PreClick", function()
		if not (InCombatLockdown() or UnitIsFriend("player","target")) then
			this:SetAttribute("unit", "player");
		end
	end);
	f:SetScript("PostClick", function()
		if not InCombatLockdown() then
			this:SetAttribute("unit", "target")
		end
	end);
end


------------------------------------------------------------------------------------------------------
-- MENU DES DEMONS
------------------------------------------------------------------------------------------------------

-- Boutons du menu des d�mons
local PetName = {"Domination", "Imp", "Voidwalker", "Succubus", "Felhunter", "Infernal", "Doomguard", "Enslave", "Sacrifice", "Felguard"};
for i, v in ipairs(PetName) do
	-- Creaton du bouton
	local frame = CreateFrame("Button", "NecrosisPetMenu"..i, UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-01");
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-02");
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	frame:Hide();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, v, "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
end


------------------------------------------------------------------------------------------------------
-- MENU DES MALEDICTIONS
------------------------------------------------------------------------------------------------------

-- Boutons du menu des mal�dictions
local CurseName = {"Amplify", "Weakness", "Agony", "Reckless", "Tongues", "Exhaust", "Elements", "Shadow", "Doom"};
for i, v in ipairs(CurseName) do
	-- Creaton du bouton
	local frame = CreateFrame("Button", "NecrosisCurseMenu"..i, UIParent, "SecureActionButtonTemplate");

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-01");
	frame:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\"..v.."-02");
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	frame:Hide();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, v, "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
end


------------------------------------------------------------------------------------------------------
-- BOUTONS SPECIAUX POPUP
------------------------------------------------------------------------------------------------------

function Necrosis_CreateWarlockPopup()
	-- Creation du bouton de ShadowTrance
	local frame = CreateFrame("Button", "NecrosisShadowTranceButton", UIParent);

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetFrameStrata("BACKGROUND");
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ShadowTrance-Icon");
	frame:RegisterForDrag("LeftButton");
	frame:RegisterForClicks("AnyUp");
	frame:Hide();

	-- Cr�ation du compte � rebours
	local FontString = frame:CreateFontString("NecrosisShadowTranceTimer", nil, "GameFontNormal");

	-- D�finition de ses attributs
	FontString:SetPoint("CENTER");
	FontString:SetTextColor(1, 1, 1);

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, "ShadowTrance", "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);


	-- Creation du bouton de BackLash
	local frame = CreateFrame("Button", "NecrosisBacklashButton", UIParent);

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetFrameStrata("BACKGROUND");
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Backlash-Icon");
	frame:RegisterForDrag("LeftButton");
	frame:Hide();

	-- Cr�ation du compte � rebours
	local FontString = frame:CreateFontString("NecrosisBacklashTimer", nil, "GameFontNormal");

	-- D�finition de ses attributs
	FontString:SetPoint("CENTER");
	FontString:SetTextColor(1, 1, 1);

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnEnter", function() Necrosis_BuildTooltip(this, "Backlash", "ANCHOR_RIGHT"); end);
	frame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);


	-- Creation du bouton de d�tection des cibles banissables / asservissables
	local frame = CreateFrame("Button", "NecrosisCreatureAlertButton", UIParent);

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetFrameStrata("BACKGROUND");
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\ElemAlert");
	frame:RegisterForDrag("LeftButton");
	frame:Hide();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);


	-- Creation du bouton de d�tection des cibles prot�g�es contre la peur
	local frame = CreateFrame("Button", "NecrosisAntiFearButton", UIParent);

	-- D�finition de ses attributs
	frame:SetMovable(true);
	frame:EnableMouse(true);
	frame:SetFrameStrata("BACKGROUND");
	frame:SetWidth(40);
	frame:SetHeight(40);
	frame:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\AntiFear-1");
	frame:RegisterForDrag("LeftButton");
	frame:Hide();

	-- Edition des scripts associ�s au bouton
	frame:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
	frame:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
	frame:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);
end


------------------------------------------------------------------------------------------------------
-- CREATION DES BOUTONS A LA DEMANDE
------------------------------------------------------------------------------------------------------

function Necrosis_CreateSphereButtons(ButtonName)
	local ShortButtonName = string.gsub(string.gsub(ButtonName, "Necrosis", ""), "Button", "");
	if ShortButtonName == "BuffMenu" or ShortButtonName == "PetMenu" or ShortButtonName == "CurseMenu" then
		return Necrosis_CreateMenuButton(ShortButtonName);
	else
		return Necrosis_CreateStoneButton(ShortButtonName);
	end
end
