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
-- Version Allemande par Geschan
-- Remerciements spéciaux pour Tilienna, Sadyre (JoL) et Aspy
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------


-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE DES TIMERS NON GRAPHIQUES
------------------------------------------------------------------------------------------------------

-- Permet l'affichage du timer de rez dans la Sphere
function Necrosis:RezTimerUpdate(SpellTimer, LastUpdate)
	local Time, TimeMax, Minutes, Secondes
	for index, valeur in ipairs(SpellTimer) do
		if valeur.Name == NECROSIS_SPELL_TABLE[11].Name then
			Time = valeur.Time
			TimeMax = valeur.TimeMax
			break
		end
	end
	if not Time then
		NecrosisShardCount:SetText("???")
		NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Shard")
		return LastUpdate
	end

	Secondes = TimeMax - floor(GetTime())
	Minutes = floor(Secondes/60)
	Secondes = mod(Secondes, 60)

	-- Le timer numérique
	if NecrosisConfig.CountType == 3 then
		if (Minutes > 0) then
			NecrosisShardCount:SetText(Minutes.." m")
		else
			NecrosisShardCount:SetText(Secondes)
		end
	end
	-- Le timer graphique
	if NecrosisConfig.Circle == 2 then
		if (Minutes >= 16) and not (LastUpdate == Minutes - 15) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Turquoise\\Shard"..Minutes - 15)
			LastUpdate = Minutes - 15
		elseif (Minutes >= 1 or Secondes >= 33) and not (LastUpdate == Minutes + 1) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Orange\\Shard"..Minutes + 1);
		elseif not (LastUpdate == Secondes) then
			NecrosisButton:SetNormalTexture("Interface\\AddOns\\Necrosis\\UI\\Rose\\Shard"..Secondes);
		end
	end

	return LastUpdate
end

-- Permet l'affichage des timers textuels
function Necrosis:TextTimerUpdate(SpellTimer, SpellGroup)
	if not (NecrosisConfig.Textual and SpellTimer[1]) then
		if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
		return
	end

	local Now = floor(GetTime())
	local minutes = 0
	local seconds = 0
	local display = ""

	local LastGroup = 0

	for index in ipairs(SpellTimer) do
		-- Changement de la couleur suivant le temps restant
		local percent = (floor(SpellTimer[index].TimeMax - Now) / SpellTimer[index].Time)*100
		local color = NecrosisTimerColor(percent)

		-- Affichage de l'entête si on change de groupe
		if not (SpellTimer[index].Group == LastGroup) and SpellTimer[index].Group > 3 then
			if SpellTimer[index].Group and SpellGroup[SpellTimer[index].Group] then
				display = display.."<purple>-------------------------------\n"
				display = display..SpellGroup[SpellTimer[index].Group].Name
				display = display.." - "
				display = display..SpellGroup[SpellTimer[index].Group].SubName
				display = display.."\n-------------------------------<close>\n<white>"
			end
			LastGroup = SpellTimer[index].Group
		end

		-- Affichage du temps restant
		seconds = SpellTimer[index].TimeMax - Now
		minutes = floor(seconds/60);
		seconds = mod(seconds, 60)
		if (minutes > 0) then
			if (minutes > 9) then
				display = display..minutes..":"
			else
				display = display.."0"..minutes..":"
			end
		else
			display = display.."0:"
		end
		if (seconds > 9) then
			display = display..seconds
		else
			display = display.."0"..seconds
		end
		display = display.." - <close>"..color..SpellTimer[index].Name.."<close>"
		if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == NECROSIS_SPELL_TABLE[16].Name)
			and not (SpellTimer[index].Target == "")
			then
				display = display.."<white> - "..SpellTimer[index].Target.."<close>\n";
		else
			display = display.."\n";
		end
	end
	display = self:MsgAddColor(display)
	NecrosisListSpells:SetText(display)
end