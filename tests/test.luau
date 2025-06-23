--// Imports
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// UI
local app = cascade.New({
	Theme = cascade.Themes.Dark,
})

do -- Main window
	local window = app:Window({
		Title = "Cascade",
		Subtitle = "Cascade test application",
		Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
	})

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
			window.Minimized = not window.Minimized
		end
	end)

	-- Section 1
	do
		local section = window:Section({
			Disclosure = true,
			Title = "Section Title",
		})

		do -- Tab 1
			local tab = section:Tab({
				Selected = true,
				Name = "Tab",
				Icon = cascade.Symbols.doc,
			})

			do -- Form 1
				local form = tab:Form()

				do -- Toggle Off
					local row = form:Row({
						SearchIndex = "ToggleOff",
					})

					row:Left():TitleStack({
						Title = "Toggle",
						Subtitle = "Toggle with a falsey value",
					})

					row:Right():Toggle({
						Value = false,
						ValueChanged = function(self, value: boolean)
							print("Value changed:", value)
						end,
					})
				end

				do -- Toggle on
					local row = form:Row({
						SearchIndex = "ToggleOn",
					})

					row:Left():TitleStack({
						Title = "Toggle",
						Subtitle = "Toggle with a truthy value",
					})

					row:Right():Toggle({
						Value = true,
						ValueChanged = function(self, value: boolean)
							print("Value changed:", value)
						end,
					})
				end

				do -- Push buttons
					local row = form:Row({
						SearchIndex = "PushButtons",
					})

					row:Left():TitleStack({
						Title = "Push Buttons",
						Subtitle = "Static buttons, these hold no value.",
					})

					row:Right():PushButton({
						Label = "Primary",
						State = "Primary",
						Pushed = function(self) 
							print("Pushed")
						end,
					})

					row:Right():PushButton({
						Label = "Secondary",
						State = "Secondary",
						Pushed = function(self) 
							print("Pushed")
						end,
					})

					row:Right():PushButton({
						Label = "Destructive",
						State = "Destructive",
						Pushed = function(self) 
							print("Pushed")
						end,
					})
				end

				do
					local row = form:Row({
						SearchIndex = "PushButtons",
					})

					row:Left():TitleStack({
						Title = "Bigger Push Buttons",
						Subtitle = "Static buttons, these hold no value.",
					})

					row:Right():PushButton({
						State = "Primary",
						Label = "Primary",
						Size = UDim2.fromOffset(80, 25),
						Pushed = function(self) 
							print("Pushed")
						end,
					})

					row:Right():PushButton({
						State = "Secondary",
						Label = "Secondary",
						Size = UDim2.fromOffset(80, 25),
						Pushed = function(self) 
							print("Pushed")
						end,
					})

					row:Right():PushButton({
						State = "Destructive",
						Label = "Destructive",
						Size = UDim2.fromOffset(80, 25),
						Pushed = function(self) 
							print("Pushed")
						end,
					})
				end
			end
		end
	end
end
