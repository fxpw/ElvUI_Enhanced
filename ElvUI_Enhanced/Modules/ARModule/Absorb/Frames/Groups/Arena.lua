
local E, _, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local ARModule = E:GetModule("ElvUI_ARModule")
local UF = E.UnitFrames
-- local LSM = E.Libs.LSM


function ARModule:Construct_ArenaFrames(frame)
	frame.HealCommBar = ARModule:Construct_HealComm(frame)
end

hooksecurefunc(UF, "Construct_ArenaFrames", ARModule.Construct_ArenaFrames)