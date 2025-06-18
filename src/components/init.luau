--// Imports
local types = require("@types")
local binder = require("@modules/binder")

--// Variables
local components = {
	Window = require("@components/Window"),
	Tab = require("@components/Tab"),
}

--// Intialize
for component, make in pairs(components) do
	components[component] = (function(make)
		return function(...)
			local object = make(...)

			binder.Apply(components, object, { component })
			
			return object
		end
	end)(make)
end

return components
