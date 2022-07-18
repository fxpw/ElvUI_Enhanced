-- from https://github.com/Mimirone/SirusRouletteHistory
EnhancedRuletteCharDB = S_Roulette_Char_DB or EnhancedRuletteCharDB or {};
if(not Custom_RouletteFrame) then
    return false;
end
local frames = {};
local frame = SRH_MainFrame or CreateFrame("Frame", "SRH_MainFrame", Custom_RouletteFrame);
frame:RegisterEvent("CHAT_MSG_ADDON");
do
    if(not Custom_RouletteFrame.closeButton.isSkinned) then
        Custom_RouletteFrame:SetScale(0.75);
    end

    frame:SetSize(Custom_RouletteFrame:GetWidth()/2.5, Custom_RouletteFrame:GetHeight()*0.65);
    if(frame.CreateBackdrop) then
        frame:CreateBackdrop("Transparent");
    else
        frame:SetBackdrop({
            bgFile = [[Interface\TutorialFrame\TutorialFrameBackground]],
            edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
            tile = true,
            edgeSize = 4,
            tileSize = 5
        });
    end
    frame:SetPoint("LEFT", Custom_RouletteFrame, "RIGHT", 0 ,0)
    local title = frame:CreateFontString(nil,"OVERLAY","GameFontNormal");
    title:SetText("История рулетки");
    title:SetPoint("TOP",0,-5);
    local totalText = frame:CreateFontString(nil,"OVERLAY","GameFontNormal");
    totalText:SetPoint("BOTTOMLEFT",5,7);
    function frame:SetTotal(value)
        totalText:SetText(string.format("Всего прокрутов: %i", value));
    end

    Custom_RouletteFrame.HistoryButton = Custom_RouletteFrame.HistoryButton or CreateFrame("Button", nil, Custom_RouletteFrame)
    local showButton = Custom_RouletteFrame.HistoryButton
    showButton:CreateBackdrop("Transparent")
    showButton:SetSize(75,24)
    showButton.text = showButton:CreateFontString(nil, "OVERLAY", "GameTooltipText");
    showButton.text:SetText("История")
    showButton.text:SetPoint("CENTER",0,0)
    showButton:SetPoint("BOTTOM", Custom_RouletteFrame.closeButton,"BOTTOM",-40,-40)
    -- showButton:Show()
    showButton:SetScript("OnClick",function()
        if frame:IsShown() then
            frame:Hide()
        else
            frame:Show()
        end
    end)


end
local function addElement(key)
    local item = C_Split(key, ":");
    if(type(item) ~= "table" or #item < 3) then print("Error: ", key) return end
    local f = CreateFrame("Button", nil, frame);
    f.ID = key
    do  --Frame
        f:SetSize(frame:GetWidth()-4, frame:GetHeight() / 16 - 2.5);
        if ( f.CreateBackdrop) then
            f:CreateBackdrop("Transparent");
        else
            f:SetBackdrop({
                bgFile = [[Interface\TutorialFrame\TutorialFrameBackground]],
                edgeFile = nil,
                tile = true,
                edgeSize = 1,
                tileSize = 5
            });
        end
        f:ClearAllPoints();
        if(#frames == 0) then
            f:SetPoint("TopLeft", frame, "TopLeft", 2, -25);
        else
            f:SetPoint("TOP", frames[#frames], "BOTTOM", 0, -3);
        end
    end
    local itemname, itemlink = GetItemInfo(tonumber(item[1]));
    local fonts = {
        name = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"),
        count = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"),
        total = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"),
        percent = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall"),
    }

    do  -- fontstrings
        fonts.name:SetPoint("LEFT", 5,0)
        fonts.name:SetSize(f:GetWidth()*0.55, f:GetHeight());
        fonts.name:SetJustifyH("LEFT")
        fonts.name:SetText(itemlink);

        fonts.count:SetPoint("LEFT", fonts.name, "RIGHT", 0,0)
        fonts.count:SetSize(f:GetWidth()*0.10, f:GetHeight());
        fonts.count:SetJustifyH("LEFT")
        if(tonumber(item[2]) > 1) then
            fonts.count:SetText(string.format("x%i", tonumber(item[2])));
        end

        fonts.total:SetPoint("LEFT", fonts.count, "RIGHT", 3,0)
        fonts.total:SetSize(f:GetWidth()*0.13, f:GetHeight());
        fonts.total:SetJustifyH("LEFT")

        fonts.percent:SetPoint("LEFT", fonts.total, "RIGHT", 3,0)
        fonts.percent:SetSize(f:GetWidth()*0.2, f:GetHeight());
        fonts.percent:SetJustifyH("LEFT")
    end
    function f:Update()
        local counts = EnhancedRuletteCharDB[self.ID] or 0;
        if(counts == 0) then
            fonts.total:SetText("0");
            fonts.percent:SetText("неизвестно");
        else
            fonts.total:SetText(counts);
            fonts.percent:SetText(string.format("%.3f%%", counts/EnhancedRuletteCharDB.TOTAL*100));
        end
    end
    f:SetScript("OnEnter", function ()
        GameTooltip:SetOwner(f,"ANCHOR_RIGHT");
        GameTooltip:SetHyperlink(itemlink);
        GameTooltip:AddDoubleLine("|cffFFFFFFВыиграно:|r", string.format("|cffFFFFFF%i|r раз(а).", EnhancedRuletteCharDB[f.ID] or 0));
        if(EnhancedRuletteCharDB.TOTAL > 0) then
            if(EnhancedRuletteCharDB[f.ID] > 0) then
                GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r", string.format("|cffFFFFFF%.3f%%|r", EnhancedRuletteCharDB[f.ID] /EnhancedRuletteCharDB.TOTAL*100));
            else
                GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r", "|cffFF3333НЕИЗВЕСТНО|r");
            end
        end
        GameTooltip:Show();
    end)
    f:SetScript("OnLeave", function ()
        GameTooltip:Hide();
    end)
    return f;
end
frame:SetScript("OnShow", function ()
    EnhancedRuletteCharDB.TOTAL = EnhancedRuletteCharDB.TOTAL or 0;
    frame:SetTotal(EnhancedRuletteCharDB.TOTAL);
    if(#frames > 0) then
        for i = 1, #frames do
            frames[i]:Update();
        end
        return;
    end
    for _, v in pairs(Custom_RouletteFrame.rewardData or {}) do
        if(v and type(v) == "table" and v.itemCountMin) then
            local key = string.format("%i:%i:%i",v.itemEntry, v.itemCountMin and v.itemCountMin or 0, v.isJackpot and 1 or 0);
            if(not EnhancedRuletteCharDB[key]) then
                EnhancedRuletteCharDB[key] = 0;
            end
            local f = addElement(key);
            table.insert(frames, f);
            frames[key] = frames[#frames];
            frames[key]:Update();
        end
    end
end)

frame:SetScript("OnEvent", function (self, event, prefix, msg,  ...)
    if(prefix == "ASMSG_LOTTERY_REWARD") then
        EnhancedRuletteCharDB[msg] = EnhancedRuletteCharDB[msg] + 1;
        EnhancedRuletteCharDB.TOTAL = EnhancedRuletteCharDB.TOTAL + 1;
        if(self:IsShown())then
            for i = 1, #frames do
                frames[i]:Update();
            end
            self:SetTotal(EnhancedRuletteCharDB.TOTAL);
        end
    end
end)

frame:Hide()
