local types = require("@types")

return function(self, properties: types.SymbolProperties): types.Symbol
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
	properties.Style = properties.Style or "Primary"
	properties.Size = properties.Size or UDim2.fromOffset(20, 20)

	structures.Body = create("ImageLabel")({
		Name = "Image",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Parent = parent,

		__dynamicKeys = {
			ImageColor3 = self.Theme.Text.Primary[1],
			ImageTransparency = self.Theme.Text.Primary[2],
		},

		__contextKeys = {
			ImageColor3 = function()
				return properties.Style == "Primary" and self.Theme.Text.Primary[1].Value or self.Theme.Text.Secondary[1].Value
			end,
			ImageTransparency = function()
				return properties.Style == "Primary" and self.Theme.Text.Primary[2].Value or self.Theme.Text.Secondary[2].Value
			end,
		},
	}) :: ImageLabel

	--// Initialize
	local object = binder.Wrap(properties, {
		Style = function(value: "Primary" | "Secondary")
			if value == "Primary" then
				structures.Body.ImageColor3 = self.Theme.Text.Primary[1].Value.Value
				structures.Body.ImageTransparency = self.Theme.Text.Primary[2].Value
			else
				structures.Body.ImageColor3 = self.Theme.Text.Secondary[1].Value
				structures.Body.ImageTransparency = self.Theme.Text.Secondary[2].Value
			end
		end,
	}, structures.Body)

	object.Type = "Symbol"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
