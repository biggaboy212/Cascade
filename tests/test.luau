--// Imports
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// UI
local app = cascade.New({
	Theme = cascade.Themes.Dark,
})

do -- App window
	local window = app:Window({
		Title = "Title",
		Subtitle = `Subtitle`,
		Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
	})

	-- Window keybind handling
	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
			window.Minimized = not window.Minimized
		end
	end)

	do -- Section 1
		local section = window:Section({
			Disclosure = true,
		})

		do -- Tab 1
			local tab = section:Tab({
				Selected = true,
				Icon = cascade.Symbols.doc,
			})

			do -- Form 1
				local form = tab:Form()

				form:Row():Toggle({
					Value = true,
					ValueChanged = function(self, value: boolean)
						print(`Value changed: {value}`)
					end
				})

				form:Row():Toggle({
					Value = false,
					ValueChanged = function(self, value: boolean)
						print(`Value changed: {value}`)
					end
				})

				form:Row({ Subtitle = "Subtitle" }):TextField({
					Value = "Label",
					Placeholder = "Placeholder",
					ValueChanged = function(self, value: string)
						print(`Value changed: {value}`)
					end,
					FocusLost = function(self, value: string)
						print(`Input complete: {value}`)
					end,
				})

				local sliderRow = form:Row({
					Title = "Slider",
					Subtitle = "A slider is a horizontal track with a control, called a thumb, that people can adjust between a minimum and maximum value."
				})
				local label = sliderRow:Label()
				sliderRow:Slider({
					Value = 16,
					Minimum = 1,
					Maximum = 100,
					ValueChanged = function(self, value: number)
						print(`Value changed: {value}`)

						if label then
							label.Text = tostring(math.round(value))
						end
					end
				})
			end
		end

		section:Tab({
			Icon = cascade.Symbols.doc,
		})

		section:Tab({
			Icon = cascade.Symbols.doc,
		})

		section:Tab({
			Icon = cascade.Symbols.doc,
		})
	end

	do -- Section 2
		local section = window:Section({
			Disclosure = true,
		})

		section
			:Tab({
				Icon = cascade.Symbols.doc,
			})
			:Tab({
				Icon = cascade.Symbols.doc,
			})
			:Tab({
				Icon = cascade.Symbols.doc,
			})
			:Tab({
				Icon = cascade.Symbols.doc,
			})

		section:Tab({
			Icon = cascade.Symbols.doc,
		})
	end
end

task.wait(4)

app.Theme = cascade.Themes.Dark
