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
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------




-- On définit _G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTION D'INITIALISATION
------------------------------------------------------------------------------------------------------

function Necrosis_Initialize()

	-- Initilialisation des Textes (VO / VF / VA / VCT / VCS / VE)
	if NecrosisConfig ~= {} then
		if (NecrosisConfig.NecrosisLanguage == "enUS") or (NecrosisConfig.NecrosisLanguage == "enGB") then
			Necrosis_Localization_Dialog_En()
		elseif (NecrosisConfig.NecrosisLanguage == "deDE") then
			Necrosis_Localization_Dialog_De()
		elseif (NecrosisConfig.NecrosisLanguage == "zhTW") then
			Necrosis_Localization_Dialog_Tw()
		elseif (NecrosisConfig.NecrosisLanguage == "zhCN") then
			Necrosis_Localization_Dialog_Cn()
		elseif (NecrosisConfig.NecrosisLanguage == "esES") then
			Necrosis_Localization_Dialog_Es()
		else
			Necrosis_Localization_Dialog_Fr()
		end
	elseif GetLocale() == "enUS" or GetLocale() == "enGB" then
		Necrosis_Localization_Dialog_En()
	elseif GetLocale() == "deDE" then
		Necrosis_Localization_Dialog_De()
	elseif GetLocale() == "zhTW" then
		Necrosis_Localization_Dialog_Tw()
	elseif GetLocale() == "zhCN" then
		Necrosis_Localization_Dialog_Cn()
	elseif  GetLocale() == "esES" then
		Necrosis_Localization_Dialog_Es()
	else
		Necrosis_Localization_Dialog_Fr()
	end


	-- On charge (ou on crée la configuration pour le joueur et on l'affiche sur la console
	if not NecrosisConfig.LastConfig or NecrosisData.LastConfig > NecrosisConfig.LastConfig then
		NecrosisConfig = {}
		NecrosisConfig = Default_NecrosisConfig
		NecrosisConfig.LastConfig = NecrosisData.LastConfig
		Necrosis_Msg(NECROSIS_MESSAGE.Interface.DefaultConfig, "USER")
	else
		Necrosis_Msg(NECROSIS_MESSAGE.Interface.UserConfig, "USER")
	end

	Necrosis_CreateWarlockUI()
	Necrosis_CreateWarlockPopup()

	-----------------------------------------------------------
	-- Exécution des fonctions de démarrage
	-----------------------------------------------------------
	-- Affichage d'un message sur la console
	Necrosis_Msg(NECROSIS_MESSAGE.Interface.Welcome, "USER")
	-- Création de la liste des sorts disponibles
	for index in ipairs(NECROSIS_SPELL_TABLE) do
		NECROSIS_SPELL_TABLE[index].ID = nil
	end
	Necrosis_SpellSetup()
	-- Création de la liste des emplacements des fragments
	Necrosis_SoulshardSetup()
	-- Création des menus de buff et d'invocation
	Necrosis_CreateMenu()
	-- Les boutons sont-ils vérouillés sur le Shard ?
	Necrosis_ButtonSetup()

	-- Enregistrement de la commande console
	SlashCmdList["NecrosisCommand"] = Necrosis_SlashHandler
	SLASH_NecrosisCommand1 = "/necro"

	-- Lecture de la configuration dans le SavedVariables.lua, écriture dans les variables définies
	NecrosisSoulshardSort_Button:SetChecked(NecrosisConfig.SoulshardSort)
	if (NecrosisConfig.SoulshardDestroy) then NecrosisSoulshardDestroy_Button:SetChecked(1) end
	if (NecrosisConfig.ShadowTranceAlert) then NecrosisShadowTranceAlert_Button:SetChecked(1) end
	if (NecrosisConfig.ShowSpellTimers) then NecrosisShowSpellTimers_Button:SetChecked(1) end
	if (NecrosisConfig.AntiFearAlert) then NecrosisAntiFearAlert_Button:SetChecked(1) end
	if (NecrosisConfig.NecrosisLockServ) then NecrosisIconsLock_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[1] > 0) then NecrosisShowFirestone_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[2] > 0) then NecrosisShowSpellstone_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[3] > 0) then NecrosisShowHealthStone_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[4] > 0) then NecrosisShowSoulstone_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[5] > 0) then NecrosisShowBuffMenu_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[6] > 0) then NecrosisShowMount_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[7] > 0) then NecrosisShowPetMenu_Button:SetChecked(1) end
	if (NecrosisConfig.StonePosition[8] > 0) then NecrosisShowCurseMenu_Button:SetChecked(1) end
	if (NecrosisConfig.NecrosisToolTip) then NecrosisShowTooltips_Button:SetChecked(1) end
	if (NecrosisConfig.Sound) then NecrosisSound_Button:SetChecked(1) end
	if (NecrosisConfig.ShowCount) then NecrosisShowCount_Button:SetChecked(1) end
	if (NecrosisConfig.BuffMenuPos.x < 0 or NecrosisConfig.BuffMenuPos.y < 0) then NecrosisBuffMenu_Button:SetChecked(1) end
	if (NecrosisConfig.PetMenuPos.x < 0 or NecrosisConfig.PetMenuPos.y < 0) then NecrosisPetMenu_Button:SetChecked(1) end
	if (NecrosisConfig.CurseMenuPos.x < 0 or NecrosisConfig.CurseMenuPos.y < 0) then NecrosisCurseMenu_Button:SetChecked(1) end
	if (NecrosisConfig.NoDragAll) then NecrosisLock_Button:SetChecked(1) end
	if (NecrosisConfig.SpellTimerPos == -1) then NecrosisSTimer_Button:SetChecked(1) end
	if (NecrosisConfig.ChatMsg) then NecrosisShowMessage_Button:SetChecked(1) end
	if (NecrosisConfig.DemonSummon) then NecrosisShowDemonSummon_Button:SetChecked(1) end
	if (NecrosisConfig.SteedSummon) then NecrosisShowSteedSummon_Button:SetChecked(1) end
	if not (NecrosisConfig.ChatType) then NecrosisChatType_Button:SetChecked(1) end
	if (NecrosisConfig.Graphical) then NecrosisGraphicalTimer_Button:SetChecked(1) end
	if not (NecrosisConfig.Yellow) then NecrosisTimerColor_Button:SetChecked(1) end
	if (NecrosisConfig.SensListe == -1) then NecrosisTimerDirection_Button:SetChecked(1) end

	-- Paramètres des glissières
	NecrosisButtonRotate_Slider:SetValue(NecrosisConfig.NecrosisAngle)
	NecrosisButtonRotate_SliderLow:SetText("0")
	NecrosisButtonRotate_SliderHigh:SetText("360")

	if NecrosisConfig.NecrosisLanguage == "esES" then
		NecrosisLanguage_Slider:SetValue(6)
	elseif NecrosisConfig.NecrosisLanguage == "zhCN" then
		NecrosisLanguage_Slider:SetValue(5)
	elseif NecrosisConfig.NecrosisLanguage == "zhTW" then
		NecrosisLanguage_Slider:SetValue(4)
	elseif NecrosisConfig.NecrosisLanguage == "deDE" then
		NecrosisLanguage_Slider:SetValue(3)
	elseif NecrosisConfig.NecrosisLanguage == "enUS" then
		NecrosisLanguage_Slider:SetValue(2)
	else
		NecrosisLanguage_Slider:SetValue(1)
	end
	NecrosisLanguage_SliderText:SetText("Langue / Language / Sprache / Lengua")
	NecrosisLanguage_SliderLow:SetText("")
	NecrosisLanguage_SliderHigh:SetText("")

	NecrosisBag_Slider:SetValue(4 - NecrosisConfig.SoulshardContainer)
	NecrosisBag_SliderLow:SetText("5")
	NecrosisBag_SliderHigh:SetText("1")

	NecrosisCountType_Slider:SetValue(NecrosisConfig.CountType)
	NecrosisCountType_SliderLow:SetText("")
	NecrosisCountType_SliderHigh:SetText("")

	NecrosisCircle_Slider:SetValue(NecrosisConfig.Circle)
	NecrosisCircle_SliderLow:SetText("")
	NecrosisCircle_SliderHigh:SetText("")

	ShadowTranceScale_Slider:SetValue(NecrosisConfig.ShadowTranceScale)
	ShadowTranceScale_SliderLow:SetText("50%")
	ShadowTranceScale_SliderHigh:SetText("150%")

	if (NecrosisConfig.NecrosisColor == "Rose") then
		NecrosisColor_Slider:SetValue(1)
	elseif (NecrosisConfig.NecrosisColor == "Bleu") then
		NecrosisColor_Slider:SetValue(2)
	elseif (NecrosisConfig.NecrosisColor == "Orange") then
		NecrosisColor_Slider:SetValue(3)
	elseif (NecrosisConfig.NecrosisColor == "Turquoise") then
		NecrosisColor_Slider:SetValue(4)
	elseif (NecrosisConfig.NecrosisColor == "Violet") then
		NecrosisColor_Slider:SetValue(5)
	elseif (NecrosisConfig.NecrosisColor == "666") then
		NecrosisColor_Slider:SetValue(6)
	else
		NecrosisColor_Slider:SetValue(7)
	end
	NecrosisColor_SliderLow:SetText("")
	NecrosisColor_SliderHigh:SetText("")

	NecrosisButtonScale_Slider:SetValue(NecrosisConfig.NecrosisButtonScale)
	NecrosisButtonScale_SliderLow:SetText("50 %")
	NecrosisButtonScale_SliderHigh:SetText("150 %")

	NecrosisBanishScale_Slider:SetValue(NecrosisConfig.BanishScale)
	NecrosisBanishScale_SliderLow:SetText("100 %")
	NecrosisBanishScale_SliderHigh:SetText("200 %")

	-- On règle la taille de la pierre et des boutons suivant les réglages du SavedVariables
	NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale/100)
	NecrosisShadowTranceButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisBacklashButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisAntiFearButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisCreatureAlertButton:SetScale(NecrosisConfig.ShadowTranceScale/100)

	-- On définit l'affichage des Timers à gauche ou à droite du bouton
	NecrosisTimerFrame0:ClearAllPoints()
	NecrosisTimerFrame0:SetPoint(NecrosisConfig.SpellTimerJust, NecrosisSpellTimerButton, "CENTER", NecrosisConfig.SpellTimerPos * 20, 0)

	-- On définit également l'affichage des tooltips pour ces timers à gauche ou à droite du bouton
	if NecrosisConfig.SpellTimerJust == "RIGHT" then
		AnchorSpellTimerTooltip = "ANCHOR_LEFT"
	else
		AnchorSpellTimerTooltip = "ANCHOR_RIGHT"
	end

	-- Le Shard est-il verrouillé sur l'interface ?
	if NecrosisConfig.NoDragAll then
		Necrosis_NoDrag()
		NecrosisButton:RegisterForDrag("")
		NecrosisSpellTimerButton:RegisterForDrag("")
	else
		Necrosis_Drag()
		NecrosisButton:RegisterForDrag("LeftButton")
		NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
	end



	-- Si pas d'objet en distance, on tente d'en équiper un
	Necrosis_MoneyToggle()
	NecrosisTooltip:SetInventoryItem("player", 18)
	local itemName = tostring(NecrosisTooltipTextLeft1:GetText())
	Necrosis_MoneyToggle()
	if (not GetInventoryItemLink("player", 18))
		or itemName:find(NECROSIS_ITEM.Spellstone)
		or itemName:find(NECROSIS_ITEM.Firestone) then
			Necrosis_SearchWand()
	end

	-- Inventaire des pierres et des fragments possedés par le Démoniste
	Necrosis_BagExplore()

	-- On vérifie que les fragments sont dans le sac défini par le Démoniste
	if NecrosisConfig.SoulshardSort then
		Necrosis_SoulshardSwitch("CHECK")
	end

	-- Initialisation des fichiers de langues -- Mise en place ponctuelle du SMS
	Necrosis_LanguageInitialize()
	if NecrosisConfig.SM then
		NECROSIS_SOULSTONE_ALERT_MESSAGE = NECROSIS_SHORT_MESSAGES[1]
		NECROSIS_INVOCATION_MESSAGES = NECROSIS_SHORT_MESSAGES[2]
	end
end

function Necrosis_LanguageInitialize()

	-- Localisation du speech.lua
	NecrosisLocalization()

	-- Localisation du XML
	NecrosisVersion:SetText(NecrosisData.Label)
	NecrosisCredits:SetText("Developed by Lomig, Liadora & Eliah")
	NecrosisShardsInventory_Section:SetText(NECROSIS_CONFIGURATION.ShardMenu)
	NecrosisShardsCount_Section:SetText(NECROSIS_CONFIGURATION.ShardMenu2)
	NecrosisSoulshardSort_Option:SetText(NECROSIS_CONFIGURATION.ShardMove)
	NecrosisSoulshardDestroy_Option:SetText(NECROSIS_CONFIGURATION.ShardDestroy)

	NecrosisMessageSpell_Section:SetText(NECROSIS_CONFIGURATION.SpellMenu1)
	NecrosisMessagePlayer_Section:SetText(NECROSIS_CONFIGURATION.SpellMenu2)
	NecrosisShadowTranceAlert_Option:SetText(NECROSIS_CONFIGURATION.TranseWarning)
	NecrosisAntiFearAlert_Option:SetText(NECROSIS_CONFIGURATION.AntiFearWarning)

	NecrosisShowTrance_Option:SetText(NECROSIS_CONFIGURATION.TranceButtonView)
	NecrosisIconsLock_Option:SetText(NECROSIS_CONFIGURATION.ButtonLock)

	NecrosisShowFirestone_Option:SetText(NECROSIS_CONFIGURATION.Show.Firestone)
	NecrosisShowSpellstone_Option:SetText(NECROSIS_CONFIGURATION.Show.Spellstone)
	NecrosisShowHealthStone_Option:SetText(NECROSIS_CONFIGURATION.Show.Healthstone)
	NecrosisShowSoulstone_Option:SetText(NECROSIS_CONFIGURATION.Show.Soulstone)
	NecrosisShowMount_Option:SetText(NECROSIS_CONFIGURATION.Show.Steed)
	NecrosisShowBuffMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Buff)
	NecrosisShowPetMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Demon)
	NecrosisShowCurseMenu_Option:SetText(NECROSIS_CONFIGURATION.Show.Curse)
	NecrosisShowTooltips_Option:SetText(NECROSIS_CONFIGURATION.Show.Tooltips)
	Necrosis_Binding:SetText(NECROSIS_BINDING.Binding)

	NecrosisShowSpellTimers_Option:SetText(NECROSIS_CONFIGURATION.SpellTime)
	NecrosisGraphicalTimer_Section:SetText(NECROSIS_CONFIGURATION.TimerMenu)
	NecrosisGraphicalTimer_Option:SetText(NECROSIS_CONFIGURATION.GraphicalTimer)
	NecrosisTimerColor_Option:SetText(NECROSIS_CONFIGURATION.TimerColor)
	NecrosisTimerDirection_Option:SetText(NECROSIS_CONFIGURATION.TimerDirection)

	NecrosisLock_Option:SetText(NECROSIS_CONFIGURATION.MainLock)
	NecrosisBuffMenu_Option:SetText(NECROSIS_CONFIGURATION.BuffMenu)
	NecrosisPetMenu_Option:SetText(NECROSIS_CONFIGURATION.PetMenu)
	NecrosisCurseMenu_Option:SetText(NECROSIS_CONFIGURATION.CurseMenu)
	NecrosisShowCount_Option:SetText(NECROSIS_CONFIGURATION.ShowCount)
	NecrosisSTimer_Option:SetText(NECROSIS_CONFIGURATION.STimerLeft)

	NecrosisSound_Option:SetText(NECROSIS_CONFIGURATION.Sound)
	NecrosisShowMessage_Option:SetText(NECROSIS_CONFIGURATION.ShowMessage)
	NecrosisShowSteedSummon_Option:SetText(NECROSIS_CONFIGURATION.ShowSteedSummon)
	NecrosisShowDemonSummon_Option:SetText(NECROSIS_CONFIGURATION.ShowDemonSummon)
	NecrosisChatType_Option:SetText(NECROSIS_CONFIGURATION.ChatType)

	NecrosisButtonRotate_SliderText:SetText(NECROSIS_CONFIGURATION.MainRotation)
	NecrosisCountType_SliderText:SetText(NECROSIS_CONFIGURATION.CountType)
	NecrosisCircle_SliderText:SetText(NECROSIS_CONFIGURATION.Circle)
	NecrosisBag_SliderText:SetText(NECROSIS_CONFIGURATION.BagSelect)
	NecrosisButtonScale_SliderText:SetText(NECROSIS_CONFIGURATION.NecrosisSize)
	NecrosisBanishScale_SliderText:SetText(NECROSIS_CONFIGURATION.BanishSize)
	ShadowTranceScale_SliderText:SetText(NECROSIS_CONFIGURATION.TranseSize)
	NecrosisColor_SliderText:SetText(NECROSIS_CONFIGURATION.Skin)

end



------------------------------------------------------------------------------------------------------
-- FONCTION GERANT LA COMMANDE CONSOLE /NECRO
------------------------------------------------------------------------------------------------------

function Necrosis_SlashHandler(arg1)
	if arg1:lower():find("recall") then
		Necrosis_Recall()
	elseif arg1:lower():find("reset") then
		NecrosisConfig = {}
		ReloadUI()
	elseif arg1:lower():find("sm") then
		if NECROSIS_SOULSTONE_ALERT_MESSAGE == NECROSIS_SHORT_MESSAGES[1] then
			NecrosisConfig.SM = false
			NecrosisLocalization()
			Necrosis_Msg("Short Messages : <red>Off", "USER")
		else
			NecrosisConfig.SM = true
			NECROSIS_SOULSTONE_ALERT_MESSAGE = NECROSIS_SHORT_MESSAGES[1]
			NECROSIS_INVOCATION_MESSAGES = NECROSIS_SHORT_MESSAGES[2]
			Necrosis_Msg("Short Messages : <brightGreen>On", "USER")
		end
	elseif arg1:lower():find("am") then
		NecrosisConfig.AutomaticMenu = not NecrosisConfig.AutomaticMenu
	elseif arg1:lower():find("bm") then
		if NecrosisConfig.BlockedMenu then
			NecrosisConfig.BlockedMenu = false
			local State = 0
			if NecrosisConfig.AutomaticMenu then State = 3 end
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", State) end
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", State) end
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", State) end
		else
			NecrosisConfig.BlockedMenu = true
			if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "4") end
			if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "4") end
			if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "4") end
		end
	else
		NecrosisButton:Open()
	end
end

