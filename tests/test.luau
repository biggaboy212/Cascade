--// Imports
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// Variables
local minimizeKeybind = Enum.KeyCode.RightControl

--// Functions
local function titledRow(parent: any, title: string, subtitle: string?) -- You can use this to automate the process of creating similar rows.
	local row = parent:Row({
		SearchIndex = title,
	})

	row:Left():TitleStack({
		Title = title,
		Subtitle = subtitle,
	})

	return row
end

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
					local row = titledRow(
						form,
						"Toggle (Off)",
						"Lets people choose between a pair of opposing states, like on and off, using a different appearance to indicate each state."
					)

					row:Right():Toggle({
						Value = false,
						ValueChanged = function(self, value: boolean)
							print("Value changed:", value)
						end,
					})
				end

				do -- Toggle on
					local row = titledRow(form, "Toggle (On)", "Toggle with a truthy value")

					row:Right():Toggle({
						Value = true,
						ValueChanged = function(self, value: boolean)
							print("Value changed:", value)
						end,
					})
				end

				do -- Text Field
					local row = titledRow(
						form,
						"Text Field",
						"A rectangular area in which people enter or edit small, specific pieces of text."
					)

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
					local row = titledRow(
						form,
						"Keybind Field",
						"A rectangular area in which people can enter and store keyboard input."
					)

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
					local row = titledRow(form, "Push Buttons", "Static buttons, these hold no value.")

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
					local row = titledRow(
						form,
						"Slider",
						"A horizontal track with a control, called a thumb, that people can adjust between a minimum and maximum value."
					)

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
					local row = titledRow(
						form,
						"Stepper",
						"A two-segment control that people use to increase or decrease an incremental value."
					)
					local label = row:Right():Label()

					row:Right():Stepper({
						ValueChanged = function(self, value: number)
							print("Value changed:", value)
							label.Text = tostring(value)
						end,
					})
				end

				do -- Fielded Stepper
					local row = titledRow(form, "Stepper (Fielded)", "Stepper with a editable field")

					row:Right():Stepper({
						Fielded = true,
						ValueChanged = function(self, value: number)
							print("Value changed:", value)
						end,
					})
				end

				do -- Radio Button Group
					local row = titledRow(
						form,
						"Radio Buttons",
						"Lets people choose an option from a set of mutually exclusive choices, using a circular indicator to show the selected option."
					)
					local radioButtonGroup = row:Right():RadioButtonGroup({
						Options = {
							"Option 1",
							"Option 2",
						},
						Value = 1,
						ValueChanged = function(self, value: number)
							print("Value changed:", self.Options[value])
						end,
					})

					radioButtonGroup:Option("Option 3")
				end

				do -- Pop Up Button
					local row = titledRow(form, "Pop Up Button", "Displays a menu of mutually exclusive options.")
					local popUpButton = row:Right():PopUpButton({
						Options = {
							"Item One",
							"Item Two",
							"Item Three",
							"Item Four",
							"Item Five",
							"Item Six",
							"Item Seven",
							"Item Eight",
							"Item Nine",
							"Item Ten",
							"Item Eleven",
						},
						Value = 2,
						ValueChanged = function(self, value: number)
							print("Value changed:", self.Options[value])
						end,
					})

					popUpButton:Option("Item Twelve")
					popUpButton:Option("Item Thirteen")
					popUpButton:Remove(13)
				end

				do -- Multi pop-up button
					local row = titledRow(
						form,
						"Pop Up Button (Maximum=3)",
						"Displays a menu of non-mutually exclusive options."
					)

					local multi = row:Right():PopUpButton({
						Options = { "One", "Two", "Three", "Four" },
						Maximum = 3,
						ValueChanged = function(self, value)
							print("Selections:")
							for _, idx in ipairs(value or {}) do
								print(self.Options[idx])
							end
						end,
					})

					multi:Option("Five")

					multi.Value = { 1, 3 }
				end

				do -- Pull Down Button
					local row = titledRow(
						form,
						"Pull Down Button",
						"Displays a menu of items or actions that directly relate to the button’s purpose."
					)
					local pullDownButton = row:Right():PullDownButton({
						Options = {
							"Action One",
							"Action Two",
						},
						Label = "Options",
						ValueChanged = function(self, value: number)
							print("Selected:", self.Options[value])
						end,
					})

					pullDownButton:Option("Action Three")
					pullDownButton:Option("Action Four")
					pullDownButton:Remove(4)
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
					local row = titledRow(
						form,
						"Dark mode",
						"An application appearance setting that uses a dark color palette to provide a comfortable viewing experience tailored for low-light environments."
					)

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
					local row = titledRow(form, "Minimize shortcut")

					row:Right():KeybindField({
						Value = minimizeKeybind,
						ValueChanged = function(self, value: Enum.KeyCode)
							minimizeKeybind = value
						end,
					})
				end

				do -- Searching
					local row = titledRow(
						form,
						"Searchable",
						"Allows users to search for content in a page with a search-field in the titlebar."
					)

					row:Right():Toggle({
						Value = window.Searching,
						ValueChanged = function(self, value: boolean)
							window.Searching = value
						end,
					})
				end

				do -- Draggable
					local row =
						titledRow(form, "Draggable", "Allows users to move the window with a mouse or touch device.")

					row:Right():Toggle({
						Value = window.Draggable,
						ValueChanged = function(self, value: boolean)
							window.Draggable = value
						end,
					})
				end

				do -- Resizable
					local row =
						titledRow(form, "Resizable", "Allows users to resize the window with a mouse or touch device.")

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
					local row = titledRow(form, "Dropshadow", "Enables a dropshadow effect on the window.")

					row:Right():Toggle({
						Value = window.Dropshadow,
						ValueChanged = function(self, value: boolean)
							window.Dropshadow = value
						end,
					})
				end

				do -- UI Blur
					local row = titledRow(
						form,
						"Background blur",
						"Enables a UI background blur effect on the window. This can be detectable in some games."
					)

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
