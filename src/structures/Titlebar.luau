return function(self)
	--// Imports
	local creator = require("@modules/creator")
	local textField = require("@structures/TextField")

	--// References
	local create = creator.Create

	--// Variables
	local window = nil
	local structures = {}

	--// UI
	structures.Body = create("Frame")({
		Name = "Toolbar",
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 52),

		__dynamicKeys = {
			BackgroundColor3 = self.Theme.Controls.Titlebar.Color,
			BackgroundTransparency = self.Theme.Controls.Titlebar.Transparency,
		},

		create("UICorner")({
			Name = "UICorner",
			CornerRadius = UDim.new(0, 10),
		}),

		create("Frame")({
			Name = "Shadow",
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(234, 234, 234),
			BackgroundTransparency = 0.75,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(1, 1),
			Size = UDim2.new(1, 0, 0, 2),
			ZIndex = 0,

			__dynamicKeys = {
				Color = self.Theme.Controls.TitlebarShadow.Background.Color,
				Transparency = self.Theme.Controls.TitlebarShadow.Background.Transparency,
			},

			create("UIGradient")({
				Name = "UIGradient",
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
				}),
				Rotation = -90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.35),
					NumberSequenceKeypoint.new(1, 0.35),
				}),

				__dynamicKeys = {
					Color = self.Theme.Controls.TitlebarShadow.Color,
					Transparency = self.Theme.Controls.TitlebarShadow.Transparency,
				},
			}),
		}),

		create("Frame")({
			Name = "Content",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),

			create("Frame")({
				Name = "Leading",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0, 1),

				create("UIListLayout")({
					Name = "UIListLayout",
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),

				create("Frame")({
					Name = "TitleSubtitle",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 2,

					create("UIListLayout")({
						Name = "UIListLayout",
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),

					create("TextLabel")({
						Name = "Subtitle",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
						LayoutOrder = 1,
						RichText = true,
						Size = UDim2.fromOffset(0, 14),
						Text = "Subtitle",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 12,
						Visible = false,

						__dynamicKeys = {
							TextColor3 = self.Theme.Text.Secondary.Color,
							TextTransparency = self.Theme.Text.Secondary.Transparency,
						},
					}),

					create("TextLabel")({
						Name = "Title",
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						FontFace = Font.new(
							"rbxassetid://12187365364",
							Enum.FontWeight.SemiBold,
							Enum.FontStyle.Normal
						),
						LineHeight = 0,
						RichText = true,
						Size = UDim2.fromOffset(0, 20),
						Text = "Title",
						TextSize = 16,

						__dynamicKeys = {
							TextColor3 = self.Theme.Text.Primary.Color,
							TextTransparency = self.Theme.Text.Primary.Transparency,
						},
					}),
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
				}),

				create("Frame")({
					Name = "NavigationButtons",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 1,

					create("UIListLayout")({
						Name = "UIListLayout",
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 1),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),

					create("TextButton")({
						Name = "Back",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						Size = UDim2.fromOffset(27, 20),
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14,

						create("ImageLabel")({
							Name = "Image",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://137248392050045",
							ImageColor3 = Color3.fromRGB(0, 0, 0),
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(9, 15),

							__dynamicKeys = {
								ImageColor3 = self.Theme.Text.Tertiary.Color,
								ImageTransparency = self.Theme.Text.Tertiary.Transparency,
							},
						}),
					}),

					create("TextButton")({
						Name = "Forward",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
						LayoutOrder = 1,
						Size = UDim2.fromOffset(27, 20),
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14,

						create("ImageLabel")({
							Name = "Image",
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://95285878898359",
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(9, 15),

							__dynamicKeys = {
								ImageColor3 = self.Theme.Text.Tertiary.Color,
								ImageTransparency = self.Theme.Text.Tertiary.Transparency,
							},
						}),
					}),
				}),

				create("Frame")({
					Name = "SidebarButton",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromOffset(38, 34),

					create("ImageButton")({
						Name = "Image",
						AnchorPoint = Vector2.new(0.5, 0.5),
						AutoButtonColor = false,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://74380920233260",
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(20, 16),

						__dynamicKeys = {
							ImageColor3 = self.Theme.Text.Secondary.Color,
							ImageTransparency = self.Theme.Text.Secondary.Transparency,
						},
					}),
				}),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("Frame")({
				Name = "Trailing",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(0, 1),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
				}),

				create("UIListLayout")({
					Name = "UIListLayout",
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
			}),
		}),

		create("Frame")({
			Name = "CornerClipRight",
			AnchorPoint = Vector2.new(1, 1),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(1, 1),
			Size = UDim2.new(0, 10, 0.5, 0),
			ZIndex = -1,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Titlebar.Color,
			},
		}),

		create("Frame")({
			Name = "CornerClipLeft",
			AnchorPoint = Vector2.new(0, 1),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(0, 10, 1, 0),
			ZIndex = -1,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Titlebar.Color,
			},
		}),
	}) :: TextButton

	--// Initialize
	structures.CornerClipLeft = structures.Body:FindFirstChild("CornerClipLeft") :: Frame
	structures.CornerClipRight = structures.Body:FindFirstChild("ConerClipRight") :: Frame
	structures.Content = structures.Body:FindFirstChild("Content") :: Frame
	structures.Leading = structures.Content:FindFirstChild("Leading") :: Frame
	structures.Trailing = structures.Content:FindFirstChild("Trailing") :: Frame
	structures.NavigationButtons = structures.Leading:FindFirstChild("NavigationButtons") :: Frame
	structures.Back = structures.NavigationButtons:FindFirstChild("Back") :: TextButton
	structures.Forward = structures.NavigationButtons:FindFirstChild("Forward") :: TextButton
	structures.SidebarButton = structures.Leading:FindFirstChild("SidebarButton"):FindFirstChild("Image") :: ImageButton
	structures.TitleStack = structures.Leading:FindFirstChild("TitleSubtitle") :: Frame
	structures.Title = structures.TitleStack:FindFirstChild("Title") :: TextLabel
	structures.Subtitle = structures.TitleStack:FindFirstChild("Subtitle") :: TextLabel

	structures.SearchField = textField(self)
	structures.SearchField.Body.Size = UDim2.fromOffset(126, 28)
	structures.SearchField.Field.Size = UDim2.fromOffset(90, 0)
	structures.SearchField.Layout.Padding = UDim.new(0, 8)
	structures.SearchField.Field.LayoutOrder = 1
	structures.SearchField.Field.PlaceholderText = "Search"
	structures.SearchField.Padding.PaddingLeft = UDim.new(0, 7)
	structures.SearchField.Padding.PaddingRight = UDim.new(0, 7)

	create("ImageLabel")({
		Name = "ImageLabel",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Image = "rbxassetid://120817720539967",
		Size = UDim2.fromOffset(13, 14),
		Parent = structures.SearchField.Body.__instance,

		__dynamicKeys = {
			ImageColor3 = self.Theme.Text.PrimaryAccent.Color,
			ImageTransparency = self.Theme.Text.PrimaryAccent.Transparency,
		},
	})

	structures.SearchField.Body.Parent = structures.Trailing

	local rawHistory = {}
	local currentIndex = 0

	local function updateNavStates()
		if not window then
			return
		end

		local backImage = structures.Back:FindFirstChild("Image")
		local forwardImage = structures.Forward:FindFirstChild("Image")

		local theme = window.Theme.Text

		if backImage then
			local backable = currentIndex > 1

			backImage.ImageColor3 = (backable and theme.Secondary.Color.Value) or theme.Tertiary.Color.Value
			backImage.ImageTransparency = (backable and theme.Secondary.Transparency.Value)
				or theme.Tertiary.Transparency.Value
			structures.Back.Interactable = backable
		end

		if forwardImage then
			local forwardable = currentIndex < #rawHistory

			forwardImage.ImageColor3 = (forwardable and theme.Secondary.Color.Value) or theme.Tertiary.Color.Value
			forwardImage.ImageTransparency = (forwardable and theme.Secondary.Transparency.Value)
				or theme.Tertiary.Transparency.Value
			structures.Forward.Interactable = forwardable
		end
	end

	local navigationHistory = setmetatable({}, {
		__newindex = function(_, key, value)
			rawset(rawHistory, key, value)

			updateNavStates()
		end,
		__index = function(_, key)
			return rawHistory[key]
		end,
		__len = function()
			return #rawHistory
		end,
	})

	local function setPage(page)
		if window and window.Tabs then
			for _, tab in pairs(window.Tabs) do
				if tab.__container == page then
					tab.Selected = true
				else
					tab.Selected = false
				end
			end
		end
	end

	local function attachHandlers()
		structures.Back.MouseButton1Click:Connect(function()
			if currentIndex > 1 then
				currentIndex -= 1
				setPage(rawHistory[currentIndex])
				updateNavStates()
			end
		end)

		structures.Forward.MouseButton1Click:Connect(function()
			if currentIndex < #rawHistory then
				currentIndex += 1
				setPage(rawHistory[currentIndex])
				updateNavStates()
			end
		end)
	end

	return structures,
		function(newWindow)
			window = newWindow
			attachHandlers()

			return function(page)
				for i = #rawHistory, currentIndex + 1, -1 do
					rawHistory[i] = nil
				end

				currentIndex += 1
				navigationHistory[currentIndex] = page
			end
		end
end
