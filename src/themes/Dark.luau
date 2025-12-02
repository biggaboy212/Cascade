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
		Secondary = color4("FFFFFF", 55),
		Tertiary = color4("FFFFFF", 25),
		Quaternary = color4("FFFFFF", 10),
		Quinary = color4("FFFFFF", 5),

		SelectionPrimary = color4("FFFFFF", 100),
		PrimaryAccent = color4("FFFFFF", 38),
	},

	Accents = {
		Red = color4("FF453A", 100),
	},

	Controls = {
		Background = color4("1C1C1E", 100),

		View = color4("1F1F21", 100),
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

		Sidebar = color4("202023", 84),
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

			SwitchOff = color4("7a7a7a", 40),
			SwitchOn = color4("478cf6", 100),

			DepthEffect = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
				ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
		},

		Slider = {
			Track = color4("2C2C2E", 100),
			TrackEffects = color4("000000", 10),
			TrackFill = color4("478CF6", 100),

			Thumb = color4("FFFFFF", 100),
			ThumbStroke = color4("000000", 20),
			ThumbEffects = color4("FFFFFF", 80),
		},

		Button = {
			Shadow = value(Color3.fromRGB(0, 0, 0)),
			FillPrimary = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 148, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 110, 255)),
			})),
			FillSecondary = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55)),
			})),
		},

		Stepper = {
			Background = color4("373737", 100),
			Dropshadow = color4("000000", 100),
			Separator = color4("FFFFFF", 10),
			Filler = color4("FFFFFF", 4),
			SegmentShadow = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
			})),
		},

		RadioButtonGroup = {
			Background = color4("373737", 100),
			Dot = color4("FFFFFF", 100),
			Stroke = color4("000000", 20),
			Overlay = color4("FFFFFF", 8),
			InnerShadow = color4("FFFFFF", 10),
		},

		MenuButton = {
			IndicatorBackground = color4("FFFFFF", 10),
			MenuBackground = color4("2C2C2E", 95),
		},
	},
}
