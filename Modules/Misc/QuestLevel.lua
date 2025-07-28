local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local ipairs = ipairs

local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestLogTitle = GetQuestLogTitle
local HybridScrollFrame_GetOffset = HybridScrollFrame_GetOffset
local QuestLogTitleButton_Resize = QuestLogTitleButton_Resize

local function ShowLevel()
	local scrollOffset = HybridScrollFrame_GetOffset(QuestLogScrollFrame)
	local numEntries = GetNumQuestLogEntries()
	local _, questIndex, title, level, isHeader

	for i, questLogTitle in ipairs(QuestLogScrollFrame.buttons) do
		questIndex = i + scrollOffset

		if questIndex <= numEntries then
			title, level, _, _, isHeader = GetQuestLogTitle(questIndex)

			if not isHeader then
				questLogTitle:SetFormattedText("  [%d] %s", level, title)
				QuestLogTitleButton_Resize(questLogTitle)
			end
		end
	end
end

do
	local old_SetTextColor
	function M:QuestLevelToggle()
		if IsAddOnLoaded("QuestGuru") then return end

		local enabled = E.db.enhanced.general.showQuestLevel
		for _, questLogTitle in ipairs(QuestLogScrollFrame.buttons) do
			if enabled then
				if (not old_SetTextColor) then
					old_SetTextColor = questLogTitle.groupMates.SetTextColor
				end
				questLogTitle.groupMates:SetTextColor(79 / 255, 140 / 255, 201 / 255)
				questLogTitle.groupMates.SetTextColor = function() end
			else
				if (old_SetTextColor) then
					questLogTitle.groupMates.SetTextColor = old_SetTextColor
				end
			end
		end

		if enabled then
			self:SecureHook("QuestLog_Update", ShowLevel)
			self:SecureHookScript(QuestLogScrollFrameScrollBar, "OnValueChanged", ShowLevel)
		else
			self:Unhook("QuestLog_Update")
			self:Unhook(QuestLogScrollFrameScrollBar, "OnValueChanged")
		end

		QuestLog_Update()
	end
end
