local E, L, V, P, G = unpack(ElvUI)
local M = E:GetModule("Enhanced_Misc")

local match = string.match

local GetFactionInfo = GetFactionInfo
local GetNumFactions = GetNumFactions
local GetWatchedFactionInfo = GetWatchedFactionInfo
local IsFactionInactive = IsFactionInactive
local SetWatchedFactionIndex = SetWatchedFactionIndex


local function ExtractFactionName(msg)
	local faction

	faction = match(msg, "|3%-7%((.-)%) к вам")
	if faction then return faction end

	faction = match(msg, "Отношение (.+) к вам улучшилось")
	if faction then return faction end

	faction = match(msg, "Отношение (.+) к вам ухудшилось")
	if faction then return faction end

	faction = match(msg, "Reputation with (.+) increased")
	if faction then return faction end

	faction = match(msg, "Reputation with (.+) decreased")
	if faction then return faction end

	return nil
end

function M:CHAT_MSG_COMBAT_FACTION_CHANGE(_, msg)
	local faction = ExtractFactionName(msg)

	if faction and faction ~= GetWatchedFactionInfo() then
		for factionIndex = 1, GetNumFactions() do
			local name = GetFactionInfo(factionIndex)

			if name == faction then
				if not IsFactionInactive(factionIndex) then
					SetWatchedFactionIndex(factionIndex)
				end

				break
			end
		end
	end
end

function M:WatchedFaction()
	if E.db.enhanced.general.autoRepChange then
		self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	else
		self:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	end
end
