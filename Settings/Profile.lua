local E, L, V, P, G = unpack(ElvUI)


P.enhanced = {
	general = {
		pvpAutoRelease = false,
		autoRepChange = false,
		merchant = false,
		moverTransparancy = 0.8,
		showQuestLevel = false,
		declineduel = false,
		hideZoneText = false,
		trainAllSkills = false,
		undressButton = false,
		alreadyKnown = false,
		deleteFortuneCookie = false,
	},
	actionbar = {
		keyPressAnimation = {
			color = {r = 1, g = 1, b = 1},
			scale = 1.5,
			rotation = 90,
		}
	},
	blizzard = {
		dressUpFrame = {
			enable = false,
			multiplier = 1.25
		},
		errorFrame = {
			enable = false,
			width = 300,
			height = 60,
			font = "PT Sans Narrow",
			fontSize = 12,
			fontOutline = "NONE"
		},
		-- takeAllMail = false
	},
	chat = {
		dpsLinks = false,
	},
	character = {
		animations = true,
		characterBackground = false,
		petBackground = false,
		inspectBackground = false,
		companionBackground = false,
		desaturateCharacter = false,
		desaturatePet = false,
		desaturateInspect = false,
		desaturateCompanion = false,
		-- selectedBGTexture = "HIDE",
		-- customTexture = "",
		-- GemsEnable = true,
		-- GemsEnableScal = true,
		-- GemsSize = 20,
		-- ------------------
		-- ArmoryConfigBackgroundValues = {
		-- 	BackgroundValues = {
		-- 		['HIDE'] = HIDE,
		-- 		['CUSTOM'] = CUSTOM,
		-- 		['Space'] = 'Space',
		-- 		-- ['TheEmpire'] = 'The Empire',
		-- 		['Castle'] = 'Castle',
		-- 		['Alliance-text'] = FACTION_ALLIANCE,
		-- 		['Horde-text'] = FACTION_HORDE,
		-- 		['Arena-bliz'] = ARENA,
		-- 		['CLASS'] = CLASS,
		-- 		-- ['FXPW'] = "FXPW",
		-- 		-- ['Covenant'] = L["Covenant"],
		-- 		-- ['Covenant2'] = L["Covenant"]..' 2',
		-- 	},
		-- 	BlizzardBackdropList = {
		-- 		['Arena-bliz'] = [[Interface\PVPFrame\PvpBg-NagrandArena-ToastBG]]
		-- 	},
		-- 	-- Covenants = {
		-- 	-- 	[0] = 'None',
		-- 	-- 	[1] = 'Kyrian',
		-- 	-- 	[2] = 'Venthyr',
		-- 	-- 	[3] = 'NightFae',
		-- 	-- 	[4] = 'Necrolord',
		-- 	-- },
		-- }
		------------------
	},
	equipment = {
		enable = true,
		font = "Homespun",
		fontSize = 10,
		fontOutline = "MONOCHROMEOUTLINE",
		itemlevel = {
			enable = true,
			qualityColor = true,
			position = "BOTTOMLEFT",
			xOffset = 1,
			yOffset = 4
		},
		durability = {
			enable = false,
			onlydamaged = true,
			position = "TOPLEFT",
			xOffset = 1,
			yOffset = 0
		}
	},
	map = {
		fogClear = {
			enable = false,
			color = {r = 0.5, g = 0.5, b = 0.5, a = 1}
		}
	},
	minimap = {
		location = false,
		showlocationdigits = true,
		locationdigits = 1,
		hideincombat = false,
		fadeindelay = 5,
		buttonGrabber = {
			backdrop = false,
			backdropSpacing = 1,
			mouseover = false,
			alpha = 1,
			buttonSize = 22,
			buttonSpacing = 0,
			buttonsPerRow = 1,
			growFrom = "TOPLEFT",
			insideMinimap = {
				enable = true,
				position = "TOPLEFT",
				xOffset = -1,
				yOffset = 1
			}
		}
	},
	nameplates = {
		classCache = false,
		chatBubblesEnable = false,
		titleCache = false,
		guild = {
			font = "PT Sans Narrow",
			fontSize = 11,
			fontOutline = "OUTLINE",
			separator = " ",
			colors = {
				raid = {r = 1, g = 127/255, b = 0},
				party = {r = 118/255, g = 200/255, b = 1},
				guild = {r = 64/255, g = 1, b = 64/255},
				none = {r = 1, g = 1, b = 1}
			},
			visibility = {
				city = true,
				pvp = true,
				arena = true,
				party = true,
				raid = true
			}
		},
		npc = {
			font = "PT Sans Narrow",
			fontSize = 11,
			fontOutline = "OUTLINE",
			reactionColor = false,
			color = {r = 1, g = 1, b = 1},
			separator = " ",
		},
		chatBubblesTypes = {
			CHAT_MSG_GUILD = true,
			CHAT_MSG_OFFICER = true,
			CHAT_MSG_PARTY = true,
			CHAT_MSG_PARTY_LEADER = true,
			CHAT_MSG_RAID = true,
			CHAT_MSG_RAID_LEADER = true,
			CHAT_MSG_RAID_WARNING = true,
			CHAT_MSG_BATTLEGROUND = true,
			CHAT_MSG_BATTLEGROUND_LEADER = true,
			CHAT_MSG_CHANNEL = true,
			CHAT_MSG_SAY = true,
			CHAT_MSG_YELL = true,
			CHAT_MSG_MONSTER_SAY = true,
			CHAT_MSG_MONSTER_YELL = true,
		}
	},
	tooltip = {
		itemQualityBorderColor = false,
		tooltipIcon = {
			enable = false,
			tooltipIconSpells = true,
			tooltipIconItems = true,
			tooltipIconAchievements = true
		},
		progressInfo = {
			enable = false,
			checkAchievements = false,
			checkPlayer = false,
			modifier = "SHIFT",
			tiers = {
				["DS"] = true,
				["FL"] = true,
				["BH"] = true,
				["TOTFW"] = true,
				["BT"] = true,
				["BWD"] = true
			}
		}
	},
	loseControl = {
		enableCooldownFrame = true,
		enableAbilityName = true,
		enableNumberText = true,
		enableSecondsText = true,
		xOffsetCooldownFrame = 0,
		yOffsetCooldownFrame = 0,
		xOffsetAbilityName = 0,
		yOffsetAbilityName = 0,
		xOffsetNumberText = 0,
		yOffsetNumberText = 0,
		xOffsetSecondsText = 0,
		yOffsetSecondsText = 0,
		colorNumberText = {r = 1, g = 1, b = 1},
		fontAbilityName = "PT Sans Narrow",
		fontSizeAbilityName = 10,
		fontOutlineAbilityName = "OUTLINE",
		fontNumberText = "PT Sans Narrow",
		fontSizeNumberText = 10,
		fontOutlineNumberText = "OUTLINE",
		iconSize = 60,
		-- compactMode = false,
		-- CC = true,
		-- PvE = true,
		-- Silence = true,
		-- Disarm = true,
		-- Root = false,
		-- Snare = false
	},
	timerTracker = {
		dbm = true,
		dbmTimerType = 3
	},
	interruptTracker = {
		size = 32,
		text = {
			enable = true,
			font = "PT Sans Narrow",
			fontSize = 10,
			fontOutline = "OUTLINE",
			position = "CENTER",
			xOffset = 0,
			yOffset = 0,
		}
	},
	unitframe = {
		portraitHDModelFix = {
			enable = false,
			debug = false,
			-- modelsToFix = "scourgemale.m2; dwarfmale.m2; orcmalenpc.m2; scourgemalenpc.m2; scourgefemalenpc.m2; dwarfmalenpc.m2; humanmalekid.m2; humanfemalekid.m2; chicken.m2; rat.m2; scourgemale_hd.m2; scourgefemale_hd.m2; dwarfmale_hd.m2; vulperafemale.m2; worgenmale.m2; vulperamale.m2; humanfemale_hd.m2; darkirondwarfmale.m2"
		},
		detachPortrait = {
			player = {
				enable = false,
				width = 54,
				height = 54
			},
			target = {
				enable = false,
				width = 54,
				height = 54
			}
		},
		hideRoleInCombat = false,
		-----~absorb
		general = {
			roleIcons = {
				icons = "ElvUI",
			}
		},
		colors = {
			absorbPrediction = {
				absorbs = {r = 0, g = 1, b = 1, a = 1},
				healAbsorbs = {r = 1, g = 0, b = 0, a = 0.25},
				overabsorbs = {r = 0, g = 1, b = 1, a = 1},
				overhealabsorbs = {r = 1, g = 0, b = 0, a = 0.25},
			}
		},
		units = {
			-- player = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- 	-- roleIcon = CopyTable(RoleIcon),
			-- },
			target = {
				-- absorbPrediction = CopyTable(AbsorbPrediction),
				-- roleIcon = CopyTable(RoleIcon),
				classicon = {
					enable = false,
					size = 28,
					xOffset = -58,
					yOffset = -22
				}
			},
			-- focus = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- 	-- roleIcon = CopyTable(RoleIcon),
			-- },
			-- pet = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- },
			-- arena = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- 	-- roleIcon = CopyTable(RoleIcon),
			-- },
			-- party = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- },
			-- raid = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- },
			-- raid40 = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- 	-- roleIcon = CopyTable(RoleIcon),
			-- },
			-- raidpet = {
			-- 	-- absorbPrediction = CopyTable(AbsorbPrediction),
			-- },
		},
	},
	watchframe = {
		enable = false,
		level = false,
		city = "COLLAPSED",
		pvp = "HIDE",
		arena = "HIDE",
		party = "COLLAPSED",
		raid = "COLLAPSED",
		noOne = "NONE",
	}
}
