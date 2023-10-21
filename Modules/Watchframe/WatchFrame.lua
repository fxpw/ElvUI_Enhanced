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
	-- print("da")
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
			-- print(49,self.db.pvp)
			statedriver[self.db.pvp]()
		elseif instanceType == "arena" then
			-- print(52,self.db.arena)
			statedriver[self.db.arena]()
		elseif instanceType == "party" then
			-- print(55,self.db.party)
			statedriver[self.db.party]()
		elseif instanceType == "raid" then
			-- print(58,self.db.raid)
			statedriver[self.db.raid]()
		else
			-- print(61)
			statedriver["NONE"]()
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

local function ShowLevel()
	for _, button in ipairs(WATCHFRAME_LINKBUTTONS) do
		if button.type == "QUEST" then
			local questIndex = GetQuestIndexForWatch(button.index)
			local title, level = GetQuestLogTitle(questIndex)
			WATCHFRAME_QUESTLINES[button.startLine].text:SetFormattedText("[%d] %s", level, title)
		end
	end
end

function WF:QuestLevelToggle()
	if self.db.level and not self:IsHooked("WatchFrame_Update") then
		self:SecureHook("WatchFrame_Update", ShowLevel)
	elseif not self.db.level and self:IsHooked("WatchFrame_Update") then
		self:Unhook("WatchFrame_Update")
	end

	WatchFrame_Update()
end

function WF:Initialize()
	self.db = E.db.enhanced.watchframe

	self:UpdateSettings()
	self:QuestLevelToggle()
end

local function InitializeCallback()
	WF:Initialize()
end

E:RegisterModule(WF:GetName(), InitializeCallback)