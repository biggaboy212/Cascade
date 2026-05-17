local types = require("@types")

return function(self, properties: types.PullDownButtonProperties): types.PullDownButton
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local dropdownMenu = require("@modules/dropdownMenu")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.MenuButton
	local structures = {
		Options = {},
	}

	--// UI
	properties = properties or {}
	properties.Expanded = properties.Expanded or false
	properties.Options = properties.Options or {}

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "PullDownButton",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Selectable = false,
			Text = "",
			Parent = parent,

			create("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 3),
				PaddingLeft = UDim.new(0, 7),
				PaddingRight = UDim.new(0, 3),
				PaddingTop = UDim.new(0, 3),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 7),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("Frame")({
				Name = "PullDownIndicator",
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Selectable = true,
				Size = UDim2.fromOffset(16, 16),

				__dynamicKeys = {
					BackgroundColor3 = theme.IndicatorBackground[1],
					BackgroundTransparency = theme.IndicatorBackground[2],
				},

				create("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 4),
				}),

				create("ImageLabel")({
					Name = "Indicators",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://86693411280110",
					Size = UDim2.fromScale(1, 1),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Text.Primary[1],
						ImageTransparency = self.Theme.Text.Primary[2],
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
				RichText = true,
				TextSize = 15,
				TextTransparency = 0.15,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Visible = false,

				__dynamicKeys = {
					TextColor3 = self.Theme.Text.Primary[1],
					TextTransparency = self.Theme.Text.Primary[2],
				},
			}),
		})
	) :: TextButton

	--// Initialize
	structures.PullDownIndicator = structures.Body:FindFirstChild("PullDownIndicator") :: Frame
	structures.CurrentTab = structures.Body:FindFirstChild("Label") :: TextLabel

	local object
	local menu = dropdownMenu.new(self, structures, {
		Name = "PullDownMenu",
		Anchor = properties.Anchor,
		AnchorMode = "BelowButton",
		Gap = 6,
		MaxHeight = 239,
		AutoScroll = false,
		OnSelected = function(target, index)
			target.Expanded = false
			target.Value = index
		end,
	})

	local bindings = {
		Anchor = function(value)
			menu:SetAnchor(value)
		end,

		Options = function(value: { [number]: string })
			menu:ClearOptions()

			for index, optionName in ipairs(value) do
				menu:AddOption(optionName, index)
			end
		end,

		Expanded = function(value: boolean)
			menu:SetExpanded(value)
		end,

		Label = function(value: string)
			if type(value) == "string" then
				structures.CurrentTab.Visible = true
				structures.CurrentTab.Text = value
			end
		end,

		Value = function(value: number)
			menu:SetValue(value)

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	menu:SetObject(object)

	object.Type = "PullDownButton"
	object.Theme = self.Theme
	object.Structures = structures
	object.Option = function(self, name: string?)
		local index = #structures.Options + 1
		local option = menu:AddOption(name, index)

		table.insert(object.Options, name)

		return option
	end
	object.Remove = function(self, index: number?)
		if index then
			menu:RemoveOption(index)
			object.Options[index] = nil
		end
	end

	binder.Apply(properties, object)
	menu:SetValue(object.Value)

	return object
end
