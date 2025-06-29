return function(self)
	--// Imports
	local creator = require("@modules/creator")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local tweenService = services.TweenService

	--// Variables
	local structures = {}

	--// UI
	structures.Body = create("Frame")({
		Name = "TextField",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(150, 23),
		SizeConstraint = Enum.SizeConstraint.RelativeXX,

		create("UICorner")({
			Name = "UICorner",
			CornerRadius = UDim.new(0, 5),
		}),

		create("UIStroke")({
			Name = "UIStroke",
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,

			__dynamicKeys = {
				Color = self.Theme.Controls.ViewBorder[1],
				Transparency = self.Theme.Controls.ViewBorder[2],
			},
		}),

		create("TextBox")({
			Name = "Field",
			AutomaticSize = Enum.AutomaticSize.XY,
			Size = UDim2.fromOffset(138, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			CursorPosition = -1,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("rbxassetid://12187365364"),
			PlaceholderText = "",
			Text = "",
			TextSize = 15,

			__dynamicKeys = {
				PlaceholderColor3 = self.Theme.Text.Tertiary[1],
				TextTransparency = self.Theme.Text.Tertiary[2],
			},

			__contextKeys = {
				_general = function()
					local field = structures["Field"]

					if not field then
						return
					end

					if field.Text == "" then
						field.PlaceholderColor3 = self.Theme.Text.Tertiary[1].Value
						field.TextTransparency = self.Theme.Text.Tertiary[2].Value
					else
						field.TextColor3 = self.Theme.Text.Primary[1].Value
						field.TextTransparency = self.Theme.Text.Primary[2].Value
					end
				end,
				TextTransparency = function()
					if not structures["Field"] then
						return 1
					end

					return structures["Field"].Text == "" and self.Theme.Text.Tertiary[2].Value
						or self.Theme.Text.Primary[2].Value
				end,
			},

			create("UIPadding")({
				Name = "UIPadding",
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
			}),
		}),

		create("UIPadding")({
			Name = "UIPadding",
			PaddingLeft = UDim.new(0, 6),
			PaddingRight = UDim.new(0, 6),
		}),

		create("UIListLayout")({
			Name = "UIListLayout",
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 4)
		}),
	}) :: Frame

	--// Initialize
	structures.Stroke = structures.Body:FindFirstChild("UIStroke") :: UIStroke
	structures.Padding = structures.Body:FindFirstChild("UIPadding") :: UIPadding
	structures.Corner = structures.Body:FindFirstChild("UICorner") :: UICorner
	structures.Layout = structures.Body:FindFirstChild("UIListLayout") :: UIListLayout
	structures.Field = structures.Body:FindFirstChild("Field") :: TextBox
	structures.FieldPadding = structures.Field:FindFirstChild("UIPadding") :: UIPadding

	local currentTween: Tween
	local enter = TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local leave = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	structures.Field.Focused:Connect(function()
		if currentTween then
			currentTween:Cancel()
		end

		currentTween = tweenService:Create(structures.Stroke, enter, {
			Color = self.Theme.Controls.SelectionStroke[1].Value,
			Transparency = self.Theme.Controls.SelectionStroke[2].Value,
			Thickness = 3,
		})
		currentTween:Play()
	end)

	structures.Field.FocusLost:Connect(function()
		if currentTween then
			currentTween:Cancel()
		end

		currentTween = tweenService:Create(structures.Stroke, leave, {
			Color = self.Theme.Controls.ViewBorder[1].Value,
			Transparency = self.Theme.Controls.ViewBorder[2].Value,
			Thickness = 1,
		})
		currentTween:Play()
	end)

	structures.Field:GetPropertyChangedSignal("Text"):Connect(function()
		if structures.Field.Text == "" then
			structures.Field.PlaceholderColor3 = self.Theme.Text.Tertiary[1].Value
			structures.Field.TextTransparency = self.Theme.Text.Tertiary[2].Value
		else
			structures.Field.TextColor3 = self.Theme.Text.Primary[1].Value
			structures.Field.TextTransparency = self.Theme.Text.Primary[2].Value
		end
	end)

	return structures
end
