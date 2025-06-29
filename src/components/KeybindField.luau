local types = require("@types")

return function(self, properties: types.KeybindFieldProperties): types.KeybindFieldProperties
	--// Imports
	local binder = require("@modules/binder")
	local services = require("@modules/services")

	--// References
	local userInputService = services.UserInputService

	--// Variables
	local structures = require("@structures/TextField")(self)

	--// UI
	properties = properties or {}
	properties.Placeholder = properties.Placeholder or "Press a key"

	--// Initialize
	structures.Field.TextXAlignment = Enum.TextXAlignment.Right
	structures.Field.TextEditable = false
	structures.Body.Parent = self.__container or self.__instance or self
	structures.Body.AutomaticSize = Enum.AutomaticSize.XY
	structures.Body.Size = UDim2.fromOffset(0, 23)
	structures.Field.Size = UDim2.fromOffset(0, 23)
	structures.Corner.CornerRadius = UDim.new(0, 6)

	local object
	object = binder.Wrap(properties, {
		Placeholder = function(value: string)
			structures.Field.PlaceholderText = value
		end,
		Value = function(value: Enum.KeyCode)
			structures.Field.Text = value.Name

			if properties.ValueChanged then
				properties.Value = value
				task.spawn(properties.ValueChanged, object, value)
			end
		end,
	}, structures.Body)

	userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if input.KeyCode == properties.Value and properties.BindPressed then
			properties.BindPressed(object, input.KeyCode, false, gameProcessedEvent)
		end
	end)

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		if structures.Field:IsFocused() then
			object.Value = input.KeyCode
			structures.Field:ReleaseFocus()
		elseif input.KeyCode == properties.Value and properties.BindPressed then
			properties.BindPressed(object, input.KeyCode, true, gameProcessedEvent)
		end
	end)

	object.Type = "KeybindField"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
