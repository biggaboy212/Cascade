--!strict
--!nolint LocalUnused
--!nolint LocalShadow
local task = nil -- Disable usage of Roblox's task scheduler

--[[
	Forms a dependency on a graph object.
]]
local Types = require("../Types")
local External = require("../External")
local evaluate = require("../Graph/evaluate")
local nameOf = require("../Utility/nameOf")

local function depend<T>(
	dependent: Types.GraphObject,
	dependency: Types.GraphObject
): ()
	-- Ensure dependencies are evaluated and up-to-date
	-- when they are depended on. Also, newly created objects
	-- might not have any transitive dependencies captured yet,
	-- so ensure that they're present.
	evaluate(dependency, false)

	if table.isfrozen(dependent.dependencySet) or table.isfrozen(dependency.dependentSet) then
		External.logError("cannotDepend", nil, nameOf(dependent, "Dependent"), nameOf(dependency, "dependency"))
	end
	dependency.dependentSet[dependent] = true
	dependent.dependencySet[dependency] = true
end

return depend