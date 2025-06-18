--// Imports
local creator = require("@modules/creator")

--// References
local value = creator.Value

--// Functions
local function Color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex(color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100)),
	}
end

--// Initialize
return {
	Accents = {
		Red = Color4("FF3B30", 100),
	},

	Controls = {
		Sidebar = Color4("EAEAEA", 84)
	},
}
