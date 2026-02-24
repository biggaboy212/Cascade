local types = require("@types")

return function(self: any, properties: types.NotificationProperties, state: { Age: number }, MAX_NOTIFICATIONS: number)
	local creator = require("@modules/creator")

	local create = creator.Create

	local notificationsContainer = self.__instance:FindFirstChild("Notifications")
	if not notificationsContainer then
		notificationsContainer = create("Frame")({
			Name = "Notifications",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 200,
			Parent = self.__instance,

			create("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 15),
				PaddingRight = UDim.new(0, 15),
			}),
		}).__instance
	end

	local body = create("Frame")({
		Name = "Notification",
		AnchorPoint = Vector2.new(0.5, 1),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -162.5, 1, 0),
		Size = UDim2.fromOffset(325, 0),
		Parent = notificationsContainer,

		create("Frame")({
			Name = "Canvas",
			AnchorPoint = Vector2.new(0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = self.Theme.Controls.Sidebar[1].Value,
			BackgroundTransparency = 0.1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 0),

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Sidebar[1],
			},

			__contextKeys = {
				BackgroundTransparency = function()
					return state.Age >= (MAX_NOTIFICATIONS - 1) and 1 or 0.1
				end,
			},

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 12),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				Padding = UDim.new(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("Frame")({
				Name = "Content",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 0, 68),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Size = UDim2.fromScale(1, 0),

				create("Frame")({
					Name = "TitleContainer",
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = 1,

					create("UIListLayout")({
						Name = "UIListLayout",
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 5),
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					}),

					create("ImageLabel")({
						Name = "Icon",
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						Size = UDim2.fromOffset(13, 13),
						Visible = false,

						__dynamicKeys = {
							ImageColor3 = self.Theme.Text.Primary[1],
						},
						__contextKeys = {
							ImageTransparency = function()
								return state.Age >= (MAX_NOTIFICATIONS - 1) and 1 or self.Theme.Text.Primary[2].Value
							end,
						},
					}),

					create("TextLabel")({
						Name = "Title",
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						LayoutOrder = 2,
						FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
						LineHeight = 0,
						Size = UDim2.new(1, 0, 0, 20),
						Text = properties.Title,
						TextColor3 = self.Theme.Text.Primary[1].Value,
						TextSize = 13,
						TextTransparency = self.Theme.Text.Primary[2].Value,
						TextWrapped = true,
						RichText = true,
						TextXAlignment = Enum.TextXAlignment.Left,

						__dynamicKeys = {
							TextColor3 = self.Theme.Text.Primary[1],
							TextTransparency = self.Theme.Text.Primary[2],
						},

						__contextKeys = {
							TextTransparency = function()
								return state.Age >= (MAX_NOTIFICATIONS - 1) and 1 or self.Theme.Text.Primary[2].Value
							end,
						},
					}),
				}),

				create("UIListLayout")({
					Name = "UIListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),

				create("TextLabel")({
					Name = "Subtitle",
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364"),
					LayoutOrder = 1,
					Position = UDim2.fromScale(0, 0.147),
					RichText = true,
					Size = UDim2.fromScale(1, 0),
					Text = properties.Subtitle,
					TextColor3 = self.Theme.Text.Secondary[1].Value,
					TextSize = 13,
					TextTransparency = self.Theme.Text.Secondary[2].Value,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Visible = properties.Subtitle ~= "",

					__dynamicKeys = {
						TextColor3 = self.Theme.Text.Secondary[1],
						TextTransparency = self.Theme.Text.Secondary[2],
					},

					__contextKeys = {
						TextTransparency = function()
							return state.Age >= (MAX_NOTIFICATIONS - 1) and 1 or self.Theme.Text.Secondary[2].Value
						end,
					},
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 12),
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
				}),
			}),

			create("Frame")({
				Name = "Topbar",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 0),
				Visible = (properties.App ~= nil) or (properties.Icon ~= nil),

				create("UIListLayout")({
					Name = "UIListLayout",
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),

				create("TextLabel")({
					Name = "App",
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					LayoutOrder = 1,
					LineHeight = 0,
					Size = UDim2.fromOffset(0, 14),
					Text = properties.App or "",
					TextColor3 = self.Theme.Text.Primary[1].Value,
					TextSize = 13,
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					RichText = true,
					Visible = properties.App ~= nil,

					__dynamicKeys = {
						TextColor3 = self.Theme.Text.Primary[1],
					},
				}),

				create("ImageLabel")({
					Name = "Icon",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = properties.AppIcon or "",
					ImageColor3 = self.Theme.Text.Primary[1].Value,
					Size = UDim2.fromOffset(20, 20),
					Visible = properties.AppIcon ~= nil,

					__dynamicKeys = {
						ImageColor3 = self.Theme.Text.Primary[1],
					},
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 12),
				}),
			}),
		}),

		create("Folder")({
			Name = "LayoutIgnore",

			create("TextButton")({
				Name = "Exit",
				AnchorPoint = Vector2.new(0.5, 0.5),
				AutoButtonColor = false,
				BackgroundColor3 = self.Theme.Controls.View[1].Value,
				BackgroundTransparency = 0.1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				FontFace = Font.new("rbxassetid://12187365364"),
				Position = UDim2.fromOffset(3, 3),
				Size = UDim2.fromOffset(20, 20),
				Text = "",
				TextColor3 = self.Theme.Text.Primary[1].Value,
				TextSize = 14,
				TextTransparency = 0.5,

				__dynamicKeys = {
					BackgroundColor3 = self.Theme.Controls.View[1],
				},

				create("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(1, 0),
				}),

				create("ImageLabel")({
					Name = "Icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://72660323302468",
					ImageColor3 = self.Theme.Text.Primary[1].Value,
					ImageTransparency = 0.5,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(20, 20),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Text.Primary[1],
					},
				}),

				create("Frame")({
					Name = "Shadow",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.fromScale(1, 1),

					create("UIStroke")({
						Name = "UIStroke",
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 0.9,
					}),

					create("UICorner")({
						Name = "UICorner",
						CornerRadius = UDim.new(1, 0),
					}),
				}),

				create("UIStroke")({
					Name = "UIStroke",
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = self.Theme.Text.Primary[1].Value,
					Thickness = 2,
					Transparency = 0.96,

					__dynamicKeys = {
						Color = self.Theme.Text.Primary[1],
					},
				}),
			}),
		}),

		create("UIScale")({
			Name = "UIScale",
			Scale = 0.85,
		}),
	}) :: Frame

	local exitBtn = body.LayoutIgnore.Exit
	local canvas = body.Canvas
	local content = canvas.Content
	local topbar = canvas.Topbar

	return body, exitBtn, canvas, content, topbar
end
