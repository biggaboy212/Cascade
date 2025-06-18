--// Imports
local creator = require("@modules/creator")

--// References
local create = creator.Create

--// Initialize
return function(parent: GuiObject, color: Color3, transparency: number, spread: number)
	local function gaussian(n, sigma)
		local weights = {}
		local sum = 0

		for i = -n, n do
			local weight = math.exp(-((i ^ 2) / (2 * sigma ^ 2)))
			table.insert(weights, weight)
			sum += weight
		end

		for i = 1, #weights do
			weights[i] = (weights[i] / sum) * (1 - transparency)
		end

		return weights
	end

	local sigma = spread / 2
	local weights = gaussian(spread, sigma)
	local layers = create("Folder")({
		Name = "ShadowLayers",
	})

	local function changed()
		layers:ClearAllChildren()
		layers.Parent = parent.Parent

		if not parent.Visible then
			return
		end

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
	end

	changed()

    parent:GetPropertyChangedSignal("Visible"):Connect(changed)
	parent:GetPropertyChangedSignal("ZIndex"):Connect(changed)
	parent:GetPropertyChangedSignal("Position"):Connect(changed)
	parent:GetPropertyChangedSignal("Size"):Connect(changed)
	parent:GetPropertyChangedSignal("AnchorPoint"):Connect(changed)
	parent.ChildAdded:Connect(changed)
	parent.ChildRemoved:Connect(changed)
	parent.AncestryChanged:Connect(changed)
    parent.Destroying:Connect(function()
		layers:Destroy()
	end)

	return layers
end
