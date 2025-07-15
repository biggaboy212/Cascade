local types = require("@types")

return function(self, properties: types.ToggleProperties): types.Row
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local tweenService = services.TweenService

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.Toggle
	local structures = {}

	--// UI
	properties = properties or {}
	properties.Value = properties.Value == true

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Toggle",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(28, 16),
			Parent = parent,

			create("ImageButton")({
				Name = "Switch",
				AutoButtonColor = false,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://104426531889908",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.91,
				Size = UDim2.fromOffset(28, 16),

				__dynamicKeys = {
					ImageColor3 = theme.SwitchOff[1],
					ImageTransparency = theme.SwitchOff[2],
				},
				__contextKeys = {
					ImageColor3 = function()
						return properties.Value and theme.SwitchOn[1].Value or theme.SwitchOff[1].Value
					end,
					ImageTransparency = function()
						return properties.Value and theme.SwitchOn[2].Value or theme.SwitchOff[2].Value
					end,
				},

				create("ImageLabel")({
					Name = "Knob",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://99107881432922",
					Position = UDim2.new(0, 1, 0.5, 0),
					Size = UDim2.fromOffset(14, 14),

					__dynamicKeys = {
						ImageColor3 = theme.Knob[1],
						ImageTransparency = theme.Knob[2],
					},

					create("ImageLabel")({
						Name = "Effects",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://138042641797315",
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(16, 16),

						__dynamicKeys = {
							ImageColor3 = theme.KnobEffects[1],
							ImageTransparency = theme.KnobEffects[2],
						},
					}),
				}),

				create("UIGradient")({
					Name = "UIGradient",
					Rotation = 90,

					__dynamicKeys = {
						Color = theme.DepthEffect[1],
					},
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Switch = structures.Body:FindFirstChild("Switch") :: ImageButton
	structures.Knob = structures.Switch:FindFirstChild("Knob") :: ImageLabel

	local object
	local bindings = {
		Value = function(value: boolean, instant: boolean?)
			instant = (instant == nil and true) or false

			local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			local knobGoal = { Position = value and UDim2.new(0, 13, 0.5, 0) or UDim2.new(0, 1, 0.5, 0) }
			local switchGoal = { 
				ImageColor3 = value and theme.SwitchOn[1].Value or theme.SwitchOff[1].Value,
				ImageTransparency = value and theme.SwitchOn[2].Value or theme.SwitchOff[2].Value,
			}

			if instant then
				tweenService:Create(structures.Knob, tweenInfo, knobGoal):Play()
				tweenService:Create(structures.Switch, tweenInfo, switchGoal):Play()
			else
				structures.Knob.Position = knobGoal.Position
				structures.Switch.ImageColor3 = switchGoal.ImageColor3
				structures.Switch.ImageTransparency = switchGoal.ImageTransparency
			end

			if properties.ValueChanged and instant then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Toggle"
	object.Theme = self.Theme
	object.Structures = structures

	do -- Input handler
		structures.Switch.MouseButton1Click:Connect(function()
			object.Value = not object.Value
		end)
	end

	bindings.Value(not not properties.Value, false)
	binder.Apply(properties, object)

	return object
end
