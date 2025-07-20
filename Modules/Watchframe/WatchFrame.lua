local E, L, V, P, G = unpack(ElvUI)
local WF = E:NewModule("Enhanced_WatchFrame", "AceHook-3.0", "AceEvent-3.0")

local ipairs = ipairs

local GetQuestIndexForWatch = GetQuestIndexForWatch
local GetQuestLogTitle = GetQuestLogTitle
local IsInInstance = IsInInstance
local IsResting = IsResting
local UnitAffectingCombat = UnitAffectingCombat

local WATCHFRAME_LINKBUTTONS = WATCHFRAME_LINKBUTTONS
local WATCHFRAME_QUESTLINES = WATCHFRAME_QUESTLINES

local WatchFrame = WatchFrame

local statedriver = {
	["EXPAND"] = function()
		WatchFrame:Show()
		WatchFrame.userCollapsed = false
		WatchFrame_Expand(WatchFrame)
	end,
	["COLLAPSE"] = function()
		WatchFrame:Show()
		WatchFrame.userCollapsed = true
		WatchFrame_Collapse(WatchFrame)
	end,
	["HIDE"] = function()
		WatchFrame:Hide()
	end,
	["NONE"] = function()
		-- WatchFrame:Hide()
	end
}

function WF:ChangeState()
	if true then return end
	if UnitAffectingCombat("player") then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "ChangeState")
		self.inCombat = true
		return
	end

	if IsResting() then
		if statedriver[self.db.city] then
			-- print(43,self.db.city)
			statedriver[self.db.city]()
		end
	else
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			if self.db.pvp and statedriver[self.db.pvp] then
				statedriver[self.db.pvp]()
			end
		elseif instanceType == "arena" then
			if self.db.arena and statedriver[self.db.arena] then
				statedriver[self.db.arena]()
			end
		elseif instanceType == "party" then
			if self.db.party and statedriver[self.db.party] then
				statedriver[self.db.party]()
			end
		elseif instanceType == "raid" then
			if self.db.raid and statedriver[self.db.raid] then
				statedriver[self.db.raid]()
			end
		else
			-- print(61)
			if self.db.noOne and statedriver[self.db.noOne] then
				statedriver[self.db.noOne]()
			end
		end
	end

	if self.inCombat then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self.inCombat = nil
	end
end

function WF:UpdateSettings()
	if true then return end
	if self.db.enable then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ChangeState")
		self:RegisterEvent("PLAYER_UPDATE_RESTING", "ChangeState")
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("PLAYER_UPDATE_RESTING")
	end
end

local function ShowLevel()
	if true then return end
	for _, button in ipairs(WATCHFRAME_LINKBUTTONS) do
		if button.type == "QUEST" then
			local questIndex = GetQuestIndexForWatch(button.index)
			local title, level = GetQuestLogTitle(questIndex)
			WATCHFRAME_QUESTLINES[button.startLine].text:SetFormattedText("[%d] %s", level, title)
		end
	end
end

function WF:QuestLevelToggle()
	if true then return end
	if self.db.level and not self:IsHooked("WatchFrame_Update") then
		self:SecureHook("WatchFrame_Update", ShowLevel)
	elseif not self.db.level and self:IsHooked("WatchFrame_Update") then
		self:Unhook("WatchFrame_Update")
	end

	WatchFrame_Update()
end

function WF:Initialize()
	if true then return end
	self.db = E.db.enhanced.watchframe

	self:UpdateSettings()
	self:QuestLevelToggle()
end

local function InitializeCallback()
	WF:Initialize()
end

E:RegisterModule(WF:GetName(), InitializeCallback)