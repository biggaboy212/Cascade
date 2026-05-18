return function(self: any)
	--// Imports
	local creator = require("@modules/creator")

	--// Methods
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self

	--// Initialize
	local body = create("Frame")({
		Name = "ImageSurface",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(26, 26),
		Parent = parent,

		create("Frame")({
			Name = "Surface",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(24, 24),

			create("ImageLabel")({
				Name = "Image",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(20, 20),
			}),

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),

			create("UIGradient")({
				Name = "UIGradient",
				Rotation = 90,
                Enabled = true,

                __dynamicKeys = {
                    Color = self.Theme.Controls.ImageSurface.Gradient,
                },
			}),
		}),
	}) :: Frame

	local structures = {
		Body = body,
	}

    structures.Surface = body:FindFirstChild("Surface") :: Frame
    structures.Image = structures.Surface and structures.Surface:FindFirstChild("Image") :: ImageLabel
    structures.Gradient = structures.Surface and structures.Surface:FindFirstChild("UIGradient") :: UIGradient

	return structures
end
