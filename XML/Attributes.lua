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
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)



------------------------------------------------------------------------------------------------------
-- DEFINITION OF INITIAL MENU ATTRIBUTES || DEFINITION INITIALE DES ATTRIBUTS DES MENUS
------------------------------------------------------------------------------------------------------

-- On crée les menus sécurisés pour les différents sorts Buff / Démon / Malédictions
function Necrosis:MenuAttribute(menu)
	if InCombatLockdown() then
		return
	end

	local menuButton = _G[menu]

	if not menuButton:GetAttribute("state") then
		menuButton:SetAttribute("state", "Ferme")
	end

	if not menuButton:GetAttribute("lastClick") then
		menuButton:SetAttribute("lastClick", "LeftButton")
	end

	menuButton:Execute([[
		menuButton0 = self:GetChildren()
		ButtonList = table.new(menuButton0:GetChildren())
		if self:GetAttribute("state") == "Bloque" then
			menuButton0:Show()
		else
			menuButton0:Hide()
		end
	]])

	menuButton:SetAttribute("_onclick", [[
		self:SetAttribute("lastClick", button)
		local Etat = self:GetAttribute("state")
		if  Etat == "Ferme" then
			if button == "RightButton" then
				menuButton0:UnregisterAutoHide()
				self:SetAttribute("state", "ClicDroit")
			else
				self:SetAttribute("state", "Ouvert")
				menuButton0:RegisterAutoHide(6)
				for i, button in ipairs(ButtonList) do
					menuButton0:AddToAutoHide(button)
				end
			end
		elseif Etat == "Ouvert" then
			menuButton0:UnregisterAutoHide()
			if button == "RightButton" then
				self:SetAttribute("state", "ClicDroit")
				
			else
				self:SetAttribute("state", "Ferme")
			end
		elseif Etat == "Combat" then
			menuButton0:UnregisterAutoHide()
			if menuButton0:IsShown() then
				menuButton0:Hide()
			else
				menuButton0:Show()
			end
		elseif Etat == "ClicDroit" and button == "LeftButton" then
			menuButton0:UnregisterAutoHide()
			self:SetAttribute("state", "Ferme")
		end
	]])
	
	menuButton:SetAttribute("_onattributechanged", [[
		if name == "state" then
			if value == "Ferme" then
				menuButton0:UnregisterAutoHide()
				menuButton0:Hide()
			elseif value == "Ouvert" then
				menuButton0:Show()
			elseif value == "Combat" or value == "Bloque" then
				menuButton0:UnregisterAutoHide()
				menuButton0:Show()
			elseif value == "ClicDroit" then
				menuButton0:UnregisterAutoHide()
				menuButton0:Show()
			end		
		end
	]])
end

function Necrosis:MetamorphosisAttribute()

	NecrosisMetamorphosisButton:Execute([[
		ButtonList = table.new(self:GetChildren())
	]])

	NecrosisMetamorphosisButton:SetAttribute("_onstate-stance", [[
		newstate = tonumber(newstate)
		if newstate == 2 then
			for i, button in ipairs(ButtonList) do
				button:Show()
			end
		else
			for i, button in ipairs(ButtonList) do
				button:Hide()
			end
		end
	]])

	RegisterStateDriver(NecrosisMetamorphosisButton, "stance", "[stance:2] 2;0")
end

------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

-- On associe les buffs au clic sur le bouton concerné
function Necrosis:BuffSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Association de l'armure demoniaque si le sort est disponible
	if _G["NecrosisBuffMenu1"] then
		NecrosisBuffMenu1:SetAttribute("type", "spell")
		if not self.Spell[31].Name then
			NecrosisBuffMenu1:SetAttribute("spell",
				self.Spell[36].Name
			)
		else
			NecrosisBuffMenu1:SetAttribute("spell",
				self.Spell[31].Name
			)
		end
	end

	-- Buff menu buttons || Association des autres buffs aux boutons
	-- 31=Demon Armor | 47=Fel Armor | 32=Unending Breath | 34=Eye of Kilrogg | 37=Ritual of Summoning | 38=Soul Link | 43=Shadow Ward | 35=Enslave Demon | 24=Demonic Empowerment | 9=Banish
	local buffID = {31, 47, 32, 34, 37, 38, 43, 24, 9}
	for i = 2, #buffID - 1, 1 do
		local f = _G["NecrosisBuffMenu"..i]
		if f and self.Spell[ buffID[i] ].Name then
			f:SetAttribute("type", "spell")
			-- Si le sort nécessite une cible, on lui en associe une
			if (i == 3 or i == 8 or i == 10) then
				f:SetAttribute("unit", "target")
			end
			f:SetAttribute("spell", self.Spell[ buffID[i] ].Name)
		end
	end


	-- Cas particulier : Bouton de Banish
	if _G["NecrosisBuffMenu9"] and self.Spell[9].Name then

		NecrosisBuffMenu9:SetAttribute("unit*", "target")				-- associate left & right clicks with target
		NecrosisBuffMenu9:SetAttribute("ctrl-unit*", "focus") 		-- associate CTRL+left or right clicks with focus

		-- left & right click will perform the same macro
		NecrosisBuffMenu9:SetAttribute("type*", "macro")
		NecrosisBuffMenu9:SetAttribute("macrotext*", "/focus\n/cast "..self.Spell[9].Name)

		-- Si le démoniste control + click le bouton de banish || if the warlock uses ctrl-click then
		-- On rebanish la dernière cible bannie || rebanish the previously banished target
		NecrosisBuffMenu9:SetAttribute("ctrl-type*", "spell")
		NecrosisBuffMenu9:SetAttribute("ctrl-spell*", self.Spell[9].Name)
	end
end

-- On associe les démons au clic sur le bouton concerné
function Necrosis:PetSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Démons maitrisés
	for i = 2, 6, 1 do
		local f = _G["NecrosisPetMenu"..i]
		if f and self.Spell[i+1].Name then
			f:SetAttribute("type1", "spell")
			f:SetAttribute("type2", "macro")
			f:SetAttribute("spell", self.Spell[i+1].Name)
			f:SetAttribute("macrotext",
				"/cast "..GetSpellInfo(74434).."\n/stopcasting\n/cast "..self.Spell[i+1].Name
			)
		end
	end

	-- Autres sorts démoniaques
	local buttonID = {1, 7, 8, 9, 10, 11}
	local BuffID = {53, 8, 30, 35, 44, 24}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]]
		if f and self.Spell[ BuffID[i] ].Name then
			f:SetAttribute("type", "spell")
			f:SetAttribute("spell", self.Spell[ BuffID[i] ].Name)
		end
	end
end

-- On associe les malédictions au clic sur le bouton concerné
function Necrosis:CurseSpellAttribute()
	if InCombatLockdown() then
		return
	end

	local buffID = {23, 22, 25, 40, 26, 16, 14}
	for i = 1, #buffID, 1 do
		local f = _G["NecrosisCurseMenu"..i]
		if f and self.Spell[ buffID[i] ].Name then
			f:SetAttribute("harmbutton", "debuff")
			f:SetAttribute("type-debuff", "spell")
			f:SetAttribute("unit", "target")
			f:SetAttribute("spell-debuff", self.Spell[ buffID[i] ].Name)
		end
	end
end

-- Associating the frames to buttons, and creating stones on right-click.
-- Association de la monture au bouton, et de la création des pierres sur un clic droit
function Necrosis:StoneAttribute(Steed)
	if InCombatLockdown() then
		return
	end

	-- stones || Pour les pierres
	local itemName = {"Soulstone", "Healthstone"}
	local buffID = {51,52}
	for i = 1, #itemName, 1 do
		local f = _G["Necrosis"..itemName[i].."Button"]
		if f and self.Spell[ buffID[i] ].Name then
			f:SetAttribute("type2", "spell")
			f:SetAttribute("spell2", self.Spell[ buffID[i] ].Name)
		end
	end

	-- mounts || Pour la monture
	if Steed and  _G["NecrosisMountButton"] then
		NecrosisMountButton:SetAttribute("type1", "spell")
		NecrosisMountButton:SetAttribute("type2", "spell")

		if (NecrosisConfig.LeftMount) then
			local leftMountName = GetSpellInfo(NecrosisConfig.LeftMount)
			NecrosisMountButton:SetAttribute("spell1", leftMountName)
		else
			if (self.Spell[2].Name) then
				NecrosisMountButton:SetAttribute("spell1", self.Spell[2].Name)
				NecrosisMountButton:SetAttribute("spell2", self.Spell[1].Name)
			else
				NecrosisMountButton:SetAttribute("spell*", self.Spell[1].Name)
			end
		end

		if (NecrosisConfig.RightMount) then
			local rightMountName = GetSpellInfo(NecrosisConfig.RightMount)
			NecrosisMountButton:SetAttribute("spell2", rightMountName)
		end
	end

	-- hearthstone || Pour la pierre de foyer
	NecrosisSpellTimerButton:SetAttribute("unit1", "target")
	NecrosisSpellTimerButton:SetAttribute("type1", "macro")
	NecrosisSpellTimerButton:SetAttribute("macrotext", "/focus")
	NecrosisSpellTimerButton:SetAttribute("type2", "item")
	NecrosisSpellTimerButton:SetAttribute("item", self.Translation.Item.Hearthstone)

	-- metamorphosis menu || Pour le menu Métamorphose
	if _G["NecrosisMetamorphosisButton"] then
		NecrosisMetamorphosisButton:SetAttribute("type", "spell")
		NecrosisMetamorphosisButton:SetAttribute("spell", self.Spell[27].Name)
	end

	-- if the 'Ritual of Souls' spell is known, then associate it to the hearthstone shift-click.
	-- Cas particulier : Si le sort du Rituel des âmes existe, on l'associe au shift+clic healthstone.
	if _G["NecrosisHealthstoneButton"] and self.Spell[50].Name then
		NecrosisHealthstoneButton:SetAttribute("shift-type*", "spell")
		NecrosisHealthstoneButton:SetAttribute("shift-spell*", self.Spell[50].Name)
	end

	-- if the 'Ritual of Summoning' spell is known, then associate it to the soulstone shift-click.
	if _G["NecrosisSoulstoneButton"] and self.Spell[37].Name then
		NecrosisSoulstoneButton:SetAttribute("shift-type*", "spell")
		NecrosisSoulstoneButton:SetAttribute("shift-spell*", self.Spell[37].Name)
	end


end

-- Association de la Connexion au bouton central si le sort est disponible
function Necrosis:MainButtonAttribute()
	-- Le clic droit ouvre le Menu des options
	NecrosisButton:SetAttribute("type2", "Open")
	NecrosisButton.Open = function()
		if not InCombatLockdown() then
			Necrosis:OpenConfigPanel()
		end
	end

	if Necrosis.Spell[NecrosisConfig.MainSpell].Name then
		NecrosisButton:SetAttribute("type1", "spell")
		NecrosisButton:SetAttribute("spell", Necrosis.Spell[NecrosisConfig.MainSpell].Name)
	end
end


------------------------------------------------------------------------------------------------------
-- DEFINITION DES ATTRIBUTS DES SORTS EN FONCTION DU COMBAT / REGEN
------------------------------------------------------------------------------------------------------

function Necrosis:NoCombatAttribute(SoulstoneMode, Pet, Buff, Curse)

	-- Si on veut que le menu s'engage automatiquement en combat
	-- Et se désengage à la fin
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] then
			if NecrosisPetMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisPetMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisPetMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Pet, 1 do
					NecrosisPetMenuButton:WrapScript(Pet[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" or self:GetParent():GetAttribute("state") == "Ferme" then
							self:GetParent():SetAttribute("state", "Ferme")
							self:GetParent():Show()
						end
					]])
				end
			end
		end
		if _G["NecrosisBuffMenuButton"] then
			if NecrosisBuffMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisBuffMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisBuffMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Buff, 1 do
					NecrosisBuffMenuButton:WrapScript(Buff[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" then
							self:GetParent():SetAttribute("state", "Ferme")
							self:GetParent():Show()
						end
					]])
				end
			end
		end
		if _G["NecrosisCurseMenuButton"] then
			if NecrosisCurseMenuButton:GetAttribute("lastClick") == "RightButton" then
				NecrosisCurseMenuButton:SetAttribute("state", "ClicDroit")
			else
				NecrosisCurseMenuButton:SetAttribute("state", "Ferme")
			end
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Curse, 1 do
					NecrosisCurseMenuButton:WrapScript(Curse[i], "OnClick", [[
						if self:GetParent():GetAttribute("state") == "Ouvert" then
							self:GetParent():SetAttribute("state", "Ferme")
							self:GetParent():Show()
						end
					]])
				end
			end
		end
	end
end

function Necrosis:InCombatAttribute(Pet, Buff, Curse)

	-- Si on veut que le menu s'engage automatiquement en combat
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] and NecrosisConfig.StonePosition[5] then
			NecrosisPetMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Pet, 1 do
					NecrosisPetMenuButton:UnwrapScript(Pet[i], "OnClick")
				end
			end
		end
		if _G["NecrosisBuffMenuButton"] and NecrosisConfig.StonePosition[3] then
			NecrosisBuffMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Buff, 1 do
					NecrosisBuffMenuButton:UnwrapScript(Buff[i], "OnClick")
				end
			end
		end
		if _G["NecrosisCurseMenuButton"] and NecrosisConfig.StonePosition[6] then
			NecrosisCurseMenuButton:SetAttribute("state", "Combat")
			if NecrosisConfig.ClosingMenu then
				for i = 1, #Curse, 1 do
					NecrosisCurseMenuButton:UnwrapScript(Curse[i], "OnClick")
				end
			end
		end
	end

	-- Si on connait le nom de la pierre de soin,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetAttribute("type1", "macro")
		NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[1])
	end

	-- Si on connait le nom de la pierre d'âme,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetAttribute("type1", "item")
		NecrosisSoulstoneButton:SetAttribute("unit", "target")
		NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[2])
	end
end

------------------------------------------------------------------------------------------------------
-- DEFINITION SITUATIONNELLE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

function Necrosis:SoulstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisSoulstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisSoulstoneButton:SetAttribute("type1", "spell")
		NecrosisSoulstoneButton:SetAttribute("spell1", self.Spell[51].Name)
		return
	end

	NecrosisSoulstoneButton:SetAttribute("type1", "item")
	NecrosisSoulstoneButton:SetAttribute("type3", "item")
	NecrosisSoulstoneButton:SetAttribute("unit", "target")
	NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[2])
	NecrosisSoulstoneButton:SetAttribute("item3", NecrosisConfig.ItemSwitchCombat[2])
end

function Necrosis:HealthstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisHealthstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisHealthstoneButton:SetAttribute("type1", "spell")
		NecrosisHealthstoneButton:SetAttribute("spell1", self.Spell[52].Name)
		return
	end

	NecrosisHealthstoneButton:SetAttribute("type1", "macro")
	NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[1])
	NecrosisHealthstoneButton:SetAttribute("type3", "Trade")
	NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "Trade")
	NecrosisHealthstoneButton.Trade = function () self:TradeStone() end
end
