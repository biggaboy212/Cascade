local types = require("@types")

return function(self, properties: types.LabelProperties): types.Label
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local structures = {}

	--// UI
	properties = properties or {}
	properties.Text = properties.Text or "Label"

	structures.Body = create("TextLabel")({
		Name = "Label",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364"),
		RichText = true,
		TextSize = 15,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextWrapped = true,
		Parent = parent,

		__dynamicKeys = {
			TextColor3 = self.Theme.Text.Secondary[1],
			TextTransparency = self.Theme.Text.Secondary[2],
		},
	}) :: TextLabel

	--// Initialize
	local object = binder.Wrap(properties, {}, structures.Body)

	object.Type = "Label"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
