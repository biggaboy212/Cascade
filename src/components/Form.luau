local types = require("@types")

return function(self, properties: types.Frame): types.Form
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local structures = {}
	local queue = {}
	local entries = {}

	--// UI
	properties = properties or {}

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Form",
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 0),
			Parent = parent,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.View[1],
				BackgroundTransparency = self.Theme.Controls.View[2],
			},

			create("UIListLayout")({
				Name = "UIListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("UIPadding")({
				Name = "Margins",
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			}),

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 6),
			}),

			create("UIStroke")({
				Name = "UIStroke",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,

				__dynamicKeys = {
					Color = self.Theme.Controls.ViewBorder[1],
					Transparency = self.Theme.Controls.ViewBorder[2],
				},
			}),
		})
	) :: Frame

	--// Initialize
	local object = binder.Wrap(properties, {}, structures.Body)

	object.Type = "Form"
	object.Theme = self.Theme
	object.Structures = structures

	local function updateDivs()
		for i, entry in ipairs(entries) do
			local currentVisible = entry.section.Visible
			local nextEntry = entries[i + 1]
			local nextVisible = nextEntry and nextEntry.section.Visible

			entry.divider.Visible = currentVisible and nextVisible == true
		end
	end

	structures.Body.ChildAdded:Connect(function(child)
		if child:IsA("Frame") and child:FindFirstChild("LayoutIgnore") then
			local divider = child.LayoutIgnore:FindFirstChild("Divider")

			if divider then
				table.insert(queue, divider)
				table.insert(entries, { section = child, divider = divider })

				child:GetPropertyChangedSignal("Visible"):Connect(function()
					updateDivs()
				end)

				updateDivs()
			end
		end
	end)

	binder.Apply(properties, object)

	return object
end
