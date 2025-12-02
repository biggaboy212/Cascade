local types = require("@types")

return function(self, properties: types.PopUpButtonProperties): types.PopUpButton
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local userInputService = services.UserInputService
	local tweenService = services.TweenService
	local workspace = services.Workspace
	local guiService = services.GuiService

	local camera = workspace.CurrentCamera

	--// Variables
	local parent = self.__container or self.__instance or self
	local theme = self.Theme.Controls.MenuButton
	local structures = {
		Options = {},
	}

	--// Constants
	local HORIZONTAL_OFFSET = -1
	local VERTICAL_PADDING = 6
	local EDGE_BUFFER = 6

	local SIZE_CONSTRAINT_Y = 239

	--// Functions
	local function resize()
		structures.Menu.AutomaticSize = Enum.AutomaticSize.XY

		task.defer(function()
			local menuHeight = structures.Menu.AbsoluteSize.Y

			if menuHeight >= SIZE_CONSTRAINT_Y then
				structures.Menu.AutomaticSize = Enum.AutomaticSize.X
				structures.Menu.Size = UDim2.fromOffset(0, SIZE_CONSTRAINT_Y)
			else
				structures.Menu.Size = UDim2.fromOffset(0, menuHeight)
				structures.Menu.AutomaticSize = Enum.AutomaticSize.X
			end
		end)
	end

	local function anchor()
		local body = structures.Body
		local menu = structures.Menu

		if not menu or not body then
			return
		end

		local bodyPos = body.AbsolutePosition
		local bodySize = body.AbsoluteSize
		local menuSize = menu.AbsoluteSize
		local viewportSize = camera.ViewportSize

		local desiredX
		if properties.Maximum and properties.Maximum > 1 then
			local anchorElement = structures.PopUpIndicator or body
			local anchorPos = anchorElement.AbsolutePosition
			desiredX = anchorPos.X + HORIZONTAL_OFFSET
		else
			desiredX = bodyPos.X + HORIZONTAL_OFFSET
		end
		
		local desiredY = bodyPos.Y + bodySize.Y + VERTICAL_PADDING
		local maxX = math.max(EDGE_BUFFER, viewportSize.X - EDGE_BUFFER - menuSize.X)
		local maxY = math.max(EDGE_BUFFER, viewportSize.Y - EDGE_BUFFER - menuSize.Y)

		desiredX = math.clamp(desiredX, EDGE_BUFFER, maxX)
		desiredY = math.clamp(desiredY, EDGE_BUFFER, maxY)

		menu.Position = UDim2.new(0, desiredX, 0, desiredY)
	end

	local function option(object, name, index)
		local option = create("TextButton")({
			Name = "Item",
			Size = UDim2.fromScale(1, 0),
			AutoButtonColor = false,
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(0, 122, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Selectable = false,
			Text = "",
			LayoutOrder = index,
			Parent = structures.Menu,

			create("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 3),
				PaddingLeft = UDim.new(0, 7),
				PaddingRight = UDim.new(0, 12),
				PaddingTop = UDim.new(0, 3),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 2),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("ImageLabel")({
				Name = "Checkmark",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Image = "rbxassetid://127464789357538",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 1,
				Size = UDim2.fromOffset(16, 16),
				Visible = false,

				__dynamicKeys = {
					ImageColor3 = self.Theme.Text.Primary[1],
					ImageTransparency = self.Theme.Text.Primary[2],
				},
			}),

			create("Frame")({
				Name = "CheckmarkRepl",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromOffset(16, 16),
				Visible = true,
			}),

			create("TextLabel")({
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				FontFace = Font.new("rbxassetid://12187365364"),
				LayoutOrder = 1,
				RichText = true,
				Text = name,
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 15,
				TextTransparency = 0.15,
				TextTruncate = Enum.TextTruncate.AtEnd,

				__dynamicKeys = {
					TextColor3 = self.Theme.Text.Primary[1],
					TextTransparency = self.Theme.Text.Primary[2],
				},
			}),

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),
		}) :: TextButton
		local label = option:FindFirstChild("Label")
		local checkmark = option:FindFirstChild("Checkmark")

		structures.Options[index] = option.__instance

		option:GetPropertyChangedSignal("GuiState"):Connect(function()
			if not object.Expanded then
				return
			end

			if option.GuiState == Enum.GuiState.Hover then
				option.BackgroundTransparency = self.Theme.Controls.SelectionFocused[2].Value

				label.TextColor3 = self.Theme.Controls.SelectionFocusedAccent[1].Value
				label.TextTransparency = self.Theme.Controls.SelectionFocusedAccent[2].Value

				checkmark.ImageColor3 = self.Theme.Controls.SelectionFocusedAccent[1].Value
				checkmark.ImageTransparency = self.Theme.Controls.SelectionFocusedAccent[2].Value
			else
				option.BackgroundTransparency = 1

				label.TextColor3 = self.Theme.Text.Primary[1].Value
				label.TextTransparency = self.Theme.Text.Primary[2].Value

				checkmark.ImageColor3 = self.Theme.Text.Primary[1].Value
				checkmark.ImageTransparency = self.Theme.Text.Primary[2].Value
			end
		end)

		option.MouseButton1Click:Connect(function()
			if object then
				if object.Maximum and object.Maximum > 1 then
					local current = object.Value or {}
					if typeof(current) ~= "table" then
						current = current and { current } or {}
					end

					local foundIndex = nil
					for i, v in ipairs(current) do
						if v == index then
							foundIndex = i
							break
						end
					end

					if foundIndex then
						table.remove(current, foundIndex)
					else
						if #current < object.Maximum then
							table.insert(current, index)
						else
							table.remove(current, 1)
							table.insert(current, index)
						end
					end

					object.Value = current
				else
					object.Expanded = false
					task.wait(0.2)
					object.Value = index
				end
			end
		end)
	end

	--// UI
	properties = properties or {}
	properties.Maximum = properties.Maximum or 1
	properties.Expanded = properties.Expanded or false

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "PopUpButton",
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Selectable = false,
			Text = "",
			Parent = parent,

			create("UIPadding")({
				Name = "UIPadding",
				PaddingBottom = UDim.new(0, 3),
				PaddingLeft = UDim.new(0, 3),
				PaddingRight = UDim.new(0, 3),
				PaddingTop = UDim.new(0, 3),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 7),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("Frame")({
				Name = "PopUpIndicator",
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Selectable = true,
				Size = UDim2.fromOffset(16, 16),

				__dynamicKeys = {
					BackgroundColor3 = theme.IndicatorBackground[1],
					BackgroundTransparency = theme.IndicatorBackground[2],
				},

				create("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 4),
				}),

				create("ImageLabel")({
					Name = "Indicators",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://89151647333378",
					Size = UDim2.fromScale(1, 1),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Text.Primary[1],
						ImageTransparency = self.Theme.Text.Primary[2],
					},
				}),
			}),

			create("TextLabel")({
				Name = "Label",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				FontFace = Font.new("rbxassetid://12187365364"),
				RichText = true,
				Text = "None",
				TextSize = 15,
				TextTransparency = 0.15,
				TextTruncate = Enum.TextTruncate.AtEnd,

				__dynamicKeys = {
					TextColor3 = self.Theme.Text.Primary[1],
					TextTransparency = self.Theme.Text.Primary[2],
				},
			}),
		})
	) :: TextButton

	--// Initialize
	structures.PopUpIndicator = structures.Body:FindFirstChild("PopUpIndicator") :: Frame
	structures.CurrentTab = structures.Body:FindFirstChild("Label") :: TextLabel

	structures.MenuContainer = create("ScreenGui")({
		Name = "Container",
		IgnoreGuiInset = true,
		ScreenInsets = Enum.ScreenInsets.None,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 201,
		OnTopOfCoreBlur = true,

		create("CanvasGroup")({
			Name = "MenuBody",
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),

			create("ScrollingFrame")({
				Name = "PopUpMenu",
				AutomaticSize = Enum.AutomaticSize.X,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				CanvasSize = UDim2.new(),
				ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
				ScrollBarImageTransparency = 0.5,
				ScrollBarThickness = 3,

				__dynamicKeys = {
					BackgroundColor3 = theme.MenuBackground[1],
					BackgroundTransparency = theme.MenuBackground[2],
				},

				create("UICorner")({
					Name = "UICorner",
					CornerRadius = UDim.new(0, 6),
				}),

				create("UIStroke")({
					Name = "UIStroke",
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = 0.9,
				}),

				create("UIPadding")({
					Name = "UIPadding",
					PaddingBottom = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
				}),

				create("UIListLayout")({
					Name = "UIListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 1),
				}),
			}),
		}),
	}) :: ScreenGui

	structures.MenuBody = structures.MenuContainer:FindFirstChild("MenuBody") :: CanvasGroup
	structures.Menu = structures.MenuBody:FindFirstChild("PopUpMenu") :: ScrollingFrame

	local object
	local bindings = {
		Options = function(value: { [number]: string })
			for _, option in ipairs(structures.Options) do
				option:Destroy()
			end

			for index, _option in ipairs(value) do
				option(object, _option, index)
				resize()
			end
		end,

		Expanded = function(value: boolean)
			local expand = value == true

			if expand then
				structures.MenuContainer.Parent = structures.Body.__instance
			end

			anchor()

			local goal = { GroupTransparency = expand and 0 or 1 }
			local tweenInfo = TweenInfo.new(expand and 0 or 0.4, Enum.EasingStyle.Exponential)
			local tween = tweenService:Create(structures.MenuBody, tweenInfo, goal)

			tween:Play()
			tween.Completed:Connect(function()
				if object.Expanded == false then
					structures.MenuContainer.Parent = nil
				end
			end)
		end,

		Value = function(value)
			local isMulti = object and object.Maximum and object.Maximum > 1

			if isMulti then
				local selMap = {}
				if typeof(value) == "table" then
					for _, v in ipairs(value) do
						selMap[v] = true
					end
				elseif value then
					selMap[value] = true
				end

				local labels = {}
				for idx, opt in ipairs(structures.Options) do
					if selMap[idx] and opt and opt:FindFirstChild("Label") then
						table.insert(labels, opt:FindFirstChild("Label").Text)
					end
				end

				if #labels == 0 then
					structures.CurrentTab.Text = "None"
				else
					structures.CurrentTab.Text = table.concat(labels, ", ")
				end

				for index, option in ipairs(structures.Options) do
					if not option or not option:FindFirstChild("Checkmark") then
						continue
					end

					if selMap[index] then
						option:FindFirstChild("Checkmark").Visible = true
						option:FindFirstChild("CheckmarkRepl").Visible = false
					else
						option:FindFirstChild("Checkmark").Visible = false
						option:FindFirstChild("CheckmarkRepl").Visible = true
					end
				end
			else
				if not value or not structures.Options[value] then
					structures.CurrentTab.Text = "None"
				else
					structures.CurrentTab.Text = structures.Options[value]:FindFirstChild("Label").Text
				end

				for index, option in ipairs(structures.Options) do
					local currentIndex = index == value

					if not option or not option:FindFirstChild("Checkmark") then
						continue
					end

					if not currentIndex then
						option:FindFirstChild("Checkmark").Visible = false
						option:FindFirstChild("CheckmarkRepl").Visible = true -- Scuffed way to do this but 🤷‍♂️
					else
						option:FindFirstChild("CheckmarkRepl").Visible = false
						if not value then
							option:FindFirstChild("Checkmark").Visible = false
						else
							option:FindFirstChild("Checkmark").Visible = true
						end
					end
				end
			end

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "PopUpButton"
	object.Theme = self.Theme
	object.Structures = structures
	object.Option = function(self, name: string?)
		local index = #structures.Options + 1

		option(object, name, index)
		resize()

		table.insert(object.Options, name)

		return structures.Options[index]
	end
	object.Remove = function(self, index: number?)
		if index and structures.Options[index] then
			structures.Options[index]:Destroy()
			object.Options[index] = nil
		end
	end

	binder.Apply(properties, object)

	structures.Body:GetPropertyChangedSignal("AbsolutePosition"):Connect(anchor)
	structures.Body:GetPropertyChangedSignal("AbsoluteSize"):Connect(anchor)
	structures.Menu:GetPropertyChangedSignal("AbsoluteSize"):Connect(anchor)

	userInputService.InputBegan:Connect(function(input)
		if
			object.Expanded
			and (
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			)
		then
			local mouse = userInputService:GetMouseLocation()
			local inset = guiService:GetGuiInset()
			local menuFrame = structures.Menu
			local pos = menuFrame.AbsolutePosition
			local size = menuFrame.AbsoluteSize

			local adjustedMouseY = mouse.Y - inset.Y

			if
				mouse.X < pos.X
				or mouse.X > pos.X + size.X
				or adjustedMouseY < pos.Y
				or adjustedMouseY > pos.Y + size.Y
			then
				object.Expanded = false
			end
		end
	end)

	structures.Body.MouseButton1Click:Connect(function()
		object.Expanded = not object.Expanded
	end)

	return object
end
