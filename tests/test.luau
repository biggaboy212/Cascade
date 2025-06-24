--// Imports
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// UI
local app = cascade.New({
	Theme = cascade.Themes.Light,
})

do -- Main window
	local window = app:Window({
		Title = "Cascade",
		Subtitle = "Cascade demo app",
		Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
	})

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
			window.Minimized = not window.Minimized
		end
	end)

	window.Destroying:Connect(function()
		print("Closed window!")
	end)

	-- API demo
	do
		local section = window:Section({
			Title = "Demo",
		})

		do -- Components
			local tab = section:Tab({
				Selected = true,
				Title = "Components",
				Icon = cascade.Symbols.switch2,
			})

			do -- Form 1
				local form = tab:Form()

				do -- Toggle off
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

				do -- Text Field
					local row = form:Row({
						SearchIndex = "TextField",
					})

					row:Left():TitleStack({
						Title = "Text Field",
						Subtitle = "A rectangular area in which people enter or edit small, specific pieces of text.",
					})

					row:Right():TextField({
						Value = "Label",
						ValueChanged = function(self, value: string)
							print("Value changed:", value)
						end,
						FocusLost = function(self, value: string)
							print("Focus lost with:", value)
						end,
					})
				end

				do -- Buttons
					local row = form:Row({
						SearchIndex = "PushButtons",
					})

					row:Left():TitleStack({
						Title = "Push Buttons",
						Subtitle = "Static buttons, these hold no value.",
					})

					row:Right():Button({
						Label = "Primary",
						State = "Primary",
						Pushed = function(self)
							print("Pushed")
						end,
					})

					row:Right():Button({
						Label = "Secondary",
						State = "Secondary",
						Pushed = function(self)
							print("Pushed")
						end,
					})

					row:Right():Button({
						Label = "Destructive",
						State = "Destructive",
						Pushed = function(self)
							print("Pushed")
						end,
					})
				end

				do -- Slider
					local row = form:Row({
						SearchIndex = "Sliders",
					})

					row:Left():TitleStack({
						Title = "Slider",
						Subtitle = "A horizontal track with a control, called a thumb, that people can adjust between a minimum and maximum value.",
					})

					local label = row:Right():Label()

					row:Right():Slider({
						Value = 0.5,
						ValueChanged = function(self, value: number)
							print("Value changed:", value)

							label.Text = string.format(`%.2f`, value)
						end,
					})
				end

				do -- Stepper
					local row = form:Row({
						SearchIndex = "Stepper",
					})

					row:Left():TitleStack({
						Title = "Stepper",
						Subtitle = "A two-segment control that people use to increase or decrease an incremental value.",
					})

					local label = row:Right():Label()

					row:Right():Stepper({
						ValueChanged = function(self, value: number)
							print("Value is now:", value)

							label.Text = tostring(value)
						end,
					})
				end

				do -- Fielded Stepper
					local row = form:Row({
						SearchIndex = "StepperFielded",
					})

					row:Left():TitleStack({
						Title = "Stepper (Fielded)",
						Subtitle = "Stepper with a editable field",
					})

					row:Right():Stepper({
						Fielded = true,
						ValueChanged = function(self, value: number)
							print("Value is now:", value)
						end,
					})
				end

				do -- Radio Button Group
				end
			end
		end

		do -- Window
			local tab = section:Tab({
				Title = "Window",
				Icon = cascade.Symbols.sidebarLeft,
			})

			do -- Form 1
				local form = tab:Form()

				do -- Dark mode toggle
					local row = form:Row()

					row:Left():TitleStack({
						Title = "Dark mode",
						Subtitle = "Dark Mode is a systemwide appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments."
					})

					row:Right():Toggle({
						Value = app.Theme == cascade.Themes.Dark,
						ValueChanged = function(self, value: boolean)
							app.Theme = value and cascade.Themes.Dark or cascade.Themes.Light
						end
					})
				end
			end
		end
	end

	-- Tab demo
	do
		local section = window:Section()

		section
			:Tab({ Icon = cascade.Symbols.photo })
			:Tab({ Icon = cascade.Symbols.photo })
			:Tab({ Icon = cascade.Symbols.photo })
			:Tab({ Icon = cascade.Symbols.photo })

		section:Tab({ Icon = cascade.Symbols.photo })
	end
end
