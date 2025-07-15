local types = require("@types")

return function(self, properties: types.RadioButtonGroupProperties): types.RadioButtonGroup
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.RadioButtonGroup
	local structures = {
		RadioButtons = {},
	}

	--// Functions
	local function radioButton(object, name, index)
		structures.RadioButtons[index] = create("Frame")({
			Name = "RadioButton",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = index,
			Parent = structures.Body.__instance,

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = UDim.new(0, 6),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("ImageButton")({
				Name = "Button",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://118333468121914",
				Size = UDim2.fromOffset(14, 14),

				__dynamicKeys = {
					ImageColor3 = theme.Background[1],
					ImageTransparency = theme.Background[2],
				},

				__contextKeys = {
					ImageColor3 = function()
						return properties.Value == index and self.Theme.Controls.Selection[1].Value
							or theme.Background[1].Value
					end,
					ImageTransparency = function()
						return properties.Value == index and self.Theme.Controls.Selection[2].Value
							or theme.Background[2].Value
					end,
				},

				create("ImageLabel")({
					Name = "Overlay",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://118333468121914",
					Size = UDim2.fromOffset(14, 14),

					__dynamicKeys = {
						ImageColor3 = theme.Overlay[1],
						ImageTransparency = theme.Overlay[2],
					},

					create("UIGradient")({
						Name = "UIGradient",
						Rotation = 90,
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
					}),
				}),

				create("ImageLabel")({
					Name = "Dot",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://118333468121914",
					Position = UDim2.fromScale(0.5, 0.5),
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.fromOffset(6, 6),
					SliceCenter = Rect.new(7, 7, 7, 7),

					__dynamicKeys = {
						ImageColor3 = theme.Dot[1],
						ImageTransparency = theme.Dot[2],
					},

					__contextKeys = {
						ImageTransparency = function()
							return properties.Value == index and theme.Dot[2].Value or 1
						end,
					},
				}),

				create("ImageLabel")({
					Name = "Stroke",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://132968326823931",
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),

					__dynamicKeys = {
						ImageColor3 = theme.Stroke[1],
						ImageTransparency = theme.Stroke[2],
					},

					__contextKeys = {
						ImageTransparency = function()
							return properties.Value == index and 1 or theme.Stroke[2].Value
						end,
					},
				}),

				create("ImageLabel")({
					Name = "InnerShadow",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://95115717327743",
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),

					__dynamicKeys = {
						ImageColor3 = theme.InnerShadow[1],
						ImageTransparency = theme.InnerShadow[2],
					},

					__contextKeys = {
						ImageTransparency = function()
							return properties.Value == index and 1 or theme.InnerShadow[2].Value
						end,
					},
				}),

				create("ImageLabel")({
					Name = "DropShadow",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://110994967430153",
					Position = UDim2.new(0.5, 0, 0.5, 1),
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.fromOffset(20, 20),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Controls.Selection[1],
						ImageTransparency = self.Theme.Controls.Selection[2],
					},

					__contextKeys = {
						ImageTransparency = function()
							return properties.Value == index and 0.76 or 1
						end,
					},
				}),
			}),

			create("TextLabel")({
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				FontFace = Font.new("rbxassetid://12187365364"),
				LayoutOrder = 1,
				RichText = true,
				Text = name,
				TextSize = 15,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Visible = not not name,

				__dynamicKeys = {
					TextColor3 = self.Theme.Text.Primary[1],
					TextTransparency = self.Theme.Text.Primary[2],
				},
			}),
		}) :: Frame

		local button = structures.RadioButtons[index]:FindFirstChild("Button") :: ImageButton
		if button and button:IsA("ImageButton") then
			button.MouseButton1Click:Connect(function()
				if object then
					object.Value = index
				end
			end)
		end
	end

	--// UI
	properties = properties or {}
	properties.Options = properties.Options or {}

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "RadioButtons",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Parent = parent,

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = UDim.new(0, 16),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Wraps = true,
			}),
		})
	) :: Frame

	--// Initialize
	local object
	local bindings = {
		Options = function(value: { [number]: string })
			for index, option in ipairs(value) do
				if structures.RadioButtons[index] then
					structures.RadioButtons[index]:Destroy()
				end

				radioButton(object, option, index)
			end
		end,
		Value = function(value: number)
			for index, radioButton in ipairs(structures.RadioButtons) do
				local currentIndex = index == value

				if radioButton then
					local button = radioButton:FindFirstChild("Button")

					button.ImageColor3 = currentIndex and self.Theme.Controls.Selection[1].Value
						or theme.Background[1].Value
					button.ImageTransparency = currentIndex and self.Theme.Controls.Selection[2].Value
						or theme.Background[2].Value

					button:FindFirstChild("Dot").ImageTransparency = currentIndex and theme.Dot[2].Value or 1

					button:FindFirstChild("Stroke").ImageTransparency = currentIndex and 1 or theme.Stroke[2].Value
					button:FindFirstChild("InnerShadow").ImageTransparency = currentIndex and 1
						or theme.InnerShadow[2].Value
					button:FindFirstChild("DropShadow").ImageTransparency = currentIndex and 0.76 or 1
				end
			end

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "RadioButtonGroup"
	object.Theme = self.Theme
	object.Structures = structures
	object.Option = function(self, name: string?)
		local index = #structures.RadioButtons + 1

		radioButton(object, name, index)

		table.insert(properties.Options or {}, name)

		return structures.RadioButtons[index]
	end

	binder.Apply(properties, object)

	return object
end
