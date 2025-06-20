local types = require("@types")

return function(self, properties: types.SectionProperties): types.Section
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	properties = properties or {}

	properties.Name = properties.Name or "Section Title"
	properties.Disclosure = properties.Disclosure or true
	properties.Expanded = properties.Expanded or true

	structures.SidebarGroup = binder.Apply(
		properties,
		create("Frame")({
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.new(1, 0, 0, 23),
			Parent = (self.Type == "Window" and self.Structures.SidebarList) or (self.__instance or self),

			create("UIListLayout")({
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("Frame")({
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 0),

				create("TextButton")({
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					LayoutOrder = 1,
					Size = UDim2.fromOffset(13, 14),
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14,

					create("ImageLabel")({
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://115960806571685",
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(11, 7),
						__dynamicKeys = {
							ImageColor3 = self.Theme.Text.Tertiary.Color,
							ImageTransparency = self.Theme.Text.Tertiary.Transparency,
						},
					}),
				}),

				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),

				create("UIPadding")({
					PaddingBottom = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 3),
				}),

				create("TextLabel")({
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					LineHeight = 0,
					RichText = true,
					Size = UDim2.fromOffset(0, 14),
					Text = "Section Title",
					TextSize = 12,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					__dynamicKeys = {
						TextColor3 = self.Theme.Text.Tertiary.Color,
						TextTransparency = self.Theme.Text.Tertiary.Transparency,
					},
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.SectionHeader = structures.SidebarGroup:FindFirstChild("SectionHeader") :: Frame
	structures.Title = structures.SectionHeader:FindFirstChild("Section") :: TextLabel
	structures.Disclosure = structures.SectionHeader:FindFirstChild("Disclosure") :: TextButton
	structures.DisclosureImage = structures.Disclosure:FindFirstChild("DisclosureImage") :: ImageLabel

	local object = binder.Wrap(properties, {
		Name = function(name: string)
			structures.Title.Text = name
		end,
		Disclosure = function(state: boolean)
			structures.Disclosure.Visible = state
		end,
		Expanded = function(state: boolean)
			structures.SidebarGroup.AutomaticSize = state and Enum.AutomaticSize.Y or Enum.AutomaticSize.None
			structures.DisclosureImage.Rotation = state and 0 or -90
		end,
	}, structures.SidebarGroup)

	structures.Disclosure.MouseButton1Click:Connect(function()
		object.Expanded = not object.Expanded
	end)

	object.Type = "Section"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
