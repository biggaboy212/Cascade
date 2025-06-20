local types = require("@types")

return function(self, properties: types.WindowProperties): types.Window
	--// Imports
	local effects = require("@effects")
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	properties = properties or {}
	
	properties.Draggable = properties.Draggable ~= nil and properties.Draggable or true
	properties.Resizable = properties.Resizable ~= nil and properties.Resizable or true
	properties.Title = properties.Title or "Title"
	properties.Description = properties.Description or "Description"
	properties.Dropshadow = properties.Dropshadow ~= nil and properties.Dropshadow or true
	properties.UIBlur = properties.UIBlur ~= nil and properties.UIBlur or true

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Body",
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(850, 530),
			Parent = self.__instance or self,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Sidebar.Color,
				BackgroundTransparency = self.Theme.Controls.Sidebar.Transparency,
			},

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 10),
			}),

			create("UIDragDetector")({
				ActivatedCursorIcon = "rbxasset://0",
				CursorIcon = "rbxasset://0",
				DragUDim2 = UDim2.fromOffset(11, 0),
				SelectionModeDragSpeed = UDim2.fromScale(1, 1),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, -1),
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
							BackgroundTransparency = self.Theme.Controls.Separator.Shadow.Transparency
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
							ImageColor3 = Color3.fromRGB(255, 95, 87),
							Size = UDim2.fromOffset(12, 12),

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.8,
								Size = UDim2.fromScale(1, 1),
							}),

							create("ImageLabel")({
								Name = "Icon",
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94781753558308",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.5,
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(1, 1),
								Visible = false,
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
							ImageColor3 = Color3.fromRGB(254, 188, 46),
							LayoutOrder = 1,
							Size = UDim2.fromOffset(12, 12),

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.8,
								Size = UDim2.fromScale(1, 1),
							}),

							create("ImageLabel")({
								Name = "Icon",
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://119587944519839",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.5,
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(1, 1),
								Visible = false,
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
							ImageColor3 = Color3.fromRGB(40, 200, 64),
							LayoutOrder = 2,
							Size = UDim2.fromOffset(12, 12),

							create("ImageLabel")({
								Name = "Stroke",
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://94763505860483",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.8,
								Size = UDim2.fromScale(1, 1),
							}),

							create("ImageLabel")({
								Name = "Icon",
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 1,
								BorderColor3 = Color3.fromRGB(0, 0, 0),
								BorderSizePixel = 0,
								Image = "rbxassetid://114376524082699",
								ImageColor3 = Color3.fromRGB(0, 0, 0),
								ImageTransparency = 0.5,
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(1, 1),
								Visible = false,
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
					}),

					create("UIPadding")({
						Name = "UIPadding",
						PaddingLeft = UDim.new(0, 10),
						PaddingRight = UDim.new(0, 10),
						PaddingBottom = UDim.new(0, 10),
					}),
				}),
			}),

			create "Frame" {
				Name = "Separator",
				AnchorPoint = Vector2.new(1, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Position = UDim2.fromScale(1, 0),
				Size = UDim2.new(0, 1, 1, 0),
				__dynamicKeys = {
					BackgroundColor3 = self.Theme.Controls.Separator.Background.Color,
					BackgroundTransparency = self.Theme.Controls.Separator.Background.Transparency
				},
			},

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

				create("Frame")({
					Name = "TopArea",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 52),
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Dragger = structures.Body:FindFirstChild("UIDragDetector") :: UIDragDetector
	structures.Handles = structures.Body:FindFirstChild("Handles") :: Folder
	structures.Sidebar = structures.Body:FindFirstChild("Sidebar") :: Frame
	structures.SidebarList = structures.Sidebar:FindFirstChild("SidebarList") :: Frame
	structures.Toolbar = structures.Sidebar:FindFirstChild("Toolbar") :: Frame
	structures.WindowControls = structures.Toolbar:FindFirstChild("WindowControls") :: Frame

	structures.Dragger.BoundingUI = structures.Handles:FindFirstChild("TopArea")

	local object = binder.Wrap(properties, {
		Minimized = function(value: boolean)
			
		end,
		Maximized = function(value: boolean)
			
		end,
		Draggable = function(value: boolean)
			structures.Dragger.Enabled = value
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

			if value then
				structures.BlurModel = effects.UIBlur(structures.Body)
			end
		end,
	}, structures.Body)

	object.Type = "Window"
	object.Theme = self.Theme
	object.Structures = structures
	object.Tabs = {}
	object.Pages = {}

	binder.Apply(properties, object)

	return object
end
