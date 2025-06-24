local types = require("@types")

return function(self, properties: types.ImageLabel): types.ImageLabel
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
	properties.Size = properties.Size or UDim2.fromOffset(20, 20)

	structures.Body = binder.Apply(
		properties,
		create("ImageLabel")({
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
		})
	) :: ImageLabel

	--// Initialize
	local object = binder.Wrap(properties, {}, structures.Body)

	object.Type = "Image"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
