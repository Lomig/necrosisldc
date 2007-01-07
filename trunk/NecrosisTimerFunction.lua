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
-- Version 04.12.2006-1
------------------------------------------------------------------------------------------------------


-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- FONCTIONS D'INSERTION
------------------------------------------------------------------------------------------------------

-- La table des timers est là pour ça !
function Necrosis_InsertTimerParTable(IndexTable, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)
	-- Insertion de l'entrée dans le tableau
	table.insert(SpellTimer,
		{
			Name = NECROSIS_SPELL_TABLE[IndexTable].Name,
			Time = NECROSIS_SPELL_TABLE[IndexTable].Length,
			TimeMax = floor(GetTime() + NECROSIS_SPELL_TABLE[IndexTable].Length),
			Type = NECROSIS_SPELL_TABLE[IndexTable].Type,
			Target = Target,
			TargetLevel = LevelTarget,
			Group = 0,
			Gtimer = nil
		}
	)

	-- Association d'un timer graphique au timer
	-- Si il y a une frame timer de libérée, on l'associe au timer
	local TimerLibre = nil
	for index, valeur in ipairs(TimerTable) do
		if not valeur then
			TimerLibre = index
			TimerTable[index] = true
			break
		end
	end
	-- Si il n'y a pas de frame de libérée, on rajoute une frame
	if not TimerLibre then
		table.insert(TimerTable, true)
		TimerLibre = #TimerTable
	end
	-- Association effective au timer
	SpellTimer[#SpellTimer].Gtimer = TimerLibre
	local FontString, StatusBar = Necrosis_AddFrame("NecrosisTimerFrame"..TimerLibre)
	FontString:SetText(SpellTimer[#SpellTimer].Name)
	StatusBar:SetMinMaxValues(SpellTimer[#SpellTimer].TimeMax - SpellTimer[#SpellTimer].Time, SpellTimer[#SpellTimer].TimeMax)

	-- Tri des entrées par type de sort
	Necrosis_Tri(SpellTimer, "Type")

	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer)

	-- On met à jour l'affichage
	NecrosisUpdateTimer(SpellTimer, SpellGroup)

	return SpellGroup, SpellTimer, TimerTable
end

-- Et pour insérer le timer de pierres
function Necrosis_InsertTimerStone(Stone, start, duration, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entrée dans le tableau
	if Stone == "Healthstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_COOLDOWN.Healthstone,
				Time = 180,
				TimeMax = floor(GetTime() + 180),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			}
		)
	elseif Stone == "SpellstoneIn" then
		if Necrosis_TimerExisteDeja(NECROSIS_COOLDOWN.Spellstone, SpellTimer) then
			return SpellGroup, SpellTimer, TimerTable
		end
		if Necrosis_TimerExisteDeja(NECROSIS_COOLDOWN.SpellstoneIn, SpellTimer) then
			Necrosis_RetraitTimerParNom(NECROSIS_COOLDOWN.SpellstoneIn, SpellTimer, TimerTable)
		end
		table.insert(SpellTimer,
			{
				Name = NECROSIS_COOLDOWN.SpellstoneIn,
				Time = 30,
				TimeMax = floor(GetTime() + 30),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			}
		)
	elseif Stone == "Spellstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_COOLDOWN.Spellstone,
				Time = 180,
				TimeMax = floor(GetTime() + 180),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			}
		)
	elseif Stone == "Soulstone" then
		table.insert(SpellTimer,
			{
				Name = NECROSIS_SPELL_TABLE[11].Name,
				Time = floor(duration - GetTime() + start),
				TimeMax = floor(start + duration),
				Type = NECROSIS_SPELL_TABLE[11].Type,
				Target = "???",
				TargetLevel = "",
				Group = 1,
				Gtimer = nil,
			}
		)
	end

	-- Association d'un timer graphique au timer
	-- Si il y a une frame timer de libérée, on l'associe au timer
	local TimerLibre = nil
	for index, valeur in ipairs(TimerTable) do
		if not valeur then
			TimerLibre = index
			TimerTable[index] = true
			break
		end
	end
	-- Si il n'y a pas de frame de libérée, on rajoute une frame
	if not TimerLibre then
		table.insert(TimerTable, true)
		TimerLibre = #TimerTable
	end
	-- Association effective au timer
	SpellTimer[#SpellTimer].Gtimer = TimerLibre
	local FontString, StatusBar = Necrosis_AddFrame("NecrosisTimerFrame"..TimerLibre)
	FontString:SetText(SpellTimer[#SpellTimer].Name)
	StatusBar:SetMinMaxValues(SpellTimer[#SpellTimer].TimeMax - SpellTimer[#SpellTimer].Time, SpellTimer[#SpellTimer].TimeMax)

	-- Tri des entrées par type de sort
	Necrosis_Tri(SpellTimer, "Type")

	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer)

	-- On met à jour l'affichage
	NecrosisUpdateTimer(SpellTimer, SpellGroup)

	return SpellGroup, SpellTimer, TimerTable
end

-- Pour la création de timers personnels
function NecrosisTimerX(nom, duree, truc, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)

	table.insert(SpellTimer,
		{
			Name = nom,
			Time = duree,
			TimeMax = floor(GetTime() + duree),
			Type = truc,
			Target = Target,
			TargetLevel = LevelTarget,
			Group = 0,
			Gtimer = nil
		}
	)

	-- Association d'un timer graphique au timer
	-- Si il y a une frame timer de libérée, on l'associe au timer
	local TimerLibre = nil
	for index, valeur in ipairs(TimerTable) do
		if not valeur then
			TimerLibre = index
			TimerTable[index] = true
			break
		end
	end
	-- Si il n'y a pas de frame de libérée, on rajoute une frame
	if not TimerLibre then
		table.insert(TimerTable, true)
		TimerLibre = #TimerTable
	end
	-- Association effective au timer
	SpellTimer[#SpellTimer].Gtimer = TimerLibre
	local FontString, StatusBar = Necrosis_AddFrame("NecrosisTimerFrame"..TimerLibre)
	FontString:SetText(SpellTimer[#SpellTimer].Name)
	StatusBar:SetMinMaxValues(SpellTimer[#SpellTimer].TimeMax - SpellTimer[#SpellTimer].Time, SpellTimer[#SpellTimer].TimeMax)


	-- Tri des entrées par type de sort
	Necrosis_Tri(SpellTimer, "Type")

	-- Création des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Necrosis_Parsing(SpellGroup, SpellTimer)

	-- On met à jour l'affichage
	NecrosisUpdateTimer(SpellTimer, SpellGroup)

	return SpellGroup, SpellTimer, TimerTable
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE RETRAIT
------------------------------------------------------------------------------------------------------

-- Connaissant l'index du Timer dans la liste, on le supprime
function Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable, SpellGroup)
	-- Suppression du timer graphique
	TimerTable[SpellTimer[index].Gtimer] = false
	_G["NecrosisTimerFrame"..SpellTimer[index].Gtimer]:Hide()

	-- Suppression du timer du groupe de mob
	if SpellGroup.Visible[SpellTimer[index].Group] then
		SpellGroup.Visible[SpellTimer[index].Group] = SpellGroup.Visible[SpellTimer[index].Group] - 1
		-- On cache la Frame des groupes si elle est vide
		if SpellGroup.Visible[SpellTimer[index].Group] <= 0 then
			local frameGroup = _G["NecrosisSpellTimer"..SpellTimer[index].Group]
			if frameGroup then frameGroup:Hide() end
		end
	elseif _G["NecrosisSpellTimer"..SpellTimer[index].Group] then
		_G["NecrosisSpellTimer"..SpellTimer[index].Group]:Hide()
	end

	-- On enlève le timer de la liste
	table.remove(SpellTimer, index)

	-- On met à jour l'affichage
	NecrosisUpdateTimer(SpellTimer, SpellGroup)

	return SpellTimer, TimerTable, SpellGroup
end

-- Si on veut supprimer spécifiquement un Timer...
function Necrosis_RetraitTimerParNom(name, SpellTimer, TimerTable, SpellGroup)
	for index = 1, #SpellTimer, 1 do
		if SpellTimer[index].Name == name then
			SpellTimer, TimerTable, SpellGroup = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable, SpellGroup)
			break
		end
	end
	return SpellTimer, TimerTable, SpellGroup
end

-- Fonction pour enlever les timers de combat lors de la regen
function Necrosis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable)
	for index = 1, #SpellTimer, 1 do
		if SpellTimer[index] then
			-- Si les cooldowns sont nominatifs, on enlève le nom
			if SpellTimer[index].Type == 3 then
				SpellTimer[index].Target = ""
				SpellTimer[index].TargetLevel = ""
			end
			-- Enlevage des timers de combat
			if ((SpellTimer[index].Type == 4) or (SpellTimer[index].Type == 5)) then
				SpellTimer, TimerTable, SpellGroup = Necrosis_RetraitTimerParIndex(index, SpellTimer, TimerTable, SpellGroup)
			end
		end
	end

	if #SpellGroup.Name >= 4 then
		for index = 4, #SpellGroup.Name, 1 do
			_G["NecrosisSpellTimer"..index]:Hide()
			table.remove(SpellGroup.Name)
			table.remove(SpellGroup.SubName)
			table.remove(SpellGroup.Visible)
		end
	end
	return SpellGroup, SpellTimer, TimerTable
end



------------------------------------------------------------------------------------------------------
-- FONCTIONS BOOLEENNES
------------------------------------------------------------------------------------------------------

function Necrosis_TimerExisteDeja(Nom, SpellTimer)
	for index = 1, table.getn(SpellTimer), 1 do
		if SpellTimer[index].Name == Nom then
			return true;
		end
	end
	return false;
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS DE TRI
------------------------------------------------------------------------------------------------------

-- On définit les groupes de chaque Timer
function Necrosis_Parsing(SpellGroup, SpellTimer)
	for index = 1, #SpellTimer, 1 do
		if SpellTimer[index].Group == 0 then
			local GroupeOK = false
			for i = 1, #SpellGroup.Name, 1 do
				if ((SpellTimer[index].Type == i) and (i <= 3)) or
				   (SpellTimer[index].Target == SpellGroup.Name[i]
					and SpellTimer[index].TargetLevel == SpellGroup.SubName[i])
					then
					GroupeOK = true
					SpellTimer[index].Group = i
					SpellGroup.Visible[i] = SpellGroup.Visible[i] + 1
					break
				end
			end
			-- Si le groupe n'existe pas, on en crée un nouveau
			if not GroupeOK then
				table.insert(SpellGroup.Name, SpellTimer[index].Target)
				table.insert(SpellGroup.SubName, SpellTimer[index].TargetLevel)
				table.insert(SpellGroup.Visible, 1)
				SpellTimer[index].Group = #SpellGroup.Name
			end
		end
	end

	Necrosis_Tri(SpellTimer, "Group")
	return SpellGroup, SpellTimer
end

-- On trie les timers selon leur groupe
function Necrosis_Tri(SpellTimer, clef)
	return table.sort(SpellTimer,
		function (SubTab1, SubTab2)
			return SubTab1[clef] < SubTab2[clef]
		end)
end
