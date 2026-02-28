local E, L, V, P, G = unpack(ElvUI)
local Gems = E:NewModule("CharacterFrame_Gems_BG", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")
local _
local initInspect = false
local initCharacter = false

---------------------------------------------------------------------------
-- Slot definitions
---------------------------------------------------------------------------
Gems.Slots = {
	["HeadSlot"] = true,
	["NeckSlot"] = false,
	["ShoulderSlot"] = true,
	["BackSlot"] = false,
	["ChestSlot"] = true,
	["ShirtSlot"] = false,
	["TabardSlot"] = false,
	["WristSlot"] = true,
	["HandsSlot"] = true,
	["WaistSlot"] = true,
	["LegsSlot"] = true,
	["FeetSlot"] = true,
	["Finger0Slot"] = false,
	["Finger1Slot"] = false,
	["Trinket0Slot"] = false,
	["Trinket1Slot"] = false,
	["MainHandSlot"] = true,
	["SecondaryHandSlot"] = true,
	["RangedSlot"] = true,
}

Gems.GearListLeft = {
	["HeadSlot"] = true,
	["NeckSlot"] = true,
	["ShoulderSlot"] = true,
	["BackSlot"] = true,
	["ChestSlot"] = true,
	["ShirtSlot"] = true,
	["TabardSlot"] = true,
	["WristSlot"] = true,
}

Gems.GearListRight = {
	["HandsSlot"] = true,
	["WaistSlot"] = true,
	["LegsSlot"] = true,
	["FeetSlot"] = true,
	["Finger0Slot"] = true,
	["Finger1Slot"] = true,
	["Trinket0Slot"] = true,
	["Trinket1Slot"] = true,
}

Gems.GearListMain = {
	["MainHandSlot"] = true,
	["SecondaryHandSlot"] = true,
	["RangedSlot"] = true,
}

---------------------------------------------------------------------------
-- Custom gem ID tables (super-black / black / meta-black sockets)
---------------------------------------------------------------------------
Gems.superBlackSockets = {
	[104000] = true, [104001] = true, [104002] = true, [104003] = true,
	[104004] = true, [104005] = true, [104006] = true, [104007] = true,
	[104008] = true, [104009] = true, [104010] = true, [104011] = true,
	[104012] = true, [104013] = true, [104014] = true, [104015] = true,
	[104016] = true, [104017] = true, [104018] = true, [104019] = true,
	[100824] = true, [100825] = true, [100826] = true, [100827] = true,
	[100828] = true, [100829] = true, [100830] = true, [100831] = true,
	[100832] = true, [100833] = true, [100834] = true, [100835] = true,
	[100836] = true, [100837] = true, [100838] = true, [100839] = true,
	[100840] = true, [100841] = true, [100842] = true, [100843] = true,
	[100844] = true, [100845] = true, [100846] = true, [100847] = true,
	[100848] = true, [100849] = true, [100850] = true, [100851] = true,
	[100852] = true, [100853] = true, [100854] = true, [100855] = true,
	[100856] = true, [100857] = true, [100858] = true, [100859] = true,
	[100860] = true, [100861] = true, [100862] = true, [100863] = true,
	[100864] = true, [100865] = true, [100866] = true, [100867] = true,
	[100868] = true, [100869] = true, [100870] = true, [100871] = true,
	[100872] = true, [100873] = true, [100874] = true, [100875] = true,
	[100876] = true, [100877] = true, [100878] = true, [100879] = true,
	[100880] = true, [100881] = true, [100882] = true, [100883] = true,
	[100884] = true,
}

Gems.blackSockets = {
	[260043] = true, [103501] = true, [103502] = true, [103503] = true,
	[103504] = true, [103505] = true, [103506] = true, [103507] = true,
	[103508] = true, [103509] = true, [103510] = true, [103511] = true,
	[103512] = true, [103513] = true, [103514] = true, [103515] = true,
	[103516] = true, [103517] = true, [103518] = true, [103519] = true,
	[103520] = true, [100822] = true, [100766] = true, [100765] = true,
	[100764] = true, [100762] = true, [260042] = true, [260039] = true,
	[260048] = true, [260038] = true, [260047] = true, [260041] = true,
	[260046] = true, [260037] = true, [260036] = true, [260045] = true,
	[260035] = true, [260044] = true, [100769] = true, [100770] = true,
	[100767] = true, [260034] = true, [149186] = true, [260033] = true,
	[260032] = true, [260031] = true, [260030] = true, [100775] = true,
	[100774] = true, [100778] = true, [100773] = true, [100771] = true,
	[100777] = true, [100781] = true, [100782] = true, [100783] = true,
	[100784] = true, [100785] = true, [100786] = true, [100787] = true,
	[100788] = true, [100789] = true, [100790] = true, [100791] = true,
	[100792] = true, [100793] = true, [100794] = true, [100795] = true,
	[100796] = true, [260040] = true, [100797] = true, [100798] = true,
	[100799] = true, [100801] = true, [100802] = true, [100803] = true,
	[100805] = true, [100806] = true, [100807] = true, [100809] = true,
	[100810] = true, [100813] = true, [100814] = true, [100815] = true,
	[100754] = true, [100817] = true, [100818] = true, [100758] = true,
	[100821] = true, [100700] = true, [100701] = true, [100702] = true,
	[100703] = true, [100704] = true, [100705] = true, [100706] = true,
	[100707] = true, [100708] = true, [100709] = true, [100710] = true,
	[100711] = true, [100712] = true, [100713] = true, [100714] = true,
	[100715] = true, [100716] = true, [100717] = true, [100718] = true,
	[100719] = true, [100720] = true, [100721] = true, [100722] = true,
	[100723] = true, [100724] = true, [100725] = true, [100726] = true,
	[100727] = true, [100728] = true, [100729] = true, [100730] = true,
	[100731] = true, [100732] = true, [100733] = true, [100734] = true,
	[100735] = true, [100736] = true, [100737] = true, [100738] = true,
	[100739] = true, [100740] = true, [100741] = true, [100742] = true,
	[100743] = true, [100744] = true, [100745] = true, [100746] = true,
	[100747] = true, [100748] = true, [100749] = true, [100750] = true,
	[100751] = true, [100752] = true,
}

Gems.metaBlackSockets = {
	[260050] = true, [260052] = true, [260054] = true, [260056] = true,
	[260058] = true, [260051] = true, [260053] = true, [260055] = true,
	[260057] = true, [260059] = true, [260060] = true, [260062] = true,
	[260064] = true, [260066] = true, [260068] = true, [260061] = true,
	[260063] = true, [260065] = true, [260067] = true, [260069] = true,
	[260070] = true,
}

Gems.SoketsColor = {
	["Red"]    = {1, 0.109, 0.078, 0.5},
	["Yellow"] = {1, 0.945, 0.078, 0.5},
	["Blue"]   = {0.078, 0.258, 1, 0.5},
	["Meta"]   = {1, 1, 1, 1},
	["Socket"] = {0.988, 0.152, 0.905, 0.5},
}

---------------------------------------------------------------------------
-- Helpers: safe item link retrieval
---------------------------------------------------------------------------
local function GetUnitForInspect()
	if InspectFrame and InspectFrame.unit then
		return InspectFrame.unit
	end
	return "target"
end

local function SafeGetItemLink(unit, slotID)
	local link = GetInventoryItemLink(unit, slotID)
	if not link then return nil end
	local _, itemLink = GetItemInfo(link)
	return itemLink
end

local function GetSlotLink(who, slotID)
	if who == "Character" then
		return SafeGetItemLink("player", slotID)
	elseif who == "Inspect" then
		return SafeGetItemLink(GetUnitForInspect(), slotID)
	end
end

---------------------------------------------------------------------------
-- Count gems in a link (replaces tooltip scanning for inspect)
---------------------------------------------------------------------------
local function CountGemsInLink(link)
	if not link then return 0 end
	local count = 0
	for i = 1, 3 do
		local _, gemLink = GetItemGem(link, i)
		if gemLink then
			count = count + 1
		end
	end
	return count
end

---------------------------------------------------------------------------
-- Determine anchor direction for a slot
---------------------------------------------------------------------------
local function GetAnchorForSlot(slotName)
	if Gems.GearListLeft[slotName] then
		return "left"
	elseif Gems.GearListRight[slotName] then
		return "right"
	elseif Gems.GearListMain[slotName] then
		return "bot"
	end
	return nil
end

---------------------------------------------------------------------------
-- Gear quality gradient textures
---------------------------------------------------------------------------
function Gems:UpdateGearTextures(who)
	if not E.private.enhanced.character.GearTexturesEnable then return end

	for slotName in pairs(Gems.Slots) do
		local slotID = GetInventorySlotInfo(slotName)
		local quality

		if who == "Inspect" then
			local rawLink = GetInventoryItemLink(GetUnitForInspect(), slotID)
			if rawLink then
				_, _, quality = GetItemInfo(rawLink)
			end
		elseif who == "Character" then
			local rawLink = GetInventoryItemLink("player", slotID)
			if rawLink then
				_, _, quality = GetItemInfo(rawLink)
			end
		end

		local Slot = _G[who .. slotName]
		if Slot and Slot.Gems and Slot.Gems.AnchorForGems then
			if not Slot.Gradient then
				Slot.Gradient = Slot:CreateTexture(nil, "BACKGROUND")
				local anchor = Slot.Gems.AnchorForGems
				if anchor == "left" then
					Slot.Gradient:SetPoint("LEFT", Slot, "LEFT", 0, 0)
					Slot.Gradient:SetTexCoord(0, 1, 0, 1)
				elseif anchor == "right" then
					Slot.Gradient:SetPoint("RIGHT", Slot, "RIGHT", 0, 0)
					Slot.Gradient:SetTexCoord(1, 0, 0, 1)
				end
				Slot.Gradient:Size(132, 41)
				Slot.Gradient:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\Gradation]])
			end

			if type(quality) == "number" then
				local r, g, b = GetItemQualityColor(quality)
				Slot.Gradient:SetVertexColor(r, g, b)
				local anchor = Slot.Gems.AnchorForGems
				if anchor == "left" then
					Slot.Gradient:SetTexCoord(0, 1, 0, 1)
				elseif anchor == "right" then
					Slot.Gradient:SetTexCoord(1, 0, 0, 1)
				end
				Slot.Gradient:Show()
			else
				Slot.Gradient:Hide()
			end
		end
	end
end

---------------------------------------------------------------------------
-- Gem click handler (insert / remove)
---------------------------------------------------------------------------
local function GemsOnClick(button, frame, socketNum)
	if button == "RightButton" then
		-- Use C_ItemSocketInfo API for removing legendary gems
		SocketInventoryItem(frame.containerID)
		if C_ItemSocketInfo and C_ItemSocketInfo.CanRemoveGem(socketNum) then
			C_ItemSocketInfo.RemoveGem(socketNum)
		else
			CloseSocketInfo()
			if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
				HideUIPanel(ItemSocketingFrame)
			end
		end
	elseif button == "LeftButton" then
		SocketInventoryItem(frame.containerID)
		local existing = GetExistingSocketInfo(socketNum)
		local socketType = GetSocketTypes(socketNum)
		if not existing then
			-- Try super-black sockets first, then regular black sockets
			local socketTables
			if socketType == "Meta" then
				socketTables = {Gems.metaBlackSockets}
			else
				socketTables = {Gems.superBlackSockets, Gems.blackSockets}
			end

			for _, gemTable in ipairs(socketTables) do
				for bagID = 0, 4 do
					for slotID = 1, GetContainerNumSlots(bagID) do
						local itemID = GetContainerItemID(bagID, slotID)
						if itemID and gemTable[itemID] then
							PickupContainerItem(bagID, slotID)
							ClickSocketButton(socketNum)
							AcceptSockets()
							HideUIPanel(ItemSocketingFrame)
							return
						end
					end
				end
			end
		end
		if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
			HideUIPanel(ItemSocketingFrame)
		end
	end
end

---------------------------------------------------------------------------
-- Update link / socket count for a slot frame
---------------------------------------------------------------------------
local function UpdateLink(frame, link, who)
	if who == "Character" then
		SocketInventoryItem(frame.containerID)
		frame.Gems.MaxGems = GetNumSockets() or 0
		for i = 1, frame.Gems.MaxGems do
			frame.Gems["Gem" .. i].GemColor = GetSocketTypes(i)
		end
		CloseSocketInfo()
		if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
			HideUIPanel(ItemSocketingFrame)
		end
	elseif who == "Inspect" then
		-- For inspect we can only count visible gems
		frame.Gems.MaxGems = CountGemsInLink(link)
	end
	frame.Gems.ItemLink = link
end

---------------------------------------------------------------------------
-- Hide all gem textures on a frame
---------------------------------------------------------------------------
local function HideGemTextures(frame)
	if not frame or not frame.Gems then return end
	for i = 1, 3 do
		local gem = frame.Gems["Gem" .. i]
		if gem then
			gem.texture:SetTexture(nil)
			gem:SetScript("OnEnter", nil)
			gem:SetScript("OnLeave", nil)
			gem:SetScript("OnClick", nil)
		end
	end
end

---------------------------------------------------------------------------
-- Update gem icons for a single slot frame
---------------------------------------------------------------------------
local function UpdateGems(frame, link, who)
	if not frame or not frame.Gems then return end
	local maxGems = frame.Gems.MaxGems or 0

	if maxGems > 0 then
		for i = 1, maxGems do
			local gemName, gemLink = GetItemGem(link, i)
			local gem = frame.Gems["Gem" .. i]

			gem.GemName = gemName or "n"
			gem.GemLink = gemLink or "n"

			local itemQuality, itemTexture
			if gemLink then
				_, _, itemQuality, _, _, _, _, _, _, itemTexture = GetItemInfo(gemLink)
			end

			if itemTexture then
				gem.texture:SetTexture(itemTexture)
				gem.texture:SetVertexColor(1, 1, 1, 1)
				gem.texture:Show()
			else
				gem.texture:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\NormTex2]])
				if who == "Character" and gem.GemColor then
					local color = Gems.SoketsColor[gem.GemColor]
					if color then
						gem.texture:SetVertexColor(color[1], color[2], color[3], color[4])
					end
				end
				gem.texture:Show()
			end

			gem.texture:SetTexCoord(unpack(E.TexCoords))
			gem.texture:ClearAllPoints()
			gem.texture:SetAllPoints(gem)

			gem:RegisterForClicks("AnyDown")
			gem:EnableMouse(true)

			-- Tooltip on hover
			gem:SetScript("OnEnter", function()
				if gemLink then
					GameTooltip:SetOwner(gem, "ANCHOR_TOP")
					GameTooltip:SetHyperlink(gemLink)
					if itemQuality == 5 and who == "Character" then
						GameTooltip:AddLine("|cff46ff00 ЛКМ|r вставить ЧБ - |cffff0000 ПКМ|r вынУть ЧБ")
					end
					GameTooltip:Show()
				end
			end)

			gem:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)

			-- Click handler (character only)
			if who == "Character" then
				gem:SetScript("OnClick", function(_, button)
					GemsOnClick(button, frame, i)
				end)
			else
				gem:SetScript("OnClick", nil)
			end
		end
	else
		HideGemTextures(frame)
	end
end

---------------------------------------------------------------------------
-- Unified update function for all slots
---------------------------------------------------------------------------
local function UpdateAllGems(who)
	if who == "Character" and not initCharacter then return end
	if who == "Inspect" and (not InspectFrame or not InspectFrame:IsShown()) then return end

	for slotName in pairs(Gems.Slots) do
		local frame = _G[format("%s%s", who, slotName)]
		if frame and frame.Gems then
			local link = GetSlotLink(who, frame:GetID())
			if link then
				if link ~= frame.Gems.ItemLink then
					-- Item changed — full update
					UpdateLink(frame, link, who)
					HideGemTextures(frame)
					UpdateGems(frame, link, who)
				else
					-- Same item — check if gems changed
					for i = 1, 3 do
						local gemName, gemLink = GetItemGem(link, i)
						local gem = frame.Gems["Gem" .. i]
						if gem and (gem.GemName ~= gemName or gem.GemLink ~= gemLink) then
							HideGemTextures(frame)
							UpdateGems(frame, link, who)
							break
						end
					end
				end
			else
				frame.Gems.ItemLink = "empty"
				HideGemTextures(frame)
			end
		end
	end

	if who == "Character" then
		S:ColorItemCharacterBorder()
		if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
			HideUIPanel(ItemSocketingFrame)
		end
	elseif who == "Inspect" then
		S:ColorItemInspectBorder()
	end

	Gems:UpdateGearTextures(who)
end

---------------------------------------------------------------------------
-- Gem size & position
---------------------------------------------------------------------------
function Gems:UpdateSize(frame, i)
	local gemsize
	if E.private.enhanced.character.GemsEnableScal then
		gemsize = frame:GetHeight() / 3
	else
		gemsize = E.private.enhanced.character.GemsSize
	end

	local gem = frame.Gems["Gem" .. i]
	gem:Size(gemsize, gemsize)

	local h = frame:GetHeight()
	local anchor = frame.Gems.AnchorForGems

	gem:ClearAllPoints()
	if anchor == "left" then
		gem:SetPoint("CENTER", frame, "CENTER", (h / 2 + gemsize / 2) + (gemsize * (i - 1)), -(h / 2 - gemsize / 2))
	elseif anchor == "right" then
		gem:SetPoint("CENTER", frame, "CENTER", -(h / 2 + gemsize / 2) - (gemsize * (i - 1)), -(h / 2 - gemsize / 2))
	elseif anchor == "bot" then
		gem:SetPoint("CENTER", frame, "CENTER", (-h / 2 + gemsize / 2) + (gemsize * (i - 1)), -(h / 2 + gemsize / 2))
	end
end

---------------------------------------------------------------------------
-- Unified init function for gem frames
---------------------------------------------------------------------------
local function InitGemFrames(who)
	local frameLevel = (who == "Inspect") and 85 or 4

	for slotName in pairs(Gems.Slots) do
		local frame = _G[format("%s%s", who, slotName)]
		if not frame then break end

		frame.Gems = frame.Gems or {}

		local anchor = GetAnchorForSlot(slotName)
		frame.Gems.AnchorForGems = anchor

		if not frame.Gems.ItemLink then
			frame.Gems.ItemLink = "empty"
		end

		local link = GetSlotLink(who, frame:GetID())

		-- Determine socket count
		if who == "Character" and link then
			SocketInventoryItem(frame.containerID)
			frame.Gems.MaxGems = GetNumSockets() or 0
		elseif who == "Inspect" and link then
			frame.Gems.MaxGems = CountGemsInLink(link)
		else
			frame.Gems.MaxGems = 0
		end

		-- Create 3 gem button frames
		for i = 1, 3 do
			if not frame.Gems["Gem" .. i] then
				frame.Gems["Gem" .. i] = CreateFrame("Button", nil, frame)
				frame.Gems["Gem" .. i].texture = frame.Gems["Gem" .. i]:CreateTexture()
				frame.Gems["Gem" .. i]:SetFrameLevel(frameLevel)
			end

			local gem = frame.Gems["Gem" .. i]
			if link then
				local gemName, gemLink = GetItemGem(link, i)
				gem.GemName = gemName or "n"
				gem.GemLink = gemLink or "n"
			else
				gem.GemName = "n"
				gem.GemLink = "n"
			end

			if who == "Character" then
				gem.GemColor = GetSocketTypes(i)
			end

			Gems:UpdateSize(frame, i)
		end

		-- Close socketing UI after reading socket data
		if who == "Character" and link then
			CloseSocketInfo()
			if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
				HideUIPanel(ItemSocketingFrame)
			end
		end
	end
end

---------------------------------------------------------------------------
-- Init: Inspect
---------------------------------------------------------------------------
local function GemsOnInitInspect()
	if initInspect then return end
	if not E.private.enhanced.character.GemsEnable then return end

	InitGemFrames("Inspect")
	initInspect = true
	Gems:UpdateGearTextures("Inspect")
end

---------------------------------------------------------------------------
-- Init: Character
---------------------------------------------------------------------------
local function GemsOnInitCharacter()
	if not E.private.enhanced.character.GemsEnable then return end
	if initCharacter then return end

	InitGemFrames("Character")

	if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
		HideUIPanel(ItemSocketingFrame)
	end

	initCharacter = true
	Gems:UpdateGearTextures("Character")
	S:ColorItemCharacterBorder()
end

---------------------------------------------------------------------------
-- Background texture management
---------------------------------------------------------------------------
function Gems:UpdateCharacterBG()
	if E.private.enhanced.character.selectedBGTexture == 'HIDE' then
		CharacterModelFrameBackgroundOverlay:SetTexture(nil)
	elseif E.private.enhanced.character.selectedBGTexture == 'CUSTOM' then
		CharacterModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.customTexture)
	elseif E.private.enhanced.character.selectedBGTexture == 'CLASS' then
		CharacterModelFrameBackgroundOverlay:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]] .. E.myclass)
	else
		CharacterModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.ArmoryConfigBackgroundValues.BlizzardBackdropList[E.private.enhanced.character.selectedBGTexture] or [[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]] .. E.private.enhanced.character.selectedBGTexture)
	end
end

function Gems:UpdateInspectBG()
	if E.private.enhanced.character.selectedBGTexture == 'HIDE' then
		InspectModelFrameBackgroundOverlay:SetTexture(nil)
	elseif E.private.enhanced.character.selectedBGTexture == 'CUSTOM' then
		InspectModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.customTexture)
	elseif E.private.enhanced.character.selectedBGTexture == 'CLASS' then
		InspectModelFrameBackgroundOverlay:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]] .. E.myclass)
	else
		InspectModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.ArmoryConfigBackgroundValues.BlizzardBackdropList[E.private.enhanced.character.selectedBGTexture] or [[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]] .. E.private.enhanced.character.selectedBGTexture)
	end
end

---------------------------------------------------------------------------
-- Hide model frame default backgrounds
---------------------------------------------------------------------------
local function HideModelBackgrounds(frameName)
	local modelFrame = _G[frameName]
	if modelFrame and modelFrame.BackgroundTopLeft and modelFrame.BackgroundTopLeft:IsShown() then
		modelFrame.BackgroundTopLeft:Hide()
		modelFrame.BackgroundTopRight:Hide()
		modelFrame.BackgroundBotLeft:Hide()
		modelFrame.BackgroundBotRight:Hide()
		if modelFrame.backdrop then
			modelFrame.backdrop:Hide()
		end
	end
end

---------------------------------------------------------------------------
-- Module initialization
---------------------------------------------------------------------------
function Gems:Initialize()
	if not E.private.enhanced.character.enable then return end

	if E.private.enhanced.character.GemsEnable then
		-- Delayed init so that inventory data is loaded
		C_Timer:After(0.55, GemsOnInitCharacter)

		-- Event frame for equipment changes and socket updates
		local eventFrame = CreateFrame("Frame", nil, UIParent)
		eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
		eventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
		eventFrame:RegisterEvent("SOCKET_INFO_UPDATE")
		eventFrame:RegisterEvent("SOCKET_INFO_CLOSE")
		eventFrame:SetScript("OnEvent", function(_, event, unit)
			if event == "SOCKET_INFO_UPDATE" then
				-- Instant refresh after gem insert/remove
				C_Timer:After(0.05, function() UpdateAllGems("Character") end)
			elseif event == "SOCKET_INFO_CLOSE" then
				if ItemSocketingFrame and ItemSocketingFrame:IsShown() then
					HideUIPanel(ItemSocketingFrame)
				end
			elseif (event == "UNIT_INVENTORY_CHANGED" and unit == "player") or event == "PLAYER_EQUIPMENT_CHANGED" then
				if E.private.enhanced.character.GemsEnable then
					C_Timer:After(0.05, function() UpdateAllGems("Character") end)
				end
				Gems:UpdateCharacterBG()
			elseif event == "UNIT_INVENTORY_CHANGED" and unit ~= "player" then
				C_Timer:After(0.55, function() UpdateAllGems("Inspect") end)
			end
		end)

		-- Initial update after a short delay
		C_Timer:After(1, function() UpdateAllGems("Character") end)
	end

	-- Paper doll frame hooks
	PaperDollFrame:HookScript("OnShow", function()
		CharacterModelFrame:ClearAllPoints()
		CharacterModelFrame:SetPoint('TOPLEFT', CharacterHeadSlot, 0, 5)
		CharacterModelFrame:SetPoint('RIGHT', CharacterHandsSlot)
		CharacterModelFrame:SetPoint('BOTTOM', CharacterMainHandSlot)

		HideModelBackgrounds("CharacterModelFrame")
		CharacterModelFrameBackgroundOverlay:Show()
		CharacterModelFrameBackgroundOverlay:ClearAllPoints()
		CharacterModelFrameBackgroundOverlay:SetAllPoints(CharacterModelFrame)
	end)

	Gems:UpdateCharacterBG()

	InspectFrame:HookScript("OnShow", function()
		InspectModelFrame:ClearAllPoints()
		InspectModelFrame:SetPoint('TOPLEFT', InspectHeadSlot, 0, 5)
		InspectModelFrame:SetPoint('RIGHT', InspectHandsSlot)
		InspectModelFrame:SetPoint('BOTTOM', InspectMainHandSlot)

		HideModelBackgrounds("InspectModelFrame")
		InspectModelFrameBackgroundOverlay:Show()
		InspectModelFrameBackgroundOverlay:ClearAllPoints()
		InspectModelFrameBackgroundOverlay:SetAllPoints(InspectModelFrame)
		InspectItemLevelFrame:ClearAllPoints()
		InspectItemLevelFrame:SetPoint("BOTTOM", 0, 40)
		Gems:UpdateInspectBG()

		if E.private.enhanced.character.GemsEnable then
			C_Timer:After(0.55, GemsOnInitInspect)
			C_Timer:After(0.57, function() UpdateAllGems("Inspect") end)
		end
	end)

	if E.private.enhanced.character.GemsEnable then
		InspectFrame:HookScript("OnEvent", function()
			C_Timer:After(0.55, GemsOnInitInspect)
			C_Timer:After(0.57, function() UpdateAllGems("Inspect") end)
		end)
	end
end

---------------------------------------------------------------------------
-- Registration
---------------------------------------------------------------------------
local function InitializeCallback()
	Gems:Initialize()
	-- Auto-hide any lingering frames from initialization
	C_Timer:After(4, function()
		if CharacterFrame:IsShown() then HideUIPanel(CharacterFrame) end
		if ItemSocketingFrame and ItemSocketingFrame:IsShown() then HideUIPanel(ItemSocketingFrame) end
	end)
end

E:RegisterModule(Gems:GetName(), InitializeCallback)
