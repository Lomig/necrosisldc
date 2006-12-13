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
-- Version 09.12.2006-1
------------------------------------------------------------------------------------------------------


function Necrosis_Localization_Speech_De()

	NECROSIS_INVOCATION_MESSAGES = {
		[1] = {
			"<after>Arcanum Taxi Cab ! Ich beschw\195\182re <target>, bitte klicke auf das Portal.",
		},
		[2] = {
			"<after>Willkommen an Bord, <target>, du fliegst mit ~Sukkubus Air Lines~ zu <player>...",
			"<after>Die Stewardessen und ihre Peitschen werden Dir w\195\164hrend der Reise zur Verf\195\188gung stehen!",
		},
		[3] = {
			"<after>Wenn Du das Portal klicken w\195\188rdest, wird jemand mit dem Namen <target> erscheinen, und Deinen Job f\195\188r Dich tun !",
		},
		[4] = {
			"<after>Wenn Du nicht m\195\182chtest, dass eine auf dem Boden kriechende, schleimige und einfach gr\195\164ssliche Kreatur aus diesem Portal kommt,",
			"<after>klicke drauf und hilf <target>, so schnell wie m\195\182glich einen Weg zur H\195\182lle zu finden!",
		},
	};

	NECROSIS_SOULSTONE_ALERT_MESSAGE = {
		[1] = {
			"<after>Solltet Ihr einen Massenselbstmord erw\195\164gen, denkt daran dass <target> sich nun selbst wiederbeleben kann. Alles wird gut werden, auf in den Kampf !",
		},
		[2] = {
			"<after><target> kann afk gehen um eine Tasse Kaffee oder so zu trinken, denn er wird Dank dieses Seelensteins in der Lage sein, unseren Tod zu \195\188berleben",
		},
};

	
	NECROSIS_SHORT_MESSAGES = {
		{{"<after>--> <target> hat nun einen Seelenstein aktiv f\195\188r 30 Minuten <--"}},
		{{"<after><Portal> Ich beschw\195\182re <target>, bitte klickt auf das Tor <Portal>"}}
	};

	NECROSIS_PET_MESSAGE = {
		-- Wichtel
		[1] = {
			[1] = {
				"Na mein kleiner, b\195\182ser Wichtel, nun h\195\182r auf rumzuzicken und hilf endlich! UND DAS IST EIN BEFEHL !",
			},
			[2] = {
				"<pet> ! SCHWING DIE BEINE ! JETZT SOFORT !",
			},
		};
		-- Leerwandler
		[2] = {
			[1] = {
				"Huuuch, anscheinend brauch ich einen Idioten, der f\195\188r mich die R\195\188be hinh\195\164lt...",
				"<pet>, hilf mir !",
			},
		};
		-- Sukkubus
		[3] = {
			[1] = {
				"<pet>, Baby, sei ein Schatzi und hilf mir!",
			},
		};
		-- Teufelsj�ger
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Bei Fu\195\159, mein Guter, bei Fu\195\159 ! <pet> !",
			},
		};
		-- Felguard
		[5] = {
			[1] = {
				"<emote> is concentrating hard on Demoniac knowledge...",
				"I'll give you a soul if you come to me, Felguard ! Please hear my command !",
				"<after>Obey now, <pet> !",
				"<after><emote>looks in a bag, then throws a mysterious shard at <pet>",
				"<sacrifice>Please return in the Limbs you are from, Demon, and give me your power in exchange !"
			},
		};
		-- S�tze f�r die erste Beschw�rung : Wenn Necrosis den Namen Deines D�mons noch nicht kennt
		[6] = {
			[1] = {
				"Angeln ? Oh jaaa, ich liebe Angeln, schau !",
				"Ich schlie\195\159e meine Augen, dann bewege ich meine Finger in etwa so... Und voila ! Ja, aber sicher, es ist ein Fisch, ich schw\195\182re es Dir !",
			},
			[2] = {
				"Nichtsdestotrotz hasse ich Euch alle ! Ich brauche Euch nicht, ich habe Freunde.... M\195\164chtige Freunde !",
				"KOMM ZU MIR, KREATUR, DIE DU KOMMST AUS DER H\195\150LLE UND ENDLOSEN ALPTR\195\132UMEN !",
			},
		};
		-- Spr�che zur Beschw�rung des Mounts
		[7] = {
			[1] = {
				"Hey, ich bin sp\195\164t dran ! Ich hoffe ich finde ein Pferd das rennt wie ein ge\195\182lter Blitz !",
			},
			[2] = {
				"Ich beschw\195\182re ein Reittier, das einem Alptraum entspringt!",
				"AH AHA HA HA AH AH !",
			},
		};
	};

end


-- Besondere Zeichen :
-- � = \195\169 ---- � = \195\168
-- � = \195\160 ---- � = \195\162
-- � = \195\180 ---- � = \195\170
-- � = \195\187 ---- � = \195\164
-- � = \195\132 ---- � = \195\182
-- � = \195\150 ---- � = \195\188
-- � = \195\156 ---- � = \195\159
-- � = \195\167 ---- � = \195\174

