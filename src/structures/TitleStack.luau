return function(self)
	--// Imports
	local creator = require("@modules/creator")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	structures.Body = create("Frame")({
		Name = "TitleStack",
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(0, 0),

		create("UIListLayout")({
			Name = "UIListLayout",
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),

		create("UIPadding")({
			Name = "UIPadding",
		}),

		create("TextLabel")({
			Name = "Subtitle",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			FontFace = Font.new("rbxassetid://12187365364"),
			LayoutOrder = 1,
			RichText = true,
			Size = UDim2.new(0, 0, 0, 14),
			Text = "Subtitle",
			TextSize = 13,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			Visible = false,

			__dynamicKeys = {
				TextColor3 = self.Theme.Text.Secondary[1],
				TextTransparency = self.Theme.Text.Secondary[2],
			},
		}),

		create("TextLabel")({
			Name = "Title",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			FontFace = Font.new("rbxassetid://12187365364"),
			RichText = true,
			Size = UDim2.new(0, 0, 0, 16),
			Text = "Title",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 15,
			TextTransparency = 0.15,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,

			__dynamicKeys = {
				TextColor3 = self.Theme.Text.Primary[1],
				TextTransparency = self.Theme.Text.Primary[2],
			},
		}),
	}) :: Frame

	--// Initialize
	structures.Title = structures.Body:FindFirstChild("Title") :: TextLabel
	structures.Subtitle = structures.Body:FindFirstChild("Subtitle") :: TextLabel
	structures.Padding = structures.Body:FindFirstChild("UIPadding") :: UIPadding

	return structures
end
