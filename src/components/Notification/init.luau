local types = require("@types")

return function(self, properties: types.NotificationProperties): types.Notification
	local services = require("@modules/services")
	local binder = require("@modules/binder")
	local notificationList = require("@modules/notificationList")
	local ui = require("@self/ui")

	local tweenService = services.TweenService

	properties = properties or {}
	properties.Title = properties.Title or "Notification"
	properties.Subtitle = properties.Subtitle or ""
	properties.Duration = properties.Duration or 6

	if properties.App then
		properties.App = string.upper(properties.App)
	end

	local closed = false
	local MAX_NOTIFICATIONS = 4
	local state = { Age = 0 }

	local body, exitBtn, canvas, content, topbar = ui(self, properties, state, MAX_NOTIFICATIONS)

	local bindings = {
		Title = function(value: string)
			content.TitleContainer.Title.Text = value
		end,
		Subtitle = function(value: string)
			content.Subtitle.Text = value
			content.Subtitle.Visible = value ~= ""
		end,
		App = function(value: string)
			local upperValue = string.upper(value or "")
			topbar.App.Text = upperValue
			topbar.App.Visible = value ~= nil
			topbar.Visible = (value ~= nil) or (properties.AppIcon ~= nil)

			if properties.App ~= upperValue then
				properties.App = upperValue
			end
		end,
		AppIcon = function(value: string)
			topbar.Icon.Image = value or ""
			topbar.Icon.Visible = value ~= nil
			topbar.Visible = (properties.App ~= nil) or (value ~= nil)
		end,
		Icon = function(value: string)
			if value then
				content.TitleContainer.Icon.Image = value
			end
			content.TitleContainer.Icon.Visible = value ~= nil
		end,
	}

	local object = binder.Wrap(properties, bindings, body, { "App", "Icon" })

	object.Type = "Notification"
	object.Theme = self.Theme

	binder.Apply(properties, object)

	local function closeNotification(fromUserInput: boolean?)
		if closed then
			return
		end
		closed = true

		if not body.Parent then
			return
		end

		if properties.Closed then
			task.spawn(properties.Closed, object, fromUserInput)
		end

		local fadeTween = tweenService:Create(
			object.__instance,
			TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
			{
				Position = object.__instance.Position + UDim2.fromOffset(350, 0),
			}
		)

		object:UpdateState(MAX_NOTIFICATIONS, false)

		local scale = object.__instance:FindFirstChild("UIScale")
		if scale then
			tweenService
				:Create(scale, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Scale = 0.85,
				})
				:Play()
		end

		fadeTween:Play()
		fadeTween.Completed:Connect(function()
			if body.Parent then
				notificationList.RemoveNotification(object)
				body:Destroy()
			end
		end)
	end

	exitBtn.MouseButton1Click:Connect(function()
		closeNotification(true)
	end)

	function object:Close(fromUserInput: boolean?)
		closeNotification(fromUserInput)
	end

	function object:UpdateState(age: number, instant: boolean?)
		state.Age = age

		local isFaded = age >= (MAX_NOTIFICATIONS - 1)
		local isPrimary = age == 0

		local exitBgFade = isPrimary and 0.1 or 1
		local exitStrokeFade = isPrimary and 0.96 or 1
		local exitShadowFade = isPrimary and 0.9 or 1
		local exitIconFade = isPrimary and 0.5 or 1

		if isFaded then
			exitBgFade = 1
			exitStrokeFade = 1
			exitShadowFade = 1
			exitIconFade = 1
		end

		local targetBgTransparency = isFaded and 1 or 0.1

		local function apply(inst, props)
			if instant then
				for k, v in pairs(props) do
					inst[k] = v
				end
			else
				tweenService
					:Create(inst, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), props)
					:Play()
			end
		end

		apply(canvas, { BackgroundTransparency = targetBgTransparency })

		for _, descendant in ipairs(canvas:GetDescendants()) do
			if descendant:IsA("TextLabel") then
				local targetTextTransparency = 1
				if not isFaded then
					if descendant.Name == "Title" then
						targetTextTransparency = self.Theme.Text.Primary[2].Value
					elseif descendant.Name == "Subtitle" then
						targetTextTransparency = self.Theme.Text.Secondary[2].Value
					elseif descendant.Name == "App" then
						targetTextTransparency = 0.5
					end
				end
				apply(descendant, { TextTransparency = targetTextTransparency })
			elseif descendant:IsA("ImageLabel") and descendant.Name ~= "Icon" then
				apply(descendant, { ImageTransparency = isFaded and 1 or 0 })
			end
		end

		if content:FindFirstChild("TitleContainer") and content.TitleContainer:FindFirstChild("Icon") then
			apply(content.TitleContainer.Icon, { ImageTransparency = isFaded and 1 or 0 })
		end
		if topbar:FindFirstChild("Icon") then
			apply(topbar.Icon, { ImageTransparency = isFaded and 1 or 0 })
		end

		apply(exitBtn, { BackgroundTransparency = exitBgFade })
		apply(exitBtn.Icon, { ImageTransparency = exitIconFade })
		apply(exitBtn.UIStroke, { Transparency = exitStrokeFade })

		local shadow = exitBtn:FindFirstChild("Shadow")
		if shadow and shadow:FindFirstChild("UIStroke") then
			apply(shadow.UIStroke, { Transparency = exitShadowFade })
		end
	end

	body.Position = UDim2.new(1, 187.5, 1, 0)

	object:UpdateState(0, true)

	notificationList.AddNotification(object, body)

	if body:FindFirstChild("UIScale") then
		body.UIScale.Scale = 0.85
		tweenService
			:Create(body.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Scale = 1,
			})
			:Play()
	end

	tweenService
		:Create(body.__instance, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -162.5, 1, 0),
		})
		:Play()

	if properties.Duration > 0 then
		task.delay(properties.Duration, function()
			closeNotification()
		end)
	end

	return object
end
