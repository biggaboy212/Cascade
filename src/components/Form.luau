local types = require("@types")

return function(self, properties: types.Frame): types.Form
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}
	local queue = {}

	--// UI
	properties = properties or {}

	local parent = self.__container or self.__instance or self

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Form",
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Position = UDim2.fromScale(0.0164, 0.00228),
			Size = UDim2.fromScale(1, 0),
			Parent = parent,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.View.Color,
				BackgroundTransparency = self.Theme.Controls.View.Transparency,
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
					Color = self.Theme.Controls.ViewBorder.Color,
					Transparency = self.Theme.Controls.ViewBorder.Transparency,
				},
			}),
		})
	) :: Frame

	--// Initialize
	local object = binder.Wrap(properties, {}, structures.Body)

	object.Type = "Form"
	object.Theme = self.Theme
	object.Structures = structures

	structures.Body.ChildAdded:Connect(function(child)
		for _, divider: Frame in pairs(queue) do
			divider.Visible = true
		end
		
		if child:IsA("Frame") and child:FindFirstChild("LayoutIgnore") and child:FindFirstChild("LayoutIgnore"):FindFirstChild("Divider") then
			local divider = child:FindFirstChild("LayoutIgnore"):FindFirstChild("Divider")
			table.insert(queue, divider)
		end
	end)

	binder.Apply(properties, object)

	return object
end
