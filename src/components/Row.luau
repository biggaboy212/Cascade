local types = require("@types")

return function(self, properties: types.RowProperties): types.Row
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local titleStack = require("@structures/TitleStack")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	properties = properties or {}
	properties.Title = properties.Title or "Title"
	properties.Subtitle = properties.Subtitle or "Subtitle"

	local parent = self.__container or self.__instance or self

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Row",
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 0),
			Parent = parent,

			create("Frame")({
				Name = "LeftAccessory",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(0.5, -28, 0, 0),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 10),
					PaddingRight = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 10),
				}),
			}),

			create("Frame")({
				Name = "RightAccessory",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Size = UDim2.new(0.5, -28, 0, 0),

				create("UIListLayout")({
					Name = "UIListLayout",
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 10),
					PaddingLeft = UDim.new(0, 11),
					PaddingTop = UDim.new(0, 10),
				}),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				Padding = UDim.new(0, 56),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("Folder")({
				Name = "LayoutIgnore",

				create("Frame")({
					Name = "Divider",
					AnchorPoint = Vector2.new(0, 1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.95,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 1),
					Visible = false,
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.LeftAccessories = structures.Body:FindFirstChild("LeftAccessory")
	structures.RightAccessories = structures.Body:FindFirstChild("RightAccessories")

	structures.TitleStack = titleStack(self)
	structures.TitleStack.Body.Parent = structures.LeftAccessories

	local object = binder.Wrap(properties, {
		Title = function(value: string)
			structures.TitleStack.Title.Text = value
		end,
		Subtitle = function(value: string)
			structures.TitleStack.Subtitle.Text = value
		end,
		SearchIndex = function(value: string)
			structures.Body:SetAttribute("SearchIndex", value)
		end
	}, structures.Body)

	object.Type = "Row"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
