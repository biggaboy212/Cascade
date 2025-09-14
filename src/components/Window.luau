-- We uh
-- We dont talk about this..

local types = require("@types")

return function(self, properties: types.WindowProperties): types.Window
	--// Imports
	local effects = require("@effects")
	local services = require("@modules/services")
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local titleBar, addToHistory = require("@structures/Titlebar")(self)
	local resizeHandler = require("@modules/resizeHandler")

	--// References
	local create = creator.Create

	local userInputService = services.UserInputService
	local tweenService = services.TweenService

	--// Variables
	local parent = self.__container or self.__instance or self
	local window = create("Frame")({
		Name = "Window",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Parent = parent,
	}).__instance
	local originalSize
	local originalPosition
	local originalPosition2
	local minimizing
	local dragging
	local resizeClient
	local structures = {}

	--// UI
	properties = properties or {}

	properties.Size = properties.Size or UDim2.fromOffset(850, 530)
	properties.Maximized = properties.Maximized == true
	properties.Minimized = properties.Minimized == true
	properties.Searching = properties.Searching ~= false
	properties.Resizable = properties.Resizable ~= false
	properties.Draggable = properties.Draggable ~= false
	properties.Resizable = properties.Resizable ~= false
	properties.Dropshadow = properties.Dropshadow ~= false
	properties.UIBlur = properties.UIBlur ~= false
	properties.Title = properties.Title or "Title"

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Body",
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Parent = window,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Sidebar[1],
				BackgroundTransparency = self.Theme.Controls.Sidebar[2],
			},

			__contextKeys = {
				BackgroundTransparency = function()
					return properties.UIBlur and self.Theme.Controls.Sidebar[2].Value or 0
				end,
			},

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
				ClipsDescendants = true,

				create("UIPadding")({
					Name = "UIPadding",
				}),

				create("Frame")({
					Name = "Margins",
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
								BackgroundColor3 = self.Theme.Controls.Separator.Shadow[1],
								BackgroundTransparency = self.Theme.Controls.Separator.Shadow[2],
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
									ImageColor3 = self.Theme.Controls.Exit[1],
									ImageTransparency = self.Theme.Controls.Exit[2],
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
									ImageColor3 = self.Theme.Controls.Minimize[1],
									ImageTransparency = self.Theme.Controls.Minimize[2],
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
									ImageColor3 = self.Theme.Controls.Zoom[1],
									ImageTransparency = self.Theme.Controls.Zoom[2],
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
					BackgroundColor3 = self.Theme.Controls.Separator.Background[1],
					BackgroundTransparency = self.Theme.Controls.Separator.Background[2],
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
					BackgroundColor3 = self.Theme.Controls.Background[1],
					BackgroundTransparency = self.Theme.Controls.Background[2],
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
						BackgroundColor3 = self.Theme.Controls.Background[1],
					},
				}),
			}),

			create("Folder")({
				Name = "LayoutIgnore",

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
					Modal = false,
				}),

				create("ImageLabel")({
					Name = "Dropshadow",
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://138260268144845",
					ImageTransparency = 0.65,
					Interactable = false,
					Position = UDim2.new(0.5, 0, 0.5, 3),
					ScaleType = Enum.ScaleType.Slice,
					Size = UDim2.new(1, 24, 1, 24),
					SliceCenter = Rect.new(28, 26, 96, 94),
					ZIndex = 0,
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Scale = create("UIScale")({
		Parent = window,
	})
	structures.Cornering = structures.Body:FindFirstChild("UICorner") :: UICorner
	structures.LayoutIgnore = structures.Body:FindFirstChild("LayoutIgnore") :: Folder
	structures.Dropshadow = structures.LayoutIgnore:FindFirstChild("Dropshadow") :: ImageLabel
	structures.Separator = structures.Body:FindFirstChild("Separator") :: Frame
	structures.SidebarMargins = structures.Body:FindFirstChild("Sidebar")
	structures.Sidebar = structures.SidebarMargins:FindFirstChild("Margins") :: Frame
	structures.SidebarList = structures.Sidebar:FindFirstChild("SidebarList") :: Frame
	structures.Toolbar = structures.Sidebar:FindFirstChild("Toolbar") :: Frame
	structures.WindowControls = structures.Toolbar:FindFirstChild("WindowControls") :: Frame
	structures.ContentBody = structures.Body:FindFirstChild("ContentBody") :: Frame
	structures.Content = structures.ContentBody:FindFirstChild("Content") :: Frame
	structures.CornerClip = structures.ContentBody:FindFirstChild("CornerClip") :: Frame

	structures.Titlebar = titleBar
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
			structures.Titlebar.SearchField.Body.Parent = value and structures.Titlebar.Trailing or nil
			structures.Titlebar.SearchField.Body.Visible = value
		end,
		Draggable = function(value: boolean)
			dragging = not value and false
		end,
		Resizable = function(value: boolean)
			if resizeClient and not properties.Maximized then
				resizeClient.SetEnabled(value)
			end
		end,
		Minimized = function(value: boolean?, tween: boolean?)
			local useTween = tween ~= false

			if value and not minimizing then
				originalPosition2 = structures.Body.Position
				
				if structures["BlurModel"] then
					structures["BlurModel"].SetVisibility(false)
				end
			end

			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			local bodyTarget = {
				Position = value and UDim2.new(0.5, 0, 0.5, structures.Body.AbsoluteSize.Y * 2) or originalPosition2,
			}
			local scaleTarget = { Scale = value and 0 or 1 }

			if useTween then
				minimizing = true
				tweenService:Create(structures.Body.__instance, tweenInfo, bodyTarget):Play()

				local scaleTween: Tween = tweenService:Create(structures.Scale.__instance, tweenInfo, scaleTarget)

				scaleTween:Play()
				scaleTween.Completed:Once(function()
					minimizing = false

					if structures["BlurModel"] and not properties.Minimized then
						structures["BlurModel"].SetVisibility(true)
					end
				end)
			else
				structures.Body.Position = bodyTarget.Position
				structures.Scale.Scale = scaleTarget.Scale

				if value and structures["BlurModel"] then
					structures["BlurModel"].SetVisibility(false)
				end
			end
		end,
		Maximized = function(value: boolean?, tween: boolean?)
			tween = tween ~= false

			if value then
				originalSize = structures.Body.Size
				originalPosition = structures.Body.Position
				resizeClient.SetEnabled(false)
			else
				dragging = false
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

			if not value then
				resizeClient.SetEnabled(properties.Resizable)
			end
		end,
		Dropshadow = function(value: boolean)
			structures.Dropshadow.Visible = value
		end,
		UIBlur = function(value: boolean)
			if structures["BlurModel"] then
				structures["BlurModel"].Model:Destroy()
				structures["BlurModel"] = nil
			end

			structures.Body.BackgroundTransparency = value and self.Theme.Controls.Sidebar[2].Value or 0

			if value and not properties.Minimized then
				structures.BlurModel = effects.UIBlur(structures.Body)
			end
		end,
	}
	local object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "Window"
	object.Theme = self.Theme
	object.Structures = structures
	object.Tabs = {}
	object.addToHistory = addToHistory(object)
	object.__container = structures.Content

	do -- Resize handler
		resizeClient = resizeHandler(structures.Body.__instance, Vector2.new(350, 250))

		resizeClient.CreateClient()
	end

	do -- Sidebar button
		local toggled = true

		local function toggle()
			toggled = not toggled

			local marginsTargetSize = toggled and UDim.new(0, 0) or UDim.new(0, -200)
			local sidebarTargetSize = toggled and UDim2.new(0, 200, 1, 0) or UDim2.new(0, 0, 1, 0)
			local contentTargetSize = toggled and UDim2.new(1, -201, 1, 0) or UDim2.new(1, 0, 1, 0)
			local cornerLeftSize = toggled and UDim2.new(0, 10, 1, 0) or UDim2.new(0, 10, 0.5, 0)

			local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

			structures.Separator.Visible = toggled and true or false
			structures.CornerClip.Visible = toggled and true

			tweenService
				:Create(structures.ContentBody, tweenInfo, {
					Size = contentTargetSize,
				})
				:Play()

			tweenService
				:Create(structures.SidebarMargins:FindFirstChild("UIPadding"), tweenInfo, {
					PaddingLeft = marginsTargetSize,
				})
				:Play()

			local sidebarTween = tweenService:Create(structures.SidebarMargins, tweenInfo, {
				Size = sidebarTargetSize,
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
			local matches = {}
			local items = {}
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

				local cache = pageCaches[page]

				for _, descendant in ipairs(match:GetDescendants()) do
					if descendant:IsA("GuiObject") then
						local wasVisible = cache and cache[descendant]
						if wasVisible then
							descendant.Visible = true
						end
					end
				end
			end
		end)
	end

	do -- Window controls
		local exit = structures.WindowControls:FindFirstChild("Exit") :: ImageButton
		local minimize = structures.WindowControls:FindFirstChild("Minimize") :: ImageButton
		local zoom = structures.WindowControls:FindFirstChild("Zoom") :: ImageButton

		local function rollOver()
			exit:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
			minimize:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
			zoom:FindFirstChild("Icon").Visible = structures.WindowControls.GuiState ~= Enum.GuiState.Hover
		end

		zoom.MouseButton1Click:Connect(function()
			properties.Maximized = not properties.Maximized
			bindings.Maximized(properties.Maximized, true)
		end)

		minimize.MouseButton1Click:Connect(function()
			properties.Minimized = not properties.Minimized
			bindings.Minimized(properties.Minimized, true)
		end)

		if self.Structures and self.Structures["WindowPill"] then
			local pill: ImageButton = self.Structures["WindowPill"]

			pill.MouseButton1Click:Connect(function()
				properties.Minimized = not properties.Minimized
				bindings.Minimized(properties.Minimized, true)
			end)
		end

		exit.MouseButton1Click:Connect(function()
			bindings.Minimized(true)
			task.delay(0.25, structures.Body.Destroy)
		end)

		structures.WindowControls.MouseEnter:Connect(rollOver)
		structures.WindowControls.MouseLeave:Connect(rollOver)
	end

	do -- Window dragging
		local inputPos = nil
		local startPos = nil
		local connection = nil
		local boundingUi = structures.LayoutIgnore:FindFirstChild("TopArea")

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

	local function recheck() -- Due to roblox resizing issues
		-- If there's a better way to do this please tell me or make a PR
		for i, v in pairs(structures.Body:GetDescendants()) do
			if not pcall(function()
				return v.Size
			end) then
				continue
			end

			local original = v.Size

			v.Size = UDim2.fromOffset(0, 0)
			v.Size = original
		end
	end

	task.defer(recheck)
	task.delay(1, recheck)

	return object
end
