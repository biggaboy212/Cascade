--// Imports
local cascade = require("@src/init")

--// Variables
local app = cascade.New({
	Theme = cascade.Themes.Light,
})
local window = app.Window()

--// UI
task.wait(2)

app.Theme = cascade.Themes.Dark