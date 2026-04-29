local types = require("@types")

return function(self, properties: types.TabProperties): types.Tab
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")
	local Page = require("@components/Page")

	--// References
	local create = creator.Create
	local window = self.Type == "Window" and self or self.__window

	--// Variables
	local parent = self.Type == "Window" and self.Structures.SidebarList
		or self.Type == "Tab" and self.__instance.Parent
		or self.__instance
		or self
	local structures = {}

	--// UI
	properties = properties or {}

	properties.Title = properties.Title or "Label"
	properties.Indentation = properties.Indentation or 0
	properties.Selected = properties.Selected == true

	structures.Body = binder.Apply(
		properties,
		create("TextButton")({
			Name = "SidebarItem",
			AutoButtonColor = false,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			LayoutOrder = window.Tabs and #window.Tabs or 1,
			Size = UDim2.new(1, 0, 0, 28),
			Text = "",
			TextColor3 = Color3.fromRGB(0, 0, 0),
			TextSize = 14,
			Parent = parent,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.SelectionFocused[1],
				BackgroundTransparency = self.Theme.Controls.SelectionFocused[2],
			},
			__contextKeys = {
				BackgroundTransparency = function()
					return properties.Selected and self.Theme.Controls.SelectionFocused[2].Value or 1
				end,
			},

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 5),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
				Padding = UDim.new(0, 14),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),

			create("UIPadding")({
				Name = "UIPadding",
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 8),
			}),

			create("Frame")({
				Name = "Leading",
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -34, 0, 0),

				create("TextLabel")({
					Name = "Title",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					FontFace = Font.new("rbxassetid://12187365364"),
					LayoutOrder = 2,
					LineHeight = 0,
					RichText = true,
					Size = UDim2.new(1, -22, 0, 20),
					TextSize = 15,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,

					__dynamicKeys = {
						TextColor3 = self.Theme.Text.SelectionPrimary[1],
						TextTransparency = self.Theme.Text.SelectionPrimary[2],
					},
					__contextKeys = {
						TextColor3 = function()
							return properties.Selected and self.Theme.Text.SelectionPrimary[1].Value
								or self.Theme.Text.Primary[1].Value
						end,
						TextTransparency = function()
							return properties.Selected and self.Theme.Text.SelectionPrimary[2].Value
								or self.Theme.Text.Primary[2].Value
						end,
					},
				}),

				create("UIListLayout")({
					Name = "UIListLayout",
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),

				create("ImageLabel")({
					Name = "Symbol",
					Visible = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Image = "rbxassetid://127049167227557",
					LayoutOrder = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(20, 20),

					__dynamicKeys = {
						ImageColor3 = self.Theme.Controls.Selection[1],
						ImageTransparency = self.Theme.Controls.Selection[2],
					},
					__contextKeys = {
						ImageColor3 = function()
							return properties.Selected and self.Theme.Text.SelectionPrimary[1].Value
								or self.Theme.Controls.Selection[1].Value
						end,
						ImageTransparency = function()
							return properties.Selected and self.Theme.Text.SelectionPrimary[2].Value
								or self.Theme.Controls.Selection[2].Value
						end,
					},
				}),
			}),

			create("Frame")({
				Name = "Trailing",
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				BorderSizePixel = 0,
				LayoutOrder = 1,
				Size = UDim2.fromOffset(20, 16),
			}),
		})
	) :: TextButton

	--// Initialize
	structures.Trailing = structures.Body:FindFirstChild("Trailing") :: Frame
	structures.Leading = structures.Body:FindFirstChild("Leading") :: Frame
	structures.Title = structures.Leading:FindFirstChild("Title") :: TextLabel
	structures.Symbol = structures.Leading:FindFirstChild("Symbol") :: ImageLabel
	structures.Padding = structures.Body:FindFirstChild("UIPadding") :: UIPadding

	local pageComponent = nil

	if properties and properties.Page then
		if type(properties.Page) == "table" and properties.Page.Type == "Page" then
			pageComponent = properties.Page
			structures.Page = pageComponent.Structures.Page
		else
			structures.Page = properties.Page
		end
	else
		pageComponent = Page(self, properties and properties.PageProperties)
		structures.Page = pageComponent.Structures.Page
	end

	local object
	object = binder.Wrap(properties, {
		Title = function(name: string)
			structures.Title.Text = name
		end,
		Icon = function(icon: string?)
			structures.Symbol.Visible = icon and true or false
			if icon then
				structures.Symbol.Image = icon
			end
		end,
		Indentation = function(indentation: number)
			structures.Padding.PaddingLeft += UDim.new(0, (11 * indentation))
		end,
		Selected = function(selected: boolean)
			if selected then
				for _, tab: types.Tab in pairs(window.Tabs) do
					if tab.__container == object.__container then
						continue
					end

					tab.Selected = false
				end
			end

			structures.Body.Transparency = selected and self.Theme.Controls.SelectionFocused[2].Value or 1

			structures.Title.TextColor3 = selected and self.Theme.Text.SelectionPrimary[1].Value
				or self.Theme.Text.Primary[1].Value
			structures.Title.TextTransparency = selected and self.Theme.Text.SelectionPrimary[2].Value
				or self.Theme.Text.Primary[2].Value

			structures.Symbol.ImageColor3 = selected and self.Theme.Text.SelectionPrimary[1].Value
				or self.Theme.Controls.Selection[1].Value
			structures.Symbol.ImageTransparency = selected and self.Theme.Text.SelectionPrimary[2].Value
				or self.Theme.Controls.Selection[2].Value

			structures.Page.Parent = selected and window and window.__container or nil
		end,
	}, structures.Body)

	object.Navigate = function(self, targetPage: types.Page)
		if not targetPage or type(targetPage) ~= "table" or targetPage.Type ~= "Page" then
			warn("Tab:Navigate expects a Page component.")
			return
		end

		local newPageStructure = targetPage.Structures.Page

		if object.Selected and window and window.__container then
			if structures.Page then
				structures.Page.Parent = nil
			end
			newPageStructure.Parent = window.__container
		end

		structures.Page = newPageStructure

		pageComponent = targetPage
	end

	object.Type = "Tab"
	object.Theme = self.Theme
	object.Structures = structures
	object.__container = structures.Page.__instance or structures.Page
	object.__window = self.__window

	binder.Apply(properties, object)

	if window then
		table.insert(window.Tabs, object)

		if object.Selected then
			window.addToHistory(object.__container)
		end

		structures.Body.MouseButton1Click:Connect(function()
			if object.Selected then
				return
			end

			object.Selected = true
			
				window.addToHistory(object.__container)
		end)
	end

	if self.Type == "Tab" then
		object.Indentation = self.Indentation + 1
	end

	return object
end
