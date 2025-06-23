--// Imports
local binder = require("@modules/binder")

--// Variables
local components = {
	Window = require("@components/Window"),
	Section = require("@components/Section"),
	Tab = require("@components/Tab"),
	Form = require("@components/Form"),
	Row = require("@components/Row"),
	TitleStack = require("@components/TitleStack"),
	Label = require("@components/Label"),
	Toggle = require("@components/Toggle"),
	TextField = require("@components/TextField"),
	Slider = require("@components/Slider"),
}

--// Intialize
for component, make in pairs(components) do
	components[component] = (function(make)
		return function(...)
			local object = make(...)

			binder.Apply(components, object)

			return object
		end
	end)(make)
end

return components
