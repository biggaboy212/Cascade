local interaction = {}

function interaction.isDisabled(properties): boolean
	return properties and properties.Disabled == true
end

function interaction.setInteractable(instance: Instance?, enabled: boolean)
	if not instance then
		return
	end

	pcall(function()
		instance.Active = enabled
	end)
	pcall(function()
		instance.Selectable = enabled
	end)
	pcall(function()
		instance.Interactable = enabled
	end)
end

function interaction.connectActivate(button: GuiButton, callback: () -> ())
	local connections = {}

	local function activate()
		callback()
	end

	if button.Activated then
		table.insert(connections, button.Activated:Connect(activate))
	else
		table.insert(connections, button.MouseButton1Click:Connect(activate))
	end

	return connections
end

function interaction.disconnectAll(connections: { RBXScriptConnection? })
	for _, connection in ipairs(connections) do
		if connection then
			connection:Disconnect()
		end
	end

	table.clear(connections)
end

function interaction.clampNumber(value: number?, minimum: number?, maximum: number?): number
	local resolved = tonumber(value) or minimum or 0
	local min = minimum or resolved
	local max = maximum or resolved

	if max < min then
		min, max = max, min
	end

	return math.clamp(resolved, min, max)
end

function interaction.validRange(minimum: number?, maximum: number?): (number, number)
	local min = tonumber(minimum) or 0
	local max = tonumber(maximum) or min

	if max < min then
		warn("Cascade: received Maximum below Minimum; swapping the range.")
		min, max = max, min
	end

	return min, max
end

return interaction
