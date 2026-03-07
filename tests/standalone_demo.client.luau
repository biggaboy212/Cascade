--// Imports
local cascade = require("@src/init")
local creator = cascade.Creator
local create = creator.Create

--// Components
cascade.RegisterComponent("CustomPanel", function(self, properties)
	local frame = create("Frame")({
		Name = "CustomPanel",
		BackgroundColor3 = self.Theme.SecondaryBackgroundColor3 or Color3.fromRGB(30, 30, 30),
		Size = properties.Size or UDim2.fromOffset(300, 200),
		Position = properties.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = properties.Parent or self.__container,

		create("UICorner")({
			CornerRadius = UDim.new(0, 8),
		}),

		create("UIStroke")({
			Color = Color3.fromRGB(255, 255, 255),
			Transparency = 0.8,
			Thickness = 1,
		}),
	})

	self:Label({
		Text = properties.Title or "Custom Panel",
		Position = UDim2.fromOffset(10, 10),
		Size = UDim2.fromOffset(280, 20),
		Parent = frame.__instance,
	})

	return frame
end)

--// UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StandaloneTest"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local ctx = cascade.Component({
	Theme = cascade.Themes.Dark,
	Accent = cascade.Accents.Red,
	Parent = screenGui,
})

local panel, panelInstance = ctx:CustomPanel({
	Title = "Standalone Demo",
	Position = UDim2.fromScale(0.5, 0.5),
})

print("Panel Instance:", panelInstance:GetFullName())

panel:Button({
	Label = "Click Me",
	Position = UDim2.fromOffset(10, 40),
	Pushed = function()
		print("Custom Panel Button Pushed!")
	end,
})

panel:Slider({
	Position = UDim2.fromOffset(10, 80),
	Value = 0.7,
	ValueChanged = function(_, value)
		print("Slider Value:", value)
	end,
})

print("Standalone example initialized.")
