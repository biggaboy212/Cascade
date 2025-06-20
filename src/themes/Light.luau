--// Imports
local creator = require("@modules/creator")

--// References
local value = creator.Value

--// Functions
local function color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex(color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100)),
	}
end

--// Initialize
return {
	Text = {
		Primary = color4("000000", 85),
		PrimaryAccent = color4("4D4D4D", 100),
		Secondary = color4("000000", 50),
		Tertiary = color4("000000", 25),
		Quaternary = color4("000000", 10),
		Quinary = color4("000000", 5),
	},

	Accents = {
		Red = color4("FF3B30", 100),
	},

	Controls = {
		SwitchAccent = color4("478CF6", 100),
		Selection = color4("007AFF", 100),
		SelectionStroke = color4("007AFF", 50),
		SelectionFocused = color4("0A82FF", 100),
		SelectionFocusedAccent = color4("FFFFFF", 85),

		Sidebar = color4("EAEAEA", 84),
		Separator = {
			Background = color4("000000", 18),
			Shadow = color4("000000", 10),
		},

		Background = color4("FFFFFF", 100),

		Titlebar = color4("EEEEEE", 100),
		TitlebarShadow = {
			Background = color4("EAEAEA", 25),
			Color = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
			})),
			Transparency = value(NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.35),
				NumberSequenceKeypoint.new(1, 0.35),
			})),
		},

		View = color4("000000", 1.5),
		ViewBorder = color4("000000", 5),
	},
}
