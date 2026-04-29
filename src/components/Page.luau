local types = require("@types")

return function(self, properties: types.PageProperties)
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	properties = properties or {}

	local structures = {}

	structures.Page = binder.Apply(
		properties,
		create("ScrollingFrame")({
			Name = "ContentList",
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(),
			ClipsDescendants = false,
			ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
			ScrollBarImageTransparency = 0.6,
			ScrollBarThickness = 7,
			Size = UDim2.fromScale(1, 1),

			create("UIListLayout")({
				Name = "UIListLayout",
				Padding = UDim.new(0, 9),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("UIPadding")({
				Name = "Margins",
				PaddingBottom = UDim.new(0, 17),
				PaddingLeft = UDim.new(0, 17),
				PaddingRight = UDim.new(0, 17),
				PaddingTop = UDim.new(0, 17),
			}),
		})
	) :: ScrollingFrame

	local function refreshPadding()
		local scoped = {}

		for _, instance in ipairs(__SH.COMPINDEXES) do
			if instance.Parent == structures.Page.__instance then
				table.insert(scoped, instance)
			end
		end

		for i, child in ipairs(scoped) do
			if child.Name == "PageSection" then
				local prev = scoped[i - 1]
				local padding = child:FindFirstChildOfClass("UIPadding")
				
				if padding then
					if prev and prev.Name ~= "PageSection" then
						padding.PaddingTop = UDim.new(0, 18)
					else
						padding.PaddingTop = UDim.new(0, 0)
					end
				end
			end
		end
	end

	structures.Page.ChildAdded:Connect(refreshPadding)
	structures.Page.ChildRemoved:Connect(refreshPadding)

	refreshPadding()

	local object = binder.Wrap(properties, {
		Parent = function(p)
			structures.Page.Parent = p
		end,
	}, structures.Page)

	object.Type = "Page"
	object.Theme = self.Theme
	object.Structures = structures
	if self.__window then
		object.__window = self.__window
	end
	object.__container = structures.Page.__instance or structures.Page

	return object
end
