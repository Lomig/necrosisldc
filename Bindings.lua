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

-- Création des raccourcis claviers
function Necrosis:BindName()

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Première section
	-------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Le Titre
	_G["BINDING_HEADER_Necrosis"] = "Necrosis LdC"

	-- La Sphere
	_G["BINDING_NAME_CLICK NecrosisButton:LeftButton"] = Necrosis.Spell[NecrosisConfig.MainSpell].Name

	-- Le Cheval
	if NecrosisConfig.OwnMount then
		local _, nameMount1 = GetCompanionInfo("MOUNT", NecrosisConfig.LeftMount)
		local _, nameMount2 = GetCompanionInfo("MOUNT", NecrosisConfig.RightMount)
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = nameMount1
		_G["BINDING_NAME_CLICK NecrosisMountButton:RightButton"] = nameMount2
	elseif Necrosis.Spell[2].ID then
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = Necrosis.Spell[2].Name
		_G["BINDING_NAME_CLICK NecrosisMountButton:RightButton"] = Necrosis.Spell[1].Name
	else
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = Necrosis.Spell[1].Name
		_G["BINDING_NAME_CLICK NecrosisMountButton:RightButton"] = Necrosis.Spell[1].Name
	end

	-- La Pierre de feu
	_G["BINDING_NAME_CLICK NecrosisFirestoneButton:RightButton"] = Necrosis.Spell[54].Name
	_G["BINDING_NAME_CLICK NecrosisFirestoneButton:LeftButton"] = self.Translation.Item.Firestone

	--La Pierre de sort
	_G["BINDING_NAME_CLICK NecrosisSpellstoneButton:RightButton"] = Necrosis.Spell[53].Name
	_G["BINDING_NAME_CLICK NecrosisSpellstoneButton:LeftButton"] = self.Translation.Item.Spellstone

	--La Pierre de soin
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:RightButton"] = Necrosis.Spell[52].Name
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:LeftButton"] = self.Translation.Item.Healthstone.." - "..NECROSIS_COOLDOWN["Utilisation"]
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:MiddleButton"] = self.Translation.Item.Healthstone.." - "..NECROSIS_COOLDOWN["Echange"]

	-- La Pierre de sort
	_G["BINDING_NAME_CLICK NecrosisSoulstoneButton:RightButton"] = Necrosis.Spell[51].Name
	_G["BINDING_NAME_CLICK NecrosisSoulstoneButton:LeftButton"] = self.Translation.Item.Soulstone
	
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Deuxième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	_G["BINDING_HEADER_NecrosisSpell"] = "Necrosis - "..Necrosis.Config.Menus["Menu des Buffs"]
	
	_G["BINDING_NAME_CLICK NecrosisBuffMenuButton:LeftButton"] = Necrosis.Config.Menus["Menu des Buffs"]
	
	local buffID = {31, 47, 32, 33, 34, 37, 39, 38, 43}
	for i = 1, #buffID, 1 do
		_G["BINDING_NAME_CLICK NecrosisBuffMenu"..i..":LeftButton"] = Necrosis.Spell[ buffID[i] ].Name
	end
	
	_G["BINDING_NAME_CLICK NecrosisBuffMenu11:LeftButton"] = Necrosis.Spell[9].Name
	_G["BINDING_NAME_CLICK NecrosisBuffMenu11:RightButton"] = Necrosis.Spell[9].Name.." (1)"

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Troisième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	_G["BINDING_HEADER_NecrosisPet"] = "Necrosis - "..Necrosis.Config.Menus["Menu des Demons"]
	
	_G["BINDING_NAME_CLICK NecrosisPetMenuButton:LeftButton"] = Necrosis.Config.Menus["Menu des Demons"]
	
	for i = 2, 6, 1 do
		_G["BINDING_NAME_CLICK NecrosisPetMenu"..i..":LeftButton"] = Necrosis.Spell[i+1].Name
	end
	
	local buttonID = {1, 7, 8, 9, 10}
	local BuffID = {15, 8, 30, 35, 44}
	for i = 1, #buttonID, 1 do
		_G["BINDING_NAME_CLICK NecrosisPetMenu"..buttonID[i]..":LeftButton"] = Necrosis.Spell[ BuffID[i] ].Name
	end

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Quatrième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- Le Titre
	_G["BINDING_HEADER_NecrosisCurse"] = "Necrosis - "..Necrosis.Config.Menus["Menu des Maledictions"]
	
	_G["BINDING_NAME_CLICK NecrosisCurseMenuButton:LeftButton"] = Necrosis.Config.Menus["Menu des Maledictions"]
	
	local buffID = {23, 22, 24, 25, 40, 26, 16}
	for i = 1, #buffID, 1 do
		_G["BINDING_NAME_CLICK NecrosisCurseMenu"..i..":LeftButton"] = Necrosis.Spell[ buffID[i] ].Name
	end
	
	_G["BINDING_NAME_CLICK NecrosisCurseMenu9:LeftButton"] = Necrosis.Spell[14].Name

end
