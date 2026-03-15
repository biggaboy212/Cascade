--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler

--[[
	Creates cleanup tables with access to constructors as methods.
]]
local Types = require("../Types")
local ExternalDebug = require("../ExternalDebug")
local merge = require("../Utility/merge")
local scopePool = require("../Memory/scopePool")

local function scoped(
	...: {[unknown]: unknown}
): any
	local scope = setmetatable(
		scopePool.reuseAny() :: any or {},
		{__index = merge(false, {}, ...)}
	) :: any
	ExternalDebug.trackScope(scope)
	return scope
end

return (scoped :: any) :: Types.ScopedConstructor