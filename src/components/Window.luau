local types = require("@types")

return function(self, properties: types.WindowProperties): types.Window
	--// Imports
	local effects = require("@effects")
	local services = require("@modules/services")
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local titleBar = require("@structures/Titlebar")

	--// References
	local create = creator.Create

	local userInputService = services.UserInputService
	local tweenService = services.TweenService

	--// Variables
	local originalSize
	local originalPosition
	local dragging
	local structures = {}

	--// UI
	properties = properties or {}

	properties.Maximized = properties.Maximized ~= nil and properties.Maximized or false
	properties.Minimized = properties.Minimized ~= nil and properties.Minimized or false
	properties.Searching = properties.Searching == nil and true or properties.Searching
	properties.Resizable = properties.Resizable == nil and true or properties.Resizable
	properties.Draggable = properties.Draggable == nil and true or properties.Draggable
	properties.Resizable = properties.Resizable == nil and true or properties.Resizable
	properties.Title = properties.Title or "Title"
	properties.Dropshadow = properties.Dropshadow == nil and true or properties.Dropshadow
	properties.UIBlur = properties.UIBlur == nil and true or properties.UIBlur

	local parent = self.__container or self.__instance or self

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Body",
			ClipsDescendants = true,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(850, 530),
			Parent = parent,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Sidebar.Color,
				BackgroundTransparency = self.Theme.Controls.Sidebar.Transparency,
			},

			create("UIPadding")({
				Name = "UIPadding",
			}),

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 10),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 0),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("Frame")({
				Name = "Sidebar",
				BackgroundColor3 = Color3.fromRGB(234, 234, 234),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 200, 1, 0),

				create("Folder")({
					Name = "LayoutIgnore",

					create("Frame")({
						Name = "Shadow",
						AnchorPoint = Vector2.new(1, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, 2, 0, 0),
						Size = UDim2.new(0, 5, 1, 0),
						ZIndex = 0,
						__dynamicKeys = {
							BackgroundColor3 = self.Theme.Controls.Separator.Shadow.Color,
							BackgroundTransparency = self.Theme.Controls.Separator.Shadow.Transparency,
						},

						create("UIGradient")({
							Name = "UIGradient",
							Transparency = NumberSequence.new({
								NumberSequenceKeypoint.new(0, 1),
								NumberSequenceKeypoint.new(1, 0),
							}),
						}),
					}),
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingRight = UDim.new(0, 2),
				}),

				create("Frame")({
					Name = "Toolbar",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 52),

					create("Frame")({
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

						create("ImageButton")({
							Name = "Exit",
							AutoButtonColor = false,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://132228700346004",
							Size = UDim2.fromOffset(12, 12),

							__dynamicKeys = {
								ImageColor3 = self.Theme.Controls.Exit.Color,
								ImageTransparency = self.Theme.Controls.Exit.Transparency,
							},

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								Size = UDim2.fromScale(1, 1),

								__dynamicKeys = {
									ImageColor3 = self.Theme.Controls.WindowControlStroke.Color,
									ImageTransparency = self.Theme.Controls.WindowControlStroke.Transparency,
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
									ImageColor3 = self.Theme.Controls.WindowControlIcon.Color,
									ImageTransparency = self.Theme.Controls.WindowControlIcon.Transparency,
								},
							}),
						}),

						create("ImageButton")({
							Name = "Minimize",
							AutoButtonColor = false,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://132228700346004",
							LayoutOrder = 1,
							Size = UDim2.fromOffset(12, 12),

							__dynamicKeys = {
								ImageColor3 = self.Theme.Controls.Minimize.Color,
								ImageTransparency = self.Theme.Controls.Minimize.Transparency,
							},

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								Size = UDim2.fromScale(1, 1),

								__dynamicKeys = {
									ImageColor3 = self.Theme.Controls.WindowControlStroke.Color,
									ImageTransparency = self.Theme.Controls.WindowControlStroke.Transparency,
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
									ImageColor3 = self.Theme.Controls.WindowControlIcon.Color,
									ImageTransparency = self.Theme.Controls.WindowControlIcon.Transparency,
								},
							}),
						}),

						create("ImageButton")({
							Name = "Zoom",
							AutoButtonColor = false,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							BackgroundTransparency = 1,
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://132228700346004",
							LayoutOrder = 2,
							Size = UDim2.fromOffset(12, 12),

							__dynamicKeys = {
								ImageColor3 = self.Theme.Controls.Zoom.Color,
								ImageTransparency = self.Theme.Controls.Zoom.Transparency,
							},

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								Size = UDim2.fromScale(1, 1),

								__dynamicKeys = {
									ImageColor3 = self.Theme.Controls.WindowControlStroke.Color,
									ImageTransparency = self.Theme.Controls.WindowControlStroke.Transparency,
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
									ImageColor3 = self.Theme.Controls.WindowControlIcon.Color,
									ImageTransparency = self.Theme.Controls.WindowControlIcon.Transparency,
								},
							}),
						}),
					}),
				}),

				create("ScrollingFrame")({
					Name = "SidebarList",
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(),
					Position = UDim2.fromOffset(0, 52),
					ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarImageTransparency = 0.7,
					ScrollBarThickness = 6,
					Size = UDim2.new(1, 0, 1, -52),

					create("UIListLayout")({
						Name = "UIListLayout",
						Padding = UDim.new(0, 9),
						SortOrder = Enum.SortOrder.LayoutOrder,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
					}),

					create("UIPadding")({
						Name = "UIPadding",
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 10),
						PaddingBottom = UDim.new(0, 10),
					}),
				}),
			}),

			create("Frame")({
				Name = "Separator",
				AnchorPoint = Vector2.new(1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.fromScale(1, 0),
				Size = UDim2.new(0, 1, 1, 0),
				__dynamicKeys = {
					BackgroundColor3 = self.Theme.Controls.Separator.Background.Color,
					BackgroundTransparency = self.Theme.Controls.Separator.Background.Transparency,
				},
			}),

			create("Frame")({
				Name = "ContentBody",
				AnchorPoint = Vector2.new(1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				LayoutOrder = 2,
				Position = UDim2.fromScale(1, 0),
				Size = UDim2.new(1, -201, 1, 0),

				__dynamicKeys = {
					BackgroundColor3 = self.Theme.Controls.Background.Color,
					BackgroundTransparency = self.Theme.Controls.Background.Transparency,
				},

				create("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 10),
				}),

				create("Frame")({
					Name = "Content",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(255, 199, 199),
					BorderMode = Enum.BorderMode.Inset,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Position = UDim2.fromOffset(0, 52),
					Size = UDim2.new(1, 0, 1, -52),

					create("UIPadding")({
						Name = "Margins",
						PaddingBottom = UDim.new(0, 3),
						PaddingLeft = UDim.new(0, 3),
						PaddingRight = UDim.new(0, 3),
						PaddingTop = UDim.new(0, 3),
					}),
				}),

				create("Frame")({
					Name = "CornerClip",
					AnchorPoint = Vector2.new(0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.fromOffset(10, 10),
					ZIndex = -1,

					__dynamicKeys = {
						BackgroundColor3 = self.Theme.Controls.Background.Color,
					},
				}),
			}),

			create("Folder")({
				Name = "Handles",

				create("TextButton")({
					Name = "W",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 0.5),
					Selectable = false,
					Size = UDim2.new(0, 5, 1, -10),
					Text = "",
				}),

				create("TextButton")({
					Name = "N",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.5, 0),
					Selectable = false,
					Size = UDim2.new(1, -10, 0, 5),
					Text = "",
				}),

				create("TextButton")({
					Name = "SE",
					Active = false,
					AnchorPoint = Vector2.new(1, 1),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 1),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "NW",
					Active = false,
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "SW",
					Active = false,
					AnchorPoint = Vector2.new(0, 1),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "S",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.5, 1),
					Selectable = false,
					Size = UDim2.new(1, -10, 0, 5),
					Text = "",
				}),

				create("TextButton")({
					Name = "E",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0.5),
					Selectable = false,
					Size = UDim2.new(0, 5, 1, -10),
					Text = "",
				}),

				create("TextButton")({
					Name = "NE",
					Active = false,
					AnchorPoint = Vector2.new(1, 0),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "TopArea",
					AutoButtonColor = false,
					Active = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 52),
					ZIndex = 0,
					Text = "",
					Modal = true,
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Cornering = structures.Body:FindFirstChild("UICorner") :: UICorner
	structures.Handles = structures.Body:FindFirstChild("Handles") :: Folder
	structures.Separator = structures.Body:FindFirstChild("Separator") :: Frame
	structures.Sidebar = structures.Body:FindFirstChild("Sidebar") :: Frame
	structures.SidebarList = structures.Sidebar:FindFirstChild("SidebarList") :: Frame
	structures.Toolbar = structures.Sidebar:FindFirstChild("Toolbar") :: Frame
	structures.WindowControls = structures.Toolbar:FindFirstChild("WindowControls") :: Frame
	structures.ContentBody = structures.Body:FindFirstChild("ContentBody") :: Frame
	structures.Content = structures.ContentBody:FindFirstChild("Content") :: Frame
	structures.CornerClip = structures.ContentBody:FindFirstChild("CornerClip") :: Frame

	local _titleBar, initializeTBar = titleBar(self)

	structures.Titlebar = _titleBar
	structures.Titlebar.Body.Parent = structures.ContentBody

	originalSize = structures.Body.Size
	originalPosition = structures.Body.Position

	local bindings = {
		Title = function(value: string)
			structures.Titlebar.Title.Visible = value and true or false

			if value then
				structures.Titlebar.Title.Text = value
			end
		end,
		Subtitle = function(value: string)
			structures.Titlebar.Subtitle.Visible = value and true or false

			if value then
				structures.Titlebar.Subtitle.Text = value
			end
		end,
		Searching = function(value: boolean)
			structures.Titlebar.SearchField.Body.Visible = value
		end,
		Draggable = function(value: boolean)
			dragging = not value and false
		end,
		Minimized = function(value: boolean) end,
		Maximized = function(value: boolean?, tween: boolean?)
			if not value then
				dragging = false
			end

			if value then
				originalSize = structures.Body.Size
				originalPosition = structures.Body.Position
			end

			local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			local bodyTarget = {
				Size = value and UDim2.fromScale(1, 1) or originalSize,
				Position = value and UDim2.fromScale(0.5, 0.5) or originalPosition,
			}
			local cornerTarget = { CornerRadius = value and UDim.new(0, 0) or UDim.new(0, 10) }

			if tween then
				tweenService:Create(structures.Body.__instance, tweenInfo, bodyTarget):Play()
				tweenService:Create(structures.Cornering, tweenInfo, cornerTarget):Play()
			else
				structures.Body.Size = bodyTarget.Size
				structures.Body.Position = bodyTarget.Position
				structures.Cornering.CornerRadius = cornerTarget.CornerRadius
			end
		end,
		Dropshadow = function(value: boolean)
			if structures["ShadowLayers"] then
				structures["ShadowLayers"]:Destroy()
			end

			if value then
				structures.ShadowLayers = effects.Dropshadow(structures.Body, Color3.new(0, 0, 0), 0.25, 14)
			end
		end,
		UIBlur = function(value: boolean)
			if structures["BlurModel"] then
				structures["BlurModel"].Model:Destroy()
				structures["BlurModel"] = nil
			end

			structures.Body.BackgroundTransparency = value and self.Theme.Controls.Sidebar.Transparency.Value or 0

			if value then
				structures.BlurModel = effects.UIBlur(structures.Body)
			end
		end,
	}
	local object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Window"
	object.Theme = self.Theme
	object.Structures = structures
	object.Tabs = {}
	object.addToHistory = initializeTBar(object)
	object.__container = structures.Content

	do -- Sidebar button
		local toggled = true

		local function toggle()
			toggled = not toggled

			local sidebarTargetSize = toggled and UDim.new(0, 0) or UDim.new(0, -201)
			local cornerLeftSize = toggled and UDim2.new(0, 10, 1, 0) or UDim2.new(0, 10, 0.5, 0)

			local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

			structures.Separator.Visible = toggled and true or false
			structures.CornerClip.Visible = toggled and true

			local sidebarTween = tweenService:Create(structures.Body:FindFirstChild("UIPadding"), tweenInfo, {
				PaddingLeft = sidebarTargetSize,
			})

			tweenService
				:Create(structures.Titlebar.CornerClipLeft, tweenInfo, {
					Size = cornerLeftSize,
				})
				:Play()

			sidebarTween:Play()

			if not toggled then
				sidebarTween.Completed:Connect(function()
					structures.CornerClip.Visible = false
				end)
			end
		end

		structures.Titlebar.SidebarButton.MouseButton1Click:Connect(toggle)
	end

	do -- Page searching
		local field = structures.Titlebar.SearchField.Field
		local pageCaches = {}

		local function toCache(page, descendants)
			local cache = {}
			for _, child in ipairs(descendants) do
				if child:IsA("GuiObject") then
					cache[child] = child.Visible
				end
			end
			pageCaches[page] = cache
		end

		local function fromCache(page, descendants)
			local cache = pageCaches[page]
			if not cache then
				return
			end

			for _, child in ipairs(descendants) do
				if child:IsA("GuiObject") then
					child.Visible = cache[child] ~= false
				end
			end
		end

		field:GetPropertyChangedSignal("Text"):Connect(function()
			local page = structures.Content:FindFirstChildOfClass("ScrollingFrame")
			if not page then
				return
			end

			local descendants = page:GetDescendants()

			if not pageCaches[page] then
				toCache(page, descendants)
			end

			local query = field.Text:lower()

			if query == "" then
				fromCache(page, descendants)
				return
			end

			local matches = {}
			local items = {}

			for _, child in ipairs(descendants) do
				if child:IsA("GuiObject") then
					local searchIndex = child:GetAttribute("SearchIndex")

					if typeof(searchIndex) == "string" and searchIndex:lower():find(query) then
						table.insert(matches, child)
					end
				end
			end

			for _, match in ipairs(matches) do
				items[match] = true

				local parent = match.Parent

				while parent and parent ~= page do
					if parent:IsA("GuiObject") then
						items[parent] = true
					end

					parent = parent.Parent
				end
			end

			for _, child in ipairs(descendants) do
				if child:IsA("GuiObject") then
					child.Visible = false
				end
			end

			for _, match in ipairs(matches) do
				match.Visible = true

				local parent = match.Parent

				while parent and parent ~= page do
					if parent:IsA("GuiObject") then
						parent.Visible = true
					end

					parent = parent.Parent
				end

				for _, descendant in ipairs(match:GetDescendants()) do
					if descendant:IsA("GuiObject") then
						descendant.Visible = true
					end
				end
			end
		end)
	end

	do -- Window controls
		local exit = structures.WindowControls:FindFirstChild("Exit")
		local minimize = structures.WindowControls:FindFirstChild("Minimize")
		local zoom = structures.WindowControls:FindFirstChild("Zoom")

		local function rollOver()
			exit:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
			minimize:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
			zoom:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
		end

		zoom.MouseButton1Click:Connect(function()
			properties.Maximized = not properties.Maximized
			bindings.Maximized(properties.Maximized, true)
		end)

		structures.WindowControls.MouseEnter:Connect(rollOver)
		structures.WindowControls.MouseLeave:Connect(rollOver)
	end

	do -- Window dragging
		local inputPos = nil
		local startPos = nil
		local connection = nil
		local boundingUi = structures.Handles:FindFirstChild("TopArea")

		boundingUi.InputBegan:Connect(function(input)
			if
				(
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				)
				and properties.Draggable
				and not properties.Maximized
			then
				dragging = true
				inputPos = input.Position
				startPos = structures.Body.Position

				if connection then
					connection:Disconnect()
				end

				connection = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		userInputService.InputChanged:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			then
				if dragging then
					local delta = input.Position - inputPos

					local newPosition = UDim2.new(
						startPos.X.Scale,
						startPos.X.Offset + delta.X,
						startPos.Y.Scale,
						startPos.Y.Offset + delta.Y
					)

					structures.Body.Position = newPosition
				end
			end
		end)
	end

	binder.Apply(properties, object)

	return object
end
