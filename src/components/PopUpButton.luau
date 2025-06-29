local types = require("@types")

return function(self, properties: types.PopUpButtonProperties): types.PopUpButton
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local tweenService = services.TweenService
	local workspace = services.Workspace

	local camera = workspace.CurrentCamera

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.PopUpButton
	local structures = {}

	--// Constants
	local HORIZONTAL_OFFSET = -1
	local VERTICAL_PADDING = 6
	local SCREEN_EDGE_BUFFER = 40

	--// Functions
	local function anchor()
		local body = structures.Body
		local menu = structures.Menu

		if not menu or not body then
			return
		end

		local viewportY = camera.ViewportSize.Y
		local bodyY = body.AbsolutePosition.Y
		local menuY = menu.AbsoluteSize.Y

		local offsetY = 0
		local margins = viewportY - bodyY

		if margins < menuY - VERTICAL_PADDING then
			offsetY = (menuY - VERTICAL_PADDING - margins) + SCREEN_EDGE_BUFFER
		end

		menu.Position =
			UDim2.fromOffset(body.AbsolutePosition.X + HORIZONTAL_OFFSET, bodyY - VERTICAL_PADDING - offsetY)
	end

	--// UI
	properties = properties or {}
	properties.Expanded = properties.Expanded or false
	properties.Value = properties.Value == true

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "PopUpButton",
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
				Name = "PopUpIndicator",
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
					Image = "rbxassetid://89151647333378",
					ImageColor3 = Color3.fromRGB(0, 0, 0),
					ImageTransparency = 0.15,
					Size = UDim2.fromScale(1, 1),
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
				Text = "Item One",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 15,
				TextTransparency = 0.15,
				TextTruncate = Enum.TextTruncate.AtEnd,
			}),
		})
	) :: TextButton

	--// Initialize
	structures.MenuContainer = create("ScreenGui")({
		Name = "Container",
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.None,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		create("Frame")({
			Name = "PopUpMenu",
			AutomaticSize = Enum.AutomaticSize.XY,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,

			__dynamicKeys = {
				BackgroundColor3 = theme.MenuBackground[1],
				BackgroundTransparency = theme.MenuBackground[2],
			},

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 6),
			}),

			create("UIStroke")({
				Name = "UIStroke",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.9,
			}),

			create("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
				PaddingTop = UDim.new(0, 5),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("UIScale")({
				Name = "UIScale",
			}),
		}),
	})

	structures.Menu = structures.MenuContainer:FindFirstChild("PopUpMenu")
	structures.MenuScale = structures.Menu:FindFirstChild("UIScale")

	local object
	local bindings = {
		Expanded = function(value: boolean)
			local expand = value == true

			if expand then
				structures.MenuContainer.Parent = structures.Body.__instance
			end

			anchor()

			local goal = { Scale = expand and 1 or 0 }
			local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential)
			local tween = tweenService:Create(structures.MenuScale, tweenInfo, goal)

			tween:Play()
			tween.Completed:Once(function()
				if not expand then
					structures.MenuContainer.Parent = nil
				end
			end)
		end,

		Value = function(value: boolean)
			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "PopUpButton"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	structures.Body:GetPropertyChangedSignal("AbsolutePosition"):Connect(anchor)
	structures.Body:GetPropertyChangedSignal("AbsoluteSize"):Connect(anchor)
	structures.Menu:GetPropertyChangedSignal("AbsoluteSize"):Connect(anchor)

	structures.Body.MouseButton1Click:Connect(function()
		object.Expanded = not object.Expanded
	end)

	return object
end
