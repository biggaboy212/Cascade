--// Imports
local creator = require("@modules/creator")

--// References
local value = creator.Value

--// Functions
local function Color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex(color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100)),
	}
end

--// Initialize
return {
	Text = {
		Primary = Color4("000000", 85),
	},

	Accents = {
		Red = Color4("FF3B30", 100),
	},

	Controls = {
		SwitchAccent = Color4("478CF6", 100),
		Selection = Color4("007AFF", 100),
		SelectionFocused = Color4("0A82FF", 100),
		SelectionFocusedAccent = Color4("FFFFFF", 85),

		Sidebar = Color4("EAEAEA", 84),
		Separator = {
			Background = Color4("000000", 18),
			Shadow = Color4("000000", 10),
		},
	},
}
