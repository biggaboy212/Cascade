--// Imports
local utility = require("@modules/utility")
local types = require("@types")
local creator = require("@modules/creator")
local binder = require("@modules/binder")

local themes = require("@themes/init")
local components = require("@components/init")

--// References
local create = creator.Create

--// Variables
local cascade = { Themes = themes }

--// Initialize
cascade.New = function(properties: types.AppProperties): types.App
	properties = {
		Theme = properties and properties.Theme or themes.Light,
	}

	local container = utility.ProtectUI(create("ScreenGui")({
		Name = "Cascade",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ScreenInsets = Enum.ScreenInsets.None,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		OnTopOfCoreBlur = true,
	}))

	local object = binder.Wrap(properties, {
		Theme = function(theme)
			local function deepUpdate(target, new)
				for k, v in pairs(new) do
					if typeof(v) == "table" and typeof(target[k]) == "table" and not v.Value then
						deepUpdate(target[k], v)
					else
						target[k].Value = v.Value
					end
				end
			end

			deepUpdate(properties.Theme, theme)
		end
	}, container, { "Theme" })

	for component, make in pairs(components) do
		object[component] = make
	end

	binder.Apply(properties, object)

	return object
end

return cascade
