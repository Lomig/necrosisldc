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
-- Version Russe par Komsomolka(Азурегос/Пиратская Бухта)
--
-- Version $LastChangedDate$
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Necrosis:Localization_Dialog_Ru()

	function Necrosis:Localization()
		self:Localization_Speech_Ru()
	end

	NECROSIS_COOLDOWN = {
		["Healthstone"] = "Готовность Камня здоровья",
		["Utilisation"] = "Use",
		["Echange"] = "Trade",
	}

	NecrosisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFNecrosis|r",
			Stone = {
				[true] = "Есть",
				[false] = "Нет",
			},
			Hellspawn = {
				[true] = "Вкл",
				[false] = "Выкл",
			},
			["Soulshard"] = "Осколки душ: ",
			["InfernalStone"] = "Камни инфернала: ",
			["DemoniacStone"] = "Демонические статуэтки: ",
			["Soulstone"] = "\nКамень души: ",
			["Healthstone"] = "Камень здоровья: ",
			["Spellstone"] = "Камень чар: ",
			["Firestone"] = "Камень огня: ",
			["CurrentDemon"] = "Демон: ",
			["EnslavedDemon"] = "Демон: Порабощенный",
			["NoCurrentDemon"] = "Демон: Отсутствует",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFКамень Души|r",
			Text = {"[Правый Клик] Создать","[Левый Клик] Использовать","[Правый Клик] Повторное создание","Ожидание"}
		},
		["Healthstone"] = {
			Label = "|c0066FF33Камень здоровья|r",
			Text = {"[Правый Клик] Создать","[Левый Клик] Использовать"},
			Text2 = "[Средний Клик] или [Ctrl]+[Левый Клик] для передачи",
			Ritual = "|c00FFFFFF[Shift]+[Клик] Начать Ритуал Душ|r"
		},
		["Spellstone"] = {
			Label = "|c0099CCFFКамень чар|r",
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["Firestone"] = {
			Label = "|c00FF4444Камень огня|r",
			Text = {"Right click to create","In Inventory\nLeft click to use","Used", "Used\Click to create"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFТаймер заклинаний|r",
			Text = "Активное заклинание на цели",
			Right = "[Правый Клик] Использовать Камня Здоровья до "
		},
		["ShadowTrance"] = {
			Label = "|c00FFFFFFТеневой транс|r"
		},
		["Backlash"] = {
			Label = "|c00FFFFFFУдар Плетью|r"
		},
		["Domination"] = {
			Label = "|c00FFFFFFДемоническое превосходство|r"
		},
		["Enslave"] = {
			Label = "|c00FFFFFFПорабощение демона|r"
		},
		["Armor"] = {
			Label = "|c00FFFFFFДемоническая Броня|r"
		},
		["FelArmor"] = {
			Label = "|c00FFFFFFДоспех Скверны|r"
		},
		["Invisible"] = {
			Label = "|c00FFFFFFОбнаружение невидимости|r"
		},
		["Aqua"] = {
			Label = "|c00FFFFFFБесконечное дыхание|r"
		},
		["Kilrogg"] = {
			Label = "|c00FFFFFFОко Килрогга|r"
		},
		["Banish"] = {
			Label = "|c00FFFFFFИзгнание|r",
			Text = "Правый-Клик для каста Рейтинг 1"
		},
		["TP"] = {
			Label = "|c00FFFFFFРитуал призывания|r"
		},
		["RoS"] = {
			Label = "|c00FFFFFFRitual of Souls|r"
		},
		["SoulLink"] = {
			Label = "|c00FFFFFFДуховная связь|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFFЗащита от темной магии|r"
		},
		["Imp"] = {
			Label = "|c00FFFFFFБес|r"
		},
		["Voidwalker"] = {
			Label = "|c00FFFFFFДемон Бездны|r"
		},
		["Succubus"] = {
			Label = "|c00FFFFFFСуккуба|r"
		},
		["Felhunter"] = {
			Label = "|c00FFFFFFОхотник Скверны|r"
		},
		["Felguard"] = {
			Label = "|c00FFFFFFСтраж Скверны|r"
		},
		["Infernal"] = {
			Label = "|c00FFFFFFИнфернал|r"
		},
		["Doomguard"] = {
			Label = "|c00FFFFFFСтражник Ужаса|r"
		},
		["Sacrifice"] = {
			Label = "|c00FFFFFFДемоническое жертвоприношение|r"
		},
		["Weakness"] = {
			Label = "|c00FFFFFFПроклятие слабости|r"
		},
		["Agony"] = {
			Label = "|c00FFFFFFПроклятие агонии|r"
		},
		["Reckless"] = {
			Label = "|c00FFFFFFПроклятие безрассудства|r"
		},
		["Tongues"] = {
			Label = "|c00FFFFFFПроклятие косноязычия|r"
		},
		["Exhaust"] = {
			Label = "|c00FFFFFFПроклятие изнеможения|r"
		},
		["Elements"] = {
			Label = "|c00FFFFFFПроклятие стихий|r"
		},
		["Doom"] = {
			Label = "|c00FFFFFFПроклятие рока|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFКонь|r",
			Text = "[Правый Клик] Призыв коня Скверны"
		},
		["BuffMenu"] = {
			Label = "|c00FFFFFFМеню заклинаний|r",
			Text = "[Правый Клик] Для удержания меню открытым",
			Text2 = "Авто-Режим: Закрытие при выходе из боя",
		},
		["PetMenu"] = {
			Label = "|c00FFFFFFМеню демонов|r",
			Text = "[Правый Клик] Для удержания меню открытым",
			Text2 = "Авто-Режим: Закрытие при выходе из боя",
		},
		["CurseMenu"] = {
			Label = "|c00FFFFFFМеню проклятий|r",
			Text = "[Правый Клик] Для удержания меню открытым",
			Text2 = "Авто-Режим: Закрытие при выходе из боя",
		},
		["Radar"] = {
			Label = "|c00FFFFFFЧутье на демонов|r"
		},
		["AmplifyCooldown"] = "[Правый Клик] Усиливает проклятие",
		["DominationCooldown"] = "[Правый Клик] Быстрый вызов",
	}

	NECROSIS_SOUND = {
		["Fear"] = "Interface\\AddOns\\Necrosis\\sounds\\Fear-Ru.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\SoulstoneEnd-Ru.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis\\sounds\\EnslaveDemonEnd-Ru.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis\\sounds\\ShadowTrance-Ru.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis\\sounds\\Backlash-Fr.mp3",
	};

	NECROSIS_PROC_TEXT = {
		["ShadowTrance"] = "<white>Т<lightPurple1>е<lightPurple2>н<purple>е<darkPurple1>в<darkPurple2>о<darkPurple1>й Т<purple>р<lightPurple2>а<lightPurple1>н<white>с",
		["Backlash"] = "<white>О<lightPurple1>т<lightPurple2>в<purple>е<darkPurple1>т<darkPurple2>н<darkPurple1>ы<darkPurple2>й У<purple>д<lightPurple2>а<lightPurple1>р"
	}


	NECROSIS_MESSAGE = {
		["Bag"] = {
			["FullPrefix"] = "Ваша ",
			["FullSuffix"] = " полна!",
			["FullDestroySuffix"] = " полна. Следующий осколок души будет уничтожен!",
		},
		["Interface"] = {
			["Welcome"] = "<white>Введите /necro для отображения окна настроек",
			["TooltipOn"] = "[+] Всплывающие подсказки включены" ,
			["TooltipOff"] = "[-] Всплывающие подскажки выключены",
			["MessageOn"] = "[+] Оповещения в окне чата - включены",
			["MessageOff"] = "[-] Оповещения в окне чата - выключены",
			["DefaultConfig"] = "<lightYellow>Загружена стандартная конфигурация.",
			["UserConfig"] = "<lightYellow>Конфигурация успешно загружена."
		},
		["Help"] = {
			"/necro <lightOrange>recall<white> -- <lightBlue>Команда для размещение окна Necrosis и его кнопок в центре экрана.",
			"/necro <lightOrange>reset<white> -- <lightBlue>Команда полностью страсывает все настройки Necrosis до настроек по-умолчанию.",
		},
		["Information"] = {
			["FearProtect"] = "Ваша цель не поддается страху!",
			["EnslaveBreak"] = "Ваш демон разорвал цепи!",
			["SoulstoneEnd"] = "<lightYellow>Ваш камень души выдохся!"
		}
	};


	-- Gestion XML - Menu de configuration
	Necrosis.Config.Panel = {
		"Настройки Сообщений",
		"Настройки Сферы",
		"Настройки Кнопок",
		"Настройки Меню",
		"Настройки Таймера",
		"Настройки Дополнительные"
	}

	Necrosis.Config.Messages = {
		["Position"] = "<- Сообщения Necrosis будут расположены здесь ->",
		["Afficher les bulles d'aide"] = "Показывать подсказки",
		["Afficher les messages dans la zone systeme"] = "Показывать сообщения Necrosis в системном окне",
		["Activer les messages aleatoires de TP et de Rez"] = "Включить различные оповещения",
		["Utiliser des messages courts"] = "Использовать только 'короткие' сообщения",
		["Activer egalement les messages pour les Demons"] = "Показывать сообщения для демонов",
		["Activer egalement les messages pour les Montures"] = "Показывать сообщения для коней",
		["Activer \195\169galment les messages pour les Rituel des \195\162mes"] = "Activate random speeches for Ritual of Souls",
		["Activer les sons"] = "Воспроизводить звуковые эффекты",
		["Alerter quand la cible est insensible a la peur"] = "Предупреждать, если цель не поддается страху",
		["Alerter quand la cible peut etre banie ou asservie"] = "Предупреждать, если цель изгнана или порабощена",
		["M'alerter quand j'entre en Transe"] = "Предупреждать о наступлении Теневого Транса"
	}

	Necrosis.Config.Sphere = {
		["Taille de la sphere"] = "Размер кнопок Necrosis",
		["Skin de la pierre Necrosis"] = "Вид Сферы",
		["Evenement montre par la sphere"] = "На Сфере отображать",
		["Sort caste par la sphere"] = "Заклинание Сферы",
		["Afficher le compteur numerique"] = "Показывать отсчет цифрами",
		["Type de compteur numerique"] = "Показывать количество камней"
	}
	Necrosis.Config.Sphere.Colour = {
		"Розовый",
		"Синий",
		"Оранжевый",
		"Бирюзовый",
		"Пурпурный",
		"666",
		"X"
	}
	Necrosis.Config.Sphere.Count = {
		"Осколки душ",
		"Камни призыва демонов",
		"Таймер оживления",
		"Мана",
		"Здоровье"
	}

	Necrosis.Config.Buttons = {
		["Rotation des boutons"] = "Вращение кнопок",
		["Fixer les boutons autour de la sphere"] = "Закрепить кнопки вокруг Сферы",
		["Utiliser mes propres montures"] = "Use my own mounts",
		["Choix des boutons a afficher"] = "Selection of buttons to be shown",
		["Monture - Clic gauche"] = "Mount - Left click",
		["Monture - Clic droit"] = "Mount - Right click",
	}
	Necrosis.Config.Buttons.Name = {
		"Показывать кнопку Камня огня",
		"Показывать кнопку Камня чар",
		"Показывать кнопку Камня здоровья",
		"Показывать кнопку Камня Души",
		"Показывать кнопку Заклинаний",
		"Показывать кнопку вызова Коня",
		"Показывать кнопку Демонов",
		"Показывать кнопку Проклятий",
	}

	Necrosis.Config.Menus = {
		["Options Generales"] = "Основные настройки",
		["Menu des Buffs"] = "Меню Заклинаний",
		["Menu des Demons"] = "Меню Демонов",
		["Menu des Maledictions"] = "Меню Проклятий",
		["Afficher les menus en permanence"] = "Всегда показывать меню",
		["Afficher automatiquement les menus en combat"] = "Показывать меню автоматически во время боя",
		["Fermer le menu apres un clic sur un de ses elements"] = "Закрывать меню тогда, когда Вы нажали на его элемент",
		["Orientation du menu"] = "Размещение меню",
		["Changer la symetrie verticale des boutons"] = "Изменить вертикальную симметрию кнопок",
		["Taille du bouton Banir"] = "Размер кнопки Изгнания",
	}
	Necrosis.Config.Menus.Orientation = {
		"Горизонтально",
		"Вверх",
		"Вниз"
	}

	Necrosis.Config.Timers = {
		["Type de timers"] = "Тип таймера",
		["Afficher le bouton des timers"] = "Показывать кнопку таймера заклинаний",
		["Afficher les timers sur la gauche du bouton"] = "Показывать строки таймера слева от кнопки таймера",
		["Afficher les timers de bas en haut"] = "Таймер растет вверх",
	}
	Necrosis.Config.Timers.Type = {
		"Нет таймера",
		"Графический",
		"Текстовый"
	}

	Necrosis.Config.Misc = {
		["Deplace les fragments"] = "Размещать осколки душ в выбранной сумке",
		["Detruit les fragments si le sac plein"] = "Разрушать все новые осколки, если сумка полна",
		["Choix du sac contenant les fragments"] = "Выбор контейнера для осколков душ",
		["Nombre maximum de fragments a conserver"] = "Максимальное кол-во хранимых осколков душ",
		["Verrouiller Necrosis sur l'interface"] = "Заблокировать Necrosis",
		["Afficher les boutons caches"] = "Показать скрытые значки для их перемещения",
		["Taille des boutons caches"] = "Размер скрытых значков"
	}

end
