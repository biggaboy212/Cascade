local notificationList = {}

local services = require("@modules/services")
local tweenService = services.TweenService

local activeNotifications = {}
local MAX_NOTIFICATIONS = 4
local STACK_OFFSET_Y = -12
local SCALE_DECREMENT = 0.05

function notificationList.AddNotification(notificationObj, frame)
	if #activeNotifications >= MAX_NOTIFICATIONS then
		local oldest = table.remove(activeNotifications, 1)
		if oldest and oldest.Object and oldest.Object.Close then
			oldest.Object:Close()
		end
	end

	table.insert(activeNotifications, {
		Object = notificationObj,
		Frame = frame,
	})

	notificationList.UpdateStack()
end

function notificationList.UpdateStack()
	local total = #activeNotifications

	for i = 1, total do
		local notif = activeNotifications[i]
		local frame = notif.Frame.__instance

		if not frame or not frame.Parent then
			continue
		end

		local age = total - i

		local targetScale = 1 - (age * SCALE_DECREMENT)
		local targetY = (age * STACK_OFFSET_Y)

		frame.ZIndex = 100 - age

		local baseOffsetX = -162.5
		local baseOffsetY = 0
		local endOffsetY = baseOffsetY + targetY

		local scaleObj = frame:FindFirstChild("UIScale")

		if age > 0 then
			if scaleObj then
				tweenService
					:Create(scaleObj, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
						Scale = targetScale,
					})
					:Play()
			end

			tweenService
				:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, baseOffsetX, 1, endOffsetY),
				})
				:Play()

			if notif.Object.UpdateState then
				notif.Object:UpdateState(age)
			end
		else
			if scaleObj then
				tweenService
					:Create(scaleObj, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
						Scale = 1,
					})
					:Play()
			end

			tweenService
				:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, baseOffsetX, 1, baseOffsetY),
				})
				:Play()

			if notif.Object.UpdateState then
				notif.Object:UpdateState(age)
			end
		end
	end
end

function notificationList.RemoveNotification(notificationObj)
	for i, notif in ipairs(activeNotifications) do
		if notif.Object == notificationObj then
			table.remove(activeNotifications, i)
			break
		end
	end

	notificationList.UpdateStack()
end

return notificationList
