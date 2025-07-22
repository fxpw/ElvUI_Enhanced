local E, L, V, P, G = unpack(ElvUI)
local WF = E:NewModule("Enhanced_WatchFrame", "AceHook-3.0", "AceEvent-3.0")
local B = E:GetModule("Blizzard")

local GetQuestIndexForWatch = GetQuestIndexForWatch
local GetQuestLogTitle = GetQuestLogTitle
local IsInInstance = IsInInstance
local IsResting = IsResting
local UnitAffectingCombat = UnitAffectingCombat

local statedriver = {
	["EXPAND"] = function()
		ObjectiveTrackerFrame.userCollapsed = false
		B:ObjectiveTracker_Expand(ObjectiveTrackerFrame)
		ObjectiveTrackerFrame:Show()
	end,
	["COLLAPSE"] = function()
		ObjectiveTrackerFrame.userCollapsed = true
		B:ObjectiveTracker_Collapse(ObjectiveTrackerFrame)
		ObjectiveTrackerFrame:Show()
	end,
	["HIDE"] = function()
		ObjectiveTrackerFrame:Hide()
	end,
	["NONE"] = function()
		-- WatchFrame:Hide()
	end
}

function WF:ChangeState()
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
	if self.db.enable then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ChangeState")
		self:RegisterEvent("PLAYER_UPDATE_RESTING", "ChangeState")
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("PLAYER_UPDATE_RESTING")
	end
end

local function ShowLevel(self, index)
	-- local numWatches = GetNumQuestWatches()
	-- for index = 1, numWatches do
	local questLogIndex = GetQuestIndexForWatch(index)
	local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily, questID = GetQuestLogTitle(questLogIndex)
	local levelTextColor = GetQuestDifficultyColor(level)
	local block, isExistingBlock = self.usedBlocks[self.blockTemplate][questID]
	block.HeaderText:SetTextColor(levelTextColor.r, levelTextColor.g, levelTextColor.b);
	block.HeaderText:SetFormattedText("[%d] %s", level, title)
	block.height = block.HeaderText:GetStringHeight();
	-- end
end

function WF:QuestLevelToggle()
	if self.db.level and not self:IsHooked(QuestObjectiveTracker, "UpdateSingle") then
		self:SecureHook(QuestObjectiveTracker, "UpdateSingle", ShowLevel)
	elseif not self.db.level and self:IsHooked(QuestObjectiveTracker, "UpdateSingle") then
		self:Unhook(QuestObjectiveTracker, "UpdateSingle")
	end
	ObjectiveTrackerFrame:Update()
end

function WF:Initialize()
	self.db = E.db.enhanced.watchframe

	self:UpdateSettings()
	self:QuestLevelToggle()
end

E:RegisterModule(WF:GetName())