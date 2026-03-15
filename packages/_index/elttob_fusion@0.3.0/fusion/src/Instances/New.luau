--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler

--[[
	Constructs and returns a new instance, with options for setting properties,
	event handlers and other attributes on the instance right away.
]]
local Types = require("../Types")
local External = require("../External")
local defaultProps = require("../Instances/defaultProps")
local applyInstanceProps = require("../Instances/applyInstanceProps")

type Component = (Types.PropertyTable) -> Instance

local function New(
	scope: Types.Scope<unknown>,
	className: string
)
	if (className :: any) == nil then
		local scope = (scope :: any) :: string
		External.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. scope .. "\" { ... }")
	end

	-- This might look appealing to try and cache. But please don't. The scope
	-- upvalue is shared between the two curried function calls, so this will
	-- open incredible cross-codebase wormholes like you've never seen before.
	return function(
		props: Types.PropertyTable
	): Instance
		local ok, instance = pcall(Instance.new, className)
		if not ok then
			External.logError("cannotCreateClass", nil, className)
		end

		local classDefaults = defaultProps[className]
		if classDefaults ~= nil then
			for defaultProp, defaultValue in pairs(classDefaults) do
				(instance :: any)[defaultProp] = defaultValue
			end
		end

		table.insert(scope, instance)
		applyInstanceProps(scope, props, instance)

		return instance
	end
end

return New