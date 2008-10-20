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

	-- Le Titre
	_G["BINDING_HEADER_Necrosis"] = "Necrosis LdC"
	
	-- La Sphere
	_G["BINDING_NAME_CLICK NecrosisButton:LeftButton"] = Necrosis.Spell[NecrosisConfig.MainSpell].Name
	
	-- Le Cheval
	if NecrosisConfig.OwnMount then
		local _, nameMount = GetCompanionInfo("MOUNT", NecrosisConfig.LeftMount)
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = nameMount
	elseif Necrosis.Spell[2].ID then
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = Necrosis.Spell[2].Name
	else
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = Necrosis.Spell[1].Name
	end
	
	-- La Pierre de feu
	_G["BINDING_NAME_CLICK NecrosisFirestoneButton:RightButton"] = Necrosis.Spell[54].Name
	_G["BINDING_NAME_CLICK NecrosisFirestoneButton:LeftButton"] = self.Translation.Item.Firestone
	
end
