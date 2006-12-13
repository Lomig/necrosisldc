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


function Necrosis_Localization_Speech_En()

	NECROSIS_INVOCATION_MESSAGES = {
		[1] = {
			"<after>Arcanum Taxi Cab ! I am summoning <target>, please click on the portal.",
		},
		[2] = {
			"<after>Welcome aboard, <target>, you are flying on the ~Succubus Air Lines~ to <player>...",
			"<after>Air Hostesses and their lashes are at your service during your trip !",
		},
		[3] = {
			"<after>If you click on the portal, someone named <target> will appear and do your job for you !",
		},
		[4] = {
			"<after>If you do not want a sprawling, phlegm-looking and asthmatic creature to come from this portal, click on it to help <target> find a path in Hell as quick as possible !",
		},
	};

	NECROSIS_SOULSTONE_ALERT_MESSAGE = {
		[1] = {
			"<after>If you cherish the idea of a mass suicide, <target> now can self-resurrect, so all should be fine. Go ahead.",
		},
		[2]= {
			"<after><target> can go afk to drink a cup of coffee or so, soulstone is in place to allow for the wipe...",
		},
	};

	NECROSIS_PET_MESSAGE = {
		-- Imp
		[1] = {
			[1] = {
				"Well, crappy nasty little Imp, now you stop sulking and you come to help ! AND THAT'S AN ORDER !",
			},
			[2] = {
				"<pet>! HEEL ! NOW !",
			},
		};
		-- Voidwalker
		[2] = {
			[1] = {
				"Oops, I will probably need an idiot to be knocked for me...",
				"<pet>, please help !",
			},
		};
		-- Succubus
		[3] = {
			[1] = {
				"<pet> baby, please help me sweet heart !",
			},
		};
		-- Felhunter
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Come on boy, come here ! <pet> !",
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
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"Fishing ? Yes I love fishing... Look !",
				"I close my eyes, I move my fingers like that...",
				"<after>And voila ! Yes, yes, it is a fish, I can swear you !",
			},
			[2] = {
				"Anyway I hate you all ! I don't need you, I have friends.... Powerful friends !",
				"COME TO ME, CREATURE OF HELL AND NIGHTMARE !",
			},
		};
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"Hey, I'm late ! Let's find a horse that roxes !",
			},
			[2] = {
				"<emote> is giggling gloomily...",
				"<yell>I am summoning a stead from nightmare !",
				"<after>AH AHA HA HA AH AH !",
			},
		};
	};
	
	NECROSIS_SHORT_MESSAGES = {
		{{"<after>--> <target> is soulstoned for 30 minutes <--"}},
		{{"<after><TP> Summoning <target>, please click on the portal <TP>"}},
	};

end

