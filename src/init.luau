--// Imports
local utility = require("@modules/utility")
local types = require("@types")
local creator = require("@modules/creator")
local binder = require("@modules/binder")

local symbols = require("@modules/symbols")
local themes = require("@themes/init")
local components = require("@components/init")

--// References
local create = creator.Create

--// Variables
local cascade = { Themes = themes, Symbols = symbols }

--// Functions
local function deepCopy(original)
	local copy = {}
	for key, value in pairs(original) do
		local vType = typeof(value)
		if vType == "table" then
			if value.Value ~= nil and value.Connect and typeof(value.Connect) == "function" then
				copy[key] = creator.Value(value.Value)
			else
				copy[key] = deepCopy(value)
			end
		else
			copy[key] = value
		end
	end
	return copy
end

--// Initialize
cascade.New = function(properties: types.AppProperties): types.App
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end

	properties = properties or {}

	local initialTheme = properties.Theme or themes.Light
	properties.Theme = deepCopy(initialTheme)

	local container = utility.ProtectUI(create("ScreenGui")({
		Name = "Cascade",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		OnTopOfCoreBlur = true,
	}))

	local object = binder.Wrap(properties, {
		Theme = function(theme)
			local function deepUpdate(target, new)
				for key, value in pairs(new) do
					if typeof(value) == "table" and typeof(target[key]) == "table" and not value.Value then
						deepUpdate(target[key], value)
					elseif target[key] and value and value.Value ~= nil then
						target[key].Value = value.Value
					end
				end
			end

			deepUpdate(properties.Theme, theme)
		end,
	}, container, { "Theme" })

	for component, make in pairs(components) do
		object[component] = make
	end

	binder.Apply(properties, object)

	return object
end

return cascade