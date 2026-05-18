--[[
	This will not showcase every feature and property. Please reference the docs:
	https://biggaboy212.github.io/Cascade/
]]

--// Imports
-- ! Replace these imports if copying this example. ! --
local cascade = require("@src/init")
local services = require("@modules/services")

--// References
local userInputService = services.UserInputService

--// Variables
local minimizeKeybind = Enum.KeyCode.RightControl

--// Privates
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
	-- Window pill is helpful for mobile devices who cannot use keys to un-minimize a window.
	WindowPill = true,

	-- You can also pass a custom theme / shallow edit parts of a theme.
	Theme = cascade.Themes.Dark,

	-- Check the docs for the full list of accents
	Accent = cascade.Accents.Blue,
})

do -- Main window
	local window = app:Window({
		Title = "Cascade",
		Subtitle = "Cascade demo app",

		-- Size the UI properly per-device
		Size = userInputService.TouchEnabled and UDim2.fromOffset(550, 325) or UDim2.fromOffset(850, 530),
	})

	-- Cascade does not handle key-minimize, so this is an implementation.
	userInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if input.KeyCode == minimizeKeybind and not gameProcessedEvent then
			window.Minimized = not window.Minimized
		end
	end)

	-- Cascade lets you index instance-properties as you regularly would. eg :Destroy .Destroying .Name etc etc...
	window.Destroying:Connect(function()
		print("Closed window")
	end)

	-- API demo
	do
		local section = window:Section({ -- Sections group tabs
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

				do -- Multi pop-up button with many options
					local row = titledRow(
						form,
						"Pop Up Button (Maximum=3) (many options)",
						"Multi Pop Up Button with many options"
					)

					local multi = row:Right():PopUpButton({
						Maximum = 3,
						ValueChanged = function(self, value)
							print("Selections:")
							for _, idx in ipairs(value or {}) do
								print(self.Options[idx])
							end
						end,
					})

					for i = 1, 20 do
						multi:Option(`Option {tostring(i)}`)
					end
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

				do -- Notification
					local row = titledRow(
						form,
						"Notification",
						"A non-disruptive, transient message that appears on screen to alert the user of important information, events, or state changes within an application."
					)

					row:Right():Button({
						Label = "Show (Chat)",
						State = "Primary",
						Pushed = function(self)
							app:Notification({
								Title = "New Message",
								Subtitle = "You received a new message from a friend.",
								App = "Chat",
								AppIcon = cascade.Symbols.bell,
								Duration = 8,
								Closed = function(self)
									print("Notification was dismissed!")
								end,
							})
						end,
					})

					row:Right():Button({
						Label = "Show (App)",
						State = "Primary",
						Pushed = function(self)
							app:Notification({
								Title = "Success",
								Subtitle = "Your changes have been saved.",
								App = "Vanta",
								AppIcon = "rbxassetid://104057131451858",
								Icon = cascade.Symbols.checkmark,
								Duration = 8,
								Closed = function(self)
									print("Notification was dismissed!")
								end,
							})
						end,
					})
				end
			end
		end

		do -- Window
			local tab = section:Tab({
				Title = "Window",
				Icon = cascade.Symbols.sidebarLeft,
			})

			do -- Appearance
				local pageSection = tab:PageSection({ Title = "Appearance" })

				do
					local form = pageSection:Form()

					do -- Appearance
						local row = titledRow(form, "Appearance", "Customize the application appearance.")

						row:Right():RadioButtonGroup({
							Options = { "Dark", "Light" },
							Value = app.Theme._id == "Dark" and 1,
							ValueChanged = function(self, value: number)
								app.Theme = cascade.Themes[self.Options[value]]
							end,
						})
					end

					do -- Color
						local row = titledRow(form, "Color", "Customize the application color.")

						local flattenedAccents = {}
						for accent, _ in pairs(cascade.Accents) do
							table.insert(flattenedAccents, accent)
						end

						local accentValue = table.find(flattenedAccents, (app.Accent and app.Accent._id) or "Graphite")

						row:Right():PopUpButton({
							Value = accentValue,
							Options = flattenedAccents,
							ValueChanged = function(self, value: number)
								app.Accent = cascade.Accents[self.Options[value]]
							end,
						})
					end
				end

				do
					local form = pageSection:Form()

					do -- Toolbar Title
						local row = titledRow(form, "Toolbar title", "Customize the application toolbar title.")

						local oldWindowName = window.Title

						local titleField = row:Right():TextField({
							Value = window.Title,
							Placeholder = "Title...",
							ValueChanged = function(self, value: string)
								window.Title = value
							end,
						})

						row:Right():Button({
							Label = "Reset",
							State = "Destructive",
							Pushed = function(self, value: string)
								titleField.Value = oldWindowName
							end,
						})
					end

					do -- Toolbar subtitle
						local row = titledRow(form, "Toolbar sub-title", "Customize the application toolbar subtitle.")

						local oldWindowSubtitle = window.Subtitle

						local subTitleField = row:Right():TextField({
							Value = window.Subtitle,
							Placeholder = "Sub-title...",
							ValueChanged = function(self, value: string)
								window.Subtitle = value
							end,
						})

						row:Right():Button({
							Label = "Reset",
							State = "Destructive",
							Pushed = function(self, value: string)
								subTitleField.Value = oldWindowSubtitle
							end,
						})
					end
				end
			end

			do -- Input
				local pageSection = tab:PageSection({ Title = "Input" })

				do
					local form = pageSection:Form()

					-- WindowControls
					do
						for i, v in { "Exit", "Minimize", "Zoom" } do
							local row = titledRow(form, `Can {v}`)

							row:Right():Toggle({
								Value = window[`Can{v}`],
								ValueChanged = function(self, value: boolean)
									window[`Can{v}`] = value
								end,
							})
						end
					end
				end

				do
					local form = pageSection:Form()

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
						local row = titledRow(
							form,
							"Draggable",
							"Allows users to move the window with a mouse or touch device."
						)

						row:Right():Toggle({
							Value = window.Draggable,
							ValueChanged = function(self, value: boolean)
								window.Draggable = value
							end,
						})
					end

					do -- Resizable
						local row = titledRow(
							form,
							"Resizable",
							"Allows users to resize the window with a mouse or touch device."
						)

						row:Right():Toggle({
							Value = window.Resizable,
							ValueChanged = function(self, value: boolean)
								window.Resizable = value
							end,
						})
					end
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

		-- SF Symbols
		do
			local link = "https://sf-symbols.pages.dev/"
			local tab = section:Tab({
				Title = "SF Symbols",
				Icon = cascade.Symbols.scribbleVariable,
			})

			do
				local pageSection =
					tab:PageSection({ Title = "SF Symbols", Subtitle = "Cascade has a built-in SF Symbols library." })

				do
					local form = pageSection:Form()

					-- Legal notice
					do
						local row = form:Row()

						row:Left():Label({
							Text = "<i>"
								.. "SF Symbols © Apple Inc.\n"
								.. "SF Symbols is a trademark of Apple Inc."
								.. "</i>",
							TextXAlignment = Enum.TextXAlignment.Left,
						})
					end

					-- SF Symbols discovery link
					do
						local row = form:Row({ SearchIndex = "Symbols Copy Link" })

						row:Left():TitleStack({
							Title = "Official SF Symbols",
							Subtitle = "Explore the full SF Symbols library. Assets created by Apple Inc. Website and discovery curated by the Cascade developers.",
						})

						row:Right():Button({
							Label = "Copy link",
							Pushed = function(self)
								if setclipboard then
									setclipboard(link)
								end

								app:Notification({
									App = "Cascade",

									Title = setclipboard and "Copied" or "Unable to copy",
									Subtitle = not setclipboard
										and `The current environment does not support \`setclipboard\`, Official link: <u>{link}</u>`,

									Duration = 8,
								})
							end,
						})
					end
				end

				-- Info
				do
					local form = pageSection:Form()

					-- Info
					do
						local row = form:Row()

						row:Left():Label({
							Text = "SF Symbols 7 is the officially supported built-in icon system for Cascade, it includes 6,900+ symbols which have all been imported to ROBLOX and are exposed with `Cascade.Symbols`",
							TextXAlignment = Enum.TextXAlignment.Left,
						})
					end
				end
			end
		end
	end

	-- Navigation Demo
	do
		local section = window:Section({ Title = "Navigation", Disclosure = false })
		local tab = section:Tab({
			Title = "Routing",
			Icon = cascade.Symbols.switch2,
			Selected = false,
			-- Page = app:Page() -- You can also pass a page manually
		})

		local homePage = app:Page() -- You can pass a page to a tab manually, see above
		local settingsPage = app:Page()

		-- Home
		do
			local form = homePage:Form()

			local row = form:Row({ SearchIndex = "Home" })

			row:Left():ImageSurface({
				Image = cascade.Symbols.house,
				SurfaceColor = Color3.fromRGB(255, 107, 53),
			})
			row:Left():TitleStack({
				Title = "Home",
				Subtitle = "This is the main view.",
			})

			row:Right():Button({
				Label = "Enter",
				Pushed = function()
					tab:Navigate(settingsPage)
				end,
			})
		end

		-- Settings
		do
			local form = settingsPage:Form()
			titledRow(form, "Settings", "This is a sub-page."):Right():Button({
				Label = "Back to Home",
				State = "Secondary",
				Pushed = function()
					tab:Navigate(homePage)
				end,
			})
		end

		tab:Navigate(homePage)
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
