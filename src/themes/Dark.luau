--// Imports
local creator = require("@modules/creator")

--// References
local value = creator.Value

--// Functions
local function color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex("#" .. color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100))
	}
end

--// Initialize
return {
	Text = {
		Primary = color4("FFFFFF", 85),
		Secondary = color4("FFFFFF", 55),
		Tertiary = color4("FFFFFF", 25),
		Quaternary = color4("FFFFFF", 10),
		Quinary = color4("FFFFFF", 5),
	},

	Accents = {
		Red = color4("FF453A", 100),
	},

	Controls = {
		SwitchAccent = color4("478CF6", 100),
		Selection = color4("007AFF", 100),
		SelectionFocused = color4("0A82FF", 100),
		SelectionFocusedAccent = color4("FFFFFF", 85),

		Sidebar = color4("000000", 45),
		Separator = {
			Background = color4("000000", 100),
			Shadow = color4("FFFFFF", 5),
		},
	},
}