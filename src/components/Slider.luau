local types = require("@types")

return function(self, properties: types.SliderProperties): types.Slider
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.Slider
	local dragStart = 0
	local structures = {}

	--// UI
	properties = properties or {}
	properties.Value = properties.Value or 0
	properties.Maximum = properties.Maximum or 1
	properties.Minimum = properties.Minimum or 0

	structures.Body = binder.Apply(
		properties,
		create("ImageLabel")({
			Name = "Slider",
			Active = true,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://92966982499851",
			Position = UDim2.fromScale(0, 0.5),
			Selectable = true,
			Size = UDim2.fromOffset(150, 4),
			Parent = parent,

			__dynamicKeys = {
				ImageColor3 = theme.Track[1],
				ImageTransparency = theme.Track[2],
			},

			create("ImageLabel")({
				Name = "TrackClip",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://113661976068590",
				ImageColor3 = Color3.fromRGB(252, 252, 252),
				ResampleMode = Enum.ResamplerMode.Pixelated,
				Size = UDim2.new(0, 2, 1, 0),
				ZIndex = 3,

				__dynamicKeys = {
					ImageColor3 = self.Theme.Controls.View[1],
					ImageTransparency = self.Theme.Controls.View[2],
				},
			}),

			create("Frame")({
				Name = "Fill",
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0, 1),

				__dynamicKeys = {
					BackgroundColor3 = self.Theme.Controls.Selection[1],
					BackgroundTransparency = self.Theme.Controls.Selection[2],
				},

				create("ImageLabel")({
					Name = "Effects",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://82410105327406",
					ImageColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 150, 1, 0),
					ZIndex = 0,

					__dynamicKeys = {
						ImageColor3 = theme.TrackEffects[1],
						ImageTransparency = theme.TrackEffects[2],
					},
				}),

				create("Frame")({
					Name = "Thumb",
					Active = true,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0),
					Selectable = true,
					Size = UDim2.fromOffset(20, 20),
					ZIndex = 2,

					create("ImageLabel")({
						Name = "Background",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://125496304036680",
						Selectable = true,
						Size = UDim2.fromOffset(20, 20),

						__dynamicKeys = {
							ImageColor3 = theme.Thumb[1],
							ImageTransparency = theme.Thumb[2],
						},

						create("UIStroke")({
							Name = "UIStroke",
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,

							__dynamicKeys = {
								Color = theme.ThumbStroke[1],
								Transparency = theme.ThumbStroke[2],
							},
						}),

						create("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(1, 0),
						}),
					}),

					create("ImageLabel")({
						Name = "ThumbEffects",
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://85926626300527",
						Position = UDim2.fromScale(0.5, 0),
						Size = UDim2.fromOffset(22, 22),
						ZIndex = 0,

						__dynamicKeys = {
							ImageColor3 = theme.ThumbEffects[1],
							ImageTransparency = theme.ThumbEffects[2],
						},

						create("UICorner")({
							Name = "UICorner",
							CornerRadius = UDim.new(1, 0),
						}),
					}),
				}),
			}),
		})
	) :: ImageLabel

	--// Initialize
	structures.Fill = structures.Body:FindFirstChild("Fill") :: Frame
	structures.Thumb = structures.Fill:FindFirstChild("Thumb") :: Frame
	structures.Dragger = create("UIDragDetector")({
		Name = "UIDragDetector",
		ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset,
		SelectionModeDragSpeed = UDim2.new(),
		SelectionModeRotateSpeed = 0,
		ActivatedCursorIcon = "rbxassetid://0",
		CursorIcon = "rbxassetid://0",
		Parent = structures.Thumb,
	}) :: UIDragDetector

	local object
	local bindings = {
		Value = function(value: number)
			local sliderWidth = structures.Body.AbsoluteSize.X
			local thumbWidth = structures.Thumb.AbsoluteSize.X
			local thumbHalfWidth = thumbWidth / 2

			local min = properties.Minimum
			local max = properties.Maximum
			local alpha = (value - min) / (max - min)

			local availableWidth = sliderWidth - thumbWidth
			local fillWidth = thumbHalfWidth + (availableWidth * alpha)

			structures.Fill.Size = UDim2.new(0, fillWidth, 1, 0)

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Slider"
	object.Theme = self.Theme
	object.Structures = structures

	structures.Dragger.DragStart:Connect(function()
		dragStart = structures.Fill.AbsoluteSize.X
	end)

	structures.Dragger.DragContinue:Connect(function()
		local sliderWidth = structures.Body.AbsoluteSize.X
		local thumbWidth = structures.Thumb.AbsoluteSize.X
		local thumbHalfWidth = thumbWidth / 2

		local minX = thumbHalfWidth
		local maxX = sliderWidth - thumbHalfWidth

		local deltaPixels = structures.Dragger.DragUDim2.X.Offset
		local newCenterX = dragStart + deltaPixels
		local clampedCenterX = math.clamp(newCenterX, minX, maxX)

		local alpha = (clampedCenterX - minX) / (maxX - minX)
		
		object.Value = object.Minimum + (object.Maximum - object.Minimum) * alpha
	end)

	binder.Apply(properties, object)

	return object
end
