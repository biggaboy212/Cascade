local types = require("@types")

return function(self, properties: types.PageSectionProperties): types.PageSection
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

	local section = create("Frame")({
		Name = "PageSection",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = parent,

		create("UIListLayout")({
			Name = "UIListLayout",
			Padding = UDim.new(0, 12),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		create("UIPadding")({
			PaddingBottom = UDim.new(0, 18)
		}),
	})

	structures.Body.Parent = section.__instance

	--// Initialize
	structures.Padding.PaddingLeft = UDim.new(0, 8)
	structures.Padding.PaddingRight = UDim.new(0, 8)

	structures.Title.FontFace = Font.new(structures.Title.FontFace.Family, Enum.FontWeight.SemiBold)
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

	object.Type = "PageSection"
	object.Theme = self.Theme
	object.Structures = structures
	object.__container = section.__instance

	binder.Apply(properties, object)

	return object
end
