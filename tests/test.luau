--// Imports
local cascade = require("@src/init")

--// Variables
local app = cascade.New({
	Theme = cascade.Themes.Light,
})
local window = app:Window()
local tab = window:Tab({
	Selected = true,
	Name = "Tsa"
})

local tab2 = window:Tab({
	Name = "Tsa",
	Indentation = 1
})

task.wait(1)

app.Theme = cascade.Themes.Dark