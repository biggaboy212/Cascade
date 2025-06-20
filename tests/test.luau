--// Imports
local cascade = require("@src/init")

--// Variables
local app = cascade.New({
	Theme = cascade.Themes.Light,
})

local window = app:Window()

do -- Main
	local section = window:Section({
		Name = "Main"
	})
	
	section:Tab({
		Selected = true,
		Name = "Legit",
		Icon = cascade.Symbols.checkmarkSeal,
	})

	section:Tab({
		Name = "Rage",
		Icon = cascade.Symbols.flame,
	})

	section:Tab({
		Name = "Visuals",
		Icon = cascade.Symbols.arkit,
	})

	section:Tab({
		Name = "Miscellaneous",
		Icon = cascade.Symbols.squareStack3dUp,
	})

	section:Tab({
		Name = "Configuration",
		Icon = cascade.Symbols.archivebox,
	})

	section:Tab({
		Name = "Settings",
		Icon = cascade.Symbols.gearshape,
	})
end

do
	local section = window:Section()
	
	section:Tab({
		Icon = cascade.Symbols.cube,
	})

	section:Tab({
		Icon = cascade.Symbols.cube,
		Indentation = 1
	})

	section:Tab({
		Icon = cascade.Symbols.cube,
		Indentation = 2
	})

	section:Tab({
		Icon = cascade.Symbols.cube,
		Indentation = 3
	})

	section:Tab({
		Icon = cascade.Symbols.cube,
	})
end