local types = require("@types")

return function(self, properties: types.TitleStackProperties): types.TitleStack
	--// Imports
	local binder = require("@modules/binder")

	local titleStack = require("@structures/TitleStack")

	--// Variables
	local structures = titleStack(self)

	--// UI
	properties = properties or {}
	properties.Title = properties.Title or "Title"

	structures.Body.Parent = self.__container or self.__instance or self

	--// Initialize
	local object = binder.Wrap(properties, {
		Title = function(value: string)
			structures.Title.Text = value
		end,
		Subtitle = function(value: string)
			structures.Subtitle.Visible = true
			structures.Subtitle.Text = value
		end,
	}, structures.Body)

	object.Type = "TitleStack"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
