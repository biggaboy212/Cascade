--// Imports
local creator = require("@modules/creator")

--// References
local value = creator.Value

--// Functions
local function color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex(color))

	return {
		value(parsedColor),
		value(1 - (alpha / 100)),
	}
end

--// Initialize
return {
	Text = {
		Primary = color4("FFFFFF", 85),
		PrimaryAccent = color4("FFFFFF", 38),
		Secondary = color4("FFFFFF", 55),
		Tertiary = color4("FFFFFF", 25),
		Quaternary = color4("FFFFFF", 10),
		Quinary = color4("FFFFFF", 5),
	},

	Controls = {
		Background = color4("1C1C1E", 100),

		View = color4("FFFFFF", 1.5),
		ViewBorder = color4("FFFFFF", 5),

		WindowControlIcon = color4("000000", 50),
		WindowControlStroke = color4("FFFFFF", 10),
		Exit = color4("FF5F57", 100),
		Minimize = color4("FEBC2E", 100),
		Zoom = color4("28C840", 100),

		SwitchAccent = color4("478CF6", 100),
		Selection = color4("007AFF", 100),
		SelectionStroke = color4("007AFF", 60),
		SelectionFocused = color4("0A82FF", 100),
		SelectionFocusedAccent = color4("FFFFFF", 85),

		Sidebar = color4("212121", 70),
		Separator = {
			Background = color4("000000", 50),
			Shadow = color4("FFFFFF", 0),
		},

		Titlebar = color4("363636", 100),
		TitlebarShadow = {
			Background = color4("000000", 0),
			Color = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
			Transparency = value(NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.5),
				NumberSequenceKeypoint.new(1, 1),
			})),
		},

		Toggle = {
			Knob = color4("FFFFFF", 100),
			KnobEffects = color4("FFFFFF", 100),

			SwitchOff = color4("000000", 19),
			SwitchOn = color4("478cf6", 100),

			DepthEffect = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
				ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
		},
	},
}
