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



function Necrosis_Localization_Speech_Fr()

	NECROSIS_INVOCATION_MESSAGES = {
		[1] = {
			"<after>Taxi des Arcanes ! J'invoque <target>, cliquez sur le portail svp !",
		},
		[2] = {
			"<after>Bienvenue, <target>, sur le vol de ~Succube Air Lines~ \195\160 destination de <player>...",
			"<after>Les h\195\180tesses et leur fouet sont \195\160 votre disposition durant le trajet",
		},
		[3] = {
			"<after>Si vous ne voulez pas qu'une cr\195\169ature tentaculaire, glaireuse et asthmatique sorte de ce portail, cliquez dessus pour aider <target> \195\160 trouver son chemin au plus vite !",
		},
		[4] = {
			"<after>J'invoque cette feignasse de <target>, on se motive pour activer le portail svp :)",
		},
		[5] = {
			"<after>Tel un lapin dans un chapeau de mage, <target> va appara\195\174tre devant vos yeux \195\169bahis. Et hop.",
		},
		[6] = {
			"PAR ASTAROTH ET DASMODES, JE T'INVOQUE, O TOUT PUISSANT DEMON DES SEPT ENFERS, PARANGON VELU DES INFRA MONDES DEMONIAQUES, PAR LA PUISSANCE DU SCEAU ANCESTR... euh ?!? Il y a un truc qui va pas, l\195\160 !",
			"<after>Ah merde c’est <target> qui d\195\169barque !!",
		},
		[7] = {
			"<after>Chantons ensemble ! Venu de nulle part, c'est <target>, Plus vif que le serpent, c'est <target> !",
			"<after>Personne ne l'aper\195\167oit, c'est <target>, Mais il est toujours l\195\160, c'est <target> !",
			"<after>Plein d'effroi les Pirates de Tanaris rien qu'\195\160 son nom voient leur sang qui se glace, se glace, se glace... Mais quand il y a danger, c'est <target> qui vient pour nous aider, <target>...",
			"(Cliquez vite sur le portail sinon je continue...)",
			"C'EST <target> ! <target> ! <target> !",
			"C'EST <target> ! <target> ! <target> !",
		},
		[8] = {
			"<after>MOUAhaAHAHaAHAHaAHAhAHA !",
			"<after>La faible chose nomm\195\169e <target> est attir\195\169e comme un aimant par la puissance du grand <player> ! Il lui faut deux cr\195\169tins pour apparaitre, svp !",
			"<after>(J'ai dit cr\195\169tin ? euhhh.... Je voulais dire copain !)",
		},
		[9] = {
			"<after>On parie que si 2 blaireaux cliquent sur le portail ca en fait apparaitre un troisi\195\168me ?",
			"<after>Si, si, je vous jure, il s'appellera m\195\170me <target> !",
		},
		[10] = {
			"<after>Si 2 types cliquent sur le joli machin qui brille, un troisi\195\168me sortira et fera le boulot \195\160 votre place... Voici <target>, un ami qui vous veut du bien ! (hehehe)",
		},
		[11] = {
			"<after>Si vous cliquez mal sur le cercle d'invocation, l'\195\162me de <target> se perdra en chemin dans les Cercles de l'Enfer, et vous ne pr\195\169f\195\169rez pas savoir ce qui va sortir \195\160 sa place ! ",
		},
	}

	NECROSIS_SOULSTONE_ALERT_MESSAGE = {
		[1] = {
			"Si ca vous tente un suicide collectif, <target> s'en fout, la pierre d'\195\162me lui permettra de se relever",
		},
		[2] = {
			"<target> peut partir siroter un caf\195\169, et pourra se relever du wipe qui s'en suivra gr\195\162ce \195\160 sa pierre d'\195\162me",
		},
		[3] = {
			"Pierre pos\195\169e sur <target>, vous pouvez recommencer \195\160 faire n’importe quoi sans risque",
		},
		[4] = {
			"Gr\195\162ce \195\160 sa pierre d’\195\162me, <target> est pass\195\169 en mode Easy wipe",
		},
		[5] = {
			"<target> peut d\195\169sormais revenir d’entre les morts, histoire d’organiser le prochain wipe",
		},
		[6] = {
			"Bon, <target>, je viens de t'arracher l'\195\162me et de la mettre dans un bocal \195\160 anchois pour 30 minutes. Histoire qu'elle reste sur place si on meurt tous, hein ?",
		},
		[7] = {
			"LAAAAAAA MOOOOOOOOOOOOORRRRRRRRRRTTTTT.......................",
			"(n'aura plus aucun effet sur <target> pendant 30 minutes...)",
		},
		[8] = {
			"MPHPMMhmhmmmmpphpPOHh <target>, MMMphhhhaphhphmhhphHHahAHaApmh pierre d'\195\162me MPHmmPPPHHhhHHmu 30 minutes !",
		},
		[9] = {
			"Gr\195\162ce \195\160 sa pierre d’\195\162me, <target> peut de nouveau faire n’importe quoi.",
		},
		[10] = {
			"<player> est prot\195\169g\195\169 par la pierre d'\195\162me pendant 30 minutes !",
			"...",
			"...",
			"....... Non, non, je d\195\169conne, en fait c'est <target>, rassurez vous :P",
		},
	}

	NECROSIS_PET_MESSAGE = {
		-- Diablotin
		[1] = {
			[1] = {
				"Bon, s\195\162le petite peste de Diablotin, tu arr\195\170tes de bouder et tu viens m'aider ! ET C'EST UN ORDRE !",
			},
			[2] = {
				"<pet> ! AU PIED ! TOUT DE SUITE !",
			},
			[3] = {
				"Attendez, je sors mon briquet !",
			},
		},
		-- Marcheur éthéré
		[2] = {
			-- Phrase aléatoire 1
			[1] = {
				"Oups, je vais sans doute avoir besoin d'un idiot pour prendre les coups à ma place...",
				"<pet>, viens m'aider !",
			},
			[2] = {
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"(Non je ne suis pas dingue, j'imite le bruit du marcheur en rut !)",
			},
		},
		-- Succube
		[3] = {
			[1] = {
				"<pet> ma grande, viens m'aider ch\195\169rie !",
			},
			[2] = {
				"Ch\195\169rie, l\195\162che ton rimmel et am\195\168ne ton fouet, y a du taf l\195\160 !",
			},
			[3] = {
				"<pet> ? Viens ici ma louloutte !",
			},
		},
		-- Chasseur corrompu
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Aller vient mon brave, viens ! <pet> !",
			},
			[2] = {
				"Rhoo, et qui c’est qui va se bouffer le mage hein ? C’est <pet> !",
				"Regardez, il bave d\195\169j\195\160 :)",
			},
			[3] = {
				"Une minute, je sors le caniche et j’arrive !",
			},
		},
		-- Gangregarde
		[5] = {
			[1] = {
				"<emote> concentre toute sa puissance dans ses connaissances d\195\169monologiques...",
				"En \195\169change de cette \195\162me, viens \195\160 moi, Gangregarde !",
				"<after>Ob\195\169is moi maintenant, <pet> !",
				"<after><emote>fouille dans son sac, puis lance un cristal \195\160 <pet>",
				"<sacrifice>Retourne dans les limbes et donne moi de ta puissance, D\195\169mon !"
			},
		},
		-- Phrase pour la première invocation de pet (quand Necrosis ne connait pas encore leur nom)
		[6] = {
			[1] = {
				"La p\195\170che au d\195\169mon ? Rien de plus facile !",
				"Bon, je ferme les yeux, j'agite les doigts comme \195\167a... et hop ! Oh, les jolies couleurs !",
			},
			[2] = {
				"Toute fa\195\167on je vous d\195\169teste tous ! J'ai pas besoin de vous, j'ai des amis.... Puissants !",
				"VENEZ A MOI, CREATURES DE L'ENFER !",
			},
			[3] = {
				"Eh, le d\195\169mon, viens voir, il y a un truc \195\160 cogner l\195\160 !",
			},
			[4] = {
				"En farfouillant dans le monde abyssal, on trouve de ces trucs... Regardez, ceci par exemple !",
			},

		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"Mmmphhhh, je suis en retard ! Invoquons vite un cheval qui rox !",
			},
			[2] = {
				"J'invoque une monture de l'enfer !",
			},
			[3] = {
				"MOUHAhaHAAHAhaHAhAHAahAaHAAHaHAhaHAaaAahAHa !",
				"TREMBLEZ, MORTELS, J'ARRIVE A LA VITESSE DU CAUCHEMARD !!!!",
			},
			[4] = {
				"Et hop, un cheval tout feu tout flamme !",
			},
			[5] = {
				"Vous savez, depuis que j’ai mis une selle ignifug\195\169e, je n'ai plus de probl\195\168me de culotte !"
			},
		},
	}

	NECROSIS_SHORT_MESSAGES = {
		{{"--> <target> est prot\195\169g\195\169 par une pierre d'\195\162me <--"}},
		{{"<TP> Invocation de <target> en cours, cliquez sur le portail svp <TP>"}}
	}

end


-- Pour les caractères spéciaux :
-- é = \195\169 ---- è = \195\168
-- à = \195\160 ---- â = \195\162
-- ô = \195\180 ---- ê = \195\170
-- û = \195\187 ---- ä = \195\164
-- Ä = \195\132 ---- ö = \195\182
-- Ö = \195\150 ---- ü = \195\188
-- Ü = \195\156 ---- ß = \195\159
-- ç = \195\167 ---- î = \195\174

