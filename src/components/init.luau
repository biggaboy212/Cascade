--// Imports
local binder = require("@modules/binder")

--// Variables
local components = {
	Window = require("@components/Window"),
	Section = require("@components/Section"),
	Tab = require("@components/Tab"),
	PageSection = require("@components/PageSection"),
	Form = require("@components/Form"),
	Row = require("@components/Row"),
	HStack = require("@components/HStack"),
	VStack = require("@components/VStack"),
	TitleStack = require("@components/TitleStack"),
	Label = require("@components/Label"),
	Symbol = require("@components/Symbol"),
	Toggle = require("@components/Toggle"),
	TextField = require("@components/TextField"),
	KeybindField = require("@components/KeybindField"),
	Slider = require("@components/Slider"),
	Button = require("@components/Button"),
	Stepper = require("@components/Stepper"),
	RadioButtonGroup = require("@components/RadioButtonGroup"),
	PopUpButton = require("@components/PopUpButton"),
	PullDownButton = require("@components/PullDownButton"),
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
