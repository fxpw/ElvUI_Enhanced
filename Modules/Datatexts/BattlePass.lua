-- local E, L, V, P, G = unpack(ElvUI)
-- local DT = E:GetModule("DataTexts")
-- local EE = E:GetModule("ElvUI_Enhanced")



-- local bpFrame = CreateFrame("Frame","ELVUI_DATATEXT_BPFRAME",UIParent)
-- bpFrame:SetSize(200,400)
-- bpFrame:SetPoint("CENTER",UIParent)
-- bpFrame:CreateBackdrop("Transparent")
-- bpFrame:Hide()

-- -- local lastPanel

-- local function OnEvent(self)


-- 	-- lastPanel = self
-- end

-- local function OnEnter(self)

-- end




-- local function OnClick(_, btn)
-- 	if btn == "LeftButton" then
-- 		if bpFrame:IsShown() then
-- 			bpFrame:Hide()
-- 		else
-- 			bpFrame:Show()
-- 		end
-- 	end
-- end


-- DT:RegisterDatatext("BattlePass", {"PLAYER_ENTERING_WORLD", "BAG_UPDATE", "UNIT_INVENTORY_CHANGED"}, OnEvent, nil, OnClick, OnEnter, nil, EE:ColorizeSettingName(L["BattlePass"]))