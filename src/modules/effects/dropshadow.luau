local creator = require("@modules/creator")
local create = creator.Create

return function(parent: GuiObject, color: Color3, transparency: number, spread: number, overrideParent: Instance?)
	local function gaussian(n, sigma)
		local weights, sum = {}, 0

		for i = -n, n do
			local weight = math.exp(-((i ^ 2) / (2 * sigma ^ 2)))
			weights[#weights + 1] = weight
			sum += weight
		end

		for i = 1, #weights do
			weights[i] = (weights[i] / sum) * (1 - transparency)
		end

		return weights
	end

	local sigma = spread / 2
	local weights = gaussian(spread, sigma)
	local layers = create("Folder")({ Name = "ShadowLayers" })
	local enabled = true

	local lastState = {
		Visible = nil,
		Size = nil,
		Position = nil,
		ZIndex = nil,
		AnchorPoint = nil,
	}

	local pendingUpdate = false
	local function scheduleUpdate(overrideCheck: boolean?)
		if pendingUpdate or not enabled then return end
		pendingUpdate = true

		task.defer(function()
			pendingUpdate = false

			if not parent or not parent.Parent then
				layers:Destroy()
				return
			end

			local changedVisible = parent.Visible ~= lastState.Visible
			local changedSize = parent.AbsoluteSize ~= lastState.Size
			local changedPos = parent.Position ~= lastState.Position
			local changedZ = parent.ZIndex ~= lastState.ZIndex
			local changedAnchor = parent.AnchorPoint ~= lastState.AnchorPoint

			if not (changedVisible or changedSize or changedPos or changedZ or changedAnchor) and not overrideCheck then
				return
			end

			lastState.Visible = parent.Visible
			lastState.Size = parent.AbsoluteSize
			lastState.Position = parent.Position
			lastState.ZIndex = parent.ZIndex
			lastState.AnchorPoint = parent.AnchorPoint

			layers:ClearAllChildren()
			layers.Parent = overrideParent or parent.Parent

			if not parent.Visible then return end

			for i, opacity in ipairs(weights) do
				local index = i - math.floor(#weights / 2)
				local offsetAmount = math.abs(index) - 1

				local layer = create("Frame")({
					Name = `Layer{i}`,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = parent.ZIndex - 1,
					AnchorPoint = parent.AnchorPoint,
					Position = parent.Position,
					Size = UDim2.fromOffset(
						parent.AbsoluteSize.X + (offsetAmount * 2),
						parent.AbsoluteSize.Y + (offsetAmount * 2)
					),
					Parent = layers.__instance,

					create("UIStroke")({
						Name = "UIStroke",
						Color = color,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 1 - opacity,
					}),
				})

				local corner = parent:FindFirstChildOfClass("UICorner")
				if corner then
					corner:Clone().Parent = layer.__instance
				end
			end
		end)
	end

	local function connectSignals()
		local props = { "Visible", "ZIndex", "Position", "Size", "AnchorPoint" }
		for _, prop in ipairs(props) do
			parent:GetPropertyChangedSignal(prop):Connect(scheduleUpdate)
		end

		parent.ChildAdded:Connect(function()
			scheduleUpdate()
		end)
		parent.ChildRemoved:Connect(function()
			scheduleUpdate()
		end)
		parent.AncestryChanged:Connect(function()
			scheduleUpdate()
		end)
	end

	parent.Destroying:Connect(function()
		layers:Destroy()
	end)

	connectSignals()
	scheduleUpdate()

	return {
		Layers = layers, 
		SetEnabled = function(value)
			enabled = value

			if not value then
				layers:ClearAllChildren()
			else
				scheduleUpdate(true)
			end
		end
	}
end
