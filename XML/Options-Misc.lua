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

	local frame = _G["NecrosisMiscConfig"]
	if not frame then
		-- Création de la fenêtre
		frame = CreateFrame("Frame", "NecrosisMiscConfig", NecrosisGeneralFrame)
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(false)
		frame:EnableMouse(true)
		frame:SetWidth(350)
		frame:SetHeight(452)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT")

		-- Déplacement des fragments
		frame = CreateFrame("CheckButton", "NecrosisMoveShard", NecrosisMiscConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMiscConfig, "BOTTOMLEFT", 25, 400)

		frame:SetScript("OnClick", function()
			NecrosisConfig.SoulshardSort = this:GetChecked()
			if NecrosisConfig.SoulshardSort then
				NecrosisDestroyShard:Enable()
			else
				NecrosisDestroyShard:Disable()
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Destruction des fragments quand le sac est plein
		frame = CreateFrame("CheckButton", "NecrosisDestroyShardBag", NecrosisMiscConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMiscConfig, "BOTTOMLEFT", 50, 375)

		frame:SetScript("OnClick", function() NecrosisConfig.SoulshardDestroy = this:GetChecked() end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)
		frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Choix du sac à fragments
		frame = CreateFrame("Slider", "NecrosisShardBag", NecrosisMiscConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(0, 4)
		frame:SetValueStep(1)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisMiscConfig, "BOTTOMLEFT", 175, 350)

		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(5-this:GetValue())
		end)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetScript("OnMouseUp", function()
			GameTooltip:SetText(5 - this:GetValue())
			NecrosisConfig.SoulshardContainer = 4 - this:GetValue()
			Necrosis:SoulshardSwitch("MOVE")
		end)
		frame:SetScript("OnValueChanged", function() GameTooltip:SetText(5 - this:GetValue()) end)

		NecrosisShardBagLow:SetText("5")
		NecrosisShardBagHigh:SetText("1")

		-- Destruction des fragments quand le sac est plein
		frame = CreateFrame("CheckButton", "NecrosisDestroyShard", NecrosisMiscConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMiscConfig, "BOTTOMLEFT", 50, 375)

		frame:SetScript("OnClick", function()
			NecrosisConfig.DestroyShard = this:GetChecked()
			Necrosis:BagExplore()
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		frame = CreateFrame("EditBox", "NecrosisDestroyCount", NecrosisDestroyShard, "InputBoxTemplate")
		frame:SetNumeric(true)
		frame:SetFocus(false)
		frame:EnableMouse(true)
		frame:SetWidth(40)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("RIGHT", NecrosisMiscConfig, "BOTTOMRIGHT", 0, 375)

		frame:SetScript("OnTextChanged", function()
			NecrosisConfig.DestroyShard = false
			NecrosisDestroyShard:SetChecked(false)
			NecrosisConfig.DestroyCount = this:GetNumber()
		end)

		FontString = frame:CreateFontString(nil, nil, "ChatFontNormal")
		FontString:SetFont("Fonts\\ARIALN.TTF", 12)
		FontString:SetColor(1, 1, 1)

		-- Verrouillage de Necrosis
		frame = CreateFrame("CheckButton", "NecrosisLock", NecrosisMiscConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMiscConfig, "BOTTOMLEFT", 50, 325)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				Necrosis:NoDrag()
				NecrosisButton:RegisterForDrag("")
				NecrosisSpellTimerButton:RegisterForDrag("")
				NecrosisConfig.NoDragAll = true
			else
				if not NecrosisConfig.NecrosisLockServ then
					Necrosis:Drag()
				end
				NecrosisButton:RegisterForDrag("LeftButton")
				NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
				NecrosisConfig.NoDragAll = false
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Affichage des boutons cachés
		frame = CreateFrame("CheckButton", "NecrosisHiddenButtons", NecrosisMiscConfig, "UICheckButtonTemplate")
		frame:EnableMouse(true)
		frame:SetWidth(24)
		frame:SetHeight(24)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("LEFT", NecrosisMiscConfig, "BOTTOMLEFT", 50, 300)

		frame:SetScript("OnClick", function()
			if (this:GetChecked()) then
				ShowUIPanel(NecrosisShadowTranceButton)
				ShowUIPanel(NecrosisBacklashButton)
				ShowUIPanel(NecrosisAntiFearButton)
				ShowUIPanel(NecrosisCreatureAlertButton)
				NecrosisShadowTranceButton:RegisterForDrag("LeftButton")
				NecrosisBacklashButton:RegisterForDrag("LeftButton")
				NecrosisAntiFearButton:RegisterForDrag("LeftButton")
				NecrosisCreatureAlertButton:RegisterForDrag("LeftButton")
			else
				HideUIPanel(NecrosisShadowTranceButton)
				HideUIPanel(NecrosisBacklashButton)
				HideUIPanel(NecrosisAntiFearButton)
				HideUIPanel(NecrosisCreatureAlertButton)
				NecrosisShadowTranceButton:RegisterForDrag("")
				NecrosisBacklashButton:RegisterForDrag("")
				NecrosisAntiFearButton:RegisterForDrag("")
				NecrosisCreatureAlertButton:RegisterForDrag("")
			end
		end)

		FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		frame:SetFontString(FontString)
		frame:SetTextColor(1, 1, 1)

		-- Tailles boutons cachés
		frame = CreateFrame("Slider", "NecrosisHiddenSize", NecrosisMiscConfig, "OptionsSliderTemplate")
		frame:SetMinMaxValues(50, 200)
		frame:SetValueStep(5)
		frame:SetWidth(150)
		frame:SetHeight(15)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", NecrosisMiscConfig, "BOTTOMLEFT", 175, 275)

		local STx, STy, BLx, BLy, AFx, AFy, CAx, CAy
		frame:SetScript("OnEnter", function()
			STx, STy = NecrosisShadowTranceButton:GetCenter()
			STx = STx * (NecrosisConfig.ShadowTranceScale / 100)
			STy = STy * (NecrosisConfig.ShadowTranceScale / 100)

			BLx, BLy = NecrosisBacklashButton:GetCenter()
			BLx = BLx * (NecrosisConfig.ShadowTranceScale / 100)
			BLy = BLy * (NecrosisConfig.ShadowTranceScale / 100)

			AFx, AFy = NecrosisAntiFearButton:GetCenter()
			AFx = AFx * (NecrosisConfig.ShadowTranceScale / 100)
			AFy = AFy * (NecrosisConfig.ShadowTranceScale / 100)

			CAx, CAy = NecrosisCreatureAlertButton:GetCenter()
			CAx = CAx * (NecrosisConfig.ShadowTranceScale / 100)
			CAy = CAy * (NecrosisConfig.ShadowTranceScale / 100)

			ShowUIPanel(NecrosisShadowTranceButton)
			ShowUIPanel(NecrosisBacklashButton)
			ShowUIPanel(NecrosisAntiFearButton)
			ShowUIPanel(NecrosisCreatureAlertButton)
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this:GetValue().."%")
		end)
		frame:SetScript("OnLeave", function()
			if not NecrosisHiddenSize:GetChecked() then
				HideUIPanel(NecrosisShadowTranceButton)
				HideUIPanel(NecrosisBacklashButton)
				HideUIPanel(NecrosisAntiFearButton)
				HideUIPanel(NecrosisCreatureAlertButton)
			end
			GameTooltip:Hide()
		end)
		frame:SetScript("OnValueChanged", function()
			if not (this:GetValue() == NecrosisConfig.ShadowTranceScale) then
				GameTooltip:SetText(this:GetValue().."%")
				NecrosisConfig.ShadowTranceScale = this:GetValue()

				NecrosisShadowTranceButton:ClearAllPoints()
				NecrosisShadowTranceButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", STx / (NecrosisConfig.ShadowTranceScale / 100), STy / (NecrosisConfig.ShadowTranceScale / 100))
				NecrosisShadowTranceButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

				NecrosisBacklashButton:ClearAllPoints()
				NecrosisBacklashButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", BLx / (NecrosisConfig.ShadowTranceScale / 100), BLy / (NecrosisConfig.ShadowTranceScale / 100))
				NecrosisBacklashButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

				NecrosisCreatureAlertButton:ClearAllPoints()
				NecrosisCreatureAlertButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", CAx / (NecrosisConfig.ShadowTranceScale / 100), CAy / (NecrosisConfig.ShadowTranceScale / 100))
				NecrosisCreatureAlertButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

				NecrosisAntiFearButton:ClearAllPoints()
				NecrosisAntiFearButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", AFx / (NecrosisConfig.ShadowTranceScale / 100), AFy / (NecrosisConfig.ShadowTranceScale / 100))
				NecrosisAntiFearButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)
			end
		end)

		NecrosisShardBagLow:SetText("50 %")
		NecrosisShardBagHigh:SetText("200 %")

	end

	NecrosisMoveShard:SetChecked(NecrosisConfig.SoulshardSort)
	NecrosisDestroyShardBag:SetChecked(NecrosisConfig.SoulshardDestroy)
	NecrosisShardBag:SetValue(4 - NecrosisConfig.SoulshardContainer)
	NecrosisDestroyShard:SetChecked(NecrosisConfig.DestroyShard)

	if not NecrosisConfig.DestroyCount then
		NecrosisDestroyCount:SetNumber(0)
	else
		NecrosisDestroyCount:SetNumber(NecrosisConfig.DestroyCount)
	end

	NecrosisLock:SetChecked(NecrosisConfig.NoDragAll)
	NecrosisHiddenSize:SetValue(NecrosisConfig.ShadowTranceScale)

	NecrosisMoveShard:SetText(Necrosis.Config.Misc["Deplace les fragments"])
	NecrosisDestroyShardBag:SetText(Necrosis.Config.Misc["Detruit les fragments si le sac plein"])
	NecrosisShardBagText:SetText(Necrosis.Config.Misc["Choix du sac contenant les fragments"])
	NecrosisDestroyShard:SetText(Necrosis.Config.Misc["Nombre maximum de fragments a conserver"])
	NecrosisLock:SetText(Necrosis.Config.Misc["Verrouiller Necrosis sur l'interface"])
	NecrosisHiddenButtons:SetText(Necrosis.Config.Misc["Afficher les boutons caches"])
	NecrosisHiddenSizeText:SetText(Necrosis.Config.Misc["Taille des boutons caches"])

	frame:Show()
end