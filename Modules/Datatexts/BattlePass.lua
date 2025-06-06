local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local EE = E:GetModule("ElvUI_Enhanced")



local lastPanel

local function OnEvent(self)


	lastPanel = self
end

local function OnEnter(self)

end

local function OnClick(_, btn)
	if btn == "LeftButton" then
	end
end


DT:RegisterDatatext("BattlePass", {"PLAYER_ENTERING_WORLD", "BAG_UPDATE", "UNIT_INVENTORY_CHANGED"}, OnEvent, nil, OnClick, OnEnter, nil, EE:ColorizeSettingName(L["BattlePass"]))