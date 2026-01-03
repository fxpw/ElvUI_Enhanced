---@diagnostic disable: param-type-mismatch
local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")


-- local function ElvUI_ConstructLFGFrame()

local MainFrame = ElvUI_LookingForGuildFrame or CreateFrame("Frame","ElvUI_LookingForGuildFrame",LookingForGuildFrame)
MainFrame.history = {}
MainFrame:CreateBackdrop("Transparent")
MainFrame:SetSize(300,400)
MainFrame:SetPoint("LEFT",LookingForGuildFrame,"RIGHT",40,0)



local ScrollParent =  CreateFrame("Frame", "ElvUI_LookingForGuildFrameScrollParent",MainFrame)
ScrollParent:SetAllPoints(MainFrame)

local font = "ChatFontSmall"
local fontHeight = select(2, getglobal(font):GetFont())
local recordHeight = fontHeight + 2
local recordWidth = ScrollParent:GetWidth() - 35
local numLogRecordFrames = math.floor((ScrollParent:GetHeight() - 3) / recordHeight)
-- local record = ScrollFrame:CreateFontString("ElvUI_LookingForGuildFrameRecordButton1", OVERLAY, font)
local record = CreateFrame("Button","ElvUI_LookingForGuildFrameRecordButton1", ScrollParent)
record:SetHeight(recordHeight)
record:SetWidth(recordWidth)
record.fnstngLeft = record:CreateFontString("ElvUI_LookingForGuildFrameRecordButtonFSL1",OVERLAY,"GameTooltipText")
record.fnstngLeft:SetPoint("LEFT",record,"LEFT",0,0)
record.fnstngRight = record:CreateFontString("ElvUI_LookingForGuildFrameRecordButtonFSR1",OVERLAY,"GameTooltipText")
record.fnstngRight:SetPoint("RIGHT",record,"RIGHT",0,0)
record:SetText("test")
record.tanktext = record:CreateTexture()
record.tanktext:SetSize(recordHeight,recordHeight)
record.tanktext:SetPoint("BOTTOMRIGHT",record,"BOTTOMRIGHT",-30,0)
record.tanktext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\tank]])
record.healtext = record:CreateTexture()
record.healtext:SetSize(recordHeight,recordHeight)
record.healtext:SetPoint("RIGHT",record.tanktext,"LEFT",-1,0)
record.healtext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\healer]])
record.dpstext = record:CreateTexture()
record.dpstext:SetSize(recordHeight,recordHeight)
record.dpstext:SetPoint("RIGHT",record.healtext,"LEFT",-1,0)
record.dpstext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\dps]])
-- record:SetNonSpaceWrap(false)
record:SetScript("OnEnter",function(self)
end)
record:SetScript("OnLeave",function(self)
    GameTooltip:Hide()
end)
record:SetPoint("TOPLEFT", ScrollParent, "TOPLEFT", 5, -3)
for i=2,numLogRecordFrames do
    record =  CreateFrame("Button","ElvUI_LookingForGuildFrameRecordButton"..i, ScrollParent)
    record:SetHeight(recordHeight)
    record:SetWidth(recordWidth)
    record.fnstngLeft = record:CreateFontString("ElvUI_LookingForGuildFrameRecordButtonFSL"..i,OVERLAY,"GameTooltipText")
    record.fnstngLeft:SetPoint("LEFT",record,"LEFT",0,0)
    record.fnstngRight = record:CreateFontString("ElvUI_LookingForGuildFrameRecordButtonFSR"..i,OVERLAY,"GameTooltipText")
    record.fnstngRight:SetPoint("RIGHT",record,"RIGHT",0,0)
    record.tanktext = record:CreateTexture()
    record.tanktext:SetSize(recordHeight,recordHeight)
    record.tanktext:SetPoint("BOTTOMRIGHT",record,"BOTTOMRIGHT",-30,0)
    record.tanktext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\tank]])
    record.healtext = record:CreateTexture()
    record.healtext:SetSize(recordHeight,recordHeight)
    record.healtext:SetPoint("RIGHT",record.tanktext,"LEFT",-1,0)
    record.healtext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\healer]])
    record.dpstext = record:CreateTexture()
    record.dpstext:SetSize(recordHeight,recordHeight)
    record.dpstext:SetPoint("RIGHT",record.healtext,"LEFT",-1,0)
    record.dpstext:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\dps]])
    record:SetScript("OnEnter",function(self)
    end)
    record:SetScript("OnLeave",function(self)
        GameTooltip:Hide()
    end)
    -- record:SetNonSpaceWrap(false)
    record:SetPoint("TOPLEFT", "ElvUI_LookingForGuildFrameRecordButton"..(i-1), "BOTTOMLEFT")
end


local ScrollBar = CreateFrame("ScrollFrame", "ElvUI_LookingForGuildFrameScrollParentScrollBar",ScrollParent,"FauxScrollFrameTemplateLight")
ScrollBar:SetWidth(ScrollParent:GetWidth() - 35)
ScrollBar:SetHeight(ScrollParent:GetHeight() - 10)
ScrollBar:SetPoint("RIGHT", ScrollParent, "RIGHT", -35, 0)


-- local function LogRecordToString(record,i)
--     -- if record <= #historyRB then return "---------" end
--     -- local timestamp, name, message = unpack(record)
--     -- local timestamp = record.timespam
--     -- local name = record.namespam
--     -- local raid = record.raid
--     -- print(timestamp, name, message)
--     -- if not timestamp or not name or not raid then
--     -- 	return "NAIDI MENYA"
--     -- else
--         return record[1]
--     -- end
-- end
local guildId = 1

local function SendMessageForRecrutingGuild(text)

    local value = tonumber(C_CVAR_FL_GUILD_SETTINGS2) or 0

    local interests, availability, classRoles, activityTimes = 0, 0, 0, 0;

    local flagIndex = 0;
    for param = LFGUILD_PARAM_QUESTS, LFGUILD_PARAM_RP do
        if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
            interests = bit.bor(interests, bit.lshift(1, flagIndex));
        end
        flagIndex = flagIndex + 1;
    end

    flagIndex = 0;
    for param = LFGUILD_PARAM_WEEKDAYS, LFGUILD_PARAM_WEEKENDS do
        if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
            availability = bit.bor(availability, bit.lshift(1, flagIndex));
        end
        flagIndex = flagIndex + 1;
    end

    flagIndex = 0;
    for param = LFGUILD_PARAM_TANK, LFGUILD_PARAM_DAMAGE do
        if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
            classRoles = bit.bor(classRoles, bit.lshift(1, flagIndex));
        end
        flagIndex = flagIndex + 1;
    end

    flagIndex = 0;
    for param = LFGUILD_PARAM_MORNING, LFGUILD_PARAM_NIGHT do
        if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
            activityTimes = bit.bor(activityTimes, bit.lshift(1, flagIndex));
        end
        flagIndex = flagIndex + 1;
    end
    SendServerMessage("ACMSG_GF_ADD_RECRUIT", string.format("%d|%d|%d|%d|%d|%s", classRoles, interests, availability, guildId, activityTimes, text));
end
StaticPopupDialogs["ELVUILFGH"] = {
    text = "",
    button1 = "Да",
    button2 = "Нет, я еще посмотрю",

    OnShow = function (self)
        -- self.text = guildName
        self.editBox:SetText("Заметка(необязательно)")
    end,
    OnAccept = function (self, data, data2)
        local text = self.editBox:GetText()
        -- do whatever you want with it
            SendMessageForRecrutingGuild(text)
    end,
    hasEditBox = true,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,  -- avoid some UI taint
}

local function LogChanged()
    if not MainFrame:IsVisible() then
        return
    end
    -- UpdateRecors()
    --local log = #HistoryRB
    local offset = FauxScrollFrame_GetOffset(ScrollBar)
    -- print(offset,862)
    local numRecords = #MainFrame.history
    font = "ChatFontSmall"
    fontHeight = select(2, getglobal(font):GetFont())
    recordHeight = fontHeight + 2
    recordWidth = ScrollParent:GetWidth() - 35
    -- numLogRecordFrames = math.floor(
    -- (MainFrame.ScrollFrame:GetHeight() - 3) / recordHeight)
    -- print(numRecords)
    local numDisplayedRecords = math.min(numLogRecordFrames, numRecords - offset)
    for i=1,numLogRecordFrames do
        -- print(i,864)
        local buttontoshow = _G["ElvUI_LookingForGuildFrameRecordButton"..i]
        local fnstrngtoshowL = _G["ElvUI_LookingForGuildFrameRecordButtonFSL"..i]
        local fnstrngtoshowR = _G["ElvUI_LookingForGuildFrameRecordButtonFSR"..i]
        buttontoshow:SetWidth(recordWidth)
        local logIndex = i + offset - 1
        -- print(logIndex,870)
        -- print(LogRecordToStringRB(logIndex),868)
        if logIndex < numRecords then
            -- print(874)
            local IsNeedTank = MainFrame.history[#MainFrame.history-logIndex][18]
            local IsNeedHeal = MainFrame.history[#MainFrame.history-logIndex][19]
            local IsNeedDPS = MainFrame.history[#MainFrame.history-logIndex][20]
            local comment = MainFrame.history[#MainFrame.history-logIndex][4]
            local ilvl
            local name = MainFrame.history[#MainFrame.history-logIndex][1]
            local lvl = MainFrame.history[#MainFrame.history-logIndex][2]
            local members = MainFrame.history[#MainFrame.history-logIndex][3]
            local s,e = string.find(comment,"[1-2][0-9][0-9]")
            if  s and e then
                ilvl = string.sub(comment,s,e)
            else
                ilvl = "Нет"
            end
            if IsNeedTank then
                buttontoshow.tanktext:Show()
            else
                buttontoshow.tanktext:Hide()
            end
            if IsNeedHeal then
                buttontoshow.healtext:Show()
            else
                buttontoshow.healtext:Hide()
            end
            if IsNeedDPS then
                buttontoshow.dpstext:Show()
            else
                buttontoshow.dpstext:Hide()
            end
            fnstrngtoshowR:SetText(ilvl)
            -- recordtoshow:SetText
            -- print(LogRecordToStringRB(logIndex),870)
            fnstrngtoshowL:SetText(MainFrame.history[#MainFrame.history-logIndex][1])
            -- recordtoshow:SetPoint("LEFT",recordtoshow,"RIGHT")
            buttontoshow:SetScript("OnEnter",function(self)
                -- local name, lvl, members

                -- comment = MainFrame.history[#MainFrame.history-logIndex][4]
                -- guildInfo[1] = guild[GF_BROWSE_UPDATE.Name];
                -- guildInfo[2] = tonumber(guild[GF_BROWSE_UPDATE.Level]) or 1;
                -- guildInfo[3] = tonumber(guild[GF_BROWSE_UPDATE.MemberCount]) or 1;
                -- guildInfo[4] = guild[GF_BROWSE_UPDATE.Comment];
                GameTooltip:SetOwner(UIParent, 'ANCHOR_CURSOR_RIGHT');
                GameTooltip:AddLine("Имя гильдии: "..name)
                GameTooltip:AddLine("Уровень гильдии: "..lvl)
                GameTooltip:AddLine("Кол ов игроков в гильдии: "..members)
                GameTooltip:AddLine("Сообщение: \n"..comment)
                -- GameTooltip:AddLine("Сообщение: ".."test")
                GameTooltip:Show()
            end)
            buttontoshow:SetScript("OnLeave",function(self)
                GameTooltip:Hide()
            end)
            buttontoshow.base = MainFrame.history[#MainFrame.history-logIndex]
            -- buttontoshow.card = buttontoshow.card or tcopy(_G[cardsToIndex[cardIndex]])
            buttontoshow:SetScript("OnClick",function(self)
                guildId = self.base[30]
                StaticPopupDialogs["ELVUILFGH"].text = self.base[1]
                StaticPopup_Show("ELVUILFGH")
                -- self.card.RequestToJoinClub(self.card)
                -- LookingForGuildRequestToJoinMixin:Initialize(self.base)
                -- LookingForGuildRequestToJoinMixin:ElvUIInitialize(self.base)
            end)
            -- recordtoshow:SetJustifyH("LEFT")
            buttontoshow:Show()
        else
            buttontoshow:Hide()
        end
    end
    FauxScrollFrame_Update(ScrollBar, numRecords, numDisplayedRecords, recordHeight)
end


MainFrame:RegisterEvent("CHAT_MSG_ADDON")

local GF_BROWSE_UPDATE = {
	GuildID = 1,
	EmblemInfo = 2,
	Comment = 3,
	Interests = 4,
	Level = 5,
	Name = 6,
	HasRequest = 7,
	Availability = 8,
	ClassRoles = 9,
	MemberCount = 10,
	ActivityTimes = 11,
};

-- local NUM_LF_GUILD_SETTINGS_FLAGS = 13;
local NUM_LF_GUILD_INTERESTS_FLAGS = 5;
local NUM_LF_GUILD_AVAILABILITY_FLAGS = 2;
local NUM_LF_GUILD_CLASS_ROLES_FLAGS = 3;
local NUM_LF_GUILD_ACTIVITY_TIME_FLAGS = 4;



MainFrame:SetScript("OnEvent",function(self,...)
    if select(2,...) == "ASMSG_GF_BROWSE_UPDATE" and #select(3,...) > 1 then
        -- print(...)
        -- print(select(3,...))
        local msg = select(3,...)

        local guild = {strsplit("|", msg)};

        local guildID = tonumber(guild[GF_BROWSE_UPDATE.GuildID]) or 0;
        local requestPending = guild[GF_BROWSE_UPDATE.HasRequest] == "true";

        local guildInfo = {};
        guildInfo[1] = guild[GF_BROWSE_UPDATE.Name];
        guildInfo[2] = tonumber(guild[GF_BROWSE_UPDATE.Level]) or 1;
        guildInfo[3] = tonumber(guild[GF_BROWSE_UPDATE.MemberCount]) or 1;
        guildInfo[4] = guild[GF_BROWSE_UPDATE.Comment];
        guildInfo[5] = requestPending;

        local tabardInfo = {strsplit(":", guild[GF_BROWSE_UPDATE.EmblemInfo])}
        for i = 1, 5 do
            guildInfo[#guildInfo + 1] = tonumber(tabardInfo[i]) or 0;
        end

        local interests = tonumber(guild[GF_BROWSE_UPDATE.Interests]) or 0;
        for index = 0, (NUM_LF_GUILD_INTERESTS_FLAGS - 1) do
            guildInfo[#guildInfo + 1] = bit.band(interests, bit.lshift(1, index)) ~= 0;
        end

        local availability = tonumber(guild[GF_BROWSE_UPDATE.Availability]) or 0;
        for index = 0, (NUM_LF_GUILD_AVAILABILITY_FLAGS - 1) do
            -- print(#guildInfo)
            guildInfo[#guildInfo + 1] = bit.band(availability, bit.lshift(1, index)) ~= 0;
        end

        local classRoles = tonumber(guild[GF_BROWSE_UPDATE.ClassRoles]) or 0;
        for index = 0, (NUM_LF_GUILD_CLASS_ROLES_FLAGS - 1) do
            guildInfo[#guildInfo + 1] = bit.band(classRoles, bit.lshift(1, index)) ~= 0;
            -- print(#guildInfo)
            -- print(guildInfo[#guildInfo])
        end

        local activityTimes = tonumber(guild[GF_BROWSE_UPDATE.ActivityTimes]) or 0;
        for index = 0, (NUM_LF_GUILD_ACTIVITY_TIME_FLAGS - 1) do
            guildInfo[#guildInfo + 1] = bit.band(activityTimes, bit.lshift(1, index)) ~= 0;
        end
        -- print(guildID)
        guildInfo[30] = guildID;
            -- local tableToInsert
        -- local ifHas = false
        for _,v in pairs(self.history) do
            -- print(k,v)
            if v[1] == guildInfo[1] then
                return
            end
        end
        table.insert(self.history,guildInfo)
        -- cardIndex = cardIndex + 1
        -- if cardIndex == 4 then
        --     cardIndex = 1
        -- end
    end
    LogChanged()
end)

ScrollBar:SetScript("OnVerticalScroll",function(self, value)
    -- local font = "ChatFontSmall"
    -- local fontHeight = select(2, getglobal(font):GetFont())
    -- local recordHeight = fontHeight + 2
    FauxScrollFrame_OnVerticalScroll(ScrollBar, value, recordHeight, LogChanged)
end)
LookingForGuildFrame:HookScript("OnShow",function()
    MainFrame:Show()
end)
LookingForGuildFrame:HookScript("OnHide",function()
    MainFrame:Hide()
end)


local clearButton = CreateFrame("Button","ElvUI_LookingForGuildFrameClearAllButton", MainFrame, "GameMenuButtonTemplate")
clearButton:SetSize(120,25)
clearButton:SetPoint("BOTTOMRIGHT",MainFrame,"BOTTOMRIGHT",0,-25)
clearButton:SetText("Стереть историю")
clearButton:SetScript("OnClick",function()
    table.wipe(MainFrame.history)
    LogChanged()
end)
S:HandleButton(clearButton)


local function UpdateGuildSearch()
    local value = tonumber(C_CVAR_FL_GUILD_SETTINGS2) or 0

	local interests, availability, classRoles, activityTimes, guildSize = 0, 0, 0, 0, 0;

	local index = 0;
	for param = LFGUILD_PARAM_QUESTS, LFGUILD_PARAM_RP do
		if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
			interests = bit.bor(interests, bit.lshift(1, index));
		end
		index = index + 1;
	end

	index = 0;
	for param = LFGUILD_PARAM_WEEKDAYS, LFGUILD_PARAM_WEEKENDS do
		if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
			availability = bit.bor(availability, bit.lshift(1, index));
		end
		index = index + 1;
	end

	index = 0;
	for param = LFGUILD_PARAM_TANK, LFGUILD_PARAM_DAMAGE do
		if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
			classRoles = bit.bor(classRoles, bit.lshift(1, index));
		end
		index = index + 1;
	end

	index = 0;
	for param = LFGUILD_PARAM_MORNING, LFGUILD_PARAM_NIGHT do
		if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
			activityTimes = bit.bor(activityTimes, bit.lshift(1, index));
		end
		index = index + 1;
	end

	index = 0;
	for param = LFGUILD_PARAM_SMALL, LFGUILD_PARAM_LARGE do
		if bit.band(value, bit.lshift(1, param - 1)) ~= 0 then
			guildSize = bit.bor(guildSize, bit.lshift(1, index));
		end
		index = index + 1;
	end
    SendServerMessage("ACMSG_GF_BROWSE", string.format("%s|%s|%s|%s|%s|%s", classRoles, availability, interests, activityTimes, guildSize, ""));
end
local LoadManyGuilds = CreateFrame("Button","ElvUI_LookingForGuildFrameLoadManyGuildButton", MainFrame, "GameMenuButtonTemplate")
LoadManyGuilds:SetSize(120,25)
LoadManyGuilds:SetPoint("BOTTOMLEFT",MainFrame,"BOTTOMLEFT",0,-25)
LoadManyGuilds:SetText("Загрузить много")
LoadManyGuilds:SetScript("OnClick",function()
    C_Timer:NewTicker(0.2,function()
        UpdateGuildSearch()
     end,20)
end)

S:HandleButton(LoadManyGuilds)