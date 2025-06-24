local types = require("@types")

return function(self, properties: types.SectionProperties): types.Section
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local create = creator.Create

	local tweenService = services.TweenService

	--// Variables
	local parent = self.Type == "Window" and self.Structures.SidebarList or self.__instance or self
	local structures = {}

	--// Functions
	local function watchAutosize(structure: Frame, connections: { RBXScriptConnection }, update: (...any) -> (), ...)
		local args = table.pack(...)

		for _, child in ipairs(structure:GetChildren()) do
			if child:IsA("GuiObject") then
				table.insert(
					connections,
					child:GetPropertyChangedSignal("AbsoluteSize"):Connect(function(...)
						update(table.unpack(args, 1, args.n))
					end)
				)
				table.insert(
					connections,
					child:GetPropertyChangedSignal("Visible"):Connect(function(...)
						update(table.unpack(args, 1, args.n))
					end)
				)
			end
		end

		table.insert(
			connections,
			structure.ChildAdded:Connect(function(child)
				if child:IsA("GuiObject") then
					table.insert(
						connections,
						child:GetPropertyChangedSignal("AbsoluteSize"):Connect(function(...)
							update(table.unpack(args, 1, args.n))
						end)
					)
					table.insert(
						connections,
						child:GetPropertyChangedSignal("Visible"):Connect(function(...)
							update(table.unpack(args, 1, args.n))
						end)
					)
					update(table.unpack(args, 1, args.n))
				end
			end)
		)

		table.insert(
			connections,
			structure.ChildRemoved:Connect(function(...)
				update(table.unpack(args, 1, args.n))
			end)
		)
	end

	--// UI
	properties = properties or {}

	properties.Title = properties.Title or "Section Title"
	properties.Disclosure = properties.Disclosure ~= false
	properties.Expanded = properties.Expanded ~= false

	structures.SidebarGroup = binder.Apply(
		properties,
		create("TextButton")({
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			ClipsDescendants = true,
			Size = UDim2.new(1, 0, 0, 23),
			Text = "",
			AutoButtonColor = false,
			Parent = parent,

			create("UIListLayout")({
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
			}),

			create("Frame")({
				Name = "SectionHeader",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.fromScale(1, 0),

				create("Frame")({
					Name = "Disclosure",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
					LayoutOrder = 1,
					Size = UDim2.fromOffset(13, 14),
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14,

					create("ImageLabel")({
						Name = "DisclosureImage",
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						Image = "rbxassetid://115960806571685",
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(11, 7),
						__dynamicKeys = {
							ImageColor3 = self.Theme.Text.Tertiary[1],
							ImageTransparency = self.Theme.Text.Tertiary[2],
						},
					}),
				}),

				create("UIListLayout")({
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),

				create("UIPadding")({
					PaddingBottom = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 3),
				}),

				create("TextLabel")({
					Name = "Title",
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
					LineHeight = 0,
					RichText = true,
					Size = UDim2.fromOffset(0, 14),
					Text = "Section Title",
					TextSize = 12,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					__dynamicKeys = {
						TextColor3 = self.Theme.Text.Tertiary[1],
						TextTransparency = self.Theme.Text.Tertiary[2],
					},
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Layout = structures.SidebarGroup:FindFirstChild("UIListLayout") :: UIListLayout
	structures.SectionHeader = structures.SidebarGroup:FindFirstChild("SectionHeader") :: Frame
	structures.Title = structures.SectionHeader:FindFirstChild("Title") :: TextLabel
	structures.Disclosure = structures.SectionHeader:FindFirstChild("Disclosure") :: TextButton
	structures.DisclosureImage = structures.Disclosure:FindFirstChild("DisclosureImage") :: ImageLabel

	local connections = {}
	local bindings = {
		Title = function(name: string)
			structures.Title.Text = name
		end,
		Disclosure = function(state: boolean)
			structures.Disclosure.Visible = state
			structures.SidebarGroup.Active = state
		end,
		Expanded = function(state: boolean, tween: boolean?)
			tween = (tween == nil and true) or false

			local sidebarGroup = structures.SidebarGroup.__instance
			local disclosureImage = structures.DisclosureImage

			sidebarGroup.AutomaticSize = Enum.AutomaticSize.None

			for index, connection: RBXScriptConnection in pairs(connections) do
				connection:Disconnect()
				table.remove(connections, index)
			end

			local updateSize = function(useTween: boolean)
				local targetHeight = state and structures.Layout.AbsoluteContentSize.Y or 23
				local tween = tweenService:Create(
					sidebarGroup,
					TweenInfo.new(useTween and 0.35 or 0, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
					{
						Size = UDim2.new(1, 0, 0, targetHeight),
					}
				)
				tween:Play()
			end

			if state then
				watchAutosize(sidebarGroup, connections, updateSize, false)
			end

			updateSize(tween)
			tweenService
				:Create(
					disclosureImage,
					TweenInfo.new(tween and 0.35 or 0, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
					{
						Rotation = state and 0 or -90,
					}
				)
				:Play()
		end,
	}
	local object = binder.Wrap(properties, bindings, structures.SidebarGroup)

	object.Type = "Section"
	object.Theme = self.Theme
	object.Structures = structures
	object.__window = self

	structures.SidebarGroup.MouseButton1Click:Connect(function()
		if not properties.Disclosure then
			return
		end
		
		object.Expanded = not object.Expanded
	end)

	binder.Apply(properties, object)

	return object
end
