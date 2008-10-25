--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

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
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- $LastChangedDate$
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

-- On crée ou on affiche le panneau de configuration de la sphere
function Necrosis:SetButtonsConfig()

	local frame = _G["NecrosisButtonsConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisButtonsConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Création de la sous-fenêtre 1
		frame = CreateFrame("Frame", "NecrosisButtonsConfig1", NecrosisButtonsConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisButtonsConfig)
		
		local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		FontString:SetText("1 / 2")

		FontString = frame:CreateFontString("NecrosisButtonsConfig1Text", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 420)
		
		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisButtonsConfig1, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig1, "BOTTOMRIGHT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig2:Show()
			NecrosisButtonsConfig1:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisButtonsConfig1, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig2:Show()
			NecrosisButtonsConfig1:Hide()
		end)
		
		-- Création de la sous-fenêtre 2
		frame = CreateFrame("Frame", "NecrosisButtonsConfig2", NecrosisButtonsConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisButtonsConfig)
		
		local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		FontString:SetText("2 / 2")

		FontString = frame:CreateFontString("NecrosisButtonsConfig2Text", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 420)
		
		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisButtonsConfig2, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig2, "BOTTOMRIGHT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig1:Show()
			NecrosisButtonsConfig2:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisButtonsConfig2, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig2, "BOTTOMLEFT", 40, 135)

		frame:SetScript("OnClick", function()
			NecrosisButtonsConfig1:Show()
			NecrosisButtonsConfig2:Hide()
		end)
		
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Sous Menu 1
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Attache ou détache les boutons de Necrosis
		frame = CreateFrame("CheckButton", "NecrosisLockButtons", NecrosisButtonsConfig1, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 25, 395)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				NecrosisConfig.NecrosisLockServ = true
				Necrosis:ClearAllPoints()
				Necrosis:ButtonSetup()
				Necrosis:NoDrag()
				if not NecrosisConfig.NoDragAll then
					NecrosisButton:RegisterForDrag("LeftButton")
					NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
				end
			else
				NecrosisConfig.NecrosisLockServ = false
				Necrosis:ClearAllPoints()
				local ButtonName = {
					"NecrosisFirestoneButton",
					"NecrosisSpellstoneButton",
					"NecrosisHealthstoneButton",
					"NecrosisSoulstoneButton",
					"NecrosisBuffMenuButton",
					"NecrosisMountButton",
					"NecrosisPetMenuButton",
					"NecrosisCurseMenuButton",
					"NecrosisMetamorphosisButton"
				}
				local loc = {-121, -87, -53, -17, 17, 53, 87, 121}
				for i in ipairs(ButtonName) do
					if _G[ButtonName[i]] then
						_G[ButtonName[i]]:SetPoint("CENTER", "UIParent", "CENTER", loc[i], -100)
						NecrosisConfig.FramePosition[ButtonName[i]] = {
							"CENTER",
							"UIParent",
							"CENTER",
							loc[i],
							-100
						}
					end
				end
				Necrosis:Drag()
				NecrosisConfig.NoDragAll = false
				NecrosisButton:RegisterForDrag("LeftButton")
				NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)

		-- Affiche ou cache les boutons autour de Necrosis
		local boutons = {"Firestone", "Spellstone", "HealthStone", "Soulstone", "BuffMenu", "Mount", "PetMenu", "CurseMenu", "Metamorphosis"}
		local initY = 380
		for i in ipairs(boutons) do
			frame = CreateFrame("CheckButton", "NecrosisShow"..boutons[i], NecrosisButtonsConfig1, "UICheckButtonTemplate")
			frame:EnableMouse(true)
			frame:SetWidth(24)
			frame:SetHeight(24)
			frame:Show()
			frame:ClearAllPoints()
			frame:SetPoint("LEFT", NecrosisButtonsConfig1, "BOTTOMLEFT", 25, initY - (25 * i))

			frame:SetScript("OnClick", function()
				if (this:GetChecked()) then
					NecrosisConfig.StonePosition[i] = math.abs(NecrosisConfig.StonePosition[i])
				else
					NecrosisConfig.StonePosition[i] = - math.abs(NecrosisConfig.StonePosition[i])
				end
				Necrosis:ButtonSetup()
			end)

			FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
			FontString:Show()
			FontString:ClearAllPoints()
			FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
			FontString:SetTextColor(1, 1, 1)
			frame:SetFontString(FontString)
		end

	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Sous Menu 2
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- Création du slider de rotation de Necrosis
		frame = CreateFrame("Slider", "NecrosisRotation", NecrosisButtonsConfig2, "OptionsSliderTemplate")
		frame:SetMinMaxValues(0, 360)
		frame:SetValueStep(9)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisButtonsConfig2, "BOTTOMLEFT", 225, 380)

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

		NecrosisRotationLow:SetText("0")
		NecrosisRotationHigh:SetText("360")
		
		-- Création du bouton pour utiliser ses propres montures
		frame = CreateFrame("CheckButton", "NecrosisOwnMountButtons", NecrosisButtonsConfig2, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisButtonsConfig2, "BOTTOMLEFT", 25, 340)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				if GetNumCompanions("MOUNT") == 0 then
					this:SetChecked(false)
				else
					NecrosisLeftMount:Show()
					NecrosisRightMount:Show()
					NecrosisConfig.OwnMount = true
					if not NecrosisConfig.LeftMount then
						NecrosisConfig.LeftMount = 1
						NecrosisConfig.RightMount = 1
					end
					Necrosis:StoneAttribute("Own")
				end
				Necrosis:BindName()
			else
				NecrosisLeftMount:Hide()
				NecrosisRightMount:Hide()
				NecrosisConfig.OwnMount = false
				Necrosis:StoneAttribute("Own")
				Necrosis:BindName()
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		FontString:SetTextColor(1, 1, 1)
		frame:SetFontString(FontString)
		
		-- Monture clic Gauche
		frame = CreateFrame("Frame", "NecrosisLeftMount", NecrosisButtonsConfig2, "UIDropDownMenuTemplate")
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig2, "BOTTOMRIGHT", 40, 300)

		local FontString = frame:CreateFontString("NecrosisLeftMountText", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisButtonsConfig2, "BOTTOMLEFT", 35, 303)
		FontString:SetTextColor(1, 1, 1)
		FontString:SetText(self.Config.Buttons["Monture - Clic gauche"])

		UIDropDownMenu_SetWidth(frame, 125)
		
		-- Monture clic Droit
		frame = CreateFrame("Frame", "NecrosisRightMount", NecrosisButtonsConfig2, "UIDropDownMenuTemplate")
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisButtonsConfig2, "BOTTOMRIGHT", 40, 280)

		local FontString = frame:CreateFontString("NecrosisRightMountText", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisButtonsConfig2, "BOTTOMLEFT", 35, 283)
		FontString:SetTextColor(1, 1, 1)
		FontString:SetText(self.Config.Buttons["Monture - Clic droit"])

		UIDropDownMenu_SetWidth(frame, 125)
	end

	UIDropDownMenu_Initialize(NecrosisLeftMount, Necrosis.Mount_InitLeft)
	UIDropDownMenu_Initialize(NecrosisRightMount, Necrosis.Mount_InitRight)
	
	if NecrosisConfig.LeftMount then
		local _, nameMount = GetCompanionInfo("MOUNT", NecrosisConfig.LeftMount)
		UIDropDownMenu_SetSelectedID(NecrosisLeftMount, NecrosisConfig.LeftMount)
		UIDropDownMenu_SetText(NecrosisLeftMount, nameMount)
		
		_, nameMount = GetCompanionInfo("MOUNT", NecrosisConfig.RightMount)
		UIDropDownMenu_SetSelectedID(NecrosisRightMount, NecrosisConfig.RightMount)
		UIDropDownMenu_SetText(NecrosisRightMount, nameMount)
	end
	
	
	NecrosisRotation:SetValue(NecrosisConfig.NecrosisAngle)
	NecrosisLockButtons:SetChecked(NecrosisConfig.NecrosisLockServ)
	NecrosisOwnMountButtons:SetChecked(NecrosisConfig.OwnMount)
	if NecrosisConfig.OwnMount then
		NecrosisLeftMount:Show()
		NecrosisRightMount:Show()
	else
		NecrosisLeftMount:Hide()
		NecrosisRightMount:Hide()
	end
	local boutons = {"Firestone", "Spellstone", "HealthStone", "Soulstone", "BuffMenu", "Mount", "PetMenu", "CurseMenu"}
	for i in ipairs(boutons) do
		_G["NecrosisShow"..boutons[i]]:SetChecked(NecrosisConfig.StonePosition[i] > 0)
		_G["NecrosisShow"..boutons[i]]:SetText(self.Config.Buttons.Name[i])
	end
	
	NecrosisButtonsConfig1Text:SetText(self.Config.Buttons["Choix des boutons a afficher"])
	NecrosisButtonsConfig2Text:SetText(self.Config.Menus["Options Generales"])
	NecrosisRotationText:SetText(self.Config.Buttons["Rotation des boutons"])
	NecrosisLockButtons:SetText(self.Config.Buttons["Fixer les boutons autour de la sphere"])
	NecrosisOwnMountButtons:SetText(self.Config.Buttons["Utiliser mes propres montures"])

	local frame = _G["NecrosisButtonsConfig"]
	frame:Show()
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des Montures
function Necrosis.Mount_InitLeft()
	local MountCount = GetNumCompanions("MOUNT")
	local Monture = {}
	for i = 1, MountCount, 1 do
		local _, nameMount = GetCompanionInfo("MOUNT", i)
		Monture[i] = nameMount
	end
	local element = {}

	for i in ipairs(Monture) do
		element.text = Monture[i]
		element.checked = false
		element.func = Necrosis.Mount_ClickLeft
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Mount_InitRight()
	local MountCount = GetNumCompanions("MOUNT")
	local Monture = {}
	for i = 1, MountCount, 1 do
		local _, nameMount = GetCompanionInfo("MOUNT", i)
		Monture[i] = nameMount
	end
	local element = {}

	for i in ipairs(Monture) do
		element.text = Monture[i]
		element.checked = false
		element.func = Necrosis.Mount_ClickRight
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Mount_ClickLeft()
	local ID = this:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisLeftMount, ID)
	NecrosisConfig.LeftMount = ID
	Necrosis:StoneAttribute("Own")
end

function Necrosis.Mount_ClickRight()
	local ID = this:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisRightMount, ID)
	NecrosisConfig.RightMount = ID
	Necrosis:StoneAttribute("Own")
end
