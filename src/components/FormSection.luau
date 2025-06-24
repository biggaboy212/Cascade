local types = require("@types")

return function(self, properties: types.FormSectionProperties): types.FormSection
	--// Imports
	local creator = require("@modules/creator")
	local binder = require("@modules/binder")

	local titleStack = require("@structures/TitleStack")

	--// References
	local create = creator.Create

	--// Variables
	local parent = self.__container or self.__instance or self
	local structures = titleStack(self)

	--// UI
	properties = properties or {}
	properties.Title = properties.Title or "Title"

	local formSections, instance = parent:FindFirstChild("FormSections"), true

	if not formSections then
		instance = false
		formSections = create("Frame")({
			Name = "FormSections",
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = parent,

			create("UIListLayout")({
				Name = "UIListLayout",
				Padding = UDim.new(0, 25),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})
	end

	local section = create("Frame")({
		Name = "FormSection",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = instance and formSections or formSections.__instance,

		create("UIListLayout")({
			Name = "UIListLayout",
			Padding = UDim.new(0, 12),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	structures.Body.Parent = section.__instance

	--// Initialize
	structures.Padding.PaddingLeft = UDim.new(0, 8)
	structures.Padding.PaddingRight = UDim.new(0, 8)

	structures.Title.FontFace = Font.new(structures.Title.FontFace.Family, Enum.FontWeight.Bold)
	structures.Body.LayoutOrder = -1

	local object = binder.Wrap(properties, {
		Title = function(value: string)
			structures.Title.Text = value
		end,
		Subtitle = function(value: string)
			structures.Subtitle.Visible = true
			structures.Subtitle.Text = value
		end,
	}, section)

	object.Type = "FormSection"
	object.Theme = self.Theme
	object.Structures = structures
	object.__container = section.__instance

	binder.Apply(properties, object)

	return object
end
