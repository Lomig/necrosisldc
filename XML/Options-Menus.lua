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

		-- Afficher les menus en permanence
		frame = CreateFrame("CheckButton", "NecrosisBlockedMenu", NecrosisMenusConfig, "UICheckButtonTemplate")
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

		-- Afficher les menus en combat
		frame = CreateFrame("CheckButton", "NecrosisAutoMenu", NecrosisMenusConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 25, 375)

		frame:SetScript("OnClick", function() NecrosisConfig.AutomaticMenu = this:GetChecked() end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)
		frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Cacher les menus sur un click
		frame = CreateFrame("CheckButton", "NecrosisCloseMenu", NecrosisMenusConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 25, 350)

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

		-- Choix de l'orientation du menu
		frame = CreateFrame("Frame", "NecrosisBuffVector", NecrosisMenusConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig, "BOTTOMRIGHT", 0, 300)

		local FontString = frame:CreateFontString("NecrosisBuffVectorT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisMessagesConfig, "BOTTOMLEFT", 25, 303)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(125, frame)

		-- Choix du sens du menu
		frame = CreateFrame("CheckButton", "NecrosisBuffSens", NecrosisMenusConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 50, 275)

		frame:SetScript("OnClick", function()
			if this:GetChecked() then
				NecrosisConfig.BuffMenuPos.Direction = -1
			else
				NecrosisConfig.BuffMenuPos.Direction = 1
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Création du slider de scale de Necrosis
		frame = CreateFrame("Slider", "NecrosisBanishSize", NecrosisMenusConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(50, 200)
		frame:SetValueStep(5)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisMenusConfig, "BOTTOMLEFT", 175, 200)

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
		frame = CreateFrame("Slider", "NecrosisBuffOx", NecrosisMenusConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 25, 150)

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
		frame = CreateFrame("Slider", "NecrosisBuffOy", NecrosisMenusConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(-65, 65)
		frame:SetValueStep(1)
		frame:SetWidth(140)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMenusConfig, "BOTTOMRIGHT", -25, 150)

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
		NecrosisBuffOxLow:SetText("")
		NecrosisBuffOxHigh:SetText("")

	end

	UIDropDownMenu_Initialize(NecrosisBuffVector, Necrosis.BuffVector_Init)

	NecrosisBlockedMenu:SetText(["Afficher les menus en permanence"])
	NecrosisAutoMenu:SetText(["Afficher automatiquement les menus en combat"])
	NecrosisCloseMenu:SetText(["Fermer le menu apres un clic sur un de ses elements"])
	NecrosisBuffVectorT:SetText(Necrosis.Config.Menus["Orientation du menu des Buffs"])
	NecrosisBuffSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])
	NecrosisBanishSizeText:SetText(Necrosis.Config.Menus["Taille du bouton Banir"])

	NecrosisBlockedMenu:SetChecked(NecrosisConfig.BlockedMenu)
	NecrosisAutoMenu:SetChecked(NecrosisConfig.AutomaticMenu)
	NecrosisCloseMenu:SetChecked(NecrosisConfig.ClosingMenu)

	if not (NecrosisConfig.BuffMenuPos.x == 0) then
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 1)
		UIDropDownMenu_SetText(Necrosis.Config.Menus.Orientation[1], NecrosisBuffVector)
	elseif NecrosisConfig.BuffMenuPos.y > 0 then
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 2)
		UIDropDownMenu_SetText(Necrosis.Config.Menus.Orientation[2], NecrosisBuffVector)
	else
		UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 3)
		UIDropDownMenu_SetText(Necrosis.Config.Menus.Orientation[3], NecrosisBuffVector)
	end

	NecrosisBuffSens:SetChecked(NecrosisConfig.BuffMenuPos.Direction > 0)
	NecrosisBanishSize:SetValue(NecrosisConfig.BanishScale)
	NecrosisBuffOx:SetValue(NecrosisConfig.BuffMenuDecalage.x)
	NecrosisBuffOy:SetValue(NecrosisConfig.BuffMenuDecalage.y)

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

-- Fonctions du Dropdown des timers
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
		NecrosisConfig.BuffMenuPos.x = NecrosisConfig.BuffMenuPos.Direction
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
