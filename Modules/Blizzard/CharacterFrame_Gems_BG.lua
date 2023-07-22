local E, L, V, P, G = unpack(ElvUI)
local Gems = E:NewModule("CharacterFrame_Gems_BG", "AceHook-3.0", "AceEvent-3.0")
local S = E:GetModule("Skins")
-- local EI = E:GetModule("Enhanced_EquipmentInfo")
local _
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


Gems.superBlackSockets = {
	[104000] = true,
    [104001] = true,
    [104002] = true,
    [104003] = true,
    [104004] = true,
    [104005] = true,
    [104006] = true,
    [104007] = true,
    [104008] = true,
    [104009] = true,
    [104010] = true,
    [104011] = true,
    [104012] = true,
    [104013] = true,
    [104014] = true,
    [104015] = true,
    [104016] = true,
    [104017] = true,
    [104018] = true,
    [104019] = true,
    [100824] = true,
    [100825] = true,
    [100826] = true,
    [100827] = true,
    [100828] = true,
    [100829] = true,
    [100830] = true,
    [100831] = true,
    [100832] = true,
    [100833] = true,
    [100834] = true,
    [100835] = true,
    [100836] = true,
    [100837] = true,
    [100838] = true,
    [100839] = true,
    [100840] = true,
    [100841] = true,
    [100842] = true,
    [100843] = true,
    [100844] = true,
    [100845] = true,
    [100847] = true,
    [100848] = true,
    [100849] = true,
    [100850] = true,
    [100851] = true,
    [100852] = true,
    [100853] = true,
    [100854] = true,
    [100855] = true,
    [100856] = true,
    [100857] = true,
    [100858] = true,
    [100859] = true,
    [100860] = true,
    [100861] = true,
    [100862] = true,
    [100863] = true,
    [100864] = true,
    [100865] = true,
    [100866] = true,
    [100867] = true,
    [100868] = true,
    [100869] = true,
    [100870] = true,
    [100871] = true,
    [100872] = true,
    [100873] = true,
    [100874] = true,
    [100875] = true,
    [100876] = true,
    [100877] = true,
    [100878] = true,
    [100879] = true,
    [100880] = true,
    [100881] = true,
    [100882] = true,
    [100883] = true,
    [100884] = true,

}
Gems.blackSockets = {
	[260043] = true,
    [103501] = true,
    [103502] = true,
    [103503] = true,
    [103504] = true,
    [103505] = true,
    [103506] = true,
    [103507] = true,
    [103508] = true,
    [103509] = true,
    [103510] = true,
    [103511] = true,
    [103512] = true,
    [103513] = true,
    [103514] = true,
    [103515] = true,
    [103516] = true,
    [103517] = true,
    [103518] = true,
    [103519] = true,
    [103520] = true,
    [100822] = true,
    [100766] = true,
    [100765] = true,
    [100764] = true,
    [100762] = true,
    [260042] = true,
    [260039] = true,
    [260048] = true,
    [260038] = true,
    [260047] = true,
    [260041] = true,
    [260046] = true,
    [260037] = true,
    [260036] = true,
    [260045] = true,
    [260035] = true,
    [260044] = true,
    [100769] = true,
    [100770] = true,
    [100767] = true,
    [260034] = true,
    [149186] = true,
    [260033] = true,
    [260032] = true,
    [260031] = true,
    [260030] = true,
    [100775] = true,
    [100774] = true,
    [100778] = true,
    [100773] = true,
    [100771] = true,
    [100777] = true,
    [100781] = true,
	[100782] = true,
    [100783] = true,
	[100784] = true,
    [100785] = true,
    [100786] = true,
    [100787] = true,
	[100788] = true,
    [100789] = true,
    [100790] = true,
    [100791] = true,
	[100792] = true,
    [100793] = true,
    [100794] = true,
	[100795] = true,
	[100796] = true,
    [260040] = true,
    [100797] = true,
    [100798] = true,
    [100799] = true,
    [100801] = true,
    [100802] = true,
    [100803] = true,
    [100805] = true,
    [100806] = true,
    [100807] = true,
    [100809] = true,
    [100810] = true,
    [100813] = true,
    [100814] = true,
    [100815] = true,
    [100754] = true,
    [100817] = true,
    [100818] = true,
    [100758] = true,
    [100821] = true,
    [100700] = true,
    [100701] = true,
    [100702] = true,
    [100703] = true,
    [100704] = true,
    [100705] = true,
    [100706] = true,
    [100707] = true,
    [100708] = true,
    [100709] = true,
    [100710] = true,
    [100711] = true,
    [100712] = true,
    [100713] = true,
    [100714] = true,
    [100715] = true,
    [100716] = true,
    [100717] = true,
    [100718] = true,
    [100719] = true,
    [100720] = true,
    [100721] = true,
    [100722] = true,
    [100723] = true,
    [100724] = true,
    [100725] = true,
    [100726] = true,
    [100727] = true,
    [100728] = true,
    [100729] = true,
    [100730] = true,
    [100731] = true,
    [100732] = true,
    [100733] = true,
    [100734] = true,
    [100735] = true,
    [100736] = true,
    [100737] = true,
    [100738] = true,
    [100739] = true,
    [100740] = true,
    [100741] = true,
    [100742] = true,
    [100743] = true,
    [100744] = true,
    [100745] = true,
    [100746] = true,
    [100747] = true,
    [100748] = true,
    [100749] = true,
    [100750] = true,
    [100751] = true,
    [100752] = true,
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
	for SlotName, _ in pairs(Gems.Slots) do
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
		if Slot.Gems and  Slot.Gems.AnchorForGems then
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
		-- print(frame.containerID, SocetNum)
		SendServerMessage("ACMSG_REMOVE_SOCKET_FROM_ITEM", string.format("%d:%d:%d", -1, frame.containerID, SocetNum))

	elseif button == "LeftButton" then
		SocketInventoryItem(frame.containerID)
		local yes = GetExistingSocketInfo(SocetNum)
		local isMeta = GetSocketTypes(SocetNum)
		if yes == nil then
			for bagID = 0, 4 do
				for slotID = 1, GetContainerNumSlots(bagID) do
					local itemID = GetContainerItemID(bagID, slotID)
					if itemID and ((isMeta == "Meta" and Gems.metaBlackSockets[itemID]) or (isMeta ~= "Meta" and Gems.superBlackSockets[itemID]))  then
						PickupContainerItem(bagID, slotID)
						ClickSocketButton(SocetNum)
						AcceptSockets()
						HideUIPanel(ItemSocketingFrame)
						return
					end
				end
			end
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
		end
		if ItemSocketingFrame:IsShown() then
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
		if ItemSocketingFrame:IsShown() then
			HideUIPanel(ItemSocketingFrame)
		end
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
			local _, gmlnk = GetItemGem(link, i)
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
    if not frame.Gems then return end

    for i = 1, 3 do
        local gem = frame.Gems["Gem"..i]
        gem.texture:SetTexture(nil)
        gem:SetScript("OnEnter", nil)
        gem:SetScript("OnLeave", nil)
        gem:SetScript("OnClick", nil)
    end
end

local function UpdateGems(frame,link,who)

	if frame.Gems.MaxGems > 0 then
		for i = 1,frame.Gems.MaxGems do
			local gemname, gemLink = GetItemGem(link, i)

			frame.Gems["Gem"..i].GemName = gemname or "n"
			frame.Gems["Gem"..i].GemLink = gemLink or "n"
			local _, _, itemQuality, _, _, _, _, _,_, itemTexture = GetItemInfo(gemLink)

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
	for slotName, _ in pairs(Gems.Slots) do
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
		for slotName, _ in pairs(Gems.Slots) do
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
			for slotName, _ in pairs(Gems.Slots) do

				local frame = _G[format("%s%s", "Inspect", slotName)]
				frame.Gems = {}
				local unit = InspectFrame.unit
				local itemLink
				if unit then
					_, itemLink = GetItemInfo(GetInventoryItemLink(unit, frame:GetID()))
				else
					_, itemLink = GetItemInfo(GetInventoryItemLink("target", frame:GetID()))
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
			for slotName, _ in pairs(Gems.Slots) do

				local frame = _G[format("%s%s", "Character", slotName)]
				frame.Gems = frame.Gems or {}
				local  _, itemLink = GetItemInfo(GetInventoryItemLink("player", frame:GetID()))
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
			if ItemSocketingFrame:IsShown() then
				HideUIPanel(ItemSocketingFrame)
			end
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
	if CharacterFrame:IsShown() then
		HideUIPanel(CharacterFrame)
	end
	if ItemSocketingFrame:IsShown() then
		HideUIPanel(ItemSocketingFrame)
	end
end

local function InitializeCallback()
	Gems:Initialize()
	C_Timer:After(4, kostil)
	C_Timer:After(10, kostil)
end

E:RegisterModule(Gems:GetName(), InitializeCallback)
