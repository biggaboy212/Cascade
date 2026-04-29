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
	Page = require("@components/Page"),
	Notification = require("@components/Notification"),
}

--// Initialize
local function wrap(name, make)
	return function(self, ...)
		local result, raw = make(self, ...)

		if
			typeof(result) == "Instance"
			or (typeof(result) == "table" and getmetatable(result) and typeof(getmetatable(result)) == "Instance")
		then
			raw = result
			result = binder.Wrap({}, {}, result)
		end

		if typeof(result) == "table" then
			if result.Type == nil then
				result.Type = name
			end

			if result.Theme == nil and self and self.Theme then
				result.Theme = self.Theme
			end
		end

		binder.Apply(components, result)

		local final = raw
			or (
				typeof(result) == "table"
				and pcall(function()
					return result.__instance
				end)
				and result.__instance
			)

		if final ~= nil then
			table.insert(__SH.COMPINDEXES, final)
			
			return result, final
		end

		return result
	end
end

for name, make in pairs(components) do
	components[name] = wrap(name, make)
end

function components.register(name: string, make: (any, any) -> any)
	components[name] = wrap(name, make)
end

return components
