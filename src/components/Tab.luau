local types = require("@types")

return function(self, properties: types.TabProperties): types.Tab
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.Type == "Window" and self.Structures.SidebarList or self.__instance or self
	local structures = {}

	--// UI
	properties = properties or {}

	properties.Label = properties.Label or "Label"
	properties.Indentation = properties.Indentation or 0
	properties.Selected = properties.Selected or false

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "SidebarItem",
			AutoButtonColor = false,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			LayoutOrder = self.Tabs and #self.Tabs or 1,
			Size = UDim2.new(1, 0, 0, 28),
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14,
			Parent = parent,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.SelectionFocused[1],
				BackgroundTransparency = self.Theme.Controls.SelectionFocused[2],
			},
			--[[ __contextKeys = {
				BackgroundColor3 = function()
					return properties.Selected and self.Theme.Controls.SelectionFocused[1] or value(1)
				end,
				BackgroundTransparency = function()
					return properties.Selected and self.Theme.Controls.SelectionFocused[2] or value(1)
				end,
			}, ]]

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
				Padding = UDim.new(0, 14),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("UIPadding")({
				Name = "UIPadding",
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 8),
			}),

			create("Frame")({
				Name = "Leading",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -34, 0, 0),

				create("TextLabel")({
					Name = "Title",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364"),
					LayoutOrder = 2,
					LineHeight = 0,
					RichText = true,
					Size = UDim2.new(1, -22, 0, 20),
					TextSize = 15,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,

					__dynamicKeys = {
						TextColor3 = self.Theme.Controls.SelectionFocusedAccent[1],
						TextTransparency = self.Theme.Controls.SelectionFocusedAccent[2],
					},
					--[[ __contextKeys = {
						TextColor3 = function()
							return properties.Selected and self.Theme.Controls.SelectionFocusedAccent[1]
								or self.Theme.Text.Primary[1]
						end,
						TextTransparency = function()
							return properties.Selected and self.Theme.Controls.SelectionFocusedAccent[2]
								or self.Theme.Text.Primary[2]
						end,
					}, ]]
				}),

				create("UIListLayout")({
					Name = "UIListLayout",
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),

				create("ImageLabel")({
					Name = "Symbol",
					Visible = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://127049167227557",
					LayoutOrder = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(20, 20),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Controls.Selection[1],
						ImageTransparency = self.Theme.Controls.Selection[2],
					},
					--[[ __contextKeys = {
						ImageColor3 = function()
							return properties.Selected and self.Theme.Controls.SelectionFocusedAccent[1]
								or self.Theme.Controls.Selection[1]
						end,
						ImageTransparency = function()
							return properties.Selected and self.Theme.Controls.SelectionFocusedAccent[2]
								or self.Theme.Controls.Selection[2]
						end,
					}, ]]
				}),
			}),

			create("Frame")({
				Name = "Trailing",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(20, 16),
			}),
		})
	) :: TextButton

	--// Initialize
	structures.Trailing = structures.Body:FindFirstChild("Trailing") :: Frame
	structures.Leading = structures.Body:FindFirstChild("Leading") :: Frame
	structures.Title = structures.Leading:FindFirstChild("Title") :: TextLabel
	structures.Symbol = structures.Leading:FindFirstChild("Symbol") :: ImageLabel
	structures.Padding = structures.Body:FindFirstChild("UIPadding") :: UIPadding
	structures.Page = create("ScrollingFrame")({
		Name = "ContentList",
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		ClipsDescendants = false,
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		ScrollBarImageTransparency = 0.6,
		ScrollBarThickness = 7,
		Size = UDim2.fromScale(1, 1),

		create("UIListLayout")({
			Name = "UIListLayout",
			Padding = UDim.new(0, 9),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		create("UIPadding")({
			Name = "Margins",
			PaddingBottom = UDim.new(0, 17),
			PaddingLeft = UDim.new(0, 17),
			PaddingRight = UDim.new(0, 17),
			PaddingTop = UDim.new(0, 17),
		}),
	}) :: ScrollingFrame

	local object = binder.Wrap(properties, {
		Label = function(name: string)
			structures.Title.Text = name
		end,
		Icon = function(icon: string?)
			structures.Symbol.Visible = icon and true or false

			if icon then
				structures.Symbol.Image = icon
			end
		end,
		Indentation = function(indentation: number)
			structures.Body.Size -= UDim2.fromOffset((11 * indentation), 0)
		end,
		Selected = function(selected: boolean)
			structures.Body.Transparency = selected and self.Theme.Controls.SelectionFocused[2].Value or 1

			structures.Title.TextColor3 = selected and self.Theme.Controls.SelectionFocusedAccent[1].Value
				or self.Theme.Text.Primary[1].Value
			structures.Title.TextTransparency = selected and self.Theme.Controls.SelectionFocusedAccent[2].Value
				or self.Theme.Text.Primary[2].Value

			structures.Symbol.ImageColor3 = selected and self.Theme.Controls.SelectionFocusedAccent[1].Value
				or self.Theme.Controls.Selection[1].Value
			structures.Symbol.ImageTransparency = selected and self.Theme.Controls.SelectionFocusedAccent[2].Value
				or self.Theme.Controls.Selection[2].Value

			structures.Page.Parent = selected and self.__container or nil
		end,
	}, structures.Body)

	object.Type = "Tab"
	object.Theme = self.Theme
	object.Structures = structures
	object.__container = structures.Page.__instance

	binder.Apply(properties, object)

	if self.Tabs and self.__container then
		table.insert(self.Tabs, object)

		if object.Selected then
			self.addToHistory(object.__container)
		end

		structures.Body.MouseButton1Click:Connect(function()
			if object.Selected then
				return
			end

			for _, tab: types.Tab in pairs(self.Tabs) do
				tab.Selected = false
			end

			object.Selected = true

			self.addToHistory(object.__container)
		end)
	end

	return object
end
