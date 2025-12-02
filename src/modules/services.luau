--// Imports
local utility = require("@modules/utility")

--// Functions
local function cast(service: string): any
	return utility.Clone(game:GetService(service))
end

--// Initialize
return {
	HttpService = cast("HttpService") :: HttpService,
	TweenService = cast("TweenService") :: TweenService,
	RunService = cast("RunService") :: RunService,
	UserInputService = cast("UserInputService") :: UserInputService,
	GuiService = cast("GuiService") :: GuiService,

	Workspace = cast("Workspace") :: Workspace,
	Players = cast("Players") :: Players,
	Lighting = cast("Lighting") :: Lighting,
}
