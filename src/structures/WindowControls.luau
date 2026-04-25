return function(self, properties)
	--// Imports
	local creator = require("@modules/creator")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}
    local contextKeys = {
        Exit = {
			ImageColor3 = function()
				return properties.CanExit and self.Theme.Controls.Exit[1].Value
					or self.Theme.Controls.WindowControlDisabled[1].Value
			end,
			ImageTransparency = function()
				return properties.CanExit and self.Theme.Controls.Exit[2].Value
					or self.Theme.Controls.WindowControlDisabled[2].Value
			end,
		},
        
        Minimize = {
			ImageColor3 = function()
				return properties.CanMinimize and self.Theme.Controls.Minimize[1].Value
					or self.Theme.Controls.WindowControlDisabled[1].Value
			end,
			ImageTransparency = function()
				return properties.CanMinimize and self.Theme.Controls.Minimize[2].Value
					or self.Theme.Controls.WindowControlDisabled[2].Value
			end,
		},

        Zoom = {
			ImageColor3 = function()
				return properties.CanZoom and self.Theme.Controls.Zoom[1].Value
					or self.Theme.Controls.WindowControlDisabled[1].Value
			end,
			ImageTransparency = function()
				return properties.CanZoom and self.Theme.Controls.Zoom[2].Value
					or self.Theme.Controls.WindowControlDisabled[2].Value
			end,
		}
    }

	structures.Body = create("Frame")({
		Name = "WindowControls",
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(92, 38),

		create("UIListLayout")({
			Name = "UIListLayout",
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),

		create("UIPadding")({
			Name = "UIPadding",
			PaddingLeft = UDim.new(0, 20),
			PaddingRight = UDim.new(0, 20),
		}),
	})

	structures.Exit = create("ImageButton")({
		Name = "Exit",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Image = "rbxassetid://132228700346004",
		Size = UDim2.fromOffset(12, 12),
        Parent = structures.Body.__instance,

		__dynamicKeys = {
			ImageColor3 = self.Theme.Controls.Exit[1],
			ImageTransparency = self.Theme.Controls.Exit[2],
		},
		__contextKeys = contextKeys.Exit,

		create("ImageLabel")({
			Name = "Stroke",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://94763505860483",
			Size = UDim2.fromScale(1, 1),

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlStroke[1],
				ImageTransparency = self.Theme.Controls.WindowControlStroke[2],
			},
		}),

		create("ImageLabel")({
			Name = "Icon",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://94781753558308",
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			Visible = false,

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlIcon[1],
				ImageTransparency = self.Theme.Controls.WindowControlIcon[2],
			},
		}),
	})

	structures.Minimize = create("ImageButton")({
		Name = "Minimize",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Image = "rbxassetid://132228700346004",
		LayoutOrder = 1,
		Size = UDim2.fromOffset(12, 12),
        Parent = structures.Body.__instance,

		__dynamicKeys = {
			ImageColor3 = self.Theme.Controls.Minimize[1],
			ImageTransparency = self.Theme.Controls.Minimize[2],
		},
		__contextKeys = contextKeys.Minimize,

		create("ImageLabel")({
			Name = "Stroke",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://94763505860483",
			Size = UDim2.fromScale(1, 1),

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlStroke[1],
				ImageTransparency = self.Theme.Controls.WindowControlStroke[2],
			},
		}),

		create("ImageLabel")({
			Name = "Icon",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://118368309445367",
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			Visible = false,

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlIcon[1],
				ImageTransparency = self.Theme.Controls.WindowControlIcon[2],
			},
		}),
	})

	structures.Zoom = create("ImageButton")({
		Name = "Zoom",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Image = "rbxassetid://132228700346004",
		LayoutOrder = 2,
		Size = UDim2.fromOffset(12, 12),
        Parent = structures.Body.__instance,

		__dynamicKeys = {
			ImageColor3 = self.Theme.Controls.Zoom[1],
			ImageTransparency = self.Theme.Controls.Zoom[2],
		},
		__contextKeys = contextKeys.Zoom,

		create("ImageLabel")({
			Name = "Stroke",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://94763505860483",
			Size = UDim2.fromScale(1, 1),

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlStroke[1],
				ImageTransparency = self.Theme.Controls.WindowControlStroke[2],
			},
		}),

		create("ImageLabel")({
			Name = "Icon",
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Image = "rbxassetid://114376524082699",
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			Visible = false,

			__dynamicKeys = {
				ImageColor3 = self.Theme.Controls.WindowControlIcon[1],
				ImageTransparency = self.Theme.Controls.WindowControlIcon[2],
			},
		}),
	})

    return structures, contextKeys
end
