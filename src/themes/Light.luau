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
		Primary = color4("000000", 85),
		Secondary = color4("000000", 50),
		Tertiary = color4("000000", 25),
		Quaternary = color4("000000", 10),
		Quinary = color4("000000", 5),

		SelectionPrimary = color4("FFFFFF", 100),
		PrimaryAccent = color4("4D4D4D", 100),
	},

	Accents = {
		Red = color4("FF3B30", 100),
	},

	Controls = {
		Background = color4("FFFFFF", 100),

		View = color4("FCFCFC", 100),
		ViewBorder = color4("000000", 5),

		WindowControlIcon = color4("000000", 50),
		WindowControlStroke = color4("000000", 20),
		Exit = color4("FF5F57", 100),
		Minimize = color4("FEBC2E", 100),
		Zoom = color4("28C840", 100),

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

		Toggle = {
			Knob = color4("FFFFFF", 100),
			KnobEffects = color4("FFFFFF", 100),

			SwitchOff = color4("000000", 9),
			SwitchOn = color4("478cf6", 100),

			DepthEffect = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 225, 225)),
				ColorSequenceKeypoint.new(0.68, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
		},

		Slider = {
			Track = color4("000000", 5),
			TrackEffects = color4("000000", 0),

			Thumb = color4("FFFFFF", 100),
			ThumbStroke = color4("000000", 2),
			ThumbEffects = color4("FFFFFF", 100),
		},

		Button = {
			Shadow = value(Color3.new(0, 0, 0)),
			FillPrimary = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(43, 145, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 122, 255)),
			})),
			FillSecondary = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
		},

		Stepper = {
			Background = color4("FFFFFF", 100),
			Dropshadow = color4("000000", 100),
			Separator = color4("000000", 22),
			Filler = color4("000000", 5),
			SegmentShadow = value(ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
			})),
		},

		RadioButtonGroup = {
			Background = color4("FFFFFF", 100),
			Dot = color4("FFFFFF", 100),
			Stroke = color4("000000", 8),
			Overlay = color4("FFFFFF", 17),
			InnerShadow = color4("000000", 10),
		},
		
		MenuButton = {
			IndicatorBackground = color4("000000", 5),
			MenuBackground = color4("F6F6F6", 95),
		}
	},
}
