--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler

--[[
	Processes and returns an existing instance, with options for setting
	properties, event handlers and other attributes on the instance.
]]
local Types = require("../Types")
local External = require("../External")
local applyInstanceProps = require("../Instances/applyInstanceProps")

local function Hydrate(
	scope: Types.Scope<unknown>,
	target: Instance
)
	if target :: any == nil then
		External.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
	end
	return function(
		props: Types.PropertyTable
	): Instance
	
		table.insert(scope, target)
		applyInstanceProps(scope, props, target)
		return target
	end
end

return Hydrate