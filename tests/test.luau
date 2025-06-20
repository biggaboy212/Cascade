--// Imports
local cascade = require("@src/init")

--// Variables
local app = cascade.New({
	Theme = cascade.Themes.Light,
})

local window = app:Window({
	Title = "Title",
	Subtitle = "Description",
})

do -- Main
	local section = window:Section({
		Label = "Main",
	})
	
	local t = section:Tab({
		Label = "Legit",
		Icon = cascade.Symbols.checkmarkSeal,
		Selected = true,
	}):Form()

	t:Row({SearchIndex = "sigma", Title = "sigma", Subtitle = "sdas"})
	t:Row({SearchIndex = "digma", Title = "digma", Subtitle = "sdas"})
	t:Row({SearchIndex = "rigma", Title = "rigma", Subtitle = "sdas"})
	t:Row({SearchIndex = "supersigma", Title = "sigma", Subtitle = "sdas"})

	section:Tab({
		Label = "Rage",
		Icon = cascade.Symbols.flame,
	})

	section:Tab({
		Label = "Visuals",
		Icon = cascade.Symbols.arkit,
	})

	section:Tab({
		Label = "Miscellaneous",
		Icon = cascade.Symbols.squareStack3dUp,
	})

	section:Tab({
		Label = "Configuration",
		Icon = cascade.Symbols.archivebox,
	})

	section:Tab({
		Label = "Settings",
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