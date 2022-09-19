
local E, _, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ARModule = E:GetModule("ElvUI_ARModule")
local UF = E.UnitFrames
local LSM = E.Libs.LSM


function ARModule:Construct_PlayerFrame(frame)
	frame.HealCommBar = self:Construct_HealComm(frame)
end

hooksecurefunc(UF, "Construct_PlayerFrame", ARModule.Construct_PlayerFrame)