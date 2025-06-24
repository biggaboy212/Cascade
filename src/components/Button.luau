local types = require("@types")

return function(self, properties: types.ButtonProperties): types.Button
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local tweenService = services.TweenService

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.Button
	local structures = {}

	--// UI
	properties = properties or {}
	properties.State = properties.State or "Primary"
	properties.Label = properties.Label or "Label"

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "Button",
			AutoButtonColor = false,
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Text = "",
			Parent = parent,

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),

			create("Folder")({
				Name = "ShadowLayers",

				create("Frame")({
					Name = "Layer1",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 0,

					create("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 5),
					}),

					create("UIStroke")({
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 0.95,

						__dynamicKeys = {
							Color = theme.Shadow,
						},
					}),
				}),

				create("Frame")({
					Name = "Layer2",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromScale(1, 1),
					ZIndex = -1,

					create("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 5),
					}),

					create("UIStroke")({
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Thickness = 2,
						Transparency = 0.98,

						__dynamicKeys = {
							Color = theme.Shadow,
						},
					}),
				}),
			}),
		})
	) :: TextButton

	--// Initialize
	structures.Shadows = structures.Body:FindFirstChild("ShadowLayers")
	structures.Shadow1 = structures.Shadows:FindFirstChild("Layer1"):FindFirstChild("UIStroke")
	structures.Shadow2 = structures.Shadows:FindFirstChild("Layer2"):FindFirstChild("UIStroke")

	local labelContext = {
		TextColor3 = function()
			local state = properties.State

			return state == "Primary" and self.Theme.Text.SelectionPrimary[1].Value
				or state == "Secondary" and self.Theme.Text.Primary[1].Value
				or state == "Destructive" and self.Theme.Accents.Red[1].Value
		end,
		TextTransparency = function()
			local state = properties.State

			return state == "Primary" and self.Theme.Text.SelectionPrimary[2].Value
				or state == "Secondary" and self.Theme.Text.Primary[2].Value
				or state == "Destructive" and self.Theme.Accents.Red[2].Value
		end,
	}
	local fillContext = {
		Color = function()
			local state = properties.State

			return state == "Primary" and theme.FillPrimary.Value
				or (state == "Secondary" or state == "Destructive") and theme.FillSecondary.Value
		end,
	}

	structures.Label = create("TextLabel")({
		Size = UDim2.fromScale(1, 1),
		Name = "Label",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		FontFace = Font.new("rbxassetid://12187365364"),
		RichText = true,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Parent = structures.Body.__instance,

		__dynamicKeys = {
			TextColor3 = self.Theme.Text.SelectionPrimary[1],
			TextTransparency = self.Theme.Text.SelectionPrimary[2],
		},
		__contextKeys = labelContext,

		create("UIPadding")({
			Name = "UIPadding",
			PaddingBottom = UDim.new(0, 3),
			PaddingLeft = UDim.new(0, 7),
			PaddingRight = UDim.new(0, 7),
			PaddingTop = UDim.new(0, 3),
		}),
	}) :: TextLabel
	structures.Fill = create("UIGradient")({
		Name = "UIGradient",
		Rotation = 90,
		Parent = structures.Body.__instance,

		__dynamicKeys = {
			Color = theme.FillPrimary,
		},
		__contextKeys = fillContext,
	}) :: UIGradient

	local object
	local bindings = {
		State = function()
			task.defer(function()
				structures.Label.TextColor3 = labelContext.TextColor3()
				structures.Label.TextTransparency = labelContext.TextTransparency()
				structures.Fill.Color = fillContext.Color()
			end)
		end,
		Label = function(value: string)
			structures.Label.Text = value
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Button"
	object.Theme = self.Theme
	object.Structures = structures

	structures.Body.MouseButton1Click:Connect(function()
		if properties.Pushed then
			task.spawn(properties.Pushed, object)
		end
	end)

	structures.Body.MouseButton1Down:Connect(function()
		local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

		tweenService
			:Create(structures.Shadow1, tweenInfo, {
				Transparency = 0.8,
			})
			:Play()

		tweenService
			:Create(structures.Shadow2, tweenInfo, {
				Transparency = 0.9,
			})
			:Play()
	end)

	structures.Body.MouseButton1Up:Connect(function()
		local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		tweenService
			:Create(structures.Shadow1, tweenInfo, {
				Transparency = 0.95,
			})
			:Play()

		tweenService
			:Create(structures.Shadow2, tweenInfo, {
				Transparency = 0.98,
			})
			:Play()
	end)

	structures.Body.MouseLeave:Connect(function()
		local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

		tweenService
			:Create(structures.Shadow1, tweenInfo, {
				Transparency = 0.95,
			})
			:Play()

		tweenService
			:Create(structures.Shadow2, tweenInfo, {
				Transparency = 0.98,
			})
			:Play()
	end)

	binder.Apply(properties, object)

	return object
end
