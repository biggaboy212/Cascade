--// Publish
-- Refined to match macOS Human Interface Guidelines (HIG)

local function makeGradient(topHex, bottomHex)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromHex(topHex)),
		ColorSequenceKeypoint.new(1, Color3.fromHex(bottomHex)),
	})
end

return {
	Blue = {
		_id = "Blue",

		Dark = {
			SwitchAccent = Color3.fromHex("#0A84FF"),
			Selection = Color3.fromHex("#007AFF"),
			SelectionFocused = Color3.fromHex("#0A82FF"),
			Toggle = { SwitchOn = Color3.fromHex("#0A84FF") },
			Button = {
				FillPrimary = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 148, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 110, 255)),
				}),
			},
		},
		Light = {
			SwitchAccent = Color3.fromHex("#0A84FF"),
			Selection = Color3.fromHex("#007AFF"),
			SelectionFocused = Color3.fromHex("#0A82FF"),
			Toggle = { SwitchOn = Color3.fromHex("#0A84FF") },
			Button = {
				FillPrimary = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(43, 145, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 122, 255)),
				}),
			},
		},
	},
	
	Purple = {
		_id = "Purple",
		Dark = {
			SwitchAccent = Color3.fromHex("#BF5AF6"),
			Selection = Color3.fromHex("#BF5AF6"),
			SelectionFocused = Color3.fromHex("#CB7AF7"),
			Toggle = { SwitchOn = Color3.fromHex("#BF5AF6") },
			Button = { FillPrimary = makeGradient("#CB7AF7", "#9A3BD6") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#AF52DE"),
			Selection = Color3.fromHex("#AF52DE"),
			SelectionFocused = Color3.fromHex("#BF74E4"),
			Toggle = { SwitchOn = Color3.fromHex("#AF52DE") },
			Button = { FillPrimary = makeGradient("#BF74E4", "#8B30BF") },
		},
	},

	Pink = {
		_id = "Pink",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF375F"),
			Selection = Color3.fromHex("#FF375F"),
			SelectionFocused = Color3.fromHex("#FF5E7E"),
			Toggle = { SwitchOn = Color3.fromHex("#FF375F") },
			Button = { FillPrimary = makeGradient("#FF5E7E", "#D82042") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF2D55"),
			Selection = Color3.fromHex("#FF2D55"),
			SelectionFocused = Color3.fromHex("#FF5676"),
			Toggle = { SwitchOn = Color3.fromHex("#FF2D55") },
			Button = { FillPrimary = makeGradient("#FF5676", "#D8183B") },
		},
	},

	Red = {
		_id = "Red",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF453A"),
			Selection = Color3.fromHex("#FF453A"),
			SelectionFocused = Color3.fromHex("#FF6961"),
			Toggle = { SwitchOn = Color3.fromHex("#FF453A") },
			Button = { FillPrimary = makeGradient("#FF6961", "#D6251A") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF3B30"),
			Selection = Color3.fromHex("#FF3B30"),
			SelectionFocused = Color3.fromHex("#FF6961"),
			Toggle = { SwitchOn = Color3.fromHex("#FF3B30") },
			Button = { FillPrimary = makeGradient("#FF6961", "#D62015") },
		},
	},

	Orange = {
		_id = "Orange",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF9F0A"),
			Selection = Color3.fromHex("#FF9F0A"),
			SelectionFocused = Color3.fromHex("#FFB340"),
			Toggle = { SwitchOn = Color3.fromHex("#FF9F0A") },
			Button = { FillPrimary = makeGradient("#FFB340", "#D67A00") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF9500"),
			Selection = Color3.fromHex("#FF9500"),
			SelectionFocused = Color3.fromHex("#FFAB33"),
			Toggle = { SwitchOn = Color3.fromHex("#FF9500") },
			Button = { FillPrimary = makeGradient("#FFAB33", "#D67000") },
		},
	},

	Yellow = {
		_id = "Yellow",
		Dark = {
			SwitchAccent = Color3.fromHex("#FFD60A"),
			Selection = Color3.fromHex("#FFD60A"),
			SelectionFocused = Color3.fromHex("#FFDF40"),
			Toggle = { SwitchOn = Color3.fromHex("#FFD60A") },
			Button = { FillPrimary = makeGradient("#FFDF40", "#D6AD00") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FFCC00"),
			Selection = Color3.fromHex("#FFCC00"),
			SelectionFocused = Color3.fromHex("#FFD633"),
			Toggle = { SwitchOn = Color3.fromHex("#FFCC00") },
			Button = { FillPrimary = makeGradient("#FFD633", "#D6A300") },
		},
	},

	Green = {
		_id = "Green",
		Dark = {
			SwitchAccent = Color3.fromHex("#32D74B"),
			Selection = Color3.fromHex("#32D74B"),
			SelectionFocused = Color3.fromHex("#56DF6B"),
			Toggle = { SwitchOn = Color3.fromHex("#32D74B") },
			Button = { FillPrimary = makeGradient("#56DF6B", "#22AB36") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#28CD41"),
			Selection = Color3.fromHex("#28CD41"),
			SelectionFocused = Color3.fromHex("#52D765"),
			Toggle = { SwitchOn = Color3.fromHex("#28CD41") },
			Button = { FillPrimary = makeGradient("#52D765", "#1CA32C") },
		},
	},

	Graphite = {
		_id = "Graphite",
		Dark = {
			SwitchAccent = Color3.fromHex("#98989D"),
			Selection = Color3.fromHex("#98989D"),
			SelectionFocused = Color3.fromHex("#AFAFB4"),
			Toggle = { SwitchOn = Color3.fromHex("#98989D") },
			Button = { FillPrimary = makeGradient("#AFAFB4", "#7B7B80") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#8E8E93"),
			Selection = Color3.fromHex("#8E8E93"),
			SelectionFocused = Color3.fromHex("#A6A6AA"),
			Toggle = { SwitchOn = Color3.fromHex("#8E8E93") },
			Button = { FillPrimary = makeGradient("#A6A6AA", "#717176") },
		},
	},
}
