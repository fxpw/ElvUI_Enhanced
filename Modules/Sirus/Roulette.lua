---@diagnostic disable: param-type-mismatch, redundant-parameter
if select(4, GetAddOnInfo("SirusRouletteHistory")) then return end
EnhancedRuletteCharDB = S_Roulette_Char_DB or EnhancedRuletteCharDB or {};
EnhancedRuletteDB = S_Roulette_DB or EnhancedRuletteDB or {};
if (not Custom_RouletteFrame) then
	return false;
end
local frames = {};
local events = {};
local frame = SRH_MainFrame or CreateFrame("Frame", "SRH_MainFrame", Custom_RouletteFrame);
frame:RegisterEvent("CHAT_MSG_ADDON");
do
	-- if(not Custom_RouletteFrame.closeButton.isSkinned) then
	--     Custom_RouletteFrame:SetScale(0.75);
	-- end

	frame:SetSize(Custom_RouletteFrame:GetWidth() / 2.5, Custom_RouletteFrame:GetHeight() * 0.65);
	if (frame.CreateBackdrop) then
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
	frame:SetPoint("LEFT", Custom_RouletteFrame, "RIGHT", 0, 0)
	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	title:SetText("История рулетки");
	title:SetPoint("TOP", 0, -5);
	local totalTextPerChar = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	totalTextPerChar:SetPoint("BOTTOMLEFT", 5, 35);
	totalTextPerChar:SetSize(frame:GetHeight() * 0.8, 20);
	totalTextPerChar:SetJustifyH("LEFT")
	local totalTextPerAccount = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	totalTextPerAccount:SetPoint("TOP", totalTextPerChar, "BOTTOM", 0, -5);
	totalTextPerAccount:SetSize(frame:GetHeight() * 0.8, 20);
	totalTextPerAccount:SetJustifyH("LEFT")
	function frame:SetTotalPerChar(value)
		totalTextPerChar:SetText(string.format("Всего прокрутов на персонаже: %i", value));
	end

	function frame:SetTotalPerAccount(value)
		totalTextPerAccount:SetText(string.format("Всего прокрутов на аккаунте: %i", value));
	end

	frame:Hide();
	frame:SetAlpha(0);

	local btn_show_hide = CreateFrame("Button", nil, Custom_RouletteFrame);
	btn_show_hide:SetSize(30, 30);
	btn_show_hide.texture = btn_show_hide:CreateTexture();
	btn_show_hide.texture:SetAllPoints(btn_show_hide);
	btn_show_hide.texture:SetTexture("Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47");
	btn_show_hide:ClearAllPoints();
	btn_show_hide:SetPoint("RIGHT", Custom_RouletteFrameCloseButton, "RIGHT", -55, 0);
	btn_show_hide:SetScript("OnClick", function(self)
		if (frame:IsShown()) then
			C_Timer:NewTicker(0.05, function()
				if (frame:GetAlpha() > 0.1) then
					frame:SetAlpha(frame:GetAlpha() - 0.1);
				else
					frame:SetAlpha(frame:GetAlpha() - 0.1);
					frame:Hide();
				end
			end, 10);
		else
			C_Timer:NewTicker(0.05, function()
				if (frame:GetAlpha() < 0.1) then
					frame:Show();
					frame:SetAlpha(frame:GetAlpha() + 0.1);
				else
					frame:SetAlpha(frame:GetAlpha() + 0.1);
				end
			end, 10);
		end
	end)
	btn_show_hide:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:AddLine("Показать/Скрыть историю рулетки.")
		GameTooltip:Show();
	end)
	btn_show_hide:SetScript("OnLeave", function(self)
		GameTooltip:Hide();
	end)
end
local function addElement(key)
	local item = C_Split(key, ":");
	if (type(item) ~= "table" or #item < 3) then
		print("Error: ", key)
		return
	end
	local f = CreateFrame("Button", nil, frame);
	f.ID = key
	do --Frame
		f:SetSize(frame:GetWidth() - 4, frame:GetHeight() / 18 - 2.5);
		if (f.CreateBackdrop) then
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
		if (#frames == 0) then
			f:SetPoint("TopLeft", frame, "TopLeft", 2, -25);
		else
			f:SetPoint("TOP", frames[#frames], "BOTTOM", 0, -3);
		end
	end
	local _, itemlink = GetItemInfo(tonumber(item[1]));
	local fonts = {
		name = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"),
		count = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"),
		total = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"),
		percent = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"),
	}

	do -- fontstrings
		fonts.name:SetPoint("LEFT", 5, 0)
		fonts.name:SetSize(f:GetWidth() * 0.55, f:GetHeight());
		fonts.name:SetJustifyH("LEFT")
		fonts.name:SetText(itemlink);

		fonts.count:SetPoint("LEFT", fonts.name, "RIGHT", 0, 0)
		fonts.count:SetSize(f:GetWidth() * 0.10, f:GetHeight());
		fonts.count:SetJustifyH("LEFT")
		if (tonumber(item[2]) > 1) then
			fonts.count:SetText(string.format("x%i", tonumber(item[2])));
		end

		fonts.total:SetPoint("LEFT", fonts.count, "RIGHT", 3, 0)
		fonts.total:SetSize(f:GetWidth() * 0.13, f:GetHeight());
		fonts.total:SetJustifyH("LEFT")

		fonts.percent:SetPoint("LEFT", fonts.total, "RIGHT", 3, 0)
		fonts.percent:SetSize(f:GetWidth() * 0.2, f:GetHeight());
		fonts.percent:SetJustifyH("LEFT")
	end
	function f:Update()
		local counts = EnhancedRuletteCharDB[self.ID] or 0;
		if (counts == 0) then
			fonts.total:SetText("0");
			fonts.percent:SetText("неизвестно");
		else
			fonts.total:SetText(counts);
			fonts.percent:SetText(string.format("%.3f%%", counts / EnhancedRuletteCharDB.TOTAL * 100));
		end
	end

	f:SetScript("OnEnter", function()
		GameTooltip:SetOwner(f, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(itemlink);
		GameTooltip:AddDoubleLine("|cffFFFFFFВыиграно:|r",
			string.format("|cffFFFFFF%i|r раз(а).", EnhancedRuletteCharDB[f.ID] or 0));
		if (EnhancedRuletteCharDB.TOTAL > 0) then
			if (EnhancedRuletteCharDB[f.ID] > 0) then
				GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r",
					string.format("|cffFFFFFF%.3f%%|r", EnhancedRuletteCharDB[f.ID] / EnhancedRuletteCharDB.TOTAL * 100));
			else
				GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r", "|cffFF3333НЕИЗВЕСТНО|r");
			end
		end

		local globals = { count = 0, total = 0 };
		for _, v in pairs(EnhancedRuletteDB) do
			globals.count = globals.count + (v[f.ID] or 0);
			globals.total = globals.total + (v.TOTAL or 0);
		end
		if (globals.total > 0) then
			GameTooltip:AddLine("Информация по всем персонажам:");
			GameTooltip:AddDoubleLine("|cffFFFFFFВыиграно:|r", string.format("|cffFFFFFF%i|r раз(а).", globals.count));
			if (globals.count == 0) then
				GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r", "|cffFF3333НЕИЗВЕСТНО|r");
			else
				GameTooltip:AddDoubleLine("|cffFFFFFFШанс выиграть:|r",
					string.format("|cffFFFFFF%.3f%%|r", globals.count / globals.total * 100));
			end
		end


		GameTooltip:Show();
	end)
	f:SetScript("OnLeave", function()
		GameTooltip:Hide();
	end)
	return f;
end
frame:SetScript("OnShow", function(self)
	EnhancedRuletteCharDB.TOTAL = EnhancedRuletteCharDB.TOTAL or 0;
	if (not EnhancedRuletteDB[UnitName("Player")]) then
		EnhancedRuletteDB[UnitName("Player")] = EnhancedRuletteCharDB;
	end
	self:SetTotalPerChar(EnhancedRuletteCharDB.TOTAL);
	local total = 0;
	for _, v in pairs(EnhancedRuletteDB or {}) do
		total = total + (v.TOTAL or 0);
	end
	self:SetTotalPerAccount(total);
	if (#frames > 0) then
		for i = 1, #frames do
			frames[i]:Update();
		end
		return;
	end
	for _, v in pairs(Custom_RouletteFrame.rewardList or {}) do
		if (v and type(v) == "table" and v.amountMin) then
			local key = string.format("%i:%i:%i", v.itemID, v.amountMin and v.amountMin or 0, v.isJackpot and 1 or 0);
			if (not EnhancedRuletteCharDB[key]) then
				EnhancedRuletteCharDB[key] = 0;
			end
			local f = addElement(key);
			table.insert(frames, f);
			frames[key] = frames[#frames];
			frames[key]:Update();
		end
	end
end)

do -- Events
	function events:CHAT_MSG_ADDON(prefix, msg)
		if (prefix == "ASMSG_LOTTERY_REWARD" and #msg > 0) then
			if (not EnhancedRuletteCharDB[msg]) then
				EnhancedRuletteCharDB[msg] = 0;
			end
			if (not EnhancedRuletteCharDB.TOTAL) then
				EnhancedRuletteCharDB.TOTAL = 0
			end
			EnhancedRuletteCharDB[msg] = (EnhancedRuletteCharDB[msg] or 0) + 1;
			EnhancedRuletteCharDB.TOTAL = (EnhancedRuletteCharDB.TOTAL or 0) + 1;
			EnhancedRuletteDB[UnitName("Player")] = EnhancedRuletteCharDB;
		elseif (prefix == "ACMSG_LOTTERY_REWARD" and frame:IsShown()) then
			for i = 1, #frames do
				frames[i]:Update();
			end
			frame:SetTotalPerChar(EnhancedRuletteCharDB.TOTAL);
			local total = 0;
			for _, v in pairs(EnhancedRuletteDB or {}) do
				total = total + (v.TOTAL or 0);
			end
			frame:SetTotalPerAccount(total);
		end
	end
end

for k, _ in pairs(events or {}) do
	frame:RegisterEvent(k);
end
frame:SetScript("OnEvent", function(_, event, ...)
	if (not events[event]) then
		return;
	elseif (type(events[event]) == "function") then
		events[event](event, ...);
	end
end)