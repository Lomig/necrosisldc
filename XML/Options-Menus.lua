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


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

function Necrosis:SetMenusConfig()

	local frame = _G["NecrosisMenusConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisMenusConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Création de la sous-fenêtre 1
		frame = CreateFrame("Frame", "NecrosisMenusConfig1", NecrosisMenusConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisMenusConfig)

		local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 0, 120)
		FontString:SetText("1 / 4")

		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisMenusConfig1, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig1, "BOTTOMRIGHT", -25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig2:Show()
			NecrosisMenusConfig1:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisMenusConfig1, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig4:Show()
			NecrosisMenusConfig1:Hide()
		end)

		-- Création de la sous-fenêtre 2
		frame = CreateFrame("Frame", "NecrosisMenusConfig2", NecrosisMenusConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisMenusConfig)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 0, 120)
		FontString:SetText("2 / 4")

		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisMenusConfig2, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", -25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig3:Show()
			NecrosisMenusConfig2:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisMenusConfig2, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig1:Show()
			NecrosisMenusConfig2:Hide()
		end)

		-- Création de la sous-fenêtre 3
		frame = CreateFrame("Frame", "NecrosisMenusConfig3", NecrosisMenusConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisMenusConfig)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 0, 120)
		FontString:SetText("3 / 4")

		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisMenusConfig3, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", -25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig4:Show()
			NecrosisMenusConfig3:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisMenusConfig3, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig2:Show()
			NecrosisMenusConfig3:Hide()
		end)

		-- Création de la sous-fenêtre 4
		frame = CreateFrame("Frame", "NecrosisMenusConfig4", NecrosisMenusConfig)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetAllPoints(NecrosisMenusConfig)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("BOTTOM", frame, "BOTTOM", 0, 120)
		FontString:SetText("4 / 4")

		-- Boutons
		frame = CreateFrame("Button", nil, NecrosisMenusConfig4, "OptionsButtonTemplate")
		frame:SetText(">>>")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", -25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig1:Show()
			NecrosisMenusConfig4:Hide()
		end)

		frame = CreateFrame("Button", nil, NecrosisMenusConfig4, "OptionsButtonTemplate")
		frame:SetText("<<<")
		frame:EnableMouse(true)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 25, 125)

		frame:SetScript("OnClick", function()
			NecrosisMenusConfig3:Show()
			NecrosisMenusConfig4:Hide()
		end)

		-- Afficher les menus en permanence
		frame = CreateFrame("CheckButton", "NecrosisBlockedMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 25, 400)

		frame:SetScript("OnClick", function()
			NecrosisConfig.BlockedMenu = this:GetChecked()
			if NecrosisConfig.BlockedMenu then
				if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "4") end
				if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "4") end
				if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "4") end
				NecrosisAutoMenu:Disable()
				NecrosisCloseMenu:Disable()
			else
				local State = 0
				if NecrosisConfig.AutomaticMenu then State = 3 end
				if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", State) end
				if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", State) end
				if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", State) end
				NecrosisAutoMenu:Enable()
				NecrosisCloseMenu:Enable()
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Afficher les menus en combat
		frame = CreateFrame("CheckButton", "NecrosisAutoMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 25, 375)

		frame:SetScript("OnClick", function() NecrosisConfig.AutomaticMenu = this:GetChecked() end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)
		frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Cacher les menus sur un click
		frame = CreateFrame("CheckButton", "NecrosisCloseMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 25, 350)

		frame:SetScript("OnClick", function()
			NecrosisConfig.ClosingMenu = this:GetChecked()
			if NecrosisConfig.ClosingMenu then Necrosis:CreateMenu() end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)
		frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- BUFF
		-- Choix de l'orientation du menu
		frame = CreateFrame("Frame", "NecrosisBuffVector", NecrosisMenusConfig2, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", 0, 400)

		local FontString = frame:CreateFontString("NecrosisBuffVectorT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 25, 403)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(125, frame)

		-- Choix du sens du menu
		frame = CreateFrame("CheckButton", "NecrosisBuffSens", NecrosisMenusConfig2, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 50, 375)

		frame:SetScript("OnClick", function()
			if this:GetChecked() then
				NecrosisConfig.BuffMenuPos.direction = -1
			else
				NecrosisConfig.BuffMenuPos.direction = 1
			end
			Necrosis:CreateMenu()
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Création du slider de scale du Banish
		frame = CreateFrame("Slider", "NecrosisBanishSize", NecrosisMenusConfig2, "OptionsSliderTemplate")
		frame:SetMinMaxValues(50, 200)
		frame:SetValueStep(5)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisMenusConfig2, "BOTTOMLEFT", 175, 300)

		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue().." %")
			if _G["NecrosisBuffMenu11"] then
				NecrosisBuffMenu11:Show();
				NecrosisBuffMenu11:ClearAllPoints();
				NecrosisBuffMenu11:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
			end
		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			Necrosis:CreateMenu()
		end)
		frame:SetScript("OnValueChanged", function()
			if not (this:GetValue() == NecrosisConfig.BanishScale) then
				GameTooltip:SetText(this:GetValue().." %")
				NecrosisConfig.BanishScale = this:GetValue()
				if _G["NecrosisBuffMenu11"] then
					NecrosisBuffMenu11:ClearAllPoints();
					NecrosisBuffMenu11:SetScale(NecrosisConfig.BanishScale / 100);
					NecrosisBuffMenu11:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
				end
			end
		end)

		NecrosisBanishSizeLow:SetText("50 %")
		NecrosisBanishSizeHigh:SetText("200 %")

		-- Création du slider d'Offset X
		frame = CreateFrame("Slider", "NecrosisBuffOx", NecrosisMenusConfig2, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.BuffMenuDecalage.x = this:GetValue()
			Necrosis:SetOfxy("Buff")
		end)

		NecrosisBuffOxText:SetText("Offset X")
		NecrosisBuffOxLow:SetText("")
		NecrosisBuffOxHigh:SetText("")

		-- Création du slider d'Offset Y
		frame = CreateFrame("Slider", "NecrosisBuffOy", NecrosisMenusConfig2, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", -25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.BuffMenuDecalage.y = this:GetValue()
			Necrosis:SetOfxy("Buff")
		end)

		NecrosisBuffOyText:SetText("Offset Y")
		NecrosisBuffOyLow:SetText("")
		NecrosisBuffOyHigh:SetText("")

		-- DEMON
		-- Choix de l'orientation du menu
		frame = CreateFrame("Frame", "NecrosisDemonVector", NecrosisMenusConfig3, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", 0, 400)

		local FontString = frame:CreateFontString("NecrosisDemonVectorT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 25, 403)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(125, frame)

		-- Choix du sens du menu
		frame = CreateFrame("CheckButton", "NecrosisDemonSens", NecrosisMenusConfig3, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 50, 375)

		frame:SetScript("OnClick", function()
			if this:GetChecked() then
				NecrosisConfig.PetMenuPos.direction = -1
			else
				NecrosisConfig.PetMenuPos.direction = 1
			end
			Necrosis:CreateMenu()
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Création du slider d'Offset X
		frame = CreateFrame("Slider", "NecrosisDemonOx", NecrosisMenusConfig3, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.PetMenuDecalage.x = this:GetValue()
			Necrosis:SetOfxy("Pet")
		end)

		NecrosisDemonOxText:SetText("Offset X")
		NecrosisDemonOxLow:SetText("")
		NecrosisDemonOxHigh:SetText("")

		-- Création du slider d'Offset Y
		frame = CreateFrame("Slider", "NecrosisDemonOy", NecrosisMenusConfig3, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", -25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.PetMenuDecalage.y = this:GetValue()
			Necrosis:SetOfxy("Pet")
		end)

		NecrosisDemonOyText:SetText("Offset Y")
		NecrosisDemonOyLow:SetText("")
		NecrosisDemonOyHigh:SetText("")

		-- CURSE
		-- Choix de l'orientation du menu
		frame = CreateFrame("Frame", "NecrosisCurseVector", NecrosisMenusConfig4, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", 0, 400)

		local FontString = frame:CreateFontString("NecrosisCurseVectorT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisMenusConfig', "BOTTOMLEFT", 25, 403)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(125, frame)

		-- Choix du sens du menu
		frame = CreateFrame("CheckButton", "NecrosisCurseSens", NecrosisMenusConfig4, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 50, 375)

		frame:SetScript("OnClick", function()
			if this:GetChecked() then
				NecrosisConfig.PetMenuPos.direction = -1
			else
				NecrosisConfig.PetMenuPos.direction = 1
			end
			Necrosis:CreateMenu()
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Création du slider d'Offset X
		frame = CreateFrame("Slider", "NecrosisCurseOx", NecrosisMenusConfig4, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.CurseMenuDecalage.x = this:GetValue()
			Necrosis:SetOfxy("Curse")
		end)

		NecrosisCurseOxText:SetText("Offset X")
		NecrosisCurseOxLow:SetText("")
		NecrosisCurseOxHigh:SetText("")

		-- Création du slider d'Offset Y
		frame = CreateFrame("Slider", "NecrosisCurseOy", NecrosisMenusConfig4, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", -25, 225)

		local State = 0
		if NecrosisBlockedMenu then
			State = 4
		end
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue())
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "4") end

		end)
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide()
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", State) end
		end)
		frame:SetScript("OnValueChanged", function()
			GameTooltip:SetText(this:GetValue())
			NecrosisConfig.CurseMenuDecalage.y = this:GetValue()
			Necrosis:SetOfxy("Curse")
		end)

		NecrosisCurseOyText:SetText("Offset Y")
		NecrosisCurseOyLow:SetText("")
		NecrosisCurseOyHigh:SetText("")

	end

	UIDropDownMenu_Initialize(NecrosisBuffVector, self.BuffVector_Init)
	UIDropDownMenu_Initialize(NecrosisDemonVector, self.DemonVector_Init)
	UIDropDownMenu_Initialize(NecrosisCurseVector, self.CurseVector_Init)

	NecrosisBlockedMenu:SetText(self.Config.Menus["Afficher les menus en permanence"])
	NecrosisAutoMenu:SetText(self.Config.Menus["Afficher automatiquement les menus en combat"])
	NecrosisCloseMenu:SetText(self.Config.Menus["Fermer le menu apres un clic sur un de ses elements"])

	NecrosisBuffVectorT:SetText(self.Config.Menus["Orientation du menu des Buffs"])
	NecrosisBuffSens:SetText(self.Config.Menus["Changer la symetrie verticale des boutons"])
	NecrosisBanishSizeText:SetText(self.Config.Menus["Taille du bouton Banir"])

	NecrosisDemonVectorT:SetText(self.Config.Menus["Orientation du menu des Demons"])
	NecrosisDemonSens:SetText(self.Config.Menus["Changer la symetrie verticale des boutons"])

	NecrosisCurseVectorT:SetText(self.Config.Menus["Orientation du menu des Maledictions"])
	NecrosisCurseSens:SetText(self.Config.Menus["Changer la symetrie verticale des boutons"])

	NecrosisBlockedMenu:SetChecked(NecrosisConfig.BlockedMenu)
	NecrosisAutoMenu:SetChecked(NecrosisConfig.AutomaticMenu)
	NecrosisCloseMenu:SetChecked(NecrosisConfig.ClosingMenu)

	if not (NecrosisConfig.BuffMenuPos.x == 0) then
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 1)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[1], NecrosisBuffVector)
	elseif NecrosisConfig.BuffMenuPos.y > 0 then
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 2)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[2], NecrosisBuffVector)
	else
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 3)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[3], NecrosisBuffVector)
	end
	NecrosisBuffSens:SetChecked(NecrosisConfig.BuffMenuPos.direction < 0)
	NecrosisBanishSize:SetValue(NecrosisConfig.BanishScale)
	NecrosisBuffOx:SetValue(NecrosisConfig.BuffMenuDecalage.x)
	NecrosisBuffOy:SetValue(NecrosisConfig.BuffMenuDecalage.y)

	if not (NecrosisConfig.PetMenuPos.x == 0) then
		UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 1)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[1], NecrosisDemonVector)
	elseif NecrosisConfig.PetMenuPos.y > 0 then
		UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 2)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[2], NecrosisDemonVector)
	else
		UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 3)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[3], NecrosisDemonVector)
	end
	NecrosisDemonSens:SetChecked(NecrosisConfig.PetMenuPos.direction < 0)
	NecrosisDemonOx:SetValue(NecrosisConfig.PetMenuDecalage.x)
	NecrosisDemonOy:SetValue(NecrosisConfig.PetMenuDecalage.y)

	if not (NecrosisConfig.CurseMenuPos.x == 0) then
		UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 1)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[1], NecrosisCurseVector)
	elseif NecrosisConfig.CurseMenuPos.y > 0 then
		UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 2)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[2], NecrosisCurseVector)
	else
		UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 3)
		UIDropDownMenu_SetText(self.Config.Menus.Orientation[3], NecrosisCurseVector)
	end
	NecrosisCurseSens:SetChecked(NecrosisConfig.CurseMenuPos.direction < 0)
	NecrosisCurseOx:SetValue(NecrosisConfig.CurseMenuDecalage.x)
	NecrosisCurseOy:SetValue(NecrosisConfig.CurseMenuDecalage.y)

	if NecrosisConfig.BlockedMenu then
		NecrosisAutoMenu:Disable()
		NecrosisCloseMenu:Disable()
	else
		NecrosisAutoMenu:Enable()
		NecrosisCloseMenu:Enable()
	end

	frame:Show()
end



------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des Buff
function Necrosis.BuffVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = Necrosis.BuffVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.BuffVector_Click()
	local ID = this:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, ID)
	if ID == 1 then
		NecrosisConfig.BuffMenuPos.x = 1
		NecrosisConfig.BuffMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = 1
	else
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Démons
function Necrosis.DemonVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = Necrosis.DemonVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.DemonVector_Click()
	local ID = this:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, ID)
	if ID == 1 then
		NecrosisConfig.PetMenuPos.x = 1
		NecrosisConfig.PetMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = 1
	else
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Malédictions
function Necrosis.CurseVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = Necrosis.CurseVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.CurseVector_Click()
	local ID = this:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisCurseVector, ID)
	if ID == 1 then
		NecrosisConfig.CurseMenuPos.x = 1
		NecrosisConfig.CurseMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = 1
	else
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end