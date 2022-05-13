local E, L, V, P, G = unpack(ElvUI)
local Gems = E:NewModule("CharacterFrame_Gems_BG", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")
-- local EI = E:GetModule("Enhanced_EquipmentInfo")

local initInspect = false
local initCharacter = false
-- Gems.UpdateEnable = true
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
--	["AmmoSlot"] = false,
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
Gems.blackSockets = {
    [260048] = true,
    [260046] = true,
    [260044] = true,
    [260042] = true,
    [260040] = true,
    [260047] = true,
    [260045] = true,
    [260043] = true,
    [260041] = true,
    [260039] = true,
    [260038] = true,
    [260036] = true,
    [260034] = true,
    [260032] = true,
    [260030] = true,
    [260037] = true,
    [260035] = true,
    [260033] = true,
    [260031] = true,
}


Gems.metaBlackSockets = {
    [260050] = true,
    [260052] = true,
    [260054] = true,
    [260056] = true,
    [260058] = true,
    [260051] = true,
    [260053] = true,
    [260055] = true,
    [260057] = true,
    [260059] = true,
    [260060] = true,
    [260062] = true,
    [260064] = true,
    [260066] = true,
    [260068] = true,
    [260061] = true,
    [260063] = true,
    [260065] = true,
    [260067] = true,
    [260069] = true,
    [260070] = true,
}

Gems.SoketsColor ={
	["Red"] = {1, 0.109, 0.078, 0.5},
	["Yellow"] = {1, 0.945, 0.078, 0.5},
	["Blue"] = {0.078, 0.258, 1, 0.5},
	["Meta"] = {1, 1, 1, 1},
	["Socket"] = {0.988, 0.152, 0.905, 0.5},

	
}
-- taken from https://www.wowinterface.com/forums/showpost.php?p=319704&postcount=2
local ElvUI_GetNumSockets
do
	-- Generate a unique name for the tooltip:
	local tooltipName = "PhanxScanningTooltip" .. random(100000, 10000000)

	-- Create the hidden tooltip object:
	local tooltip = CreateFrame("GameTooltip", tooltipName, UIParent, "GameTooltipTemplate")
	tooltip:SetOwner(UIParent, "ANCHOR_NONE")

	-- Build a list of the tooltip's texture objects:
	local textures = {}
	for i = 1, 10 do
		textures[i] = _G[tooltipName .. "Texture" .. i]
	end

	-- Set up scanning and caching:
	local numSocketsFromLink = setmetatable({}, { __index = function(t, link)
		-- Send the link to the tooltip:
		tooltip:SetHyperlink(link)

		-- Count how many textures are shown:
		local n = 0
		for i = 1, 10 do
			if textures[i]:IsShown() then
				n = n + 1
			end
		end

		-- Cache and return the count for this link:
		t[link] = n
		return n
	end })

	-- Expose the API:
	function ElvUI_GetNumSockets(link)
		return link and numSocketsFromLink[link]
	end
end




function Gems:UpdateGearTextures(who)
	if not E.private.enhanced.character.GearTexturesEnable then return end
	for SlotName, durab in pairs(Gems.Slots) do
		local quality
		if who == "Inspect" then
			local unit = InspectFrame.unit
			if unit then
				_,_,quality = GetItemInfo(GetInventoryItemLink(unit, GetInventorySlotInfo(SlotName)))
			else
				_,_,quality = GetItemInfo(GetInventoryItemLink("target", GetInventorySlotInfo(SlotName)))
			end
		elseif who == "Character" then
			_,_,quality = GetItemInfo(GetInventoryItemLink("player", GetInventorySlotInfo(SlotName)))
		end
		-- print(quality)
		local Slot = _G[who..SlotName]
		-- Slot.SLOT_ID = GetInventorySlotInfo(SlotName)
		if Slot.Gems.AnchorForGems then
			if not Slot.Gradient then
				Slot.Gradient = Slot:CreateTexture(nil, "BACKGROUND")
				if Slot.Gems.AnchorForGems == "left" then
					Slot.Gradient:SetPoint("LEFT", Slot, "LEFT", 0, 0)
					Slot.Gradient:SetTexCoord(0, 1, 0, 1)
				elseif Slot.Gems.AnchorForGems == "right" then
					Slot.Gradient:SetPoint("RIGHT", Slot, "RIGHT", 0, 0)
					Slot.Gradient:SetTexCoord(1, 0, 0, 1)
				end
				Slot.Gradient:Size(132, 41)
				Slot.Gradient:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\Gradation]])
				if type(quality) == "number" then
					local r, g, b, hex = GetItemQualityColor(quality)
					Slot.Gradient:SetVertexColor(r, g, b, hex)
					Slot.Gradient:Show()
				elseif quality == nil then
					Slot.Gradient:Hide()

				end
			else
				if type(quality) == "number" then
					local r, g, b, hex = GetItemQualityColor(quality)
					Slot.Gradient:SetVertexColor(r, g, b, hex)
					-- Slot.Gradient:SetTexCoord(0, 1, 0, 1)
					if Slot.Gems.AnchorForGems == "left" then
						-- Slot.Gradient:SetPoint("LEFT", Slot, "LEFT", 0, 0)
						Slot.Gradient:SetTexCoord(0, 1, 0, 1)
					elseif Slot.Gems.AnchorForGems == "right" then
						-- Slot.Gradient:SetPoint("RIGHT", Slot, "RIGHT", 0, 0)
						Slot.Gradient:SetTexCoord(1, 0, 0, 1)
					end
					Slot.Gradient:Show()
				elseif quality == nil then
					Slot.Gradient:Hide()
				end
			end
		end
	end

end



local function GemsOnClick(button,frame,SocetNum)
	if button == "RightButton" then
		SendServerMessage("ACMSG_REMOVE_SOCKET_FROM_ITEM", string.format("%d:%d:%d", -1, frame.containerID, SocetNum))

	elseif button == "LeftButton" then
		SocketInventoryItem(frame.containerID)
		local yes = GetExistingSocketInfo(SocetNum)
		local isMeta = GetSocketTypes(SocetNum)
		if yes == nil then
			for bagID = 0, 4 do
				for slotID = 1, GetContainerNumSlots(bagID) do
					local itemID = GetContainerItemID(bagID, slotID)
					if itemID and ((isMeta == "Meta" and Gems.metaBlackSockets[itemID]) or  (isMeta ~= "Meta" and Gems.blackSockets[itemID]))  then
						PickupContainerItem(bagID, slotID)
						ClickSocketButton(SocetNum)
						AcceptSockets()
						HideUIPanel(ItemSocketingFrame)
						return
					end
				end
			end
			HideUIPanel(ItemSocketingFrame)
		else
			HideUIPanel(ItemSocketingFrame)
		end
	end
end


local function UpdateLink(frame,link,who)
	if who == "Character" then
		SocketInventoryItem(frame.containerID)
		frame.Gems.MaxGems = GetNumSockets() or 0
		for i = 1,frame.Gems.MaxGems do
			frame.Gems["Gem"..i].GemColor = GetSocketTypes(i)
		end
		CloseSocketInfo()
		HideUIPanel(ItemSocketingFrame)
	elseif who == "Inspect" then
		local nummaxgem = 0
		local unit = InspectFrame.unit
		-- local unit = InspectFrame.unit
		if unit then
			_,link = GetItemInfo(GetInventoryItemLink(unit, frame:GetID()))
		else
			_,link = GetItemInfo(GetInventoryItemLink("target", frame:GetID()))
		end

		local  maxgems = ElvUI_GetNumSockets(link)
		for i = 1,3 do
			local gmnm, gmlnk = GetItemGem(link, i)
			if gmlnk then
				nummaxgem = nummaxgem + 1
			end
		end
		if maxgems > nummaxgem and maxgems ~= frame.Gems.MaxGems then
			frame.Gems.MaxGems = maxgems
		else
			frame.Gems.MaxGems = nummaxgem
		end
	end
	-- if who == "Inspect" and frame.Gems.ItemLink ~+ link then

	-- end
	frame.Gems.ItemLink = link


end

local function HideGemTextures(frame)
	for i = 1,3 do
		if frame.Gems  then
			frame.Gems["Gem"..i].texture:SetTexture(nil)
			frame.Gems["Gem"..i]:SetScript("OnEnter", nil)
			frame.Gems["Gem"..i]:SetScript("OnLeave", nil)
			frame.Gems["Gem"..i]:SetScript("OnClick", nil)
		end
	end
end

local function UpdateGems(frame,link,who)

	if frame.Gems.MaxGems > 0 then
		for i = 1,frame.Gems.MaxGems do
			local gemname, gemLink = GetItemGem(link, i)

			frame.Gems["Gem"..i].GemName = gemname or "n"
			frame.Gems["Gem"..i].GemLink = gemLink or "n"
			local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(gemLink)

			if itemTexture  then
				frame.Gems["Gem"..i].texture:SetTexture(itemTexture)
				frame.Gems["Gem"..i].texture:SetVertexColor(1,1,1,1)

				frame.Gems["Gem"..i].texture:Show()
			else
				frame.Gems["Gem"..i].texture:SetTexture([[Interface\AddOns\ElvUI\Media\Textures\NormTex2]])
				if who == "Character" then
					if frame.Gems["Gem"..i].texture and frame.Gems["Gem"..i].GemColor then
						-- if Gems.SoketsColor[frame.Gems["Gem"..i].GemColor][1] then
							frame.Gems["Gem"..i].texture:SetVertexColor(Gems.SoketsColor[frame.Gems["Gem"..i].GemColor][1] or 1, Gems.SoketsColor[frame.Gems["Gem"..i].GemColor][2] or 1, Gems.SoketsColor[frame.Gems["Gem"..i].GemColor][3] or 1,Gems.SoketsColor[frame.Gems["Gem"..i].GemColor][4] or 1)
						-- end
					end
				end
				frame.Gems["Gem"..i].texture:Show()
			end
			frame.Gems["Gem"..i].texture:SetTexCoord(unpack(E.TexCoords))
			frame.Gems["Gem"..i].texture:ClearAllPoints()
			frame.Gems["Gem"..i].texture:SetAllPoints(frame.Gems["Gem"..i])

			frame.Gems["Gem"..i]:RegisterForClicks("AnyDown")
			frame.Gems["Gem"..i]:EnableMouse(true)

			frame.Gems["Gem"..i]:SetScript("OnEnter", nil)
			frame.Gems["Gem"..i]:SetScript("OnEnter", function()
				if (gemLink) then
					GameTooltip:SetOwner(frame.Gems["Gem"..i], "ANCHOR_TOP")
					GameTooltip:SetHyperlink(gemLink)
					if itemQuality == 5 and who == "Character" then
						GameTooltip:AddLine("|cff46ff00 ЛКМ|r вставить ЧБ - |cffff0000 ПКМ|r вынУть ЧБ")
					end
					GameTooltip:Show()
				end
			end)
			frame.Gems["Gem"..i]:SetScript("OnLeave", nil)
			frame.Gems["Gem"..i]:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			if who == "Character" then
				frame.Gems["Gem"..i]:SetScript("OnClick", nil)
				frame.Gems["Gem"..i]:SetScript("OnClick", function(_,button)
					GemsOnClick(button,frame,i)
				end)
			end
		end
	else
		HideGemTextures(frame)
	end
end

local function CheckForNeedUpdateCharacter()
	if not initCharacter then return end
	for slotName, durab in pairs(Gems.Slots) do
		local frame = _G[format("%s%s", "Character", slotName)]
		if frame then
			local _,link = GetItemInfo(GetInventoryItemLink("player", frame:GetID()))
			if link then
				if  link ~= frame.Gems.ItemLink then
					UpdateLink(frame,link,"Character")
					HideGemTextures(frame)
					UpdateGems(frame,link,"Character")
					-- S:ColorItemCharacterBorder()
				else
					HideGemTextures(frame)
					for i = 1,3 do
						local gmnm, gmlnk = GetItemGem(link, i)
						if frame.Gems["Gem"..i].GemName ~= gmnm or frame.Gems["Gem"..i].GemName ~= gmlnk then
							UpdateGems(frame,link,"Character")
							-- S:ColorItemCharacterBorder()
						end
					end
				end
			else
				HideGemTextures(frame)
			end
		end
	end
	S:ColorItemCharacterBorder()
	-- HideUIPanel(CharacterFrame)
	HideUIPanel(ItemSocketingFrame)
	Gems:UpdateGearTextures("Character")
end

local function CheckForNeedUpdateInspect()

	if InspectFrame:IsShown() then
		for slotName, durab in pairs(Gems.Slots) do
			local frame = _G[format("%s%s", "Inspect", slotName)]
			if frame then
				local unit = InspectFrame.unit
				local link
				if unit then
					_,link = GetItemInfo(GetInventoryItemLink(unit, frame:GetID()))
				else
					_,link = GetItemInfo(GetInventoryItemLink("target", frame:GetID()))
				end


				if link then
					if  link ~= frame.Gems.ItemLink then
						UpdateLink(frame,link,"Inspect")
						HideGemTextures(frame)
						UpdateGems(frame,link,"Inspect")
						S:ColorItemInspectBorder()
					else
						HideGemTextures(frame)
						for i = 1,3 do
							local gmnm, gmlnk = GetItemGem(link, i)

							if frame.Gems["Gem"..i].GemName ~= gmnm or frame.Gems["Gem"..i].GemName ~= gmlnk then
								UpdateGems(frame,link,"Inspect")
								S:ColorItemInspectBorder()
							end
						end
					end
				else
					HideGemTextures(frame)
				end
			end
		end
	end
	-- HideUIPanel(CharacterFrame)
	-- HideUIPanel(ItemSocketingFrame)
	Gems:UpdateGearTextures("Inspect")
end

function Gems:UpdateSize(frame,i)
	local gemsize
	if E.private.enhanced.character.GemsEnableScal == true then
		gemsize = frame:GetHeight()/3
	else
		gemsize = E.private.enhanced.character.GemsSize
	end
	frame.Gems["Gem"..i]:Size(gemsize,gemsize)

	if frame.Gems.AnchorForGems == "left" then
		frame.Gems["Gem"..i]:ClearAllPoints()
		frame.Gems["Gem"..i]:SetPoint("CENTER",frame,"CENTER",(frame:GetHeight()/2+gemsize/2)+(gemsize*(i-1)),-(frame:GetHeight()/2-gemsize/2))
	elseif frame.Gems.AnchorForGems == "right" then
		frame.Gems["Gem"..i]:ClearAllPoints()
		frame.Gems["Gem"..i]:SetPoint("CENTER",frame,"CENTER",-(frame:GetHeight()/2+gemsize/2)-(gemsize*(i-1)),-(frame:GetHeight()/2-gemsize/2))
	elseif frame.Gems.AnchorForGems == "bot" then
		frame.Gems["Gem"..i]:ClearAllPoints()
		frame.Gems["Gem"..i]:SetPoint("CENTER",frame,"CENTER",(-frame:GetHeight()/2+gemsize/2)+(gemsize*(i-1)),-(frame:GetHeight()/2+gemsize/2))
	end
end

local function GemsOnInitInspect()
	if initInspect == false then

		if E.private.enhanced.character.GemsEnable == true then
			for slotName, durability in pairs(Gems.Slots) do

				local frame = _G[format("%s%s", "Inspect", slotName)]
				frame.Gems = {}
				local unit = InspectFrame.unit
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent
				if unit then
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(GetInventoryItemLink(unit, frame:GetID()))
				else
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(GetInventoryItemLink("target", frame:GetID()))
				end
				if Gems.GearListLeft[slotName]  then
					frame.Gems.AnchorForGems = "left"
				elseif Gems.GearListRight[slotName]  then
					frame.Gems.AnchorForGems = "right"
				elseif Gems.GearListMain[slotName]  then
					frame.Gems.AnchorForGems = "bot"
				end
				if not frame.Gems.ItemLink then
					frame.Gems.ItemLink = "empty"
				end

				frame.Gems.MaxGems = ElvUI_GetNumSockets(itemLink) or 0
				-- print(frame.Gems.MaxGems,413)
				for i = 1,3 do

					frame.Gems["Gem"..i] = CreateFrame("Button",nil,frame)
					frame.Gems["Gem"..i].texture = frame.Gems["Gem"..i]:CreateTexture()
					frame.Gems["Gem"..i]:SetFrameLevel(85)

					if itemLink then
						local gmnm, gmlnk = GetItemGem(itemLink, i)
						frame.Gems["Gem"..i].GemName = gmnm or "n"
						frame.Gems["Gem"..i].GemLink = gmlnk or "n"
					else
						frame.Gems.ItemLink = "empty"
						frame.Gems["Gem"..i].GemName = "n"
						frame.Gems["Gem"..i].GemLink =  "n"
					end

					Gems:UpdateSize(frame,i)
				end

			end
		end
	end
	initInspect = true
	Gems:UpdateGearTextures("Inspect")
end


local function GemsOnInitCharacter()

	if E.private.enhanced.character.GemsEnable == true then
		if initCharacter == false then
			for slotName, durability in pairs(Gems.Slots) do

				local frame = _G[format("%s%s", "Character", slotName)]
				frame.Gems = frame.Gems or {}
				local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(GetInventoryItemLink("player", frame:GetID()))
				if Gems.GearListLeft[slotName]  then
					frame.Gems.AnchorForGems = "left"
				elseif Gems.GearListRight[slotName]  then
					frame.Gems.AnchorForGems = "right"
				elseif Gems.GearListMain[slotName]  then
					frame.Gems.AnchorForGems = "bot"
				end
				if not frame.Gems.ItemLink then
					frame.Gems.ItemLink = "empty"
				end
				if itemLink then
					SocketInventoryItem(frame.containerID)
					frame.Gems.MaxGems = GetNumSockets() or 0
				end

				for i = 1,3 do

					frame.Gems["Gem"..i] = CreateFrame("Button",nil,frame)
					frame.Gems["Gem"..i].texture = frame.Gems["Gem"..i]:CreateTexture()
					frame.Gems["Gem"..i]:SetFrameLevel(4)

					if itemLink then
						local gmnm, gmlnk = GetItemGem(itemLink, i)
						frame.Gems["Gem"..i].GemName = gmnm or "n"
						frame.Gems["Gem"..i].GemLink = gmlnk or "n"
					else
						frame.Gems.ItemLink = "empty"
						frame.Gems["Gem"..i].GemName = "n"
						frame.Gems["Gem"..i].GemLink =  "n"
					end
					frame.Gems["Gem"..i].GemColor = GetSocketTypes(i)

					Gems:UpdateSize(frame,i)
				end
				if itemLink then
					CloseSocketInfo()
					HideUIPanel(ItemSocketingFrame)
				end
			end
			HideUIPanel(ItemSocketingFrame)
		end
		initCharacter = true
	end


	Gems:UpdateGearTextures("Character")
	S:ColorItemCharacterBorder()
end

--------------------------
------------------------ bg
--------------------------
function Gems:UpdateCharacterBG()
	if E.private.enhanced.character.selectedBGTexture == 'HIDE' then
		CharacterModelFrameBackgroundOverlay:SetTexture(nil)
	elseif E.private.enhanced.character.selectedBGTexture == 'CUSTOM' then
		CharacterModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.customTexture)
	elseif E.private.enhanced.character.selectedBGTexture == 'CLASS' then
		CharacterModelFrameBackgroundOverlay:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]]..E.myclass)
	else
		CharacterModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.ArmoryConfigBackgroundValues.BlizzardBackdropList[E.private.enhanced.character.selectedBGTexture] or [[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]]..E.private.enhanced.character.selectedBGTexture)
	end
end

function Gems:UpdateInspectBG()
	if E.private.enhanced.character.selectedBGTexture == 'HIDE' then
		InspectModelFrameBackgroundOverlay:SetTexture(nil)
	elseif E.private.enhanced.character.selectedBGTexture == 'CUSTOM' then
		InspectModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.customTexture)
	elseif E.private.enhanced.character.selectedBGTexture == 'CLASS' then
		InspectModelFrameBackgroundOverlay:SetTexture([[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]]..E.myclass)
	else
		InspectModelFrameBackgroundOverlay:SetTexture(E.private.enhanced.character.ArmoryConfigBackgroundValues.BlizzardBackdropList[E.private.enhanced.character.selectedBGTexture] or [[Interface\AddOns\ElvUI_Enhanced\Media\Armory\]]..E.private.enhanced.character.selectedBGTexture)
	end
end
--------------------------
------------------------ bg
--------------------------

function Gems:Initialize()
	if E.private.enhanced.character.enable then
		if E.private.enhanced.character.GemsEnable then
			ToggleCharacter("PaperDollFrame")
			HideUIPanel(CharacterFrame)
			HideUIPanel(ItemSocketingFrame)
			-- print("ИНИЦИАЦИЯ ЗАПУЩЕНА")
			C_Timer:After(0.55, GemsOnInitCharacter)

			local f = CreateFrame("Frame",nil,UIParent)

			f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
			f:RegisterEvent("UNIT_INVENTORY_CHANGED")

			f:SetScript("OnEvent", function(self, event, unit)

				if (event == "UNIT_INVENTORY_CHANGED" and unit == "player") or event == "PLAYER_EQUIPMENT_CHANGED" then

					if  E.private.enhanced.character.GemsEnable then
						C_Timer:After(0.05, CheckForNeedUpdateCharacter)
					end

					Gems:UpdateCharacterBG()

				elseif  event == "UNIT_INVENTORY_CHANGED" and unit ~= "player" then
					C_Timer:After(0.55, CheckForNeedUpdateInspect)

				end
			end)
			C_Timer:After(1, CheckForNeedUpdateCharacter)

		end

		PaperDollFrame:HookScript("OnShow", function()

			-- CharacterHandsSlot:ClearAllPoints()
			-- CharacterHandsSlot:SetPoint("TOPRIGHT", 0, -15)

			CharacterModelFrame:ClearAllPoints()
			CharacterModelFrame:SetPoint('TOPLEFT', CharacterHeadSlot, 0, 5)
			CharacterModelFrame:SetPoint('RIGHT', CharacterHandsSlot)
			CharacterModelFrame:SetPoint('BOTTOM', CharacterMainHandSlot)
			------------update bg
			if _G["CharacterModelFrame"] and _G["CharacterModelFrame"].BackgroundTopLeft and _G["CharacterModelFrame"].BackgroundTopLeft:IsShown() then
				_G["CharacterModelFrame"].BackgroundTopLeft:Hide()
				_G["CharacterModelFrame"].BackgroundTopRight:Hide()
				_G["CharacterModelFrame"].BackgroundBotLeft:Hide()
				_G["CharacterModelFrame"].BackgroundBotRight:Hide()
				if _G["CharacterModelFrame"].backdrop then
					_G["CharacterModelFrame"].backdrop:Hide()
				end
			end
			CharacterModelFrameBackgroundOverlay:Show()
			CharacterModelFrameBackgroundOverlay:ClearAllPoints()
			CharacterModelFrameBackgroundOverlay:SetAllPoints(CharacterModelFrame)

		end)
		Gems:UpdateCharacterBG()
		InspectFrame:HookScript("OnShow",function()
			InspectModelFrame:ClearAllPoints()
			InspectModelFrame:SetPoint('TOPLEFT', InspectHeadSlot, 0, 5)
			InspectModelFrame:SetPoint('RIGHT', InspectHandsSlot)
			InspectModelFrame:SetPoint('BOTTOM', InspectMainHandSlot)

			if _G["InspectModelFrame"] and _G["InspectModelFrame"].BackgroundTopLeft and _G["InspectModelFrame"].BackgroundTopLeft:IsShown() then
				_G["InspectModelFrame"].BackgroundTopLeft:Hide()
				_G["InspectModelFrame"].BackgroundTopRight:Hide()
				_G["InspectModelFrame"].BackgroundBotLeft:Hide()
				_G["InspectModelFrame"].BackgroundBotRight:Hide()
				if _G["InspectModelFrame"].backdrop then
					_G["InspectModelFrame"].backdrop:Hide()
				end
			end
			InspectModelFrameBackgroundOverlay:Show()
			InspectModelFrameBackgroundOverlay:ClearAllPoints()
			InspectModelFrameBackgroundOverlay:SetAllPoints(InspectModelFrame)
			InspectItemLevelFrame:ClearAllPoints()
			InspectItemLevelFrame:SetPoint("BOTTOM", 0, 40)
			Gems:UpdateInspectBG()
			if E.private.enhanced.character.GemsEnable then
				C_Timer:After(0.55,GemsOnInitInspect)
				C_Timer:After(0.57, CheckForNeedUpdateInspect)
			end

		end)
		if E.private.enhanced.character.GemsEnable then
			InspectFrame:HookScript("OnEvent",function()
				-- Gems:UpdateInspectBG()
				C_Timer:After(0.55,GemsOnInitInspect)
				C_Timer:After(0.57, CheckForNeedUpdateInspect)


			end)
		end
	end
end

local function kostil()
	HideUIPanel(CharacterFrame)
	HideUIPanel(ItemSocketingFrame)
end
local function InitializeCallback()
	Gems:Initialize()
	-- HideUIPanel(CharacterFrame)
	-- HideUIPanel(ItemSocketingFrame)
	C_Timer:After(4, kostil)

end

E:RegisterModule(Gems:GetName(), InitializeCallback)
