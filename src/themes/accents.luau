--// Private Methods
local function makeGradient(topHex, bottomHex)
	return ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromHex(topHex)),
		ColorSequenceKeypoint.new(1, Color3.fromHex(bottomHex)),
	})
end

--// Publish
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
			SwitchAccent = Color3.fromHex("#BF5AF2"),
			Selection = Color3.fromHex("#9B35D4"),
			SelectionFocused = Color3.fromHex("#AE4FE0"),
			Toggle = { SwitchOn = Color3.fromHex("#BF5AF2") },
			Button = { FillPrimary = makeGradient("#AE4FE0", "#7A18B8") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#AF52DE"),
			Selection = Color3.fromHex("#8C2EC0"),
			SelectionFocused = Color3.fromHex("#9E42CA"),
			Toggle = { SwitchOn = Color3.fromHex("#AF52DE") },
			Button = { FillPrimary = makeGradient("#9E42CA", "#7010A8") },
		},
	},

	Pink = {
		_id = "Pink",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF375F"),
			Selection = Color3.fromHex("#D4163E"),
			SelectionFocused = Color3.fromHex("#E83058"),
			Toggle = { SwitchOn = Color3.fromHex("#FF375F") },
			Button = { FillPrimary = makeGradient("#E83058", "#C00030") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF2D55"),
			Selection = Color3.fromHex("#C8103A"),
			SelectionFocused = Color3.fromHex("#DC2A50"),
			Toggle = { SwitchOn = Color3.fromHex("#FF2D55") },
			Button = { FillPrimary = makeGradient("#DC2A50", "#B4002C") },
		},
	},

	Red = {
		_id = "Red",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF453A"),
			Selection = Color3.fromHex("#D4201A"),
			SelectionFocused = Color3.fromHex("#E83830"),
			Toggle = { SwitchOn = Color3.fromHex("#FF453A") },
			Button = { FillPrimary = makeGradient("#E83830", "#BC0E08") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF3B30"),
			Selection = Color3.fromHex("#C81A10"),
			SelectionFocused = Color3.fromHex("#DC2E24"),
			Toggle = { SwitchOn = Color3.fromHex("#FF3B30") },
			Button = { FillPrimary = makeGradient("#DC2E24", "#B00808") },
		},
	},

	Orange = {
		_id = "Orange",
		Dark = {
			SwitchAccent = Color3.fromHex("#FF9F0A"),
			Selection = Color3.fromHex("#C86800"),
			SelectionFocused = Color3.fromHex("#E07C00"),
			Toggle = { SwitchOn = Color3.fromHex("#FF9F0A") },
			Button = { FillPrimary = makeGradient("#E07C00", "#A85000") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FF9500"),
			Selection = Color3.fromHex("#BC6000"), 
			SelectionFocused = Color3.fromHex("#D47000"),
			Toggle = { SwitchOn = Color3.fromHex("#FF9500") },
			Button = { FillPrimary = makeGradient("#D47000", "#A04800") },
		},
	},

	Yellow = {
		_id = "Yellow",
		Dark = {
			SwitchAccent = Color3.fromHex("#FFD60A"),
			Selection = Color3.fromHex("#A87800"),
			SelectionFocused = Color3.fromHex("#C49000"),
			Toggle = { SwitchOn = Color3.fromHex("#FFD60A") },
			Button = { FillPrimary = makeGradient("#C49000", "#8C6000") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#FFCC00"),
			Selection = Color3.fromHex("#9C7000"),
			SelectionFocused = Color3.fromHex("#B88400"),
			Toggle = { SwitchOn = Color3.fromHex("#FFCC00") },
			Button = { FillPrimary = makeGradient("#B88400", "#845800") },
		},
	},

	Green = {
		_id = "Green",
		Dark = {
			SwitchAccent = Color3.fromHex("#32D74B"),
			Selection = Color3.fromHex("#1A9030"),
			SelectionFocused = Color3.fromHex("#24A83C"),
			Toggle = { SwitchOn = Color3.fromHex("#32D74B") },
			Button = { FillPrimary = makeGradient("#24A83C", "#0E7020") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#28CD41"),
			Selection = Color3.fromHex("#148428"),
			SelectionFocused = Color3.fromHex("#1E9C34"),
			Toggle = { SwitchOn = Color3.fromHex("#28CD41") },
			Button = { FillPrimary = makeGradient("#1E9C34", "#0C6818") },
		},
	},

	Graphite = {
		_id = "Graphite",
		Dark = {
			SwitchAccent = Color3.fromHex("#98989D"),
			Selection = Color3.fromHex("#58585C"),
			SelectionFocused = Color3.fromHex("#6E6E72"),
			Toggle = { SwitchOn = Color3.fromHex("#98989D") },
			Button = { FillPrimary = makeGradient("#6E6E72", "#404044") },
		},
		Light = {
			SwitchAccent = Color3.fromHex("#8E8E93"),
			Selection = Color3.fromHex("#4E4E52"),
			SelectionFocused = Color3.fromHex("#626266"),
			Toggle = { SwitchOn = Color3.fromHex("#8E8E93") },
			Button = { FillPrimary = makeGradient("#626266", "#383838") },
		},
	},
}