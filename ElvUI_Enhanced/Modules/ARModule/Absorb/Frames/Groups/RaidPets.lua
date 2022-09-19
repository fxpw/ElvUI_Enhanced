
local E, _, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ARModule = E:GetModule("ElvUI_ARModule")
local UF = E.UnitFrames
-- local LSM = E.Libs.LSM


function ARModule:Construct_RaidpetFrames()
	UF.HealCommBar = ARModule:Construct_HealComm(self)
end

hooksecurefunc(UF, "Construct_RaidpetFrames", ARModule.Construct_RaidpetFrames)