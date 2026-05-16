local types = require("@types")

return function(self, properties: types.TextFieldProperties): types.TextField
	--// Imports
	local binder = require("@modules/binder")
	local interaction = require("@modules/interaction")

	--// Variables
	local structures = require("@structures/TextField")(self)

	--// UI
	properties = properties or {}
	properties.Value = properties.Value ~= nil and properties.Value or ""
	properties.Placeholder = properties.Placeholder or "Placeholder"
	properties.Disabled = properties.Disabled == true
	local initialized = false

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

			if properties.ValueChanged and initialized then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
		Disabled = function(value: boolean)
			structures.Field.TextEditable = not value
			interaction.setInteractable(structures.Field, not value)
			if value then
				structures.Field.TextTransparency = 0.55
			elseif structures.Field.Text == "" then
				structures.Field.TextTransparency = self.Theme.Text.Tertiary[2].Value
				structures.Field.PlaceholderColor3 = self.Theme.Text.Tertiary[1].Value
			else
				structures.Field.TextTransparency = self.Theme.Text.Primary[2].Value
				structures.Field.TextColor3 = self.Theme.Text.Primary[1].Value
			end
		end,
	}, structures.Body)

	structures.Field.Focused:Connect(function()
		if interaction.isDisabled(properties) then
			structures.Field:ReleaseFocus()
			return
		end

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
	initialized = true
	bindings.Disabled(properties.Disabled)

	structures.Field:GetPropertyChangedSignal("Text"):Connect(function()
		if interaction.isDisabled(properties) then
			return
		end

		if properties.TextChanged then
			task.spawn(properties.TextChanged, object, structures.Field.Text or "")
		end
	end)

	return object
end
