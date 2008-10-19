--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

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
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------

-- Fonction pour éviter de devoir relocaliser la base des sorts disponibles
function Necrosis:SpellLocalize()
	self.Spell = {
		[1] = {Name = GetSpellInfo(5784),			Length = 0,		Type = 0}, -- Felsteed
		[2] = {Name = GetSpellInfo(23161),			Length = 0,		Type = 0}, -- Dreadsteed
		[3] = {Name = GetSpellInfo(688), 			Length = 0,		Type = 0}, -- Diablotin || Imp
		[4] = {Name = GetSpellInfo(697),			Length = 0,		Type = 0}, -- Marcheur || Voidwalker
		[5] = {Name = GetSpellInfo(712),			Length = 0,		Type = 0}, -- Succube || Succubus
		[6] = {Name = GetSpellInfo(691),			Length = 0,		Type = 0}, -- Fellhunter
		[7] = {Name = GetSpellInfo(30146),			Length = 0,		Type = 0}, -- Felguard
		[8] = {Name = GetSpellInfo(1122),			Length = 3600,	Type = 3}, -- Infernal
		[9] = {Name = GetSpellInfo(710),			Length = 30,	Type = 2}, -- Banish
		[10] = {Name = GetSpellInfo(1098),			Length = 300,	Type = 2}, -- Enslave
		[11] = {Name = GetSpellInfo(27239),			Length = 1800,	Type = 1}, -- Résurrection de pierre d'ame || Soulstone Resurrection
		[12] = {Name = GetSpellInfo(47811),			Length = 15,	Type = 6}, -- Immolation || Immolate
		[13] = {Name = GetSpellInfo(6215),			Length = 15,	Type = 6}, -- Peur || Fear
		[14] = {Name = GetSpellInfo(47813),			Length = 18,	Type = 5}, -- Corruption
		[15] = {Name = GetSpellInfo(18708),			Length = 900,	Type = 3}, -- Domination corrompue || Fel Domination
		[16] = {Name = GetSpellInfo(47867),			Length = 60,	Type = 3}, -- Malédiction funeste || Curse of Doom
		[17] = {Name = GetSpellInfo(47847),			Length = 20,	Type = 3}, -- Furie de l'ombre || Shadowfury
		[18] = {Name = GetSpellInfo(47825),			Length = 60,	Type = 3}, -- Feu de l'âme || Soul Fire
		[19] = {Name = GetSpellInfo(47860),			Length = 120,	Type = 3}, -- Voile mortel || Death Coil
		[20] = {Name = GetSpellInfo(47827),			Length = 15,	Type = 3}, -- Brûlure de l'ombre || Shadowburn
		[21] = {Name = GetSpellInfo(47829),			Length = 10,	Type = 3}, -- Conflagration
		[22] = {Name = GetSpellInfo(47864),			Length = 24,	Type = 4}, -- Malédiction Agonie || Curse of Agony
		[23] = {Name = GetSpellInfo(50511),			Length = 120,	Type = 4}, -- Malédiction Faiblesse || Curse of Weakness
		[24] = {Name = GetSpellInfo(57595),			Length = 120,	Type = 4}, -- Malédiction Témérité || Curse of Recklessness
		[25] = {Name = GetSpellInfo(11719),			Length = 30,	Type = 4}, -- Malédiction Langage || Curse of Tongues
		[26] = {Name = GetSpellInfo(47865),			Length = 300,	Type = 4}, -- Malédiction Eléments || Curse of the Elements
		[27] = {},
		[28] = {Name = GetSpellInfo(47862),			Length = 30,	Type = 6}, -- Syphon de vie || Siphon Life
		[29] = {Name = GetSpellInfo(17928),			Length = 40,	Type = 3}, -- Hurlement de terreur || Howl of Terror
		[30] = {Name = GetSpellInfo(18540),			Length = 3600,	Type = 0}, -- Rituel funeste || Ritual of Doom
		[31] = {Name = GetSpellInfo(47889),			Length = 0,		Type = 0}, -- Armure démoniaque || Demon Armor
		[32] = {Name = GetSpellInfo(5697),			Length = 0,		Type = 0}, -- Respiration interminable || Unending Breath
		[33] = {Name = GetSpellInfo(132),			Length = 0,		Type = 0}, -- Détection de l'invisibilité || Detect Invisibility
		[34] = {Name = GetSpellInfo(126),			Length = 0,		Type = 0}, -- Oeil de Kilrogg || Eye of Kilrogg
		[35] = {Name = GetSpellInfo(1098),			Length = 0,		Type = 0}, -- Enslave Demon
		[36] = {Name = GetSpellInfo(696),			Length = 0,		Type = 0}, -- Peau de démon || Demon Skin
		[37] = {Name = GetSpellInfo(698),			Length = 0,		Type = 0}, -- Rituel d'invocation || Ritual of Summoning
		[38] = {Name = GetSpellInfo(19028),			Length = 0,		Type = 0}, -- Lien spirituel || Soul Link
		[39] = {Name = GetSpellInfo(5500),			Length = 0,		Type = 0}, -- Détection des démons || Sense Demons
		[40] = {Name = GetSpellInfo(18223),			Length = 12,	Type = 4}, -- Malédiction de fatigue || Curse of Exhaustion
		[41] = {Name = GetSpellInfo(57946),			Length = 0,		Type = 0}, -- Connexion || Life Tap
		[42] = {},
		[43] = {Name = GetSpellInfo(47891),			Length = 30,	Type = 3}, -- Gardien de l'ombre || Shadow Ward
		[44] = {Name = GetSpellInfo(18788),			Length = 0,		Type = 0}, -- Sacrifice démoniaque || Demonic Sacrifice
		[45] = {Name = GetSpellInfo(47809),			Length = 0,		Type = 0}, -- Shadow Bolt
		[46] = {Name = GetSpellInfo(47843),			Length = 18,	Type = 6}, -- Affliction instable || Unstable Affliction
		[47] = {Name = GetSpellInfo(47893),			Length = 0,		Type = 0}, -- Gangrarmure || Fel Armor
		[48] = {Name = GetSpellInfo(47836),			Length = 18,	Type = 5}, -- Graine de Corruption || Seed of Corruption
		[49] = {Name = GetSpellInfo(29858),			Length = 300,	Type = 3}, -- Brise âme || SoulShatter
		[50] = {Name = GetSpellInfo(58887),			Length = 300,	Type = 3}, -- Rituel des âmes || Ritual of Souls
		[51] = {Name = GetSpellInfo(47884),			Length = 0,		Type = 0}, -- Création pierre d'âme || Create Soulstone
		[52] = {Name = GetSpellInfo(47878),			Length = 0,		Type = 0}, -- Création pierre de soin || Create Healthstone
		[53] = {Name = GetSpellInfo(47888),			Length = 0,		Type = 0}, -- Création pierre de sort || Create Spellstone
		[54] = {Name = GetSpellInfo(60220),			Length = 0,		Type = 0}, -- Création pierre de feu || Create Firestone
		[55] = {Name = GetSpellInfo(59092),			Length = 0,		Type = 0}, -- Pacte noir || Dark Pact
	}
	-- Type 0 = Pas de Timer || no timer
	-- Type 1 = Timer permanent principal || Standing main timer
	-- Type 2 = Timer permanent || main timer
	-- Type 3 = Timer de cooldown || cooldown timer
	-- Type 4 = Timer de malédiction || curse timer
	-- Type 5 = Timer de corruption || corruption timer
	-- Type 6 = Timer de combat || combat timer

	for i in ipairs(Necrosis.Spell) do
		Necrosis.Spell[i].Rank = " "
	end
end