local services = require("@modules/services")
local tweenService = services.TweenService

local canvasFader = {}

canvasFader.BypassCanvasGroup = false

function canvasFader.FadeOut(object: GuiObject, fadeInfo: TweenInfo, toTransparency: number, destroyOnComplete: boolean)
	if canvasFader.BypassCanvasGroup then
		local tween = tweenService:Create(object, fadeInfo, {
			BackgroundTransparency = toTransparency,
		})

		for _, desc in pairs(object:GetDescendants()) do
			if desc:IsA("TextLabel") or desc:IsA("TextButton") then
				tweenService:Create(desc, fadeInfo, { TextTransparency = toTransparency }):Play()
				if desc.BackgroundTransparency < 1 then
					tweenService:Create(desc, fadeInfo, { BackgroundTransparency = toTransparency }):Play()
				end
			elseif desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
				tweenService:Create(desc, fadeInfo, { ImageTransparency = toTransparency }):Play()
				if desc.BackgroundTransparency < 1 then
					tweenService:Create(desc, fadeInfo, { BackgroundTransparency = toTransparency }):Play()
				end
			elseif desc:IsA("UIStroke") then
				tweenService:Create(desc, fadeInfo, { Transparency = toTransparency }):Play()
			end
		end

		tween:Play()
		tween.Completed:Wait()

		if destroyOnComplete then
			object:Destroy()
		end

		return
	end

	local originalParent = object.Parent
	local originalPosition = object.Position
	local originalSize = object.Size
	local originalZIndex = object.ZIndex

	local canvas = Instance.new("CanvasGroup")
	canvas.Name = object.Name .. "_Fader"
	canvas.BackgroundTransparency = 1
	canvas.Position = originalPosition
	canvas.Size = originalSize
	canvas.ZIndex = originalZIndex
	canvas.GroupTransparency = 0
	canvas.Parent = originalParent

	object.Position = UDim2.fromScale(0, 0)
	object.Size = UDim2.fromScale(1, 1)
	object.Parent = canvas

	local tween = tweenService:Create(canvas, fadeInfo, {
		GroupTransparency = toTransparency,
	})

	tween:Play()
	tween.Completed:Wait()

	if destroyOnComplete then
		canvas:Destroy()
	else
		object.Position = originalPosition
		object.Size = originalSize
		object.Parent = originalParent
		canvas:Destroy()
	end
end

function canvasFader.FadeIn(object: GuiObject, fadeInfo: TweenInfo, targetTransparency: number)
	if canvasFader.BypassCanvasGroup then
		local tween = tweenService:Create(object, fadeInfo, {
			BackgroundTransparency = targetTransparency,
		})
		tween:Play()
		return
	end

	local originalParent = object.Parent
	local originalPosition = object.Position
	local originalSize = object.Size
	local originalZIndex = object.ZIndex

	local canvas = Instance.new("CanvasGroup")
	canvas.Name = object.Name .. "_Fader"
	canvas.BackgroundTransparency = 1
	canvas.Position = originalPosition
	canvas.Size = originalSize
	canvas.ZIndex = originalZIndex
	canvas.GroupTransparency = 1

	canvas.Parent = originalParent

	object.Position = UDim2.fromScale(0, 0)
	object.Size = UDim2.fromScale(1, 1)
	object.Parent = canvas

	local tween = tweenService:Create(canvas, fadeInfo, {
		GroupTransparency = 0,
	})

	tween:Play()
	tween.Completed:Wait()

	if object.Parent then
		object.Position = originalPosition
		object.Size = originalSize
		object.Parent = originalParent
	end

	canvas:Destroy()
end

return canvasFader
