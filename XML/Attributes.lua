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

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)



------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES MENUS
------------------------------------------------------------------------------------------------------

-- On crée les menus sécurisés pour les différents sorts Buff / Démon / Malédictions
function Necrosis_MenuAttribute(menu)
	if InCombatLockdown() then
		return
	end

	local menu0 = _G[menu.."0"]
	local menuButton = _G[menu.."Button"]

	menuButton:SetAttribute("*childraise*", true)

	menuButton:SetAttribute("onmousedownbutton1", "down1")
	menuButton:SetAttribute("onmousedownbutton2", "down2")
	menuButton:SetAttribute("*anchorchild-down1", menu0)
	menuButton:SetAttribute("*anchorchild-down2", menu0)

	menuButton:SetAttribute("*childofsx-down1", 0)
	menuButton:SetAttribute("*childofsy-down1", 0)
	menuButton:SetAttribute("*childofsx-down2", 0)
	menuButton:SetAttribute("*childofsy-down2", 0)
	menuButton:SetAttribute("*childpoint-down1", "CENTER")
	menuButton:SetAttribute("*childpoint-down2", "CENTER")
	menuButton:SetAttribute("*childrelpoint-down1", "CENTER")
	menuButton:SetAttribute("*childrelpoint-down2", "CENTER")

	menuButton:SetAttribute("*childstate-down1", "^mousedown1")
	menuButton:SetAttribute("*childstate-down2", "^mousedown2")
	menuButton:SetAttribute("*childreparent-down1", "true")
	menuButton:SetAttribute("*childreparent-down2", "true")

	menu0:SetAttribute("state", 0)

	menu0:SetAttribute("statemap-anchor-mousedown1", "0:1;1:0;3:3;4:4")
	menu0:SetAttribute("statemap-anchor-mousedown2", "0:1;1:0;3:3;4:4")
	menu0:SetAttribute("delaystatemap-anchor-mousedown1", "3:3;4:4;*:0")
	menu0:SetAttribute("delaytimemap-anchor-mousedown1", "8")
	menu0:SetAttribute("delayhovermap-anchor-mousedown1", "true")

	-- On bloque le menu en position ouverte si configuré
	if NecrosisConfig.BlockedMenu then menu0:SetAttribute("state", "4") end
end



------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

-- On associe les buffs au clic sur le bouton concerné
function Necrosis_BuffSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Association de l'armure demoniaque si le sort est disponible
	if _G["NecrosisBuffMenu1"] then
		NecrosisBuffMenu1:SetAttribute("type", "spell")
		if not NECROSIS_SPELL_TABLE[31].ID then
			NecrosisBuffMenu1:SetAttribute("spell",
				NECROSIS_SPELL_TABLE[36].Name
			)
		else
			NecrosisBuffMenu1:SetAttribute("spell",
				NECROSIS_SPELL_TABLE[31].Name
			)
		end
		-- Création du tableau des raccourcis claviers
		if not NecrosisAlreadyBind["NecrosisBuffMenu1"] then
			NecrosisAlreadyBind["NecrosisBuffMenu1"] = true
			table.insert(
				NecrosisBinding,
				{NECROSIS_SPELL_TABLE[31].Name, "CLICK NecrosisBuffMenu1:LeftButton"}
			)
		end
	end


	-- Association des autres buffs aux boutons
	local buffID = {31, 32, 33, 34, 37, 39, 38, 43, 47, 35}
	for i = 2, #buffID, 1 do
		local f = _G["NecrosisBuffMenu"..i]
		if f then
			f:SetAttribute("type", "spell")
			-- Si le sort nécessite une cible, on lui en associe une
			if not (i == 4 or i == 6 or i == 7 or i == 8) then
				f:SetAttribute("unit", "target")
			end
			f:SetAttribute("spell",
				NECROSIS_SPELL_TABLE[ buffID[i] ].Name
			)
			-- Création du tableau des raccourcis claviers
			if not NecrosisAlreadyBind["NecrosisBuffMenu"..i] then
				NecrosisAlreadyBind["NecrosisBuffMenu"..i] = true
				table.insert(
					NecrosisBinding,
					{NECROSIS_SPELL_TABLE[ buffID[i] ].Name, "CLICK NecrosisBuffMenu"..i..":LeftButton"}
				)
			end
		end
	end


	-- Cas particulier : Bouton de Banish
	if _G["NecrosisBuffMenu9"] then
		-- Association du sort au clic gauche
		NecrosisBuffMenu9:SetAttribute("unit", "target")
		NecrosisBuffMenu9:SetAttribute("type", "macro")
		NecrosisBuffMenu9:SetAttribute("macrotext", "/focus\n/cast "..NECROSIS_SPELL_TABLE[9].Name)

		-- Si le démoniste control + click le bouton de banish
		-- On rebanish la dernière cible bannie
		NecrosisBuffMenu9:SetAttribute("ctrl-type", "macro")
		NecrosisBuffMenu9:SetAttribute("ctrl-macrotext", "/cast [target=focus] "..NECROSIS_SPELL_TABLE[9].Name)

		-- Création du tableau des raccourcis claviers
		if not NecrosisAlreadyBind["NecrosisBuffMenu9Left"] then
			NecrosisAlreadyBind["NecrosisBuffMenu9Left"] = true
			table.insert(
				NecrosisBinding,
				{NECROSIS_SPELL_TABLE[9].Name, "CLICK NecrosisBuffMenu9:LeftButton"}
			)
		end
		-- Si le démoniste possède le Banish rang 2, on associe le rang 1 au clic droit
		if NECROSIS_SPELL_TABLE[9].Rank:find("2") then
			NecrosisBuffMenu9:SetAttribute("type1", "macro")
			NecrosisBuffMenu9:SetAttribute("macrotext1", "/focus\n/cast "..NECROSIS_SPELL_TABLE[9].Name)
			NecrosisBuffMenu9:SetAttribute("type2", "macro")
			NecrosisBuffMenu9:SetAttribute("macrotext2", "/focus\n/cast "..NECROSIS_SPELL_TABLE[9].Name.."("..NECROSIS_SPELL_TABLE[9].Rank:gsub("2", "1")..")")

			NecrosisBuffMenu9:SetAttribute("ctrl-type1", "macro")
			NecrosisBuffMenu9:SetAttribute("ctrl-macrotext1", "/cast [target=focus] "..NECROSIS_SPELL_TABLE[9].Name)
			NecrosisBuffMenu9:SetAttribute("ctrl-type2", "macro")
			NecrosisBuffMenu9:SetAttribute("ctrl-macrotext2", "/cast [target=focus] "..NECROSIS_SPELL_TABLE[9].Name.."("..NECROSIS_SPELL_TABLE[9].Rank:gsub("2", "1")..")")

			if not NecrosisAlreadyBind["NecrosisBuffMenu9Right"] then
				NecrosisAlreadyBind["NecrosisBuffMenu9Right"] = true
				table.insert(
					NecrosisBinding,
					{NECROSIS_SPELL_TABLE[9].Name.." Rank 1", "CLICK NecrosisBuffMenu9:RightButton"}
				)
			end
		end


	end
end

-- On associe les démons au clic sur le bouton concerné
function Necrosis_PetSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Démons maitrisés
	local buttonID = {2, 3, 4, 5, 10}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]]
		if f then
			f:SetAttribute("type1", "spell")
			f:SetAttribute("type2", "macro")
			f:SetAttribute("spell", NECROSIS_SPELL_TABLE[i+2].Name)
			f:SetAttribute("macrotext",
				"/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[i+2].Name
			)
			-- Création du tableau des raccourcis claviers
			if not NecrosisAlreadyBind["NecrosisPetMenu"..buttonID[i]] then
				NecrosisAlreadyBind["NecrosisPetMenu"..buttonID[i]] = true
				table.insert(
					NecrosisBinding,
					{NECROSIS_SPELL_TABLE[i+2].Name, "CLICK NecrosisPetMenu"..buttonID[i]..":LeftButton"}
				)
			end
		end
	end

	-- Autres sorts démoniaques
	local buttonID = {1, 6, 7, 8, 9}
	local BuffID = {15, 8, 30, 35, 44}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]]
		if f then
			f:SetAttribute("type", "spell")
			f:SetAttribute("spell", NECROSIS_SPELL_TABLE[ BuffID[i] ].Name)
			-- Création du tableau des raccourcis claviers
			if not NecrosisAlreadyBind["NecrosisPetMenu"..buttonID[i]] then
				NecrosisAlreadyBind["NecrosisPetMenu"..buttonID[i]] = true
				table.insert(
					NecrosisBinding,
					{NECROSIS_SPELL_TABLE[BuffID[i]].Name, "CLICK NecrosisPetMenu"..buttonID[i]..":LeftButton"}
				)
			end
		end
	end
end

-- On associe les malédictions au clic sur le bouton concerné
function Necrosis_CurseSpellAttribute()
	if InCombatLockdown() then
		return
	end

	-- Malédiction amplifiée
	if _G["NecrosisCurseMenu1"] then
		NecrosisCurseMenu1:SetAttribute("type", "spell")
		NecrosisCurseMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[42].Name)
		-- Création du tableau des raccourcis claviers
		if not NecrosisAlreadyBind["NecrosisCurseMenu1"] then
			NecrosisAlreadyBind["NecrosisCurseMenu1"] = true
			table.insert(
				NecrosisBinding,
				{NECROSIS_SPELL_TABLE[42].Name, "CLICK NecrosisCurseMenu1:LeftButton"}
			)
		end
	end

	-- Malédictions amplifiables
	local buttonID = {2, 3, 6}
	local buffID = {23, 22, 40}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisCurseMenu"..buttonID[i]]
		if f then
			f:SetAttribute("harmbutton1", "debuff")
			f:SetAttribute("type-debuff", "spell")
			f:SetAttribute("unit", "target")
			f:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[ buffID[i] ].Name)
			f:SetAttribute("harmbutton2", "amplif")
			f:SetAttribute("type-amplif", "macro")
			f:SetAttribute("macrotext-amplif",
				"/cast "..NECROSIS_SPELL_TABLE[42].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[ buffID[i] ].Name
			)
			-- Création du tableau des raccourcis claviers
			if not NecrosisAlreadyBind["NecrosisCurseMenu"..buttonID[i]] then
				NecrosisAlreadyBind["NecrosisCurseMenu"..buttonID[i]] = true
				table.insert(
					NecrosisBinding,
					{
						NECROSIS_SPELL_TABLE[ buffID[i] ].Name,
						"CLICK NecrosisCurseMenu"..buttonID[i]..":LeftButton"
					}
				)
			end
		end
	end

	-- Autres malédictions
	local buttonID = {4, 5, 7, 8, 9}
	local buffID = {24,25,26,27,16}
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisCurseMenu"..buttonID[i]]
		if f then
			f:SetAttribute("harmbutton", "debuff")
			f:SetAttribute("type-debuff", "spell")
			f:SetAttribute("unit", "target")
			f:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[ buffID[i] ].Name)
			-- Création du tableau des raccourcis claviers
			if not NecrosisAlreadyBind["NecrosisCurseMenu"..buttonID[i]] then
				NecrosisAlreadyBind["NecrosisCurseMenu"..buttonID[i]] = true
				table.insert(
					NecrosisBinding,
					{
						NECROSIS_SPELL_TABLE[ buffID[i] ].Name,
						"CLICK NecrosisCurseMenu"..buttonID[i]..":LeftButton"
					}
				)
			end
		end
	end
end

-- Association de la monture au bouton, et de la création des pierres sur un clic droit
function Necrosis_StoneAttribute(StoneIDInSpellTable, Steed)
	if InCombatLockdown() then
		return
	end

	-- Pour les pierres
	local itemName = {"Soulstone", "Healthstone", "Spellstone", "Firestone" }
	for i = 1, #StoneIDInSpellTable, 1 do
		local f = _G["Necrosis"..itemName[i].."Button"]
		if f then
			f:SetAttribute("type2", "spell")
			f:SetAttribute("spell2", NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Name.."("..NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Rank..")")

			-- On prépare le tableau des raccourcis claviers
			if not NecrosisAlreadyBind["Necrosis"..itemName[i].."Button"] then
				NecrosisAlreadyBind["Necrosis"..itemName[i].."Button"] = true
				table.insert(
					NecrosisBinding,
					{NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Name, "CLICK Necrosis"..itemName[i].."Button:RightButton"}
				)
				table.insert(
					NecrosisBinding,
					{NECROSIS_ITEM[ itemName[i] ], "CLICK Necrosis"..itemName[i].."Button:LeftButton"}
				)
			end
		end
	end

	-- Pour la monture
	if Steed and  _G["NecrosisMountButton"] then
		NecrosisMountButton:SetAttribute("type1", "spell")
		NecrosisMountButton:SetAttribute("type2", "spell")
		-- Si le démoniste possède une monture épique, on associe la monture classique au clic droit
		if NECROSIS_SPELL_TABLE[2].ID then
			NecrosisMountButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[2].Name)
			NecrosisMountButton:SetAttribute("spell2", NECROSIS_SPELL_TABLE[1].Name)

		else
			NecrosisMountButton:SetAttribute("spell*", NECROSIS_SPELL_TABLE[1].Name)
		end
		if not NecrosisAlreadyBind["NecrosisMountButton"] then
			NecrosisAlreadyBind["NecrosisMountButton"] = true
			table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[2].Name, "CLICK NecrosisMountButton:LeftButton"})
		end
	end

	-- Pour la pierre de foyer
	NecrosisSpellTimerButton:SetAttribute("type2", "item")
	NecrosisSpellTimerButton:SetAttribute("item", NECROSIS_ITEM.Hearthstone)

	-- Cas particulier : Si le sort du Rituel des âmes existe, on l'associe au shift+clic healthstone.
	if _G["NecrosisHealthstoneButton"] and NECROSIS_SPELL_TABLE[50].ID then
		NecrosisHealthstoneButton:SetAttribute("shift-type*", "spell")
		NecrosisHealthstoneButton:SetAttribute("shift-spell*", NECROSIS_SPELL_TABLE[50].Name)
	end
end

-- Association de la Connexion au bouton central si le sort est disponible
function Necrosis_MainButtonAttribute()
	-- Le clic droit ouvre le Menu des options
	NecrosisButton:SetAttribute("type2", "Open")
	NecrosisButton.Open = function()
		if NECROSIS_MESSAGE.Help[1] then
			for i = 1, #NECROSIS_MESSAGE.Help, 1 do
				Necrosis_Msg(NECROSIS_MESSAGE.Help[i], "USER")
			end
		end
		if (NecrosisGeneralFrame:IsVisible()) then
			NecrosisGeneralFrame:Hide()
			return
		else
			if NecrosisConfig.SM then
				Necrosis_Msg("!!! Short Messages : <brightGreen>On", "USER")
			end
			NecrosisGeneralFrame:Show()
			NecrosisGeneralTab_OnClick(1)
			return
		end
	end

	if NECROSIS_SPELL_TABLE[NecrosisConfig.MainSpell].ID then
		NecrosisButton:SetAttribute("type1", "spell")
		NecrosisButton:SetAttribute("spell", NECROSIS_SPELL_TABLE[NecrosisConfig.MainSpell].Name)
		if not NecrosisAlreadyBind["NecrosisButton"] then
			NecrosisAlreadyBind["NecrosisButton"] = true
			table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[NecrosisConfig.MainSpell].Name, "CLICK NecrosisButton:LeftButton"})
		end
	end
end


------------------------------------------------------------------------------------------------------
-- DEFINITION DES ATTRIBUTS DES SORTS EN FONCTION DU COMBAT / REGEN
------------------------------------------------------------------------------------------------------

function Necrosis_NoCombatAttribute(SoulstoneMode, FirestoneMode, SpellstoneMode, StoneIDInSpellTable)

	-- Si on veut que le menu s'engage automatiquement en combat
	-- Et se désengage à la fin
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "0") end
		if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "0") end
		if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "0") end
	end

	-- Si la pierre de sort est équipée, et qu'on connait une baguette,
	-- Alors cliquer milieu sur la pierre de sort équipe la baguette.
	if SpellstoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] and _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3])
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
	-- Sinon, si la pierre de feu est équipée, et qu'on connait une baguette,
	-- Alors cliquer sur la pierre de feu équipe la baguette
	elseif FirestoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] and _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
	else
		-- Si on connait l'emplacement de la pierre de sort,
		-- Alors cliquer sur le bouton de pierre de sort l'équipe.
		if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisSpellstoneButton"] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1])
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1])
		end
		-- Si on connait l'emplacement de la pierre de feu,
		-- Alors cliquer sur le bouton de pierre de feu l'équipe.
		if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisFirestoneButton"] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
		end
	end
end

function Necrosis_InCombatAttribute()

	-- Si on veut que le menu s'engage automatiquement en combat
	if NecrosisConfig.AutomaticMenu and not NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenu0"] then NecrosisPetMenu0:SetAttribute("state", "3") end
		if _G["NecrosisBuffMenu0"] then NecrosisBuffMenu0:SetAttribute("state", "3") end
		if _G["NecrosisCurseMenu0"] then NecrosisCurseMenu0:SetAttribute("state", "3") end
	end

	-- Si on connait le nom de la pierre de sort,
	-- Alors le clic gauche utiliser la pierre
	-- Alors le clic milieu sur le bouton équipera la pierre
	if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetAttribute("type1", "item")
		NecrosisSpellstoneButton:SetAttribute("item", NecrosisConfig.ItemSwitchCombat[1])
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1])
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1])
	end

	-- Si on connait le nom de la pierre de feu,
	-- Alors le clic sur le bouton équipera la pierre
	if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetAttribute("type1", "macro")
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
	end

	-- Si on connait le nom de la pierre de soin,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[4] and _G["NecrosisHealthstoneButton"] then
		NecrosisHealthstoneButton:SetAttribute("type1", "macro")
		NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[4])
	end

	-- Si on connait le nom de la pierre d'âme,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[5] and _G["NecrosisSoulstoneButton"] then
		NecrosisSoulstoneButton:SetAttribute("type1", "item")
		NecrosisSoulstoneButton:SetAttribute("unit", "target")
		NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[5])
	end
end

------------------------------------------------------------------------------------------------------
-- DEFINITION SITUATIONNELLE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

function Necrosis_SoulstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisSoulstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisSoulstoneButton:SetAttribute("type1", "spell")
		NecrosisSoulstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[1]].Name.."("..NECROSIS_SPELL_TABLE[nostone[1]].Rank..")")
		return
	end

	NecrosisSoulstoneButton:SetAttribute("type1", "item")
	NecrosisSoulstoneButton:SetAttribute("type3", "item")
	NecrosisSoulstoneButton:SetAttribute("unit", "target")
	NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[5])
	NecrosisSoulstoneButton:SetAttribute("item3", NecrosisConfig.ItemSwitchCombat[5])
end

function Necrosis_HealthstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisHealthstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisHealthstoneButton:SetAttribute("type1", "spell")
		NecrosisHealthstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[2]].Name.."("..NECROSIS_SPELL_TABLE[nostone[2]].Rank..")")
		return
	end

	NecrosisHealthstoneButton:SetAttribute("type1", "macro")
	NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[4])
	NecrosisHealthstoneButton:SetAttribute("type3", "Trade")
	NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "Trade")
	NecrosisHealthstoneButton.Trade = function () Necrosis_TradeStone() end
end

function Necrosis_SpellstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisSpellstoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisSpellstoneButton:SetAttribute("type1", "spell")
		NecrosisSpellstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[3]].Name.."("..NECROSIS_SPELL_TABLE[nostone[3]].Rank..")")
		return
	end

	NecrosisSpellstoneButton:SetAttribute("type1", "item")
	NecrosisSpellstoneButton:SetAttribute("item", NecrosisConfig.ItemSwitchCombat[1])
	NecrosisSpellstoneButton:SetAttribute("ctrl-type1", "macro")
	NecrosisSpellstoneButton:SetAttribute("shift-type1", "macro")
	NecrosisSpellstoneButton:SetAttribute("type3", "macro")
	NecrosisSpellstoneButton:SetAttribute("macrotext3", "/equip "..NecrosisConfig.ItemSwitchCombat[1])
	NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1])
	if NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisSpellstoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
	end
end

function Necrosis_FirestoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() or not _G["NecrosisFirestoneButton"] then
		return
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		NecrosisFirestoneButton:SetAttribute("type1", "spell")
		NecrosisFirestoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[4]].Name.."("..NECROSIS_SPELL_TABLE[nostone[4]].Rank..")")
		return
	end

	NecrosisFirestoneButton:SetAttribute("ctrl-type1", "macro")
	NecrosisFirestoneButton:SetAttribute("shift-type1", "macro")
	NecrosisFirestoneButton:SetAttribute("type1", "macro")
	NecrosisFirestoneButton:SetAttribute("type3", "macro")
	NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
	NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
	if NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisFirestoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
	end
end

function Necrosis_RangedUpdateAttribute()
	-- Si le démoniste est en combat, on ne fait rien :)
	if InCombatLockdown() then
		return
	end

	-- Si le démoniste a une baguette d'équipée
	if IsEquippedItemType("Wand") then
		-- Si on connait la pierre de sort,
		-- Alors le bouton du milieu équipe la pierre de sort
		if NecrosisConfig.ItemSwitchCombat[1] and _G["NecrosisSpellstoneButton"] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1])
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1])
		end
		-- Si on connait la pierre de feu,
		-- Alors cliquer équipe la pierre de feu
		if NecrosisConfig.ItemSwitchCombat[2] and _G["NecrosisFirestoneButton"] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2])
		end
	-- Sinon, si le démoniste à une pierre de sort d'équipée et qu'on connait une baguette,
	-- Cliquer milieu rééquipe la baguette
	elseif SpellstoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] and _G["NecrosisSpellstoneButton"] then
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3])
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1","/equip "..NecrosisConfig.ItemSwitchCombat[3])
	-- Sinon, si le démoniste a une pierre de feu d'équipée et qu'on connait une baguette,
	-- Cliquer rééquipe la baguette
	elseif FirestoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] and _G["NecrosisFirestoneButton"] then
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3])
	end
end
