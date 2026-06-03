local E, L, V, P, G = unpack(ElvUI)
local ENP = E:NewModule("Enhanced_NamePlates", "AceHook-3.0", "AceEvent-3.0")
local NP = E:GetModule("NamePlates")
local M = E:GetModule("Misc")
local CH = E:GetModule("Chat")

local _G = _G
local ipairs, next, pairs = ipairs, next, pairs
local sub, gsub = string.sub, string.gsub
local match, gmatch, format, lower, find = string.match, string.gmatch, string.format, string.lower, string.find
local tinsert, tremove = table.insert, table.remove

-- local IsInInstance = IsInInstance
-- local IsResting = IsResting
local UnitIsPlayer = UnitIsPlayer
local UnitName = UnitName
local UnitPlayerControlled = UnitPlayerControlled
local UnitReaction = UnitReaction
local ICON_LIST = ICON_LIST
local ICON_TAG_LIST = ICON_TAG_LIST
local UNKNOWN = UNKNOWN

local npcTitleMap = {}

local function UpdateNameplateByName(name)
	if not NP.Plates or not next(NP.Plates) then return end
	for frame in pairs(NP.Plates) do
		if frame.UnitName == name and frame.Health and not frame.Health:IsShown() then
			NP:Update_Name(frame)
		end
	end
end

function ENP:UPDATE_MOUSEOVER_UNIT()
	if UnitIsPlayer("mouseover") and UnitReaction("mouseover", "player") ~= 2 then
		local name, realm = UnitName("mouseover")
		if realm or not name or name == UNKNOWN then return end

	else
		self.scanner:ClearLines()
		self.scanner:SetUnit("mouseover")

		local name = _G["Enhanced_ScanningTooltipTextLeft1"]:GetText()
		if not name then return end
		local description = _G["Enhanced_ScanningTooltipTextLeft2"]:GetText()
		-- print(description)
		if not description then return end

		if match(description, UNIT_LEVEL_TEMPLATE) or find(description, "труп существа") then return end

		name = gsub(gsub((name), "|c........", "" ), "|r", "")
		if name ~= UnitName("mouseover") then return end
		if UnitPlayerControlled("mouseover") then return end

		if not npcTitleMap[description] then
			tinsert(EnhancedDB.NPCList, description)
			npcTitleMap[description] = #EnhancedDB.NPCList
		end

		if EnhancedDB.UnitTitle[name] ~= npcTitleMap[description] then
			EnhancedDB.UnitTitle[name] = npcTitleMap[description]
			UpdateNameplateByName(name)
		end
	end
end

-- Title Cache
local separatorMap = {
	[" "] = "%s",
	["<"] = "<%s>",
	["("] = "(%s)",
	["["] = "[%s]",
	["{"] = "{%s}"
}
local r,g,b
local function Update_NameHook(self, frame)
	if not E.db.enhanced.nameplates.titleCache then return end

	if frame.Health:IsShown() then
		if frame.Title then
			frame.Title:SetText()
			frame.Title:Hide()
		end
		return
	end

	if (frame.UnitType == "FRIENDLY_NPC" or frame.UnitType == "ENEMY_NPC") and EnhancedDB.NPCList[EnhancedDB.UnitTitle[frame.UnitName]] then
		if not frame.Title then
			frame.Title = frame.RaisedElement:CreateFontString(nil, "OVERLAY")
			frame.Title:SetWordWrap(false)
		end

		local db = E.db.enhanced.nameplates.npc
		-- if not separatorMap[db.separator] then return end
		frame.Title:SetFont(E.LSM:Fetch("font", db.font), db.fontSize, db.fontOutline)

		if E.db.enhanced.nameplates.npc.reactionColor then
			db = self.db.colors
			if frame.UnitReaction == 5 then -- friendly
				r, g, b = db.reactions.good.r, db.reactions.good.g, db.reactions.good.b
			elseif frame.UnitReaction == 1 or frame.UnitReaction == 2 then -- hostile
				r, g, b = db.reactions.bad.r, db.reactions.bad.g, db.reactions.bad.b
			elseif frame.UnitReaction == 4  then -- neutral
				r, g, b = db.reactions.neutral.r, db.reactions.neutral.g, db.reactions.neutral.b
			else
				r, g, b = 1, 1, 1
			end
			frame.Title:SetTextColor(r, g, b)
		else
			frame.Title:SetTextColor(db.color.r, db.color.g, db.color.b)
		end

		frame.Title:SetPoint("TOP", frame.Name, "BOTTOM")
		if separatorMap[db.separator] then
			frame.Title:SetFormattedText(separatorMap[db.separator], EnhancedDB.NPCList[EnhancedDB.UnitTitle[frame.UnitName]])
			frame.Title:Show()
		end
	elseif frame.Title then
		frame.Title:SetText("")
	end
end

function ENP:TitleCache()
	if E.db.enhanced.nameplates.titleCache then
		if not self:IsHooked(NP, "Update_Name") then
			self:Hook(NP, "Update_Name", Update_NameHook)
		end
	else
		if self:IsHooked(NP, "Update_Name") then
			self:Unhook(NP, "Update_Name")
		end
	end
end

-- Chat Bubbles
local events = {
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_BATTLEGROUND",
	"CHAT_MSG_BATTLEGROUND_LEADER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_SAY",
	"CHAT_MSG_YELL",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL"
}

local bubbleList = {}
local delayFrame = CreateFrame("Frame")
delayFrame:Hide()
delayFrame:SetScript("OnUpdate", function(self, elapsed)
	local i, frame = 1

	while bubbleList[i] do
		frame = bubbleList[i]
		frame.delay = frame.delay - elapsed

		if frame.delay <= 0 then
			frame.delay = 0
			E:UIFrameFadeOut(frame, .2, frame:GetAlpha(), 0)
			tremove(bubbleList, i)
		else
			i = i + 1
		end
	end

	if #bubbleList == 0 then
		self:Hide()
	end
end)

local function SetBubbleDelay(frame, delay)
	local found

	if #bubbleList > 0 then
		for _, v in ipairs(bubbleList) do
			if v == frame then
				v.delay = delay
				found = true
				break
			end
		end
	end

	if not found then
		frame.delay = delay
		tinsert(bubbleList, frame)
		delayFrame:Show()
	end
end

local inactiveBubbles = {}

local function ReleaseBubble(frame)
	inactiveBubbles[#inactiveBubbles + 1] = frame
	frame.parent.bubbleFrame = nil
	frame:Hide()
end

local function FadeClosure(frame)
	if frame.fadeInfo.mode == "OUT" then
		ReleaseBubble(frame)
	end
end

local function CreateBubble()
	local frame = CreateFrame("Frame")
	frame:SetFrameStrata("BACKGROUND")
	frame:Hide()
	frame.text = frame:CreateFontString()
	frame.text:SetJustifyH("CENTER")
	frame.text:SetJustifyV("MIDDLE")
	frame.text:SetWordWrap(true)
	frame.text:SetNonSpaceWrap(true)
	frame:SetPoint("TOPLEFT", frame.text, -15, 15)
	frame:SetPoint("BOTTOMRIGHT", frame.text, 15, -15)
	M:SkinBubble(frame)

	frame.delay = 0
	frame.FadeObject = {
		finishedFuncKeep = true,
		finishedArg1 = frame,
		finishedFunc = FadeClosure
	}

	return frame
end

local function AcquireBubble()
	local numInactiveObjects = #inactiveBubbles
	if numInactiveObjects > 0 then
		local frame = inactiveBubbles[numInactiveObjects]
		inactiveBubbles[numInactiveObjects] = nil
		return frame
	end

	return CreateBubble()
end

local function replaceIconTags(value)
	value = lower(value)
	if ICON_TAG_LIST[value] and ICON_LIST[ICON_TAG_LIST[value]] then
		return format("%s0|t", ICON_LIST[ICON_TAG_LIST[value]])
	end
end

function ENP:AddBubbleMessage(frame, msg, author, guid)
	if E.private.general.chatBubbleName then
		M:AddChatBubbleName(frame, guid, author)
	else
		frame.Name:SetText()
	end
	if not frame.text:GetFont() then
		frame.text:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
	end

	frame.text:SetText(msg)

	if frame.text:GetStringWidth() > 300 then
		frame.text:SetWidth(300)
	end

	local rebuiltString

	if E.private.chat.enable and E.private.general.classColorMentionsSpeech then
		local classColorTable, lowerCaseWord, isFirstWord, tempWord, wordMatch, classMatch
		if msg and match(msg, "%s-%S+%s*") then
			for word in gmatch(msg, "%s-%S+%s*") do
				tempWord = gsub(word, "^[%s%p]-([^%s%p]+)([%-]?[^%s%p]-)[%s%p]*$","%1%2")
				lowerCaseWord = lower(tempWord)

				classMatch = CH.ClassNames[lowerCaseWord]
				wordMatch = classMatch and lowerCaseWord

				if wordMatch and not E.global.chat.classColorMentionExcludedNames[wordMatch] then
					classColorTable = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[classMatch] or RAID_CLASS_COLORS[classMatch]
					word = gsub(word, gsub(tempWord, "%-","%%-"), format("\124cff%.2x%.2x%.2x%s\124r", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255, tempWord))
				end

				if not isFirstWord then
					rebuiltString = word
					isFirstWord = true
				else
					rebuiltString = format("%s%s", rebuiltString, word)
				end
			end
		end
	end

	if msg then
		rebuiltString = gsub(rebuiltString or msg, "{([^}]+)}", replaceIconTags)
	end

	if rebuiltString then
		frame.text:SetText(rebuiltString)
	end
end

function ENP:FindNameplateByChatMsg(event, msg, author, _, _, _, _, _, channelID, _, _, _, guid)
	if author == UnitName("player") or not author then return end
	if not NP.Plates or not next(NP.Plates) then return end

	local chatType = sub(event, 10)
	if sub(chatType, 1, 7) == "CHANNEL" then
		chatType = "CHANNEL"..channelID
	end
	if not E.db.enhanced.nameplates.chatBubblesTypes[event] then return end
	local info = ChatTypeInfo[chatType]
	if not info then return end

	for frame in pairs(NP.Plates) do
		if frame.UnitName == author then
			local bubbleFrame
			if not frame.bubbleFrame then
				bubbleFrame = AcquireBubble()
				frame.bubbleFrame = bubbleFrame
				bubbleFrame.text:ClearAllPoints()
				bubbleFrame.text:SetPoint("BOTTOM", frame, "TOP", 0, 20)
				bubbleFrame:Show()
				E:UIFrameFadeIn(bubbleFrame, .2, 0, 1)
			else
				bubbleFrame = frame.bubbleFrame
			end

			bubbleFrame.parent = frame

			bubbleFrame.text:SetSize(0, 0)
			bubbleFrame.text:SetTextColor(info.r, info.g, info.b)
			bubbleFrame.author = author

			if E.private.general.chatBubbles == "backdrop" then
				if E.PixelMode then
					bubbleFrame:SetBackdropBorderColor(info.r, info.g, info.b)
				else
					r, g, b = info.r, info.g, info.b
					bubbleFrame.bordertop:SetTexture(r, g, b)
					bubbleFrame.borderbottom:SetTexture(r, g, b)
					bubbleFrame.borderleft:SetTexture(r, g, b)
					bubbleFrame.borderright:SetTexture(r, g, b)
				end
			end

			ENP:AddBubbleMessage(bubbleFrame, msg, author, guid)

			if bubbleFrame.delay == 0 then
				E:UIFrameFadeRemoveFrame(bubbleFrame)
				E:UIFrameFadeIn(bubbleFrame, .2, bubbleFrame:GetAlpha(), 1)
			end

			local _, delayMult = gsub(msg, "%s+", "")
			SetBubbleDelay(bubbleFrame, 2 + (0.5 * delayMult))
		end
	end
end

local function NamePlateCallBackHook(self, nameplate, event, unit)
	if event == 'NAME_PLATE_UNIT_ADDED' then
		if E.db.enhanced.nameplates.chatBubblesEnable then
			if nameplate.bubbleFrame then
				nameplate.bubbleFrame = nil
			end

			if #bubbleList > 0 then
				for _, bubbleFrame in ipairs(bubbleList) do
					if nameplate.UnitName == bubbleFrame.author then
						nameplate.bubbleFrame = bubbleFrame
						bubbleFrame.parent = nameplate
						bubbleFrame.text:ClearAllPoints()
						bubbleFrame.text:SetPoint("BOTTOM", nameplate, "TOP", 0, 20)
						bubbleFrame:Show()
						break
					end
				end
			end
		end
	elseif event == 'NAME_PLATE_UNIT_REMOVED' then
		if nameplate.bubbleFrame then
			nameplate.bubbleFrame:Hide()
		end
		if nameplate.Title then
			nameplate.Title:SetText()
			nameplate.Title:Hide()
		end
	end
end

function ENP:ChatBubbles()
	if E.db.enhanced.nameplates.chatBubblesEnable then
		for _, event in ipairs(events) do
			ENP:RegisterEvent(event, "FindNameplateByChatMsg")
		end
	else
		for _, event in ipairs(events) do
			ENP:UnregisterEvent(event)
		end
	end
end

function ENP:UpdateAllSettings()
	self:ChatBubbles()
	self:TitleCache()

	if E.db.enhanced.nameplates.titleCache then
		if not self.scanner then
			self.scanner = CreateFrame("GameTooltip", "Enhanced_ScanningTooltip", nil, "GameTooltipTemplate")
			self.scanner:SetOwner(WorldFrame, "ANCHOR_NONE")
		end

		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

	else
		self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
	end

	if E.db.enhanced.nameplates.chatBubblesEnable or E.db.enhanced.nameplates.titleCache then
		if not ENP:IsHooked(NP, "NamePlateCallBack") then
			ENP:Hook(NP, "NamePlateCallBack", NamePlateCallBackHook)
		end
	elseif not E.db.enhanced.nameplates.chatBubblesEnable and not E.db.enhanced.nameplates.titleCache then
		if ENP:IsHooked(NP, "NamePlateCallBack") then
			ENP:Unhook(NP, "NamePlateCallBack")
		end
	end
end

function ENP:Initialize()
	EnhancedDB.UnitClass = nil -- removed class caching
	EnhancedDB.GuildList = nil -- removed guild caching
	EnhancedDB.UnitTitle = EnhancedDB.UnitTitle or {}

	if EnhancedDB.NPCList then
		for i, npcTitle in ipairs(EnhancedDB.NPCList) do
			npcTitleMap[npcTitle] = i
		end
	else
		EnhancedDB.NPCList = {}
	end

	ENP:UpdateAllSettings()
end

local function InitializeCallback()
	ENP:Initialize()
end

E:RegisterModule(ENP:GetName(), InitializeCallback)
