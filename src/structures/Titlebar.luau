return function(self)
	--// Imports
	local creator = require("@modules/creator")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	structures.Body = create("Frame")({
		Name = "Toolbar",
		BackgroundColor3 = Color3.fromRGB(238, 238, 238),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 52),

		__dynamicKeys = {
			BackgroundColor3 = self.Theme.Controls.Titlebar.Color,
			BackgroundTransparency = self.Theme.Controls.Titlebar.Transparency
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
				Transparency = self.Theme.Controls.TitlebarShadow.Background.Transparency
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
					Transparency = self.Theme.Controls.TitlebarShadow.Transparency
				}
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
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
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
						TextTransparency = 0.5,
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
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 16,
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
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://137248392050045",
							ImageColor3 = Color3.fromRGB(0, 0, 0),
							ImageTransparency = 0.5,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(9, 15),
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
							ImageColor3 = Color3.fromRGB(0, 0, 0),
							ImageTransparency = 0.5,
							Position = UDim2.fromScale(0.5, 0.5),
							Size = UDim2.fromOffset(9, 15),
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
						ImageColor3 = Color3.fromRGB(0, 0, 0),
						ImageTransparency = 0.5,
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(20, 16),
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

				create("Frame")({
					Name = "SearchField",
					AnchorPoint = Vector2.new(1, 0.5),
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0.5),
					Size = UDim2.fromOffset(126, 28),

					create("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(0, 5),
					}),

					create("UIStroke")({
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 0.95,
					}),

					create("UIPadding")({
						Name = "UIPadding",
						PaddingBottom = UDim.new(0, 6),
						PaddingLeft = UDim.new(0, 7),
						PaddingRight = UDim.new(0, 7),
						PaddingTop = UDim.new(0, 6),
					}),

					create("TextBox")({
						Name = "SearchField",
						AnchorPoint = Vector2.new(1, 0.5),
						AutomaticSize = Enum.AutomaticSize.XY,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						FontFace = Font.new("rbxassetid://12187365364"),
						LayoutOrder = 1,
						PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
						PlaceholderText = "Search",
						Position = UDim2.fromScale(0.902, 0.5),
						Size = UDim2.fromOffset(90, 15),
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 15,
						TextTransparency = 0.25,
						TextXAlignment = Enum.TextXAlignment.Left,
					}),

					create("UIListLayout")({
						Name = "UIListLayout",
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 8),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),

					create("ImageLabel")({
						Name = "ImageLabel",
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://120817720539967",
						ImageColor3 = Color3.fromRGB(77, 77, 77),
						Size = UDim2.fromOffset(13, 14),
					}),
				}),
			}),
		}),

		create("Frame")({
			Name = "CornerClipRight",
			AnchorPoint = Vector2.new(1, 1),
			BackgroundColor3 = Color3.fromRGB(238, 238, 238),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(1, 1),
			Size = UDim2.new(0, 10, 0.5, 0),
			ZIndex = -1,
		}),

		create("Frame")({
			Name = "CornerClipLeft",
			AnchorPoint = Vector2.new(0, 1),
			BackgroundColor3 = Color3.fromRGB(238, 238, 238),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(0, 10, 1, 0),
			ZIndex = -1,
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

	structures.SidebarButton = structures.Leading:FindFirstChild("SidebarButton") :: Frame

	return structures
end
