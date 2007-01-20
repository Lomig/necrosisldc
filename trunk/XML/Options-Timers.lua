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

function Necrosis:SetTimersConfig()

	local frame = _G["NecrosisTimersConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisTimersConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Choix du timer graphique
		frame = CreateFrame("Frame", "NecrosisTimerSelection", NecrosisTimersConfig, "UIDropDownMenuTemplate")
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisTimersConfig, "BOTTOMRIGHT", 0, 400)

		local FontString = frame:CreateFontString("NecrosisTimerSelectionT", "OVERLAY", "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 403)
		FontString:SetTextColor(1, 1, 1)

		UIDropDownMenu_SetWidth(125, frame)

		-- Affiche ou masque le bouton des timers
		frame = CreateFrame("CheckButton", "NecrosisShowSpellTimerButton", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 325)

		frame:SetScript("OnClick", function()
			NecrosisConfig.ShowSpellTimers = this:GetChecked()
			if NecrosisConfig.ShowSpellTimers then
				NecrosisSpellTimerButton:Show()
			else
				NecrosisSpellTimerButton:Hide()
			end
		end)

		FontString = frame:CreateFontString("NecrosisShowSpellTimerButtonText", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 10, 0)
		FontString:SetTextColor(1, 1, 1)

		-- Affiche les timers sur la gauche du bouton
		frame = CreateFrame("CheckButton", "NecrosisTimerOnLeft", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 300)

		frame:SetScript("OnClick", function()
			Necrosis:SymetrieTimer(this:GetChecked())
		end)

		FontString = frame:CreateFontString("NecrosisTimerOnLeftText", nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 10, 0)
		FontString:SetTextColor(1, 1, 1)

		-- Affiche les timers de bas en haut
		frame = CreateFrame("CheckButton", "NecrosisTimerUpward", NecrosisTimersConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 275)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				NecrosisConfig.SensListe = -1
			else
				NecrosisConfig.SensListe = 1
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 10, 0)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)
		frame:SetDisabledTextColor(0.75, 0.75, 0.75)
	end

	UIDropDownMenu_Initialize(NecrosisTimerSelection, Necrosis.Timer_Init)

	NecrosisTimerSelectionT:SetText(self.Config.Timers["Type de timers"])
	NecrosisShowSpellTimerButtonText:SetText(self.Config.Timers["Afficher le bouton des timers"])
	NecrosisTimerOnLeftText:SetText(self.Config.Timers["Afficher les timers sur la gauche du bouton"])
	NecrosisTimerUpward:SetText(self.Config.Timers["Afficher les timers de bas en haut"])

	UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, (NecrosisConfig.TimerType + 1))
	UIDropDownMenu_SetText(Necrosis.Config.Timers.Type[NecrosisConfig.TimerType + 1], NecrosisTimerSelection)

	NecrosisShowSpellTimerButton:SetChecked(NecrosisConfig.ShowSpellTimers)
	NecrosisTimerOnLeft:SetChecked(NecrosisConfig.SpellTimerPos == -1)
	NecrosisTimerUpward:SetChecked(NecrosisConfig.SensListe == -1)

	if NecrosisConfig.TimerType == 2 then
		NecrosisTimerUpward:Disable()
	else
		NecrosisTimerUpward:Enable()
	end

end


------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des timers
function Necrosis.Timer_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Timers.Type) do
		element.text = Necrosis.Config.Timers.Type[i]
		element.checked = false
		element.func = Necrosis.Timer_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Timer_Click()
	local ID = this:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, ID)
	NecrosisConfig.TimerType = ID - 1
	if not (ID == 1) then Necrosis:CreateTimerAnchor() end
	if ID == 3 then
		NecrosisTimerUpward:Disable()
	else
		NecrosisTimerUpward:Enable()
	end
end
