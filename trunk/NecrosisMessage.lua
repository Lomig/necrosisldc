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
-- Version 09.12.2006-1
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE (CONSOLE, CHAT, MESSAGE SYSTEME)
------------------------------------------------------------------------------------------------------

function Necrosis_Msg(msg, type)
	if msg then
		-- Si le type du message est "WORLD", le message sera envoyé en raid, à défaut en groupe, et à défaut en chat local
		if (type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID");
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY");
			else
				SendChatMessage(msg, "SAY");
			end
		-- Si le type du message est "PARTY", le message sera envoyé en groupe
		elseif (type == "PARTY") then
			SendChatMessage(msg, "PARTY");
		-- Si le type du message est "RAID", le message sera envoyé en raid
		elseif (type == "RAID") then
			SendChatMessage(msg, "RAID");
		elseif (type == "SAY") then
		-- Si le type du message est "SAY", le message sera envoyé en chat local
			SendChatMessage(msg, "SAY");
		elseif (type == "EMOTE") then
		-- Si le type du message est "EMOTE", le message sera envoyé en /e
			SendChatMessage(msg, "EMOTE");
		elseif (type == "YELL") then
		-- Si le type du message est "YELL", le message sera envoyé en /y
			SendChatMessage(msg, "YELL");
		else
			-- On colorise astucieusement notre message :D
			msg = Necrosis_MsgAddColor(msg);
			local Intro = "|CFFFF00FFNe|CFFFF50FFcr|CFFFF99FFos|CFFFFC4FFis|CFFFFFFFF: ";
			if NecrosisConfig.ChatType then
				-- ...... sur la première fenêtre de chat
				ChatFrame1:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME);
			else
				-- ...... ou au milieu de l'écran
				UIErrorsFrame:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME);
			end
		end
	end
end


------------------------------------------------------------------------------------------------------
-- ... ET LE COLORAMA FUT !
------------------------------------------------------------------------------------------------------

-- Remplace dans les chaines les codes de coloration par les définitions de couleur associées
function Necrosis_MsgAddColor(msg)
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
	msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00");
	msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66");
	msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66");
	msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66");
	msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66");
	msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00");
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
	msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933");
	msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600");
	msg = string.gsub(msg, "<redOrange>", "|CFFFF3300");
	msg = string.gsub(msg, "<red>", "|CFFFF0000");
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
	msg = string.gsub(msg, "<close>", "|r");
	return msg;
end


-- Insère dans les timers des codes de coloration en fonction du pourcentage de temps restant
function NecrosisTimerColor(percent)
	local color = "<brightGreen>";
	if (percent < 10) then
		color = "<red>";
	elseif (percent < 20) then
		color = "<redOrange>";
	elseif (percent < 30) then
		color = "<darkOrange>";
	elseif (percent < 40) then
		color = "<dirtyOrange>";
	elseif (percent < 50) then
		color = "<darkYellow>";
	elseif (percent < 60) then
		color = "<lightYellow>";
	elseif (percent < 70) then
		color = "<yellowGreen>";
	elseif (percent < 80) then
		color = "<lightGreen1>";
	elseif (percent < 90) then
		color = "<lightGreen2>";
	end
	return color;
end

------------------------------------------------------------------------------------------------------
-- VARIABLES USER-FRIENDLY DANS LES MESSAGES D'INVOCATION
------------------------------------------------------------------------------------------------------

function Necrosis_MsgReplace(msg, target, pet)
	msg = string.gsub(msg, "<player>", UnitName("player"));
	msg = string.gsub(msg, "<emote>", "");
	msg = string.gsub(msg, "<after>", "");
	msg = string.gsub(msg, "<sacrifice>", "");
	msg = string.gsub(msg, "<yell>", "");
	if target then
		msg = string.gsub(msg, "<target>", target);
	end
	if pet then
		msg = string.gsub(msg, "<pet>", NecrosisConfig.PetName[pet]);
	end
	return msg;
end

------------------------------------------------------------------------------------------------------
-- FONCTION D'AFFICHAGE DES MESSAGES EN COURS DE CAST
------------------------------------------------------------------------------------------------------

function  Necrosis_Speech_It(SpellCastName, SpellTargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess)
	-- Affichage des messages d'invocation de monture
	if (SpellCastName == NECROSIS_SPELL_TABLE[1].Name or SpellCastName == NECROSIS_SPELL_TABLE[2].Name) then
		SteedSummoned = {};
		if NecrosisConfig.SteedSummon and NecrosisConfig.ChatMsg and NECROSIS_PET_MESSAGE[7] and not NecrosisConfig.SM then
			local tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[7]));
			while tempnum == SteedMess and table.getn(NECROSIS_PET_MESSAGE[7]) >= 2 do
				tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[7]));
			end
			SteedMess = tempnum;
			for i = 1, table.getn(NECROSIS_PET_MESSAGE[7][tempnum]) do
				if string.find(NECROSIS_PET_MESSAGE[7][tempnum][i], "<after>") then
					table.insert(SteedSummoned, NECROSIS_PET_MESSAGE[7][tempnum][i]);
				elseif string.find(NECROSIS_PET_MESSAGE[7][tempnum][i], "<emote>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[7][tempnum][i]), "EMOTE");
				elseif string.find(NECROSIS_PET_MESSAGE[7][tempnum][i], "<yell>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[7][tempnum][i]), "YELL");
				else
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[7][tempnum][i]), "SAY");
				end
			end
		end
	-- Affichage des messages de rez
	elseif SpellCastName == NECROSIS_SPELL_TABLE[11].Name and SpellTargetName ~= UnitName("player") then
		PlayerSoulstoned = {};
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and NECROSIS_SOULSTONE_ALERT_MESSAGE then
			local tempnum = random(1, table.getn(NECROSIS_SOULSTONE_ALERT_MESSAGE));
			while tempnum == RezMess and table.getn(NECROSIS_SOULSTONE_ALERT_MESSAGE) >= 2 do
			tempnum = random(1, table.getn(NECROSIS_SOULSTONE_ALERT_MESSAGE));
			end
			RezMess = tempnum;
			for i = 1, table.getn(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum]) do
				if string.find(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], "<after>") then
					table.insert(PlayerSoulstoned, NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i]);
				elseif string.find(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], "<emote>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], SpellTargetName), "EMOTE");
				elseif string.find(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], "<yell>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], SpellTargetName), "YELL");
				else
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_SOULSTONE_ALERT_MESSAGE[tempnum][i], SpellTargetName), "WORLD");
				end
			end
		end
	-- Affichage des messages d'invocation de joueurs
	elseif SpellCastName == NECROSIS_SPELL_TABLE[37].Name then
		PlayerSummoned = {};
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and NECROSIS_INVOCATION_MESSAGES then
			local tempnum = random(1, table.getn(NECROSIS_INVOCATION_MESSAGES));
			while tempnum == TPMess and table.getn(NECROSIS_INVOCATION_MESSAGES) >= 2 do
				tempnum = random(1, table.getn(NECROSIS_INVOCATION_MESSAGES));
			end
			TPMess = tempnum;
			for i = 1, table.getn(NECROSIS_INVOCATION_MESSAGES[tempnum]) do
				if string.find(NECROSIS_INVOCATION_MESSAGES[tempnum][i], "<after>") then
					table.insert(PlayerSummoned, NECROSIS_INVOCATION_MESSAGES[tempnum][i]);
				elseif string.find(NECROSIS_INVOCATION_MESSAGES[tempnum][i], "<emote>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_INVOCATION_MESSAGES[tempnum][i], SpellTargetName), "EMOTE");
				elseif string.find(NECROSIS_INVOCATION_MESSAGES[tempnum][i], "<yell>") then
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_INVOCATION_MESSAGES[tempnum][i], SpellTargetName), "YELL");
				else
					Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_INVOCATION_MESSAGES[tempnum][i], SpellTargetName), "WORLD");
				end
			end
		end
		AlphaBuffMenu = 1;
		AlphaBuffVar = GetTime() + 3;
	-- Affichage des messages d'invocations de démon
	else for type = 3, 7, 1 do
		if SpellCastName == NECROSIS_SPELL_TABLE[type].Name then
			DemonSummoned = {};
			DemonSacrified = {};
			DemonName = type - 2;
			if NecrosisConfig.DemonSummon and NecrosisConfig.ChatMsg and not NecrosisConfig.SM then
				if NecrosisConfig.PetName[DemonName] == " " and NECROSIS_PET_MESSAGE[6] then
					local tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[6]));
					while tempnum == PetMess and table.getn(NECROSIS_PET_MESSAGE[6]) >= 2 do
						tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[6]));
					end
					PetMess = tempnum;
					for i = 1, table.getn(NECROSIS_PET_MESSAGE[6][tempnum]) do
						if string.find(NECROSIS_PET_MESSAGE[6][tempnum][i], "<after>") then
							table.insert(DemonSummoned, NECROSIS_PET_MESSAGE[6][tempnum][i]);
						elseif string.find(NECROSIS_PET_MESSAGE[6][tempnum][i], "<sacrifice>")then
							table.insert(DemonSacrified, NECROSIS_PET_MESSAGE[6][tempnum][i]);
						elseif string.find(NECROSIS_PET_MESSAGE[6][tempnum][i], "<emote>") then
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[6][tempnum][i]), "EMOTE");
						elseif string.find(NECROSIS_PET_MESSAGE[6][tempnum][i], "<yell>") then
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[6][tempnum][i]), "YELL");
						else
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[6][tempnum][i]), "SAY");
						end
					end
				elseif NECROSIS_PET_MESSAGE[DemonName] then
					local tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[DemonName]));
					while tempnum == PetMess and table.getn(NECROSIS_PET_MESSAGE[DemonName]) >= 2 do
						tempnum = random(1, table.getn(NECROSIS_PET_MESSAGE[DemonName]));
					end
					PetMess = tempnum;
					for i = 1, table.getn(NECROSIS_PET_MESSAGE[DemonName][tempnum]) do
						if string.find(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], "<after>") then
							table.insert(DemonSummoned, NECROSIS_PET_MESSAGE[DemonName][tempnum][i]);
						elseif string.find(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], "<sacrifice>")then
							table.insert(DemonSacrified, NECROSIS_PET_MESSAGE[DemonName][tempnum][i]);
						elseif string.find(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], "<emote>") then
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], nil , DemonName), "EMOTE");
						elseif string.find(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], "<yell>") then
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], nil , DemonName), "YELL");
						else
							Necrosis_Msg(Necrosis_MsgReplace(NECROSIS_PET_MESSAGE[DemonName][tempnum][i], nil , DemonName), "SAY");
						end
					end
				end
			end
			AlphaPetMenu = 1;
			AlphaPetVar = GetTime() + 3;
		end
	end end
	return DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, PetMess, TPMess, SteedMess, RezMess;
end



------------------------------------------------------------------------------------------------------
-- FONCTION D'AFFICHAGE DES MESSAGES EN FIN DE CAST
------------------------------------------------------------------------------------------------------

function Necrosis_Speech_Then(SpellCastName, SpellTargetName, DemonName, PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, NecrosisMounted)
	-- Si le sort était un un cast de monture et qu'il y avait quelque chose à faire dire après le cast, on y va !
	if (SpellCastName == NECROSIS_SPELL_TABLE[1].Name or SpellCastName == NECROSIS_SPELL_TABLE[2].Name) then
		table.foreach(SteedSummoned, function (index, valeur)
			if string.find(valeur, "<emote>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur), "EMOTE");
			elseif string.find(valeur, "<yell>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur), "YELL");
			else
				Necrosis_Msg(Necrosis_MsgReplace(valeur), "WORLD");
			end
		end)
		SteedSummoned = {};
		NecrosisMounted = true;
		NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02");
	-- Si le sort était un cast de Rez et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif SpellCastName == NECROSIS_SPELL_TABLE[11].Name then
		table.foreach(PlayerSoulstoned, function (index, valeur)
			if string.find(valeur, "<emote>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "EMOTE");
			elseif string.find(valeur, "<yell>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "YELL");
			else
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "WORLD");
			end
		end)
		PlayerSoulstoned = {};
	-- Si le sort était un cast de TP et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif (SpellCastName == NECROSIS_SPELL_TABLE[37].Name) then
		table.foreach(PlayerSummoned, function (index, valeur)
			if string.find(valeur, "<emote>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "EMOTE");
			elseif string.find(valeur, "<yell>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "YELL");
			else
				Necrosis_Msg(Necrosis_MsgReplace(valeur, SpellTargetName), "WORLD");
			end
		end)
		PlayerSummoned = {};
	-- Si le sort était un sacrifice de démon et qu'il y avait quelque chose à faire dire à sa mort, on y va !
	elseif SpellCastName == NECROSIS_SPELL_TABLE[44].Name then
		table.foreach(DemonSacrified, function (index, valeur)
			if string.find(valeur, "<emote>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "EMOTE");
			elseif string.find(valeur, "<yell>") then
				Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "YELL");
			else
				Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "SAY");
			end
		end)
		DemonSacrified = {};
	-- Si le sort était un cast de démon et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif SpellCastName == NECROSIS_SPELL_TABLE[3].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[4].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[5].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[6].Name
			or SpellCastName == NECROSIS_SPELL_TABLE[7].Name
			then
				table.foreach(DemonSummoned, function (index, valeur)
					if string.find(valeur, "<emote>") then
						Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "EMOTE");
					elseif string.find(valeur, "<yell>") then
						Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "YELL");
					else
						Necrosis_Msg(Necrosis_MsgReplace(valeur, nil, DemonName), "SAY");
					end
				end)
				DemonSummoned = {};
	end

	return PlayerSoulstoned, SteedSummoned, PlayerSummoned, DemonSummoned, DemonSacrified, NecrosisMounted;
end

