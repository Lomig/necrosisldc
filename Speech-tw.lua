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


-------------------------------------
--  CHINESE TRADITIONAL VERSION --
--  2006/12/29
--  艾娜羅沙@奧妮克希亞
-------------------------------------


function Necrosis_Localization_Speech_Tw()

	NECROSIS_INVOCATION_MESSAGES = {
		[1] = {
			"<after>》<player>《正在召喚【<target>】，需要二名隊友合作，請按右鍵點擊傳送門，召喚期間不要移動。",
		},
		[2] = {
			"<after>》<player>《正在召喚【<target>】，請二名隊友幫忙點擊傳送門，召喚期間請不要移動。",
		},
		[3] = {
			"<after>歡迎【<target>】搭乘由<player>所駕駛的惡魔姊姊航空，請已到的乘客二名，按右鍵點擊傳送用機門，謝謝。",
		},
		[4] = {
			"<after>》<player>《正在試著把【<target>】抓過來，需要二名隊友一起圍捕，圍捕期間請勿移動，以及勿對%t拍打餵食。",
		},
	}

	NECROSIS_SOULSTONE_ALERT_MESSAGE = {
		[1] = {
			"<after>【<target>】靈魂已經被綁定。",
		},
		[2]= {
			"<after>【<target>】靈魂已經被鎖進保險箱三十分鐘。",
		},
		[3]= {
			"<after>【<target>】的靈魂，已經寄放在天使姊姊的懷裡三十分鐘。",
		},
	}

	NECROSIS_PET_MESSAGE = {
		-- Imp
		[1] = {
			[1] = {
				"小鬼頭，現在正是需要你的時候了，出來吧！",
			},
			[2] = {
				"<pet>！應儂之求，速速現身！",
			},
			[3] = {
				"決定了，是你了！<pet>！",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"我正在招喚大沙包來幫我擋怪。",
				"正在召寵：<pet>",
			},
			[2] = {
				"決定了，是你了！<pet>！",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"出來吧<pet>，我渴望看到鞭子鞭人的那種那火辣辣的快感...囧",
			},
			[2] = {
				"決定了，是你了！<pet>！",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"正在呼叫不用餵食物的狗狗中！",
			},
			[2] = {
				"決定了，是你了！<pet>！",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> is concentrating hard on Demoniac knowledge...",
				"I'll give you a soul if you come to me, Felguard! Please hear my command!",
				"<after>Obey now, <pet>!",
				"<after><emote>looks in a bag, then throws a mysterious shard at <pet>",
				"<sacrifice>Please return in the Limbs you are from, Demon, and give me your power in exchange!"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"正在從異界釣出寵物中...",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"正在幫座騎鞍上風火輪...",
			},
			[2] = {
				"午夜的夢魘，出來吧!",
			},
		}
	}

	NECROSIS_SHORT_MESSAGES = {
		{{"<after>■【<target>】的靈魂，已被綁定３０分鐘■"}},
		{{"<after><TP>正在召喚【<target>】，請幫忙點擊傳送門<TP>"}},
	}

end

