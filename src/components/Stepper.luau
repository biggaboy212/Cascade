local types = require("@types")

return function(self, properties: types.StepperProperties): types.Stepper
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local textField = require("@structures/TextField")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.Stepper
	local structures = {}

	--// Functions
	local function getPrecision(step)
		local stepStr = tostring(step)
		local dot = string.find(stepStr, "%.")
		local precision = 0

		if dot then
			precision = #stepStr - dot
		end

		return precision
	end

	local function stepFormat(value, step)
        local stepPrecision = getPrecision(step)
        local valuePrecision = getPrecision(value)

        local displayPrecision = math.max(stepPrecision, valuePrecision)

        local formatStr = "%." .. displayPrecision .. "f"
        return string.format(formatStr, value)
    end

	local function round(value, decimals)
		local mult = 10 ^ (decimals or 0)
		return math.floor(value * mult + 0.5) / mult
	end

	--// UI
	properties = properties or {}
	properties.Value = properties.Value or 0
	properties.Step = properties.Step or 0.1
	properties.Maximum = properties.Maximum or 1
	properties.Minimum = properties.Minimum or 0
	properties.Fielded = properties.Fielded or false

	structures.Body = binder.Apply(
		properties,
		create("ImageLabel")({
			Name = "Stepper",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://85888499115674",
			LayoutOrder = 1,
			Size = UDim2.fromOffset(13, 20),
			Parent = parent,

			__dynamicKeys = {
				ImageColor3 = theme.Background[1],
				ImageTransparency = theme.Background[2],
			},

			create("ImageLabel")({
				Name = "Shadow",
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://105571270097608",
				LayoutOrder = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(19, 27),

				__dynamicKeys = {
					ImageColor3 = theme.Dropshadow[1],
					ImageTransparency = theme.Dropshadow[2],
				},
			}),

			create("ImageButton")({
				Name = "Up",
				AutoButtonColor = false,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://133515997946294",
				Size = UDim2.new(1, 0, 0, 9),
				Position = UDim2.fromOffset(0, 1),

				__dynamicKeys = {
					ImageColor3 = self.Theme.Text.Primary[1],
					ImageTransparency = self.Theme.Text.Primary[2],
				},

				__contextKeys = {
					ImageColor3 = function()
						if properties.Value >= properties.Maximum then
							return self.Theme.Text.Tertiary[1].Value
						else
							return self.Theme.Text.Primary[1].Value
						end
					end,
					ImageTransparency = function()
						if properties.Value >= properties.Maximum then
							return self.Theme.Text.Tertiary[2].Value
						else
							return self.Theme.Text.Primary[2].Value
						end
					end,
				},
			}),

			create("ImageButton")({
				Name = "Down",
				AnchorPoint = Vector2.new(0, 1),
				AutoButtonColor = false,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://83836660987173",
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 9),

				__dynamicKeys = {
					ImageColor3 = self.Theme.Text.Primary[1],
					ImageTransparency = self.Theme.Text.Primary[2],
				},

				__contextKeys = {
					ImageColor3 = function()
						if properties.Value <= properties.Minimum then
							return self.Theme.Text.Tertiary[1].Value
						else
							return self.Theme.Text.Primary[1].Value
						end
					end,
					ImageTransparency = function()
						if properties.Value <= properties.Minimum then
							return self.Theme.Text.Tertiary[2].Value
						else
							return self.Theme.Text.Primary[2].Value
						end
					end,
				},
			}),

			create("Frame")({
				Name = "Top",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(0, 6),
				Size = UDim2.new(1, 0, 0, 4),
				ZIndex = 0,

				create("UIGradient")({
					Name = "UIGradient",
					Rotation = 90,
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.949),
						NumberSequenceKeypoint.new(1, 0.949),
					}),

					__dynamicKeys = {
						Color = theme.SegmentShadow,
					},
				}),
			}),

			create("Frame")({
				Name = "Separator",
				AnchorPoint = Vector2.new(0, 0.5),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0, 0.5),
				Size = UDim2.new(1, 0, 0, 1),
				ZIndex = 0,

				__dynamicKeys = {
					BackgroundColor3 = theme.Separator[1],
					BackgroundTransparency = theme.Separator[2],
				},
			}),

			create("Frame")({
				Name = "Bottom",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(0, 10),
				Size = UDim2.new(1, 0, 0, 4),
				ZIndex = 0,

				create("UIGradient")({
					Name = "UIGradient",
					Rotation = -90,
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.949),
						NumberSequenceKeypoint.new(1, 0.949),
					}),

					__dynamicKeys = {
						Color = theme.SegmentShadow,
					},
				}),
			}),

			create("Frame")({
				Name = "Filler",
				AnchorPoint = Vector2.new(0, 0.5),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Position = UDim2.fromScale(0, 0.5),
				Size = UDim2.new(1, 0, 0, 2),
				ZIndex = 0,

				__dynamicKeys = {
					BackgroundColor3 = theme.Filler[1],
					BackgroundTransparency = theme.Filler[2],
				},
			}),
		})
	) :: ImageLabel

	--// Initialize
	structures.IPlus = structures.Body:FindFirstChild("Up") :: ImageButton
	structures.IMinus = structures.Body:FindFirstChild("Down") :: ImageButton

	structures.Field = textField(self)
	structures.Field.Padding.PaddingBottom = UDim.new(0, 2)
	structures.Field.Padding.PaddingTop = UDim.new(0, 2)
	structures.Field.Padding.PaddingRight = UDim.new(0, 2)
	structures.Field.Body.Size = UDim2.fromOffset(0, 23)
	structures.Field.Field.Size = UDim2.fromOffset(0, 0)

	local object
	local bindings = {
		Fielded = function(value: boolean)
			if value then
				structures.Field.Body.Parent = parent
				structures.Body.Parent = structures.Field.Body.__instance
			else
				structures.Field.Body.Parent = nil
				structures.Body.Parent = parent
			end
		end,
		Value = function(value: number)

			if value <= properties.Minimum then
				structures.IMinus.ImageColor3 = self.Theme.Text.Tertiary[1].Value
				structures.IMinus.ImageTransparency = self.Theme.Text.Tertiary[2].Value
				structures.IMinus.Interactable = false
			else
				structures.IMinus.ImageColor3 = self.Theme.Text.Primary[1].Value
				structures.IMinus.ImageTransparency = self.Theme.Text.Primary[2].Value
				structures.IMinus.Interactable = true
			end

			if value >= properties.Maximum then
				structures.IPlus.ImageColor3 = self.Theme.Text.Tertiary[1].Value
				structures.IPlus.ImageTransparency = self.Theme.Text.Tertiary[2].Value
				structures.IPlus.Interactable = false
			else
				structures.IPlus.ImageColor3 = self.Theme.Text.Primary[1].Value
				structures.IPlus.ImageTransparency = self.Theme.Text.Primary[2].Value
				structures.IPlus.Interactable = true
			end

			if structures.Field then
				structures.Field.Field.Text = stepFormat(value, properties.Step)
			end

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Stepper"
	object.Theme = self.Theme
	object.Structures = structures
	object.Increment = function()
		assert(properties.Minimum)
		assert(properties.Maximum)

		local precision = math.max(getPrecision(object.Value), getPrecision(properties.Step))
        local rawValue = object.Value + properties.Step
		local newValue = round(rawValue, precision)

		object.Value = math.clamp(newValue, properties.Minimum, properties.Maximum)
	end

	object.Decrement = function()
		assert(properties.Minimum)
		assert(properties.Maximum)

		local precision = math.max(getPrecision(object.Value), getPrecision(properties.Step))
		local rawValue = object.Value - properties.Step
		local newValue = round(rawValue, precision)
		
		object.Value = math.clamp(newValue, properties.Minimum, properties.Maximum)
	end

	structures.IPlus.MouseButton1Click:Connect(object.Increment)

	structures.IMinus.MouseButton1Click:Connect(object.Decrement)

	structures.Field.Field.FocusLost:Connect(function(fromEnter)
		if fromEnter then
			assert(properties.Minimum)
			assert(properties.Maximum)

			local text = structures.Field.Field.Text
			local number = tonumber(text)

			if number and properties.Fielded then
				properties.Value = math.clamp(number, properties.Minimum, properties.Maximum)

				if properties.Value then
					bindings.Value(properties.Value)
				end
			end
		else
			structures.Field.Field.Text = tostring(properties.Value)
		end
	end)

	binder.Apply(properties, object)

	return object
end
