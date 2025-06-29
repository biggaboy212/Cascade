--// Imports
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// Variables
local minimizeKeybind = Enum.KeyCode.RightControl

--// UI
local app = cascade.New({
	WindowPill = true,
	Theme = cascade.Themes.Light,
})

do -- Main window
	local window = app:Window({
		Title = "Cascade",
		Subtitle = "Cascade demo app",
		Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
	})

	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == minimizeKeybind and not gameProcessedEvent then
			window.Minimized = not window.Minimized
		end
	end)

	window.Destroying:Connect(function()
		print("Closed window")
	end)

	-- API demo
	do
		local section = window:Section({
			Disclosure = false,
			Title = "API Demo",
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
						Title = "Toggle (Off)",
						Subtitle = "Lets people choose between a pair of opposing states, like on and off, using a different appearance to indicate each state.",
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
						Title = "Toggle (On)",
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
						TextChanged = function(self, value: string)
							print("Text changed:", value)
						end,
					})
				end

				do -- Keybind Field
					local row = form:Row({
						SearchIndex = "KeybindField",
					})

					row:Left():TitleStack({
						Title = "Keybind Field",
						Subtitle = "A rectangular area in which people can enter and store keyboard input.",
					})

					row:Right():KeybindField({
						ValueChanged = function(self, value: Enum.KeyCode)
							print("Value changed:", value)
						end,
						BindPressed = function(
							self,
							value: Enum.KeyCode,
							inputComplete: boolean,
							gameProcessedEvent: boolean
						)
							if not inputComplete or gameProcessedEvent then
								return
							end

							print("Pressed bind:", value)
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

					row:Right():Symbol({
						Image = cascade.Symbols.sunMin,
					})

					row:Right():Slider({
						Value = 0.5,
						ValueChanged = function(self, value: number)
							print("Value changed:", value)
						end,
					})

					row:Right():Symbol({
						Image = cascade.Symbols.sunMax,
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
							print("Value changed:", value)

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
							print("Value changed:", value)
						end,
					})
				end

				do -- Radio Button Group
					local row = form:Row({
						SearchIndex = "Radio Buttons",
					})

					row:Left():TitleStack({
						Title = "Radio Buttons",
						Subtitle = "Lets people choose an option from a set of mutually exclusive choices, using a circular indicator to show the selected option.",
					})

					local radioButtonGroup = row:Right():RadioButtonGroup({
						Options = {
							"Option 1",
							"Option 2",
						},
						ValueChanged = function(self, value: number)
							print("Value changed:", self.Options[value])
						end,
					})

					radioButtonGroup:Option("Option 3") -- This returns the radio button instance.
				end

				do -- Pop Up Button
					local row = form:Row({
						SearchIndex = "Pop Up Button",
					})

					row:Left():TitleStack({
						Title = "Pop Up Button",
						Subtitle = "Displays a menu of mutually exclusive options.",
					})

					--local popUpButton = row:Right():PopUpButton()
				end
			end
		end

		do -- Window
			local tab = section:Tab({
				Title = "Window",
				Icon = cascade.Symbols.sidebarLeft,
			})

			do -- Appearance
				local form = tab:PageSection({ Title = "Appearance" }):Form()

				do -- Dark mode
					local row = form:Row({
						SearchIndex = "Dark mode",
					})

					row:Left():TitleStack({
						Title = "Dark mode",
						Subtitle = "Dark Mode is a application appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments.",
					})

					row:Right():Toggle({
						Value = app.Theme == cascade.Themes.Dark,
						ValueChanged = function(self, value: boolean)
							app.Theme = value and cascade.Themes.Dark or cascade.Themes.Light
						end,
					})
				end
			end

			do -- Input
				local form = tab:PageSection({ Title = "Input" }):Form()

				do -- Minimize shortcut
					local row = form:Row({
						SearchIndex = "Minimize shortcut",
					})

					row:Left():TitleStack({
						Title = "Minimize shortcut",
					})

					row:Right():KeybindField({
						Value = minimizeKeybind,
						ValueChanged = function(self, value: Enum.KeyCode)
							minimizeKeybind = value
						end,
					})
				end

				do -- Searching
					local row = form:Row({
						SearchIndex = "Searchable",
					})

					row:Left():TitleStack({
						Title = "Searchable",
						Subtitle = "Allows pages to be searched using a text field in the title bar.",
					})

					row:Right():Toggle({
						Value = window.Searching,
						ValueChanged = function(self, value: boolean)
							window.Searching = value
						end,
					})
				end

				do -- Draggable
					local row = form:Row({
						SearchIndex = "Draggable",
					})

					row:Left():TitleStack({
						Title = "Draggable",
						Subtitle = "Allows users to move the window with a mouse or touch device.",
					})

					row:Right():Toggle({
						Value = window.Draggable,
						ValueChanged = function(self, value: boolean)
							window.Draggable = value
						end,
					})
				end

				do -- Resizable
					local row = form:Row({
						SearchIndex = "Resizable",
					})

					row:Left():TitleStack({
						Title = "Resizable",
						Subtitle = "Allows users to resize the window with a mouse or touch device.",
					})

					row:Right():Toggle({
						Value = window.Resizable,
						ValueChanged = function(self, value: boolean)
							window.Resizable = value
						end,
					})
				end
			end

			do -- Effects
				local form = tab:PageSection({
					Title = "Effects",
					Subtitle = "These effects may be resource intensive across different systems.",
				}):Form()

				do -- Dropshadow
					local row = form:Row({
						SearchIndex = "Dropshadow",
					})

					row:Left():TitleStack({
						Title = "Dropshadow",
						Subtitle = "Enables a dropshadow effect on the window.",
					})

					row:Right():Toggle({
						Value = window.Dropshadow,
						ValueChanged = function(self, value: boolean)
							window.Dropshadow = value
						end,
					})
				end

				do -- UI Blur
					local row = form:Row({
						SearchIndex = "Background blur",
					})

					row:Left():TitleStack({
						Title = "Background blur",
						Subtitle = "Enables a UI background blur effect on the window. This can be detectable in some games.",
					})

					row:Right():Toggle({
						Value = window.UIBlur,
						ValueChanged = function(self, value: boolean)
							window.UIBlur = value
						end,
					})
				end
			end
		end
	end

	-- Tab demo
	do
		local section = window:Section()

		section
			:Tab({ Icon = cascade.Symbols.squareStack3dUp })
			:Tab({ Icon = cascade.Symbols.squareStack3dUp })
			:Tab({ Icon = cascade.Symbols.squareStack3dUp })
			:Tab({ Icon = cascade.Symbols.squareStack3dUp })

		section:Tab({ Icon = cascade.Symbols.squareStack3dUp })
	end
end
