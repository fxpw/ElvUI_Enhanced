local E = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local L = E.Libs.ACL:NewLocale("ElvUI", "ruRU")

-- DESC locales
L["ENH_LOGIN_MSG"] = "Вы используете |cff1784d1ElvUI|r |cff1784d1Enhanced|r |cffff8000(WotLK)|r версии %s%s|r."
L["DURABILITY_DESC"] = "Настройка параметров информации о прочности предметов в окне персонажа."
L["ITEMLEVEL_DESC"] = "Настройка параметров информации об уровне предмета в окне персонажа."
L["WATCHFRAME_DESC"] = "Настройте отображение списка заданий (квест лог) исходя из ваших личных предпочтений."

-- Incompatibility
L["GearScore '3.1.20b - Release' is not for WotLK. Download 3.1.7. Disable this version?"] = "GearScore '3.1.20b - Release' не для WotLK. Загрузите 3.1.7. Отключить эту версию?"

-- AddOn List
L["Enable All"] = "Вкл все"
L["Dependencies: "] = "Зависимости: "
L["Disable All"] = "Выкл все"
L["Load AddOn"] = true
L["Requires Reload"] = "Надо Перезагрузить"

-- Chat
L["Filter DPS meters Spam"] = "Фильтр ДПС СПАМ"
L["Replaces reports from damage meters with a clickable hyperlink to reduce chat spam"] = "Заменяет отчеты от измерителей повреждений с помощью кликабельной гиперссылки для уменьшения спама чата"

-- Datatext
L["Ammo/Shard Counter"] = "Счетчик патрон / стрел "
L["Combat Indicator"] = "Боевой индикатор"
L["Distance"] = "Расстояние"
L["In Combat"] = "В бою"
L["New Mail"] = "Новое Письмо"
L["No Mail"] = "Нет писем"
L["Out of Combat"] = "Из боя"
L["Reincarnation"] = "Реинкарнация"
L["Target Range"] = "Целевой диапазон"

-- Death Recap
L["Death Recap Frame"] = "Рамка Recap Death"
L["%s %s"] = "Урон: %s %s"
L["%s by %s"] = "%s - %s"
L["%s sec before death at %s%% health."] = "%s сек. до смерти при объеме здоровья %s%%"
L["(%d Absorbed)"] = "Поглощено: %d ед. урона."
L["(%d Blocked)"] = "Заблокировано: %d уд. урона."
L["(%d Overkill)"] = "Избыточный урон: %d ед."
L["(%d Resisted)"] = "Сопротивление %d еденицам урона."
L["Death Recap unavailable."] = "Информация о смерти не доступна."
L["Death Recap"] = "Информация о смерти"
L["Killing blow at %s%% health."] = "Объем здоровья при получении смертельного удара: %s%%"
L["You died."] = "Вы умерли."

-- Decline Duels
L["Auto decline all duels"] = "Автоматически отклонять все дуэли."
L["Decline Duel"] = "Отклонять дуэли"
L["Declined duel request from "] = "Отклонять дуэль от "

-- Enhanced Character Frame / Paperdoll Backgrounds
L["Character Background"] = "Фон персонажа"
L["Enhanced Character Frame"] = "Улучшенный фрейм персонажа"
L["Enhanced Model Frames"] = "Enhanced Model Frames"
L["Inspect Background"] = "Проверять фон"
L["Paperdoll Backgrounds"] = "Фоны всплывающего окна"
L["Pet Background"] = "Фон пета"

-- Equipment
L["Damaged Only"] = "Только поврежденные"
L["Enable/Disable the display of durability information on the character screen."] = "Включить/Выключить отображение информации о прочности предметов в окне персонажа."
L["Enable/Disable the display of item levels on the character screen."] = "Включить/Выключить отображение уровня предмета в окне персонажа."
L["Only show durabitlity information for items that are damaged."] = "Показывать уровень прочности только на поврежденных предметах."
L["Quality Color"] = "Качественный цвет"

-- General
L["Add button to Dressing Room frame with ability to undress model."] = true
L["Add button to Trainer frame with ability to train all available skills in one click."] = true
L["Alt-Click Merchant"] = "Alt-Click Торговец"
L["Already Known"] = "Уже известно"
L["Animated Achievement Bars"] = "Анимированные бары достижений"
L["Automatically change your watched faction on the reputation bar to the faction you got reputation points for."] = "Автоматическое изменение фракции на панели репутации на ту, очки репутации которой вы получили."
L["Automatically release body when killed inside a battleground."] = "Автоматически покидать тело после смерти на полях боя."
L["Automatically select the quest reward with the highest vendor sell value."] = "Автоматически выберает награду квеста с наивысшим значением продажи торговцу"
L["Change color of item icons which already known."] = "Измените цвет значков предмета, которые уже известны."
L["Changes the transparency of all the movers."] = "Изменяет прозрачность фиксаторов"
L["Display quest levels at Quest Log."] = "Показать уровни квеста в журнале"
L["Hide Zone Text"] = "Скрыть текст зоны"
L["Holding Alt key while buying something from vendor will now buy an entire stack."] = "Держи Alt, покупая что-то у продавца, чтобы купить весь стек."
L["Mover Transparency"] = "Прозрачность фиксаторов"
L["PvP Autorelease"] = "Автовыход из тела"
L["Select Quest Reward"] = "Выбирать Награду задания"
L["Show Quest Level"] = "Показать уровень квеста"
L["Track Reputation"] = "Отслеживание репутации"
L["Train All Button"] = "Кнопка выучить все"
L["Undress Button"] = "Кнопка для раздевания"
L["Undress"] = "Раздеть"

-- HD Models Portrait Fix
L["Debug"] = true
L["List of models with broken portrait camera. Separete each model name with ';' simbol"] = "Список моделей со сломанной портретной камерой. Отделять каждое название модели символом ';'"
L["Models to fix"] = "Модели для исправления"
L["Portrait HD Fix"] = "Портрет HD Fix."
L["Print to chat model names of units with enabled 3D portraits."] = "Печатает в чате модели имен юнитов с включенными 3D-портретами."

-- Interrupt Tracker
L["Interrupt Tracker"] = "Прерывания"

-- Nameplates
L["Cache Unit Class"] = "Кэш юнит классы"

-- Minimap
L["Above Minimap"] = "Над миникартой"
L["Combat Hide"] = "Прятать в бою"
L["FadeIn Delay"] = "Задержка появления"
L["Hide minimap while in combat."] = "Скрывать миникарту во время боя."
L["Show Location Digits"] = "Показать цифры местоположения"
L["Toggle Location Digits."] = "Переключить цифры местоположения."
L["Location Digits"] = "Цифры координат"
L["Location Panel"] = true
L["Number of digits for map location."] = "Колличество цифр после запятой в координатах."
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = "Время ожидания появления миникарты после выхода из боя. (0 = Выключено)"
L["Toggle Location Panel."] = true

-- Timer Tracker
L["Timer Tracker"] = true
L["Hook DBM"] = true

-- Tooltip
L["Check Player"] = "Проверьте игрока"
L["Check achievement completion instead of boss kill stats.\nSome servers log incorrect boss kill statistics, this is an alternative way to get player progress."] = true
L["Colorize the tooltip border based on item quality."] = "Окрашивать край тултипа в цвет качества предмета"
L["Icecrown Citadel"] = true
L["Item Border Color"] = "Цвет рамки предметов"
L["Progress Info"] = "Прогресс"
L["Ruby Sanctum"] = true
L["Show/Hides an Icon for Achievements on the Tooltip."] = true
L["Show/Hides an Icon for Items on the Tooltip."] = true
L["Show/Hides an Icon for Spells on the Tooltip."] = true
L["Show/Hides an Icon for Spells and Items on the Tooltip."] = true
L["Tiers"] = true
L["Tooltip Icon"] = "Значок всплывающей подсказки"
L["Trial of the Crusader"] = true
L["Ulduar"] = true

-- Movers
L["Loss Control"] = "Потеря контоля"
L["Player Portrait"] = "Портрет игрока"
L["Target Portrait"] = "Портрет цели"

-- Loss Control
L["CC"] = "Потеря контроля"
L["Disarm"] = "Разоружение"
L["Lose Control"] = "Иконка потери контроля"
L["PvE"] = "Рейдовые"
L["Root"] = "Удержание на месте"
L["Silence"] = "Безмолвие"
L["Snare"] = "Замедление"

-- Unitframes
L["Class Icons"] = true
L["Detached Height"] = "Высота при откреплении"
L["Show class icon for units."] = "Показывать иконку класса на цели."

-- WatchFrame
L["City (Resting)"] = "Город (отдых)"
L["Collapsed"] = "Развернуть"
L["Hidden"] = "Скрыть"
L["Party"] = "Группа"
L["PvP"] = "PvP"
L["Raid"] = "Рейд"

--
L["Drag"] = "Перетащить"
L["Left-click on character and drag to rotate."] = "Зажмите левую кнопку мыши и тащите курсор, чтобы вращать изображение."
L["Mouse Wheel Down"] = "Прокрутка вниз"
L["Mouse Wheel Up"] = "Прокрутка вверх"
L["Reset Position"] = "Сбросить позицию"
L["Right-click on character and drag to move it within the window."] = "Зажмите правую кнопку мыши и тащите курсор, чтобы переместить персонажа."
L["Rotate Left"] = "Вращение влево"
L["Rotate Right"] = "Вращение вправо"
L["Zoom In"] = "Приблизить"
L["Zoom Out"] = "Отдалить"

--
L["Character Stats"] = "Характеристики"
L["Damage Per Second"] = "Урон в секунду"
L["Equipment Manager"] = "Комплекты экипировки"
L["Hide Character Information"] = "Скрыть информацию о персонаже"
L["Hide Pet Information"] = "Скрыть информацию о питомце"
L["Item Level"] = "Уровень предметов"
L["New Set"] = "Новый комплект"
L["Resistance"] = "Cопротивление"
L["Show Character Information"] = "Показать информацию о персонаже"
L["Show Pet Information"] = "Показать информацию о питомце"
L["Titles"] = "Звания"
L["Total Companions"] = "Всего питомцев"
L["Total Mounts"] = "Всего"

L["ALL"] = "Все"
L["ALT_KEY"] = "ALT"

L["%d mails\nShift-Click to remove empty mails."] = true
L["Addon |cffFFD100%s|r was merged into |cffFFD100ElvUI_Enhanced|r.\nPlease remove it to avoid conflicts."] = true
L["Cache Unit Guilds / NPC Titles"] = "Кэшировать Гильдии / NPC титулы"
L["Check Achievements"] = "Проверять достижения"
L["Collected"] = true
L["Collection completed."] = true
L["Collection stopped, inventory is full."] = true
L["Color based on reaction type."] = true
L["Compact mode"] = "Компактный режим"
L["Companion Background"] = true
L["Desaturate"] = true
L["Detached Portrait"] = true
L["Dressing Room"] = "Гардеробная"
L["Enhanced"] = "Enhanced"
L["Equipment Info"] = "Информация об предметах"
L["Error Frame"] = "Ошибки "
L["Everywhere"] = "Повсюду"
L["Fog of War"] = "Туман войны"
L["Grow direction"] = "Направление роста"
L["Guild"] = "Гильдия"
L["Inside Minimap"] = "Внутри миникарты"
L["Key Press Animation"] = "Анимация нажатия"
L["Map"] = "Карта"
L["Minimap Button Grabber"] = "Собирать значки на миникарте"
L["NPC"] = "NPC"
L["Overlay Color"] = true
L["Reaction Color"] = true
L["Reported by %s"] = true
L["Rotation"] = true
L["Separator"] = true
L["Set the height of Error Frame. Higher frame can show more lines at once."] = true
L["Set the width of Error Frame. Too narrow frame may cause messages to be split in several lines"] = true
L["Show Everywhere"] = "Показать везде"
L["Show on Arena."] = "Показать на арене."
L["Show on Battleground."] = "Показать на поле битвы."
L["Smooth Animations"] = "Плавные анимации"
L["Take All"] = "Взять все"
L["Take All Mail"] = "Возьми всю почту"
L["Take Cash"] = "Принимать наличные"
L["This addon has been disabled. You should install an updated version."] = true
L["Where to show"] = "Где показать"
L["seconds"] = true
