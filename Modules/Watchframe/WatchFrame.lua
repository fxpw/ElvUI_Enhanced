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

local cachedInstanceType = nil

function WF:UpdateInstanceType()
	local _, instanceType = IsInInstance()
	cachedInstanceType = instanceType
end

function WF:ChangeState()
	if UnitAffectingCombat("player") then
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "ChangeState")
		self.inCombat = true
		return
	end

	if IsResting() then
		if statedriver[self.db.city] then
			statedriver[self.db.city]()
		end
	else
		local instanceType = cachedInstanceType
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

function WF:ZONE_CHANGED_NEW_AREA()
	self:UpdateInstanceType()
	self:ChangeState()
end

function WF:UpdateSettings()
	if self.db.enable then
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA")
		self:RegisterEvent("PLAYER_UPDATE_RESTING", "ChangeState")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:UnregisterEvent("PLAYER_UPDATE_RESTING")
		self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")
	end
end

local function UpdateHighlight(self)
	local headerColor, dashColor;
	if self.isHighlighted then
		headerColor = OBJECTIVE_TRACKER_COLOR["HeaderHighlight"];
		dashColor = OBJECTIVE_TRACKER_COLOR["NormalHighlight"];
	else
		if self.index then
			local questLogIndex = GetQuestIndexForWatch(self.index)
			if(questLogIndex and self.index)then
				local _, level = GetQuestLogTitle(questLogIndex)
				headerColor = GetQuestDifficultyColor(level)
			end
		else
			headerColor = OBJECTIVE_TRACKER_COLOR["Header"];
		end
		dashColor = OBJECTIVE_TRACKER_COLOR["Normal"];
	end

	if self.HeaderText then
		self.HeaderText:SetTextColor(headerColor.r, headerColor.g, headerColor.b);
		self.HeaderText.colorStyle = headerColor;
	end

	for _, line in pairs(self.usedLines) do
		local colorStyle = line.Text.colorStyle.reverse;
		if colorStyle then
			line.Text:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b);
			line.Text.colorStyle = colorStyle;
			if line.Dash then
				line.Dash:SetTextColor(dashColor.r, dashColor.g, dashColor.b);
			end
		end
	end
end

local function ShowLevel(self, index)
	-- local numWatches = GetNumQuestWatches()
	-- for index = 1, numWatches do
	local questLogIndex = GetQuestIndexForWatch(index)
	local title, level, _, _, _, _, _, _, questID = GetQuestLogTitle(questLogIndex)
	local colorStyle = GetQuestDifficultyColor(level)
	local block = self.usedBlocks[self.blockTemplate][questID]
	if block.HeaderText.colorStyle ~= colorStyle then
		block.HeaderText:SetTextColor(colorStyle.r, colorStyle.g, colorStyle.b);
		block.HeaderText.colorStyle = colorStyle;
	end
	block.UpdateHighlight = UpdateHighlight;
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