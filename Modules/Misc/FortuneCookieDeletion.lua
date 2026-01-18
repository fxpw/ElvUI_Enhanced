local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")
local B = E:GetModule("Bags")

local tinsert = table.insert
local GetItemInfo = GetItemInfo
local GetContainerItemID = GetContainerItemID
local GetContainerItemInfo = GetContainerItemInfo
local GetContainerNumSlots = GetContainerNumSlots


local FORTUNE_COOKIE_NAME = "Предсказание из печенья"

function M:HookVendorGrays()
	if not E.db.enhanced.general.deleteFortuneCookie then return end

	local originalGetGraysInfo = B.GetGraysInfo

	function B:GetGraysInfo()
		local count, value = originalGetGraysInfo(self)

		if not E.db.enhanced.general.deleteFortuneCookie then
			return count, value
		end

		local itemList = self.SellFrame.Info.itemList

		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				local itemID = GetContainerItemID(bag, slot)

				if itemID then
					local name, link, rarity = GetItemInfo(itemID)

					if name and name == FORTUNE_COOKIE_NAME and rarity and rarity == 1 then
						local alreadyAdded = false
						for _, item in ipairs(itemList) do
							if item[1] == bag and item[2] == slot then
								alreadyAdded = true
								break
							end
						end

						if not alreadyAdded then
							local stackCount = select(2, GetContainerItemInfo(bag, slot)) or 1
							local price = 0

							tinsert(itemList, {bag, slot, link, price, stackCount})

							value = value + (price * stackCount)
						end
					end
				end
			end
		end

		return #itemList, value
	end
end

function M:InitFortuneCookieDeletion()
	if E.db.enhanced.general.deleteFortuneCookie then
		self:HookVendorGrays()
	end
end
