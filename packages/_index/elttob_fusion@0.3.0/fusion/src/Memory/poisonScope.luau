--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler

--[[
	'Poisons' the given scope; if the scope is used again, then it will cause
	the program to crash.
]]
local Types = require("../Types")
local External = require("../External")

local function poisonScope(
	scope: Types.Scope,
	context: string
): ()
	local mt = getmetatable(scope)
	if typeof(mt) == "table" and mt._FUSION_POISONED then
		return
	end
	table.clear(scope)
	setmetatable(scope :: any, {
		_FUSION_POISONED = true,
		__index = function()
			External.logError("poisonedScope", nil, context)
		end,
		__newindex = function()
			External.logError("poisonedScope", nil, context)
		end
	})
end

return poisonScope