local types = require("@types")

return function(self, properties: types.StackProperties): types.Stack
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
	properties.Padding = properties.Padding or UDim.new(0, 10)
    properties.VerticalAlignment = properties.VerticalAlignment or Enum.VerticalAlignment.Center
    properties.HorizontalAlignment = properties.HorizontalAlignment or Enum.HorizontalAlignment.Right

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "HStack",
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.XY,
			Parent = parent,

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Wraps = true,
			}),
		})
	) :: Frame

	--// Initialize
	structures.Layout = structures.Body:FindFirstChild("UIListLayout") :: UIListLayout

	local object = binder.Wrap(properties, {
		Padding = function(value: UDim)
			structures.Layout.Padding = value
		end,
		HorizontalAlignment = function(value: Enum.HorizontalAlignment)
			structures.Layout.HorizontalAlignment = value
		end,
		VerticalAlignment = function(value: Enum.VerticalAlignment)
			structures.Layout.VerticalAlignment = value
		end,
	}, structures.Body)

	object.Type = "HStack"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
