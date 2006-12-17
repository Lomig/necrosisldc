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
-- Version 15.12.2006-1
------------------------------------------------------------------------------------------------------

-- Création du bouton de Timer des sorts
local SpellTimerButton = CreateFrame
	(
		"Button",
		"NecrosisSpellTimerButton",
		UIParent,
		"SecureActionButtonTemplate"
	);

SpellTimerButton:SetFrameStrata("MEDIUM");
SpellTimerButton:SetMovable(true);
SpellTimerButton:EnableMouse(true);
SpellTimerButton:SetMovable(true);
SpellTimerButton:SetWidth(34);
SpellTimerButton:SetHeight(34);
SpellTimerButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Normal");
SpellTimerButton:SetPushedTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Pushed");
SpellTimerButton:SetHighlightTexture("Interface\\AddOns\\Necrosis\\UI\\SpellTimerButton-Highlight");
SpellTimerButton:Hide();

-- Création de la liste des Timers Textes
local TextTimer = SpellTimerButton:CreateFontString
	(
		"NecrosisListSpells",
		nil,
		"GameFontNormalSmall"
	);

TextTimer:SetJustifyH("LEFT");
TextTimer:SetPoint("LEFT", "NecrosisSpellTimerButton", "LEFT", 23, 0);
TextTimer:SetTextColor(1, 1, 1);

-- Edition des scripts associés au bouton
SpellTimerButton:SetScript
	("OnLoad", function()
		this:RegisterForDrag("LeftButton");
		this:RegisterForClicks("RightButtonUp");
	end);
SpellTimerButton:SetScript
	("OnEnter", function()
		Necrosis_BuildTooltip(this, "SpellTimer", AnchorSpellTimerTooltip);
	end);
SpellTimerButton:SetScript("OnLeave", function() GameTooltip:Hide(); end);
SpellTimerButton:SetScript("OnMouseUp", function() Necrosis_OnDragStop(this); end);
SpellTimerButton:SetScript("OnDragStart", function() Necrosis_OnDragStart(this); end);
SpellTimerButton:SetScript("OnDragStop", function() Necrosis_OnDragStop(this); end);
