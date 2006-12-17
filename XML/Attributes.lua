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
-- Skins et voix Fran�aises : Eliah, Ner'zhul
-- Version Allemande par Arne Meier et Halisstra, Lothar
-- Remerciements sp�ciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version 15.12.2006-1
------------------------------------------------------------------------------------------------------

-- On d�finit G comme �tant le tableau contenant toutes les frames existantes.
local _G = getfenv(0);



------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES MENUS
------------------------------------------------------------------------------------------------------

-- On cr�e le menu s�curis� pour les diff�rents sorts
function Necrosis_MenuAttribute()
	if  _G["NecrosisBuffMenuButton"] then
	-- D�claration s�curis�e du bouton des buffs
	NecrosisBuffMenuButton:SetAttribute("*childraise*", true);

	NecrosisBuffMenu0:SetAttribute("statemap-anchor", "$input");
	NecrosisBuffMenu0:SetAttribute("delaystatemap-anchor", "0");
	NecrosisBuffMenu0:SetAttribute("delaytimemap-anchor", "8");
	NecrosisBuffMenu0:SetAttribute("delayhovermap-anchor", "true");

	NecrosisBuffMenuButton:SetAttribute("onmouseupbutton", "mup");
	NecrosisBuffMenuButton:SetAttribute("onmousedownbutton", "mdn");
	NecrosisBuffMenuButton:SetAttribute("*anchorchild-mdn", NecrosisBuffMenu0);
	NecrosisBuffMenuButton:SetAttribute("*childofsx-mdn", 0);
	NecrosisBuffMenuButton:SetAttribute("*childofsy-mdn", 0);
	NecrosisBuffMenuButton:SetAttribute("*childpoint-mdn", "CENTER");
	NecrosisBuffMenuButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	NecrosisBuffMenuButton:SetAttribute("*childstate-mdn", "^mousedown");
	NecrosisBuffMenuButton:SetAttribute("*childreparent-mdn", "true");

	NecrosisBuffMenuButton:SetAttribute("*anchorchild-mup", NecrosisBuffMenu0);
	NecrosisBuffMenuButton:SetAttribute("*childstate-mup", "mouseup");
	NecrosisBuffMenuButton:SetAttribute("*childverify-mup", true);

	NecrosisBuffMenu0:SetAttribute("state", 0)

	NecrosisBuffMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	NecrosisBuffMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	NecrosisBuffMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	NecrosisBuffMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	NecrosisBuffMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");
	end

	if  _G["NecrosisPetMenuButton"] then
	-- D�claration s�curis�e du bouton des d�mons
	NecrosisPetMenuButton:SetAttribute("*childraise*", true);

	NecrosisPetMenu0:SetAttribute("statemap-anchor", "$input");
	NecrosisPetMenu0:SetAttribute("delaystatemap-anchor", "0");
	NecrosisPetMenu0:SetAttribute("delaytimemap-anchor", "8");
	NecrosisPetMenu0:SetAttribute("delayhovermap-anchor", "true");

	NecrosisPetMenuButton:SetAttribute("onmouseupbutton", "mup");
	NecrosisPetMenuButton:SetAttribute("onmousedownbutton", "mdn");
	NecrosisPetMenuButton:SetAttribute("*anchorchild-mdn", NecrosisPetMenu0);
	NecrosisPetMenuButton:SetAttribute("*childofsx-mdn", 0);
	NecrosisPetMenuButton:SetAttribute("*childofsy-mdn", 0);
	NecrosisPetMenuButton:SetAttribute("*childpoint-mdn", "CENTER");
	NecrosisPetMenuButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	NecrosisPetMenuButton:SetAttribute("*childstate-mdn", "^mousedown");
	NecrosisPetMenuButton:SetAttribute("*childreparent-mdn", "true");

	NecrosisPetMenuButton:SetAttribute("*anchorchild-mup", NecrosisPetMenu0);
	NecrosisPetMenuButton:SetAttribute("*childstate-mup", "mouseup");
	NecrosisPetMenuButton:SetAttribute("*childverify-mup", true);

	NecrosisPetMenu0:SetAttribute("state", 0)

	NecrosisPetMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	NecrosisPetMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	NecrosisPetMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	NecrosisPetMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	NecrosisPetMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");
	end

	if  _G["NecrosisCurseMenuButton"] then
	-- D�claration s�curis�e du bouton des mal�dictions
	NecrosisCurseMenuButton:SetAttribute("*childraise*", true);

	NecrosisCurseMenu0:SetAttribute("statemap-anchor", "$input");
	NecrosisCurseMenu0:SetAttribute("delaystatemap-anchor", "0");
	NecrosisCurseMenu0:SetAttribute("delaytimemap-anchor", "8");
	NecrosisCurseMenu0:SetAttribute("delayhovermap-anchor", "true");

	NecrosisCurseMenuButton:SetAttribute("onmouseupbutton", "mup");
	NecrosisCurseMenuButton:SetAttribute("onmousedownbutton", "mdn");
	NecrosisCurseMenuButton:SetAttribute("*anchorchild-mdn", NecrosisCurseMenu0);
	NecrosisCurseMenuButton:SetAttribute("*childofsx-mdn", 0);
	NecrosisCurseMenuButton:SetAttribute("*childofsy-mdn", 0);
	NecrosisCurseMenuButton:SetAttribute("*childpoint-mdn", "CENTER");
	NecrosisCurseMenuButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	NecrosisCurseMenuButton:SetAttribute("*childstate-mdn", "^mousedown");
	NecrosisCurseMenuButton:SetAttribute("*childreparent-mdn", "true");

	NecrosisCurseMenuButton:SetAttribute("*anchorchild-mup", NecrosisCurseMenu0);
	NecrosisCurseMenuButton:SetAttribute("*childstate-mup", "mouseup");
	NecrosisCurseMenuButton:SetAttribute("*childverify-mup", true);

	NecrosisCurseMenu0:SetAttribute("state", 0)

	NecrosisCurseMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	NecrosisCurseMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	NecrosisCurseMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	NecrosisCurseMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	NecrosisCurseMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");
	end
end


------------------------------------------------------------------------------------------------------
-- DEFINITION INITIALE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

-- On associe les buffs au clic sur le bouton concern�
function Necrosis_BuffSpellAttribute()

	-- Association de l'armure demoniaque si le sort est disponible
	NecrosisBuffMenu1:SetAttribute("type", "spell");
	if not NECROSIS_SPELL_TABLE[31].ID then
		NecrosisBuffMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[36].Name.."("..NECROSIS_SPELL_TABLE[36].Rank..")");
	else
		NecrosisBuffMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[31].Name.."("..NECROSIS_SPELL_TABLE[31].Rank..")");
	end


	-- Association des autres buffs aux boutons
	local buffID = {31, 32, 33, 34, 37, 39, 38, 43, 9, 47, 35};
	for i = 2, #buffID, 1 do
		local f = _G["NecrosisBuffMenu"..i];
		f:SetAttribute("type", "spell");
		-- Si le sort n�cessite une cible, on lui en associe une
		if not (i == 4 or i == 6 or i == 7 or i == 8) then
			f:SetAttribute("unit", "target");
		end
		f:SetAttribute("spell", NECROSIS_SPELL_TABLE[ buffID[i] ].Name.."("..NECROSIS_SPELL_TABLE[ buffID[i] ].Rank..")");
		-- Cr�ation du tableau des raccourcis claviers
		table.insert(
			NecrosisBinding,
			{NECROSIS_SPELL_TABLE[ buffID[i] ].Name, "CLICK NecrosisBuffMenu"..i..":LeftButton"}
		);
	end


	-- Cas particulier : Si le d�moniste poss�de le Banish rang 2, on associe le rang 1 au clic droit
	if string.find(NECROSIS_SPELL_TABLE[9].Rank, "2") then
		NecrosisBuffMenu9:SetAttribute("type1", "spell");
		NecrosisBuffMenu9:SetAttribute("spell1", NECROSIS_SPELL_TABLE[9].Name.."("..NECROSIS_SPELL_TABLE[9].Rank..")");
		NecrosisBuffMenu9:SetAttribute("type2", "spell");
		NecrosisBuffMenu9:SetAttribute("spell2", NECROSIS_SPELL_TABLE[9].Name.."("..string.gsub(NECROSIS_SPELL_TABLE[9].Rank, "2", "1")..")");
		table.insert(
			NecrosisBinding,
			{NECROSIS_SPELL_TABLE[9].Name, "CLICK NecrosisBuffMenu9:LeftButton"}
		);
		table.insert(
			NecrosisBinding,
			{NECROSIS_SPELL_TABLE[9].Name.." Rank 1", "CLICK NecrosisBuffMenu9:RightButton"}
		);
	end
end

-- On associe les d�mons au clic sur le bouton concern�
function Necrosis_PetSpellAttribute()

	-- D�mons maitris�s
	local buttonID = {2, 3, 4, 5, 10};
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]];
		f:SetAttribute("type1", "spell");
		f:SetAttribute("type2", "macro");
		f:SetAttribute("spell", NECROSIS_SPELL_TABLE[i+2].Name.."("..NECROSIS_SPELL_TABLE[i+2].Rank..")");
		f:SetAttribute("macrotext", "/cast "..NECROSIS_SPELL_TABLE[15].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[i+2].Name.."("..NECROSIS_SPELL_TABLE[i+2].Rank..")");
	end

	-- Autres sorts d�moniaques
	local buttonID = {1, 6, 7, 8, 9};
	local BuffID = {15, 8, 30, 35, 44};
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisPetMenu"..buttonID[i]];
		f:SetAttribute("type", "spell");
		f:SetAttribute("spell", NECROSIS_SPELL_TABLE[ BuffID[i] ].Name.."("..NECROSIS_SPELL_TABLE[ BuffID[i] ].Rank..")");
	end
end

-- On associe les mal�dictions au clic sur le bouton concern�
function Necrosis_CurseSpellAttribute()

	-- Mal�diction amplifi�e
	NecrosisCurseMenu1:SetAttribute("type", "spell");
	NecrosisCurseMenu1:SetAttribute("spell", NECROSIS_SPELL_TABLE[42].Name);

	-- Mal�dictions amplifiables
	local buttonID = {2, 3, 6};
	local buffID = {23, 22, 40};
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisCurseMenu"..buttonID[i]];
		f:SetAttribute("harmbutton1", "debuff");
		f:SetAttribute("type-debuff", "spell");
		f:SetAttribute("unit", "target");
		f:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[ buffID[i] ].Name.."("..NECROSIS_SPELL_TABLE[ buffID[i] ].Rank..")");
		f:SetAttribute("harmbutton2", "amplif");
		f:SetAttribute("type-amplif", "macro");
		f:SetAttribute("macrotext-amplif", "/cast "..NECROSIS_SPELL_TABLE[42].Name.."\n/stopcasting\n/cast "..NECROSIS_SPELL_TABLE[ buffID[i] ].Name.."("..NECROSIS_SPELL_TABLE[ buffID[i] ].Rank..")");
	end

	-- Autres mal�dictions
	local buttonID = {4, 5, 7, 8, 9};
	local buffID = {24,25,26,27,16};
	for i = 1, #buttonID, 1 do
		local f = _G["NecrosisCurseMenu"..buttonID[i]];
		f:SetAttribute("harmbutton", "debuff");
		f:SetAttribute("type-debuff", "spell");
		f:SetAttribute("unit", "target");
		f:SetAttribute("spell-debuff", NECROSIS_SPELL_TABLE[ buffID[i] ].Name.."("..NECROSIS_SPELL_TABLE[ buffID[i] ].Rank..")");
	end
end

-- Association de la monture au bouton, et de la cr�ation des pierres sur un clic droit
function Necrosis_StoneAttribute(StoneIDInSpellTable, Steed)

	-- Pour les pierres
	local itemName = {"Soulstone", "Healthstone", "Spellstone", "Firestone" };
	for i = 1, #StoneIDInSpellTable, 1 do
		local f = _G["Necrosis"..itemName[i].."Button"];
		if f then
			f:SetAttribute("type2", "spell");
			f:SetAttribute("spell2", NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Name.."("..NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Rank..")");

			-- On pr�pare le tableau des raccourcis claviers
			table.insert(
				NecrosisBinding,
				{NECROSIS_SPELL_TABLE[ StoneIDInSpellTable[i] ].Name, "CLICK Necrosis"..itemName[i].."Button:RightButton"}
			);
			table.insert(
				NecrosisBinding,
				{NECROSIS_ITEM[ itemName[i] ], "CLICK Necrosis"..itemName[i].."Button:LeftButton"}
			);
		end
	end

	-- Pour la monture
	if Steed and  _G["NecrosisMountButton"] then
		NecrosisMountButton:SetAttribute("type1", "spell");
		NecrosisMountButton:SetAttribute("type2", "spell");
		-- Si le d�moniste poss�de une monture �pique, on associe la monture classique au clic droit
		if NECROSIS_SPELL_TABLE[2].ID then
			NecrosisMountButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[2].Name.."("..NECROSIS_SPELL_TABLE[2].Rank..")");
			NecrosisMountButton:SetAttribute("spell2", NECROSIS_SPELL_TABLE[1].Name.."("..NECROSIS_SPELL_TABLE[2].Rank..")");

		else
			NecrosisMountButton:SetAttribute("spell*", NECROSIS_SPELL_TABLE[1].Name.."("..NECROSIS_SPELL_TABLE[1].Rank..")");
		end
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[2].Name, "CLICK NecrosisMountButton:LeftButton"});
	end

	-- Pour la pierre de foyer
	NecrosisSpellTimerButton:SetAttribute("type", "item");
	NecrosisSpellTimerButton:SetAttribute("item", NECROSIS_ITEM.Hearthstone);

	-- Cas particulier : Si le sort du Rituel des �mes existe, on l'associe au shift+clic healthstone.
	if Healthstone and NECROSIS_SPELL_TABLE[50].ID then
		NecrosisHealthstoneButton:SetAttribute("shift-type*", "spell");
		NecrosisHealthstoneButton:SetAttribute("shift-spell*", NECROSIS_SPELL_TABLE[50].Name);
	end
end

-- Association de la Connexion au bouton central si le sort est disponible
function Necrosis_MainButtonAttribute()

	-- Le clic droit ouvre le Menu des options
	NecrosisButton:SetAttribute("type2", "macro");
	NecrosisButton:SetAttribute("macrotext2", "/necro");

	if NECROSIS_SPELL_TABLE[41].ID then
		NecrosisButton:SetAttribute("type1", "spell");
		NecrosisButton:SetAttribute("spell", NECROSIS_SPELL_TABLE[41].Name.."("..NECROSIS_SPELL_TABLE[41].Rank..")");
		table.insert(NecrosisBinding, {NECROSIS_SPELL_TABLE[41].Name, "CLICK NecrosisButton:LeftButton"});
	end
end


------------------------------------------------------------------------------------------------------
-- DEFINITION DES ATTRIBUTS DES SORTS EN FONCTION DU COMBAT / REGEN
------------------------------------------------------------------------------------------------------

function Necrosis_NoCombatAttribute(SoulstoneMode, FirestoneMode, SpellstoneMode, StoneIDInSpellTable)

	-- Si la pierre de sort est �quip�e, et qu'on connait une baguette,
	-- Alors cliquer milieu sur la pierre de sort �quipe la baguette.
	if SpellstoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	-- Sinon, si la pierre de feu est �quip�e, et qu'on connait une baguette,
	-- Alors cliquer sur la pierre de feu �quipe la baguette
	elseif FirestoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	else
		-- Si on connait l'emplacement de la pierre de sort,
		-- Alors cliquer sur le bouton de pierre de sort l'�quipe.
		if NecrosisConfig.ItemSwitchCombat[1] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		end
		-- Si on connait l'emplacement de la pierre de feu,
		-- Alors cliquer sur le bouton de pierre de feu l'�quipe.
		if NecrosisConfig.ItemSwitchCombat[2] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		end
	end
end

function Necrosis_InCombatAttribute()

	-- Si on connait le nom de la pierre de sort,
	-- Alors le clic gauche utiliser la pierre
	-- Alors le clic milieu sur le bouton �quipera la pierre
	if NecrosisConfig.ItemSwitchCombat[1] then
		NecrosisSpellstoneButton:SetAttribute("type1", "item");
		NecrosisSpellstoneButton:SetAttribute("item", NecrosisConfig.ItemSwitchCombat[1]);
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
	end

	-- Si on connait le nom de la pierre de feu,
	-- Alors le clic sur le bouton �quipera la pierre
	if NecrosisConfig.ItemSwitchCombat[2] then
		NecrosisFirestoneButton:SetAttribute("type1", "macro");
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
	end

	-- Si on connait le nom de la pierre de soin,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[4] then
		NecrosisHealthstoneButton:SetAttribute("type1", "macro");
		NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[4]);
	end

	-- Si on connait le nom de la pierre d'�me,
	-- Alors le clic gauche sur le bouton utilisera la pierre
	if NecrosisConfig.ItemSwitchCombat[5] then
		NecrosisSoulstoneButton:SetAttribute("type1", "item");
		NecrosisSoulstoneButton:SetAttribute("unit", "target");
		NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[5]);
	end
end

------------------------------------------------------------------------------------------------------
-- DEFINITION SITUATIONNELLE DES ATTRIBUTS DES SORTS
------------------------------------------------------------------------------------------------------

function Necrosis_SoulstoneUpdateAttribute(nostone)
	-- Si le d�moniste est en combat, on ne fait rien :)
	if ( InCombatLockdown() ) then
		return
	end

	-- Si le d�moniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche cr�e la pierre
	if nostone then
		NecrosisSoulstoneButton:SetAttribute("type1", "spell");
		NecrosisSoulstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[1]].Name.."("..NECROSIS_SPELL_TABLE[nostone[1]].Rank..")");
		return
	end

	NecrosisSoulstoneButton:SetAttribute("type1", "item");
	NecrosisSoulstoneButton:SetAttribute("type3", "item");
	NecrosisSoulstoneButton:SetAttribute("unit", "target");
	NecrosisSoulstoneButton:SetAttribute("item1", NecrosisConfig.ItemSwitchCombat[5]);
	NecrosisSoulstoneButton:SetAttribute("item3", NecrosisConfig.ItemSwitchCombat[5]);
end

function Necrosis_HealthstoneUpdateAttribute(nostone)
	-- Si le d�moniste est en combat, on ne fait rien :)
	if ( InCombatLockdown() ) then
		return
	end

	-- Si le d�moniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche cr�e la pierre
	if nostone then
		NecrosisHealthstoneButton:SetAttribute("type1", "spell");
		NecrosisHealthstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[2]].Name.."("..NECROSIS_SPELL_TABLE[nostone[2]].Rank..")");
		return
	end

	NecrosisHealthstoneButton:SetAttribute("type1", "macro");
	NecrosisHealthstoneButton:SetAttribute("macrotext1", "/stopcasting \n/use "..NecrosisConfig.ItemSwitchCombat[4]);
	NecrosisHealthstoneButton:SetAttribute("type3", "Trade");
	NecrosisHealthstoneButton:SetAttribute("ctrl-type1", "Trade");
	NecrosisHealthstoneButton.Trade = function () Necrosis_TradeStone(); end
end

function Necrosis_SpellstoneUpdateAttribute(nostone)
	-- Si le d�moniste est en combat, on ne fait rien :)
	if ( InCombatLockdown() ) then
		return
	end

	-- Si le d�moniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche cr�e la pierre
	if nostone then
		NecrosisSpellstoneButton:SetAttribute("type1", "spell");
		NecrosisSpellstoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[3]].Name.."("..NECROSIS_SPELL_TABLE[nostone[3]].Rank..")");
		return
	end

	NecrosisSpellstoneButton:SetAttribute("type1", "item");
	NecrosisSpellstoneButton:SetAttribute("item", NecrosisConfig.ItemSwitchCombat[1]);
	NecrosisSpellstoneButton:SetAttribute("ctrl-type1", "macro");
	NecrosisSpellstoneButton:SetAttribute("shift-type1", "macro");
	NecrosisSpellstoneButton:SetAttribute("type3", "macro");
	NecrosisSpellstoneButton:SetAttribute("macrotext3", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
	NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
	if NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisSpellstoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	end
end

function Necrosis_FirestoneUpdateAttribute(nostone)
	-- Si le d�moniste est en combat, on ne fait rien :)
	if ( InCombatLockdown() ) then
		return
	end

	-- Si le d�moniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche cr�e la pierre
	if nostone then
		NecrosisFirestoneButton:SetAttribute("type1", "spell");
		NecrosisFirestoneButton:SetAttribute("spell1", NECROSIS_SPELL_TABLE[nostone[4]].Name.."("..NECROSIS_SPELL_TABLE[nostone[4]].Rank..")");
		return
	end

	NecrosisFirestoneButton:SetAttribute("ctrl-type1", "macro");
	NecrosisFirestoneButton:SetAttribute("shift-type1", "macro");
	NecrosisFirestoneButton:SetAttribute("type1", "macro");
	NecrosisFirestoneButton:SetAttribute("type3", "macro");
	NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
	NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
	if NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisFirestoneButton:SetAttribute("shift-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	end
end

function Necrosis_RangedUpdateAttribute()
	-- Si le d�moniste est en combat, on ne fait rien :)
	if ( InCombatLockdown() ) then
		return
	end

	-- Si le d�moniste a une baguette d'�quip�e
	if IsEquippedItemType("Wand") then
		-- Si on connait la pierre de sort,
		-- Alors le bouton du milieu �quipe la pierre de sort
		if NecrosisConfig.ItemSwitchCombat[1] then
			NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[1]);
			NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[1]);
		end
		-- Si on connait la pierre de feu,
		-- Alors cliquer �quipe la pierre de feu
		if NecrosisConfig.ItemSwitchCombat[2] then
			NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
			NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[2]);
		end
	-- Sinon, si le d�moniste � une pierre de sort d'�quip�e et qu'on connait une baguette,
	-- Cliquer milieu r��quipe la baguette
	elseif SpellstoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisSpellstoneButton:SetAttribute("macrotext3","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		NecrosisSpellstoneButton:SetAttribute("ctrl-macrotext1","/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	-- Sinon, si le d�moniste a une pierre de feu d'�quip�e et qu'on connait une baguette,
	-- Cliquer r��quipe la baguette
	elseif FirestoneMode == 3 and NecrosisConfig.ItemSwitchCombat[3] then
		NecrosisFirestoneButton:SetAttribute("macrotext*", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
		NecrosisFirestoneButton:SetAttribute("ctrl-macrotext1", "/equip "..NecrosisConfig.ItemSwitchCombat[3]);
	end
end