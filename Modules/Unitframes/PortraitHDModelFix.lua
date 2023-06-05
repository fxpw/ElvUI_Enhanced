local E, L, V, P, G = unpack(ElvUI)
local UFPM = E:NewModule("Enhanced_PortraitHDModelFix", "AceHook-3.0")
local UF = E:GetModule("UnitFrames")

local _G = _G
local ipairs = ipairs
local type = type
local match, format, lower= string.match, string.format, string.lower

local MAX_BOSS_FRAMES = MAX_BOSS_FRAMES
local MAX_ARENA_ENEMIES = 5
local debug = false
local function checkHDModels()
	local hdTexturePathList = {
		"Character\\Tauren\\Male\\TaurenMaleFaceLower00_00_HD",
		"Character\\Draenei\\Male\\DraeneiMalefaceUpper00_00_hd",
	}

	local f = CreateFrame("Frame")
	f:Hide()
	local t = f:CreateTexture()

	for _, modelPath in ipairs(hdTexturePathList) do
		if t:SetTexture(modelPath) then
			t:SetTexture(nil)
			return true
		end
	end
end
local tableModelList = {
	["dwarfmale.m2"] = true,
	["orcmalenpc.m2"] = true,
	["scourgemalenpc.m2"] = true,
	["scourgefemalenpc.m2"] = true,
	["dwarfmalenpc.m2"] = true,
	["humanmalekid.m2"] = true,
	["humanfemalekid.m2"] = true,
	["chicken.m2"] = true,
	["rat.m2"] = true,
	["scourgemale_hd.m2"] = true,
	["scourgefemale_hd.m2"] = true,
	["dwarfmale_hd.m2"] = true,
	["vulperafemale.m2"] = true,
	["worgenmale.m2"] = true,
	["vulperamale.m2"] = true,
	["humanfemale_hd.m2"] = true,
	["darkirondwarfmale.m2"] = true,
	["dracthyrdragonmale1.m2"] = true,
	["dracthyrfemale.m2"] = true,
	["dracthyrdragonfemale2.m2"] = true,
	["dracthyrdragonfemale3.m2"] = true,
	["skeleton_hd.m2"] = true,
	["taurenmale_hd.m2"] = true,
	["gnomemale_hd.m2"] = true,
	["gnomefemale_hd.m2"] = true,
}

local pattern = "[^\\]*%.m2$"
local function portraitHDModelFix(self)
	if self:IsObjectType("Model") then
		local model = self:GetModel()
		if type(model) ~= "string" then return end

		if debug then
			E:Print(format("|cffc79c6eUnit:|r %s; |cffc79c6eModel:|r %s", self:GetParent().unitframeType, model))
		end
		model = lower(model)
		model = match(model,pattern)
		if model and tableModelList[model] then
			self:SetCamera(1)
		end
	end
end

local unitTypes = {
	{"player", "target", "targettarget", "targettargettarget", "focus", "focustarget", "pet", "pettarget"},
	{"party", "raid10","raid25", "raid40"},
	{"boss", "arena"},
}

function UFPM:UpdatePortraits()
	if not self.HDModelFound then return end
	for i = 1, #unitTypes do
		for _, unit in ipairs(unitTypes[i]) do
			if i == 1 then
				UF.CreateAndUpdateUF(UF, unit)
			elseif i == 2 then
				UF.CreateAndUpdateHeaderGroup(UF, unit)
			else
				UF.CreateAndUpdateUFGroup(UF, unit, unit == "boss" and MAX_BOSS_FRAMES or MAX_ARENA_ENEMIES)
			end
		end
	end
end

function UFPM:ToggleState()
	if not self.HDModelFound then return end
		if not self.hooked then
			self:SecureHook(UF, "PortraitUpdate", portraitHDModelFix)
			self.hooked = true
		end

	for i = 1, #unitTypes do
		for _, unit in ipairs(unitTypes[i]) do
			local frame = _G["ElvUF_" .. E:StringTitle(unit)]

			if frame and frame.Portrait3D and frame.Portrait3D.PostUpdate then
				if not self:IsHooked(frame.Portrait3D, "PostUpdate", portraitHDModelFix) then
					self:SecureHook(frame.Portrait3D, "PostUpdate", portraitHDModelFix)
				end
			end
		end
	end

	self:UpdatePortraits()
end

function UFPM:Initialize()
	if not E.private.unitframe.enable then return end

	self.HDModelFound = checkHDModels()
	self:ToggleState()
end

local function InitializeCallback()
	UFPM:Initialize()
end

E:RegisterModule(UFPM:GetName(), InitializeCallback)