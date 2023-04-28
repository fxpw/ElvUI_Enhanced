local E, L, V, P, G = unpack(ElvUI)
local LC = E:NewModule("Enhanced_LoseControl", "AceEvent-3.0")

-- local GetSpellInfo = GetSpellInfo
-- local GetTime = GetTime
-- local UnitDebuff = UnitDebuff
local _G = _G
-- local spellNameList = {}
local spellIDList = {
	-- Death Knight
	[47481]	= 13,			-- Gnaw (Ghoul) - Stun
	[51209]	= 13,			-- Hungering Cold - Freeze
	[47476]	= 9,	-- Strangulate
	[45524]	= 8,		-- Chains of Ice
	[55666]	= 8,		-- Desecration
	[58617]	= 8,		-- Glyph of Heart Strike
	[50436]	= 8,		-- Icy Clutch
	-- Druid
	[5211]	= 13,			-- Bash - Stun
	[33786]	= 25,			-- Cyclone - Invulnerablity
	[2637]	= 10,			-- Hibernate - Sleep
	[22570]	= 13,			-- Maim - Stun
	[9005]	= 13,			-- Pounce - Stun
	[339]	= 7,		-- Entangling Roots
	[19675]	= 7,		-- Feral Charge Effect
	[58179]	= 8,		-- Infected Wounds
	[61391]	= 8,		-- Typhoon
	-- Hunter
	[60210]	= 13,			-- Freezing Arrow Effect - Freeze
	[3355]	= 13,			-- Freezing Trap Effect - Freeze
	[24394]	= 13,			-- Intimidation - Stun
	[1513]	= 5,			-- Scare Beast - Fear
	[19503]	= 2,			-- Scatter Shot - Disoriented
	[19386]	= 10,			-- Wyvern Sting - Sleep
	[34490]	= 9,	-- Silencing Shot
	[53359]	= 3,		-- Chimera Shot - Scorpid
	[19306]	= 7,		-- Counterattack
	[19185]	= 7,		-- Entrapment
	[35101]	= 8,		-- Concussive Barrage
	[5116]	= 8,		-- Concussive Shot
	[13810]	= 8,		-- Frost Trap Aura
	[61394]	= 8,		-- Glyph of Freezing Trap
	[2974]	= 8,		-- Wing Clip
	-- Hunter Pets
	[50519]	= 13,			-- Sonic Blast - Stun
	[50541]	= 3,		-- Snatch
	[54644]	= 8,		-- Froststorm Breath
	[50245]	= 7,		-- Pin
	[50271]	= 8,		-- Tendon Rip
	[50518]	= 13,			-- Ravage - Stun
	[54706]	= 7,		-- Venom Web Spray
	[4167]	= 7,		-- Web
	-- Mage
	[44572]	= 13,			-- Deep Freeze - Freeze
	[31661]	= 2,			-- Dragon's Breath - Disoriented
	[12355]	= 13,			-- Impact - Stun
	[118]	= 17,			-- Polymorph - Polymorph
	[18469]	= 9,	-- Silenced - Improved Counterspell
	[64346]	= 3,		-- Fiery Payback
	[33395]	= 7,		-- Freeze
	[122]	= 7,		-- Frost Nova
	[11071]	= 7,		-- Frostbite
	[55080]	= 7,		-- Shattered Barrier
	[11113]	= 8,		-- Blast Wave
	-- [6136]	= 8,		-- Chilled
	[120]	= 8,		-- Cone of Cold
	[116]	= 8,		-- Frostbolt
	[47610]	= 8,		-- Frostfire Bolt
	[31589]	= 8,		-- Slow
	-- Paladin
	[853]	= 13,			-- Hammer of Justice - Stun
	[2812]	= 13,			-- Holy Wrath - Stun
	[20066]	= 10,			-- Repentance - Sleep
	[20170]	= 13,			-- Stun - Stun
	[10326]	= 5,			-- Turn Evil - Fear
	[63529]	= 9,	-- Silenced - Shield of the Templar
	[20184]	= 8,		-- Judgement of Justice
	-- Priest
	[605]	= 1,			-- Mind Control - Sharm
	[64044]	= 24,			-- Psychic Horror - Horror
	[8122]	= 5,			-- Psychic Scream - Fear
	[9484]	= 7,			-- Shackle Undead - Shackle
	[15487]	= 9,	-- Silence
	[64058]	= 3,		-- Psychic Horror
	[15407]	= 8,		-- Mind Flay
	-- Rogue
	[2094]	= 2,			-- Blind - Disoriented
	[1833]	= 13,			-- Cheap Shot - Stun
	[1776]	= 2,			-- Gouge - Disoriented
	[408]	= 13,			-- Kidney Shot - Stun
	[6770]	= 2,			-- Sap - Sapped
	[1330]	= 9,	-- Garrote - Silence
	[18425]	= 9,	-- Silenced - Improved Kick
	[51722]	= 3,		-- Dismantle
	[31125]	= 8,		-- Blade Twisting
	[3409]	= 8,		-- Crippling Poison
	[26679]	= 8,		-- Deadly Throw
	-- Shaman
	[39796]	= 13,			-- Stoneclaw Stun - Stun
	-- [51514]	= "CC",			-- Hex - Polymorph
	[64695]	= 7,		-- Earthgrab
	[63685]	= 7,		-- Freeze
	[3600]	= 8,		-- Earthbind
	[8056]	= 8,		-- Frost Shock
	[8034]	= 8,		-- Frostbrand Attack
	-- Warlock
	-- [710]	= "CC",			-- Banish - Banish
	[6789]	= 5,			-- Death Coil - Fear
	[5782]	= 5,			-- Fear - Fear
	[5484]	= 5,			-- Howl of Terror - Fear
	[6358]	= 1,			-- Seduction - Charm
	[30283]	= 13,			-- Shadowfury - Stun
	[24259]	= 9,	-- Spell Lock
	[18118]	= 8,		-- Aftermath
	[18223]	= 8,		-- Curse of Exhaustion
	-- Warrior
	[7922]	= 13,			-- Charge Stun - Stun
	[12809]	= 13,			-- Concussion Blow - Stun
	[20253]	= 13,			-- Intercept - Stun
	[5246]	= 5,			-- Intimidating Shout - Fear
	[12798]	= 13,			-- Revenge Stun - Stun
	[46968]	= 13,			-- Shockwave - Stun
	[18498]	= 9,	-- Silenced - Gag Order
	[676]	= 3,		-- Disarm
	[58373]	= 7,		-- Glyph of Hamstring
	[23694]	= 7,		-- Improved Hamstring
	[1715]	= 8,		-- Hamstring
	[12323]	= 8,		-- Piercing Howl
	-- Other
	[30217]	= 2,			-- Adamantite Grenade - Disoriented
	[67769]	= 13,			-- Cobalt Frag Bomb - Stun
	[30216]	= 13,			-- Fel Iron Bomb - Stun
	[20549]	= 13,			-- War Stomp - Stun
	[25046]	= 9,	-- Arcane Torrent
	[39965]	= 7,		-- Frost Grenade
	[55536]	= 7,		-- Frostweave Net
	[13099]	= 7,		-- Net-o-Matic
	[29703]	= 8,		-- Dazed
	-- PvE
	[28169]	= 22,		-- Mutating Injection - Infected
	-- [28059]	= "PvE",		-- Positive Charge
	-- [28084]	= "PvE",		-- Negative Charge
	-- [27819]	= "PvE",		-- Detonate Mana
	-- [63024]	= "PvE",		-- Gravity Bomb
	-- [63018]	= "PvE",		-- Searing Light
	[62589]	= 22,		-- Nature's Fury - Infected
	-- [63276]	= "PvE",		-- Mark of the Faceless
	[66770]	= 13,		-- Ferocious Butt - Stun
	-- [71340]	= "PvE",		-- Pact of the Darkfallen
	[70126]	= 13,		-- Frost Beacon - Freeze
	[73785]	= 22,		-- Necrotic Plague - Infected
	[318839] = 8,
}

do
	for k,v in pairs(spellIDList) do
		if type(v) == "number" then
			_G.LOSS_OF_CONTROL_SPELL_DATA[k] = v
		end
	end
end
-- local priorities = {
-- 	["CC"]		= 60,
-- 	["PvE"]		= 50,
-- 	[9]	= 40,
-- 	[3]	= 30,
-- 	[7]	= 20,
-- 	[8]	= 10,
-- }

-- function LC:OnUpdate(elapsed)
-- 	self.timeLeft = self.timeLeft - elapsed

-- 	if self.timeLeft > 10 then
-- 		self.cooldownTime:SetFormattedText("%d", self.timeLeft)
-- 	elseif self.timeLeft > 0 then
-- 		self.cooldownTime:SetFormattedText("%.1f", self.timeLeft)
-- 	else
-- 		self:SetScript("OnUpdate", nil)
-- 		self.timeLeft = nil
-- 		self.cooldownTime:SetText("0")
-- 	end
-- end

-- local function CheckPriority(priority, ccPriority, expirationTime, ccExpirationTime)
-- 	if not ccPriority then
-- 		return true
-- 	end

-- 	if priorities[priority] > priorities[ccPriority] then
-- 		return true
-- 	elseif priorities[priority] == priorities[ccPriority] and expirationTime > ccExpirationTime then
-- 		return true
-- 	end
-- end

-- function LC:UNIT_AURA(event, unit)
-- 	if unit ~= "player" then return end

-- 	local ccExpirationTime = 0
-- 	local ccName, ccIcon, ccDuration, ccPriority, wyvernSting
-- 	local _, name, icon, duration, expirationTime, priority

-- 	for i = 1, 40 do
-- 		name, _, icon, _, _, duration, expirationTime = UnitDebuff("player", i)
-- 		if not name then break end

-- 		if name == self.wyvernStingName then
-- 			wyvernSting = 1

-- 			if not self.wyvernSting then
-- 				self.wyvernSting = 1
-- 			elseif expirationTime > self.wyvernStingExpirationTime then
-- 				self.wyvernSting = 2
-- 			end

-- 			self.wyvernStingExpirationTime = expirationTime

-- 			if self.wyvernSting == 2 then
-- 				name = nil
-- 			end
-- 		elseif name == self.psychicHorrorName and icon ~= "Interface\\Icons\\Ability_Warrior_Disarm" then
-- 			name = nil
-- 		end

-- 		priority = self.db[spellNameList[name]]

-- 		if priority and CheckPriority(priority, ccPriority, expirationTime, ccExpirationTime) then
-- 			ccName = name
-- 			ccIcon = icon
-- 			ccDuration = duration
-- 			ccExpirationTime = expirationTime
-- 			ccPriority = priorities[priority]
-- 		end
-- 	end

-- 	if self.wyvernSting == 2 and not wyvernSting then
-- 		self.wyvernSting = nil
-- 	end

-- 	if ccExpirationTime == 0 then
-- 		if self.ccExpirationTime ~= 0 then
-- 			self.ccExpirationTime = 0
-- 			self.frame.timeLeft = nil
-- 			self.frame:SetScript("OnUpdate", nil)
-- 			self.frame:Hide()
-- 		end
-- 	elseif ccExpirationTime ~= self.ccExpirationTime then
-- 		self.ccExpirationTime = ccExpirationTime

-- 		self.frame.icon:SetTexture(ccIcon)
-- 		self.frame.spellName:SetText(ccName)

-- 		if ccDuration > 0 then
-- 			self.frame.cooldown:SetCooldown(ccExpirationTime - ccDuration, ccDuration)

-- 			local timeLeft = ccExpirationTime - GetTime()

-- 			if self.frame.timeLeft then
-- 				self.frame.timeLeft = timeLeft
-- 			else
-- 				self.frame.timeLeft = timeLeft
-- 				self.frame:SetScript("OnUpdate", self.OnUpdate)
-- 			end
-- 		end

-- 		self.frame:Show()
-- 	end
-- end

-- function LC:UpdateSpellNames()
-- 	local spellName
-- 	for spellID, ccType in pairs(spellIDList) do
-- 		spellName = GetSpellInfo(spellID)

-- 		if spellName then
-- 			spellNameList[spellName] = ccType
-- 		end
-- 	end
-- end

function LC:ToggleState()
	if E.private.enhanced.loseControl.enable then
		if not self.initialized then
			self:Initialize();
			return
		end

		E:EnableMover(self.frame.mover:GetName());
		-- self:RegisterEvent("UNIT_AURA")
	else
		-- self.ccExpirationTime = 0
		-- self.frame.timeLeft = nil
		-- self.frame:SetScript("OnUpdate", nil)
		-- self.frame:Hide();

		E:DisableMover(self.frame.mover:GetName());
		-- self:UnregisterEvent("UNIT_AURA")
	end
end
function LossOfControlTimeLeftFrame_SetTime(self, timeRemaining)
    if (timeRemaining) then
		local color = E:RGBToHex(E.private.enhanced.loseControl.colorNumberText.r, E.private.enhanced.loseControl.colorNumberText.g, E.private.enhanced.loseControl.colorNumberText.b)
		if ( timeRemaining >= 10 ) then
			self.NumberText:SetFormattedText("%s%d", color, timeRemaining);
		elseif (timeRemaining < 9.95) then -- From 9.95 to 9.99 it will print 10.0 instead of 9.9
			self.NumberText:SetFormattedText("%s%.1f", color, timeRemaining);
		end
		self:SetShown(timeRemaining > 0);
		self.timeRemaining = timeRemaining;
		self.numberWidth = self.NumberText:GetStringWidth() + LOSS_OF_CONTROL_TIME_OFFSET;
	else
		self:Hide();
		self.numberWidth = 0;
	end
end

-- function LossOfControlFrame_SetScale(self, scale)
-- 	self:SetScale(scale or 1);

-- 	LossOfControlFrame_SetUpDisplay(self, false);
-- end
-- local hookedfunc = LossOfControlAddOrUpdateDebuff
-- function LossOfControlAddOrUpdateDebuff(...)
-- 	print(...)
-- 	hookedfunc(...)
-- end
local testTimer
function LC:UpdateSettings(testFrame)
	if not self.db then return end
	if testFrame then
		do
			LossOfControlAddOrUpdateDebuff(51724, "Ошеломление","Interface\\Icons\\Ability_Sap", 20, GetTime()+21, 30)
		end
		if testTimer and not testTimer._cancelled then
			testTimer:Cancel()
		end
		testTimer = C_Timer:After(21,function() LossOfControlRemoveDebuff(51724) end)
	end
    local frame = self.frame;
    local icon = self.frame.Icon;
    local cooldown = self.frame.Cooldown; -- фрейм кулдауна
    local abilityName = self.frame.AbilityName; -- название спела
    local numberText = self.frame.TimeLeft.NumberText; -- время
    local secondsText = self.frame.TimeLeft.SecondsText; -- текст [секунд]
	frame:Size(self.db.iconSize);
	cooldown:Size(self.db.iconSize);
	icon:Size(self.db.iconSize);
	-- print(self.db)
	-- print(E.private.enhanced.loseControl.enableCooldownFrame)
	-- print(E.private.enhanced.loseControl.xOffsetCooldownFrame)
    if E.private.enhanced.loseControl.enableCooldownFrame then
        cooldown:Show();
		cooldown:ClearAllPoints()
		cooldown:SetPoint("CENTER",frame,"CENTER",E.private.enhanced.loseControl.xOffsetCooldownFrame,E.private.enhanced.loseControl.yOffsetCooldownFrame)
		if true then
			if cooldown.Overlay then
				cooldown.Overlay:SetAtlas("")
			end
		end
	else
        cooldown:Hide();
    end
    if E.private.enhanced.loseControl.enableAbilityName then
        abilityName:Show();
		abilityName:ClearAllPoints()
		abilityName:SetPoint("CENTER",frame,"CENTER",E.private.enhanced.loseControl.xOffsetAbilityName,E.private.enhanced.loseControl.yOffsetAbilityName)
		abilityName:FontTemplate(E.LSM:Fetch("font", self.db.fontAbilityName), self.db.fontSizeAbilityName, self.db.fontOutlineAbilityName);
		-- abilityName:SetText
    else
        abilityName:Hide();
    end
    if E.private.enhanced.loseControl.enableNumberText then
        numberText:Show();
		numberText:ClearAllPoints()
		numberText:SetPoint("CENTER",frame,"CENTER",E.private.enhanced.loseControl.xOffsetNumberText,E.private.enhanced.loseControl.yOffsetNumberText)
		numberText:FontTemplate(E.LSM:Fetch("font", self.db.fontNumberText), self.db.fontSizeNumberText, self.db.fontOutlineNumberText);
	else
        numberText:Hide();
    end
    if E.private.enhanced.loseControl.enableSecondsText then
        secondsText:Show();
		secondsText:ClearAllPoints()
		secondsText:SetPoint("CENTER",frame,"CENTER",E.private.enhanced.loseControl.xOffsetSecondsText,E.private.enhanced.loseControl.yOffsetSecondsText)
    else
        secondsText:Hide();
    end



    -- print(E.private.enhanced.loseControl.enableCooldownFrame)
    -- print(E.private.enhanced.loseControl.enableAbilityName)
    -- print(E.private.enhanced.loseControl.enableNumberText)
    -- print(E.private.enhanced.loseControl.enableSecondsText)

	-- if self.db.compactMode then
	-- 	self.frame.TimeLeft.NumberText:FontTemplate(E.media.normFont, E:Round(self.db.iconSize / 3), "OUTLINE")
	-- 	self.frame.TimeLeft.NumberText:ClearAllPoints()
	-- 	self.frame.TimeLeft.NumberText:SetPoint("CENTER")
	-- 	self.frame.AbilityName:Hide()
	-- 	self.frame.TimeLeft.SecondsText:Hide()
	-- else
	-- 	self.frame.TimeLeft.NumberText:FontTemplate(E.media.normFont, 20, "OUTLINE")
	-- 	self.frame.TimeLeft.NumberText:SetPoint("BOTTOM", 0, -50)
	-- 	self.frame.AbilityName:Show()
	-- 	self.frame.TimeLeft.SecondsText:Show()
	-- end

end

-- local functionForHook = LossOfControlFrame_SetUpDisplay
-- function LossOfControlFrame_SetUpDisplay(...)
--     functionForHook(...)
--     LC:UpdateSettings()
-- end



function LC:Initialize()
	if not E.private.enhanced.loseControl.enable then return end

	self.db = E.db.enhanced.loseControl;

	self.frame = _G.LossOfControlFrame;
    -- local frame = self.frame;
	-- self.frame:SetPoint("CENTER")
	-- self.frame:SetTemplate()
	-- self.frame:Hide()

	-- self.frame.icon = self.frame.Icon or self.frame:CreateTexture(nil, "ARTWORK")
	-- self.frame.icon:SetInside()

    -- self.frame.icon:SetAllPoints()
    local icon = self.frame.Icon;
	icon:SetTexCoord(unpack(E.TexCoords));
    icon:ClearAllPoints();
    icon:SetAllPoints(self.frame);

    -- local cooldown = self.frame.Cooldown; -- фрейм кулдауна

    -- cooldown:Size(self.frame:GetWidth()-self.frame:GetWidth()/3,self.frame:GetHeight()-self.frame:GetWidth()/3);

    -- cooldown:ClearAllPoints();
    -- cooldown:SetAllPoints(self.frame);


    -- local abilityName = self.frame.AbilityName; -- название спела
	-- abilityName = self.frame.AbilityName or self.frame:CreateFontString(nil, "OVERLAY")
	-- abilityName:FontTemplate(E.media.normFont, 20, "OUTLINE");
    -- abilityName:ClearAllPoints();
	-- abilityName:SetPoint("TOP",self.frame,"BOTTOM", 0, -250);

	-- local numberText = self.frame.TimeLeft.NumberText; -- время

    local secondsText = self.frame.TimeLeft.SecondsText; -- текст [секунд]
	-- secondsText:FontTemplate(E.media.normFont, 20, "OUTLINE");
    -- secondsText:ClearAllPoints();
	-- secondsText:SetPoint("TOP",self.frame,"BOTTOM", 0, -500);
	secondsText:SetText(L["seconds"]);

	self:UpdateSettings();

	E:CreateMover(self.frame, "LossControlMover", L["Loss Control"], nil, nil, nil, "ALL,ARENA",nil,"enhanced,loseControlGroup");

	-- self:UpdateSpellNames()
	-- self.wyvernStingName = GetSpellInfo(19386)
	-- self.psychicHorrorName = GetSpellInfo(64058)

	-- self:RegisterEvent("UNIT_AURA")
	LossOfControlFrame:HookScript("OnUpdate",function(_self)
		LC:UpdateSettings()
	end)
	self.initialized = true;
end


local function InitializeCallback()
	LC:Initialize();
end

E:RegisterModule(LC:GetName(), InitializeCallback);





