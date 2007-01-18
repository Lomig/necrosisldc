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
-- $LastChangedDate$
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


-- On crée ou on affiche le panneau de configuration de la sphere
function Necrosis:SetSphereConfig()

	local frame = _G["NecrosisSphereConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisSphereConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Création du slider de rotation de Necrosis
		frame = CreateFrame("Slider", "NecrosisRotation", NecrosisSphereConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(0, 360)
		frame:SetValueStep(9)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisSphereConfig, "BOTTOMLEFT", 175, 400)

		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
		end)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetScript("OnValueChanged", function()
			NecrosisConfig.NecrosisAngle = this:GetValue()
			GameTooltip:SetText(this:GetValue())
			Necrosis:ButtonSetup()
		end)

		-- Skin de la sphère
		frame = CreateFrame("Frame", "NecrosisSkinSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 0, 325)

		FontString = frame:CreateFontString("NecrosisSkinSelectionText", "ARTWORK", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("RIGHT", frame, "LEFT", -50, 0)

		UIDropDownMenu_SetWidth(125, frame)
		frame:SetScript("OnShow", function() UIDropDownMenu_Initialize(this, Skin_Init) end)

		-- Evenement montré par la sphère
		frame = CreateFrame("Frame", "NecrosisEventSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 0, 300)

		FontString = frame:CreateFontString("NecrosisEventSelectionText", "ARTWORK", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("RIGHT", frame, "LEFT", -50, 0)

		UIDropDownMenu_SetWidth(125, frame)
		frame:SetScript("OnShow", function() UIDropDownMenu_Initialize(this, Event_Init) end)

		-- Sort associé à la sphère
		frame = CreateFrame("Frame", "NecrosisSpellSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 0, 275)

		FontString = frame:CreateFontString("NecrosisSpellSelectionText", "ARTWORK", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("RIGHT", frame, "LEFT", -50, 0)

		UIDropDownMenu_SetWidth(125, frame)
		frame:SetScript("OnShow", function() UIDropDownMenu_Initialize(this, Spell_Init) end)

		-- Affiche ou masque le compteur numérique
		frame = CreateFrame("CheckButton", "NecrosisShowCount", NecrosisSphereConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisSphereConfig, "BOTTOMLEFT", 50, 225)

		frame:SetScript("OnClick", function()
			NecrosisConfig.ShowCount = this:GetChecked()
			Necrosis:BagExplore()
		end)

		FontString = frame:CreateFontString("NecrosisShowCountText", nil, "GameFontNormalSmall")
		FontString:SetTextColor(1, 1, 1)
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 10, 0)

		-- Evenement montré par le compteur
		frame = CreateFrame("Frame", "NecrosisCountSelection", NecrosisSphereConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisSphereConfig, "BOTTOMRIGHT", 0, 175)

		FontString = frame:CreateFontString("NecrosisCountSelectionText", "ARTWORK", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("RIGHT", frame, "LEFT", -50, 0)

		UIDropDownMenu_SetWidth(125, frame)
		frame:SetScript("OnShow", function() UIDropDownMenu_Initialize(this, Count_Init) end)
	end

	NecrosisRotationText:SetText(self.Config.Sphere["Rotation de Necrosis"])
	NecrosisRotationLow:SetText("0")
	NecrosisRotationHigh:SetText("360")

	NecrosisSkinSelection:SetText(self.Config.Sphere["Skin de la pierre Necrosis"])
	NecrosisEventSelectionText:SetText(self.Config.Sphere["Evenement montre par la sphere"])
	NecrosisSpellSelectionText:SetText(self.Config.Sphere["Sort caste par la sphere"])
	NecrosisShowCountText:SetText(self.Config.Sphere["Afficher le compteur numerique"])
	NecrosisCountSelectionText:SetText(self.Config.Sphere["Evenement montre par la sphere"])

	NecrosisRotation:SetValue(NecrosisConfig.NecrosisAngle)
	NecrosisShowCount:SetChecked(NecrosisConfig.ShowCount)

	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	for i in ipairs(couleur) do
		if couleur[i] == NecrosisConfig.NecrosisColor then
			UIDropDownMenu_SetSelectedID(NecrosisSkinSelection, i)
			UIDropDownMenu_SetText(Necrosis.Config.Sphere.Colour[i], NecrosisSkinSelection)
			break
		end
	end

	UIDropDownMenu_SetSelectedID(NecrosisEventSelection, NecrosisConfig.Circle)
	if NecrosisConfig.Circle == 1 then
		UIDropDownMenu_SetText(Necrosis.Config.Sphere.Count[NecrosisConfig.Circle], NecrosisEventSelection)
	else
		UIDropDownMenu_SetText(Necrosis.Config.Sphere.Count[NecrosisConfig.Circle + 1], NecrosisEventSelection)
	end

	local spell = {19, 31, 36, 37, 41, 43, 44, 47, 49, 55}
	for i in ipairs(spell) do
		if spell[i] == NecrosisConfig.MainSpell then
			UIDropDownMenu_SetSelectedID(NecrosisSpellSelection, i)
			UIDropDownMenu_SetText(Necrosis.Spell[spell[i]].Name, NecrosisSpellSelection)
			break
		end
	end

	UIDropDownMenu_SetSelectedID(NecrosisCountSelection, NecrosisConfig.CountType)
	UIDropDownMenu_SetText(Necrosis.Config.Sphere.Count[NecrosisConfig.CountType], NecrosisCountSelection)

	frame:Show()
end

-- Fonctions du Dropdown des skins
local function Skin_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Sphere.Colour) do
		element.text = Necrosis.Config.Sphere.Colour[i]
		element.checked = nil;
		element.func = Skin_Click()
		UIDropDownMenu_AddButton(element)
	end
end

local function Skin_Click()
	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	UIDropDownMenu_SetSelectedID(NecrosisSkinSelection, this:GetID())
	NecrosisConfig.NecrosisColor = couleur[this:GetID()]
	NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\"..couleur[this:GetID()].."\\Shard16")
end

-- Fonctions du Dropdown des Events de la sphère
local function Event_Init()
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Count) do
		if not (i == 2) then
			element.text = Necrosis.Config.Sphere.Count[i]
			element.checked = nil;
			element.func = Event_Click()
			UIDropDownMenu_AddButton(element)
		end
	end
end

local function Event_Click()
	UIDropDownMenu_SetSelectedID(NecrosisEventSelection, this:GetID())
	NecrosisConfig.Circle = this:GetID()
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end

-- Fonctions du Dropdown des sorts de la sphère
local function Spell_Init()
	local spell = {19, 31, 36, 37, 41, 43, 44, 47, 49, 55}
	local element = {}
	for i in ipairs(spellName) do
		element.text = Necrosis.Spell[spell[i]].Name
		element.checked = nil;
		element.func = Spell_Click()
		UIDropDownMenu_AddButton(element)
	end
end

local function Spell_Click()
	local spell = {19, 31, 36, 37, 41, 43, 44, 47, 49, 55}
	UIDropDownMenu_SetSelectedID(NecrosisSpellSelection, this:GetID())
	NecrosisConfig.MainSpell = spell[this:GetID()]
	Necrosis:MainButtonAttribute()
end

-- Fonctions du Dropdown des Events du compteur
local function Count_Init()
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Colour) do
		element.text = Necrosis.Config.Sphere.Colour[i]
		element.checked = nil;
		element.func = Count_Click()
		UIDropDownMenu_AddButton(element)
	end
end

local function Count_Click()
	UIDropDownMenu_SetSelectedID(NecrosisEventSelection, this:GetID())
	NecrosisConfig.Circle = this:GetID()
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end