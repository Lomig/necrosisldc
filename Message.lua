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
-- Version $LastChangedDate: 2007-01-15 22:28:13 +0100 (lun, 15 jan 2007) $
------------------------------------------------------------------------------------------------------



-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE (CONSOLE, CHAT, MESSAGE SYSTEME)
------------------------------------------------------------------------------------------------------

function Necrosis:Msg(msg, type)
	if msg then
		-- Si le type du message est "WORLD", le message sera envoyé en raid, à défaut en groupe, et à défaut en chat local
		if (type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID")
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY")
			else
				SendChatMessage(msg, "SAY")
			end
		-- Si le type du message est "PARTY", le message sera envoyé en groupe
		elseif (type == "PARTY") then
			SendChatMessage(msg, "PARTY")
		-- Si le type du message est "RAID", le message sera envoyé en raid
		elseif (type == "RAID") then
			SendChatMessage(msg, "RAID")
		elseif (type == "SAY") then
		-- Si le type du message est "SAY", le message sera envoyé en chat local
			SendChatMessage(msg, "SAY")
		elseif (type == "EMOTE") then
		-- Si le type du message est "EMOTE", le message sera envoyé en /e
			SendChatMessage(msg, "EMOTE")
		elseif (type == "YELL") then
		-- Si le type du message est "YELL", le message sera envoyé en /y
			SendChatMessage(msg, "YELL")
		else
			-- On colorise astucieusement notre message :D
			msg = self:MsgAddColor(msg)
			local Intro = "|CFFFF00FFNe|CFFFF50FFcr|CFFFF99FFos|CFFFFC4FFis|CFFFFFFFF: "
			if NecrosisConfig.ChatType then
				-- ...... sur la première fenêtre de chat
				ChatFrame1:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
			else
				-- ...... ou au milieu de l'écran
				UIErrorsFrame:AddMessage(Intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
			end
		end
	end
end


------------------------------------------------------------------------------------------------------
-- ... ET LE COLORAMA FUT !
------------------------------------------------------------------------------------------------------

-- Remplace dans les chaines les codes de coloration par les définitions de couleur associées
function Necrosis:MsgAddColor(msg)
	msg = msg:gsub("<white>", "|CFFFFFFFF")
	msg = msg:gsub("<lightBlue>", "|CFF99CCFF")
	msg = msg:gsub("<brightGreen>", "|CFF00FF00")
	msg = msg:gsub("<lightGreen2>", "|CFF66FF66")
	msg = msg:gsub("<lightGreen1>", "|CFF99FF66")
	msg = msg:gsub("<yellowGreen>", "|CFFCCFF66")
	msg = msg:gsub("<lightYellow>", "|CFFFFFF66")
	msg = msg:gsub("<darkYellow>", "|CFFFFCC00")
	msg = msg:gsub("<lightOrange>", "|CFFFFCC66")
	msg = msg:gsub("<dirtyOrange>", "|CFFFF9933")
	msg = msg:gsub("<darkOrange>", "|CFFFF6600")
	msg = msg:gsub("<redOrange>", "|CFFFF3300")
	msg = msg:gsub("<red>", "|CFFFF0000")
	msg = msg:gsub("<lightRed>", "|CFFFF5555")
	msg = msg:gsub("<lightPurple1>", "|CFFFFC4FF")
	msg = msg:gsub("<lightPurple2>", "|CFFFF99FF")
	msg = msg:gsub("<purple>", "|CFFFF50FF")
	msg = msg:gsub("<darkPurple1>", "|CFFFF00FF")
	msg = msg:gsub("<darkPurple2>", "|CFFB700B7")
	msg = msg:gsub("<close>", "|r")
	return msg
end


-- Insère dans les timers des codes de coloration en fonction du pourcentage de temps restant
function NecrosisTimerColor(percent)
	local color = "<brightGreen>"
	if (percent < 10) then
		color = "<red>"
	elseif (percent < 20) then
		color = "<redOrange>"
	elseif (percent < 30) then
		color = "<darkOrange>"
	elseif (percent < 40) then
		color = "<dirtyOrange>"
	elseif (percent < 50) then
		color = "<darkYellow>"
	elseif (percent < 60) then
		color = "<lightYellow>"
	elseif (percent < 70) then
		color = "<yellowGreen>"
	elseif (percent < 80) then
		color = "<lightGreen1>"
	elseif (percent < 90) then
		color = "<lightGreen2>"
	end
	return color
end

------------------------------------------------------------------------------------------------------
-- VARIABLES USER-FRIENDLY DANS LES MESSAGES D'INVOCATION
------------------------------------------------------------------------------------------------------

function Necrosis:MsgReplace(msg, target, pet)
	msg = msg:gsub("<player>", UnitName("player"))
	msg = msg:gsub("<emote>", "")
	msg = msg:gsub("<after>", "")
	msg = msg:gsub("<sacrifice>", "")
	msg = msg:gsub("<yell>", "")
	if target then
		msg = msg:gsub("<target>", target)
	end
	if pet and NecrosisConfig.PetName[pet] then
		msg = msg:gsub("<pet>", NecrosisConfig.PetName[pet])
	end
	return msg
end

------------------------------------------------------------------------------------------------------
-- FONCTION D'AFFICHAGE DES MESSAGES EN COURS DE CAST
------------------------------------------------------------------------------------------------------

function  Necrosis:Speech_It(Spell, Speeches, metatable)
	-- Affichage des messages d'invocation de monture
	if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
		Speeches.SpellSucceed.Steed = setmetatable({}, metatable)
		if NecrosisConfig.SteedSummon and NecrosisConfig.ChatMsg and self.Speech.Demon[7] and not NecrosisConfig.SM then
			local tempnum = math.random(1, #self.Speech.Demon[7])
			while tempnum == Speeches.LastSpeech.Steed and #self.Speech.Demon[7] >= 2 do
				tempnum = math.random(1, #self.Speech.Demon[7])
			end
			Speeches.LastSpeech.Steed = tempnum
			for i in ipairs(self.Speech.Demon[7][tempnum]) do
				if self.Speech.Demon[7][tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.Steed:insert(self.Speech.Demon[7][tempnum][i])
				elseif self.Speech.Demon[7][tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "EMOTE")
				elseif self.Speech.Demon[7][tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "SAY")
				end
			end
		end
	-- Affichage des messages de rez
	elseif Spell.Name == Necrosis.Spell[11].Name and not (Spell.TargetName == UnitName("player")) then
		Speeches.SpellSucceed.Rez = setmetatable({}, metatable)
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.Rez then
			local tempnum = math.random(1, #self.Speech.Rez)
			while tempnum == Speeches.LastSpeech.Rez and #self.Speech.Rez >= 2 do
			tempnum = math.random(1, #self.Speech.Rez)
			end
			Speeches.LastSpeech.Rez = tempnum
			for i in ipairs(self.Speech.Rez[tempnum]) do
				if self.Speech.Rez[tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.Rez:insert(self.Speech.Rez[tempnum][i])
				elseif self.Speech.Rez[tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "EMOTE")
				elseif self.Speech.Rez[tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "WORLD")
				end
			end
		end
	-- Affichage des messages d'invocation de joueurs
	elseif Spell.Name == Necrosis.Spell[37].Name then
		Speeches.SpellSucceed.TP = setmetatable({}, metatable)
		if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.TP then
			local tempnum = math.random(1, #self.Speech.TP)
			while tempnum == Speeches.LastSpeech.TP and #self.Speech.TP >= 2 do
				tempnum = math.random(1, #self.Speech.TP)
			end
			Speeches.LastSpeech.TP = tempnum
			for i in ipairs(self.Speech.TP[tempnum]) do
				if self.Speech.TP[tempnum][i]:find("<after>") then
					Speeches.SpellSucceed.TP:insert(self.Speech.TP[tempnum][i])
				elseif self.Speech.TP[tempnum][i]:find("<emote>") then
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "EMOTE")
				elseif self.Speech.TP[tempnum][i]:find("<yell>") then
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "YELL")
				else
					self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "WORLD")
				end
			end
		end
		AlphaBuffMenu = 1
		AlphaBuffVar = GetTime() + 3
	-- Affichage des messages d'invocations de démon
	else for type = 3, 7, 1 do
		if Spell.Name == Necrosis.Spell[type].Name then
			Speeches.SpellSucceed.Pet = setmetatable({}, metatable)
			Speeches.SpellSucceed.Sacrifice = setmetatable({}, metatable)
			Speeches.DemonName = type - 2
			if NecrosisConfig.DemonSummon and NecrosisConfig.ChatMsg and not NecrosisConfig.SM then
				if not NecrosisConfig.PetName[Speeches.DemonName] and self.Speech.Demon[6] then
					local tempnum = math.random(1, #self.Speech.Demon[6])
					while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[6] >= 2 do
						tempnum = math.random(1, #self.Speech.Demon[6])
					end
					Speeches.LastSpeech.Pet = tempnum
					for i in ipairs(self.Speech.Demon[6][tempnum]) do
						if self.Speech.Demon[6][tempnum][i]:find("<after>") then
							Speeches.SpellSucceed.Pet:insert(self.Speech.Demon[6][tempnum][i])
						elseif self.Speech.Demon[6][tempnum][i]:find("<sacrifice>")then
							Speeches.SpellSucceed.Sacrifice:insert(self.Speech.Demon[6][tempnum][i])
						elseif self.Speech.Demon[6][tempnum][i]:find("<emote>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "EMOTE")
						elseif self.Speech.Demon[6][tempnum][i]:find("<yell>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "YELL")
						else
							self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "SAY")
						end
					end
				elseif self.Speech.Demon[Speeches.DemonName] then
					local tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
					while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[Speeches.DemonName] >= 2 do
						tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
					end
					Speeches.LastSpeech.Pet = tempnum
					for i in ipairs(self.Speech.Demon[Speeches.DemonName][tempnum]) do
						if self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<after>") then
							Speeches.SpellSucceed.Pet:insert(
								self.Speech.Demon[Speeches.DemonName][tempnum][i]
							)
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<sacrifice>")then
							Speeches.SpellSucceed.Sacrifice:insert(
								self.Speech.Demon[Speeches.DemonName][tempnum][i]
							)
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<emote>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "EMOTE")
						elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<yell>") then
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "YELL")
						else
							self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "SAY")
						end
					end
				end
			end
			AlphaPetMenu = 1
			AlphaPetVar = GetTime() + 3
		end
	end end
	return Speeches
end



------------------------------------------------------------------------------------------------------
-- FONCTION D'AFFICHAGE DES MESSAGES EN FIN DE CAST
------------------------------------------------------------------------------------------------------

function Necrosis:Speech_Then(Spell, DemonName, Speech)
	-- Si le sort était un un cast de monture et qu'il y avait quelque chose à faire dire après le cast, on y va !
	if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
		for i in ipairs(Speech.Steed) do
			if Speech.Steed[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Steed[i]), "EMOTE")
			elseif Speech.Steed[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Steed[i]), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Steed[i]), "WORLD")
			end
		end
		Speech.Steed = {}
		if _G["NecrosisMountButton"] then
			NecrosisMountButton:SetNormalTexture("Interface\\Addons\\Necrosis\\UI\\MountButton-02")
		end
	-- Si le sort était un cast de Rez et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif Spell.Name == Necrosis.Spell[11].Name then
		for i in ipairs(Speech.Rez) do
			if Speech.Rez[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "EMOTE")
			elseif Speech.Rez[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "WORLD")
			end
		end
		Speech.Rez = {}
	-- Si le sort était un cast de TP et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif (Spell.Name == Necrosis.Spell[37].Name) then
		for i in ipairs(Speech.TP) do
			if Speech.TP[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "EMOTE")
			elseif Speech.TP[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "WORLD")
			end
		end
		Speech.TP = {}
	-- Si le sort était un sacrifice de démon et qu'il y avait quelque chose à faire dire à sa mort, on y va !
	elseif Spell.Name == Necrosis.Spell[44].Name then
		for i in ipairs(Speech.Sacrifice) do
			if Speech.Sacrifice[i]:find("<emote>") then
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "EMOTE")
			elseif Speech.Sacrifice[i]:find("<yell>") then
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "YELL")
			else
				self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "SAY")
			end
		end
		Speech.Sacrifice = {}
	-- Si le sort était un cast de démon et qu'il y avait quelque chose à faire dire après le cast, on y va !
	elseif Spell.Name == Necrosis.Spell[3].Name
			or Spell.Name == Necrosis.Spell[4].Name
			or Spell.Name == Necrosis.Spell[5].Name
			or Spell.Name == Necrosis.Spell[6].Name
			or Spell.Name == Necrosis.Spell[7].Name
			then
				for i in ipairs(Speech.Pet) do
					if Speech.Pet[i]:find("<emote>") then
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "EMOTE")
					elseif Speech.Pet[i]:find("<yell>") then
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "YELL")
					else
						self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "SAY")
					end
				end
				Speech.Pet = {}
	end

	return Speech
end

