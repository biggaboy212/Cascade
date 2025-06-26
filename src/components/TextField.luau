local types = require("@types")

return function(self, properties: types.TextFieldProperties): types.TextField
	--// Imports
	local binder = require("@modules/binder")

	--// Variables
	local structures = require("@structures/TextField")(self)

	--// UI
	properties = properties or {}
	properties.Value = properties.Value ~= nil and properties.Value or ""
	properties.Placeholder = properties.Placeholder or "Placeholder"

	--// Initialize
	structures.Field.TextTruncate = Enum.TextTruncate.AtEnd
	structures.Field.TextXAlignment = Enum.TextXAlignment.Right
	structures.Body.Parent = self.__container or self.__instance or self

	local object
	object = binder.Wrap(properties, {
		Placeholder = function(value: string)
			structures.Field.PlaceholderText = value
		end,
		Value = function(value: string)
			structures.Field.Text = value

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}, structures.Body)

	structures.Field.Focused:Connect(function()
		structures.Body.AutomaticSize = Enum.AutomaticSize.XY
	end)

	structures.Field.FocusLost:Connect(function()
		structures.Body.AutomaticSize = Enum.AutomaticSize.None

		if object.Value ~= structures.Field.Text then
			object.Value = structures.Field.Text
		end
	end)

	object.Type = "TextField"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	structures.Field:GetPropertyChangedSignal("Text"):Connect(function()
		if properties.TextChanged then
			task.spawn(properties.TextChanged, object, structures.Field.Text or "")
		end
	end)

	return object
end
