
local E, _, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ARModule = E:GetModule("ElvUI_ARModule")
local UF = E.UnitFrames
-- local LSM = E.Libs.LSM


function ARModule.HealthClipFrame_OnUpdate(clipFrame)
	ARModule.HealthClipFrame_HealComm(clipFrame.__frame)

	clipFrame:SetScript("OnUpdate", nil)
end

UF.HealthClipFrame_OnUpdate = ARModule.HealthClipFrame_OnUpdate