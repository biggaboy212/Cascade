local types = require("@types")

return function(self, properties: types.RowProperties): types.Row
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local titleStack = require("@structures/TitleStack")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local structures = {}

	--// UI
	properties = properties or {}
	properties.Title = properties.Title or "Title"
	properties.SearchIndex = properties.SearchIndex or properties.Title

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
				Size = UDim2.new(1, 0, 1, 0),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 10),
					PaddingRight = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 10),
				}),
			}),

			create("Frame")({
				Name = "RightAccessory",
				AnchorPoint = Vector2.new(1, 0.5),
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.fromScale(1, 0.5),

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

			create("Folder")({
				Name = "LayoutIgnore",

				create("Frame")({
					Name = "Divider",
					AnchorPoint = Vector2.new(0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 1),
					Visible = false,

					__dynamicKeys = {
						BackgroundColor3 = self.Theme.Controls.ViewBorder[1],
						BackgroundTransparency = self.Theme.Controls.ViewBorder[2],
					},
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.LeftAccessories = structures.Body:FindFirstChild("LeftAccessory") :: Frame
	structures.RightAccessories = structures.Body:FindFirstChild("RightAccessory") :: Frame

	structures.TitleStack = titleStack(self)
	structures.TitleStack.Body.Parent = structures.LeftAccessories
	structures.TitleStack.Subtitle.Visible = false
	structures.LeftAccessories.Size = UDim2.new(1, -structures.RightAccessories.AbsoluteSize.X, 1, 0)

	structures.RightAccessories:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		structures.LeftAccessories.Size = UDim2.new(1, -structures.RightAccessories.AbsoluteSize.X, 1, 0)
	end)

	local object = binder.Wrap(properties, {
		Title = function(value: string)
			structures.TitleStack.Title.Text = value
		end,
		Subtitle = function(value: string)
			structures.TitleStack.Subtitle.Visible = true
			structures.TitleStack.Subtitle.Text = value
		end,
		SearchIndex = function(value: string)
			structures.Body:SetAttribute("SearchIndex", value)
		end,
	}, structures.Body)

	object.Type = "Row"
	object.Theme = self.Theme
	object.Structures = structures
	object.__container = structures.RightAccessories

	binder.Apply(properties, object)

	return object
end
