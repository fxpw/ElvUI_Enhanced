
local E, _, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ARModule = E:GetModule("ElvUI_ARModule")
local UF = E.UnitFrames
-- local LSM = E.Libs.LSM


function ARModule:Construct_Raid40Frames()
	UF.HealCommBar = ARModule:Construct_HealComm(self)
end

hooksecurefunc(UF, "Construct_Raid40Frames", ARModule.Construct_Raid40Frames)