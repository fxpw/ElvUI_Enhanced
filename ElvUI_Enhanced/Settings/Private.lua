local E, L, V, P, G = unpack(ElvUI)

V.enhanced = {
	animatedAchievementBars = false,
	deathRecap = false,
	actionbar = {
		keyPressAnimation = false
	},
	character = {
		enable = true,
		modelFrames = false,
		collapsed = false,
		player = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false
			}
		},
		pet = {
			orderName = "",
			collapsedName = {
				ITEM_LEVEL = false,
				BASE_STATS = false,
				MELEE_COMBAT = false,
				RANGED_COMBAT = false,
				SPELL_COMBAT = false,
				DEFENSES = false,
				RESISTANCE = false
			}
		},
		selectedBGTexture = "HIDE",
		customTexture = "",
		GemsEnable = false,
		GemsEnableScal = true,
		GemsSize = 20,
		GearTexturesEnable = false,
		------------------
		ArmoryConfigBackgroundValues = {
			BackgroundValues = {
				['HIDE'] = HIDE,
				['CUSTOM'] = CUSTOM,
				['Space'] = 'Space',
				-- ['TheEmpire'] = 'The Empire',
				['Castle'] = 'Castle',
				['Alliance-text'] = FACTION_ALLIANCE,
				['Horde-text'] = FACTION_HORDE,
				['Arena-bliz'] = ARENA,
				['CLASS'] = CLASS,
				["fxpw"] = "fxpw",
				-- ['Covenant'] = L["Covenant"],
				-- ['Covenant2'] = L["Covenant"]..' 2',
			},
			BlizzardBackdropList = {
				['Arena-bliz'] = [[Interface\PVPFrame\PvpBg-NagrandArena-ToastBG]]
			},
			-- Covenants = {
			-- 	[0] = 'None',
			-- 	[1] = 'Kyrian',
			-- 	[2] = 'Venthyr',
			-- 	[3] = 'NightFae',
			-- 	[4] = 'Necrolord',
			-- },
		}
	},
	timerTracker = {
		enable = false
	},
	loseControl = {
		enable = false
	},
	interruptTracker = {
		enable = false,
		everywhere = false,
		arena = true,
		battleground = false
	},
	minimapButtonGrabber = false
}