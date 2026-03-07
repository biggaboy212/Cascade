--// Imports
local utility = require("@modules/utility")
local types = require("@types")
local creator = require("@modules/creator")
local binder = require("@modules/binder")
local services = require("@modules/services")

local symbols = require("@modules/symbols")
local components = require("@components/init")

local themes = require("@themes/init")
local accents = require("@themes/accents")

--// References
local create = creator.Create

local tweenService = services.TweenService

--// Variables
local cascade = {
	Themes = themes,
	Accents = accents,
	Symbols = symbols,
	
	Creator = creator,
	Binder = binder,
	Components = components
}

local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local currentTween: Tween? = nil

--// Functions
local function deepCopy(original, identifier: string?)
	local copy = {}
	for key, value in pairs(original) do
		local vType = typeof(value)
		if vType == "table" then
			if value.Value ~= nil and value.Connect and typeof(value.Connect) == "function" then
				copy[key] = creator.Value(value.Value)
			else
				copy[key] = deepCopy(value)
			end
		else
			copy[key] = value
		end
	end

	if identifier and not original._id then
		original._id = identifier
	end

	return copy
end

local function parseAccent(theme, overrides)
	for key, override in pairs(overrides) do
		local themeObj = theme[key]

		if not themeObj and type(theme) == "table" and type(theme.Controls) == "table" then
			themeObj = theme.Controls[key]
		end

		if not themeObj then
			continue
		end

		if type(themeObj) == "table" and themeObj.Connect then
			themeObj.Value = override
		elseif
			type(themeObj) == "table"
			and themeObj[1]
			and themeObj[1].Connect
			and typeof(override) == "Color3"
		then
			themeObj[1].Value = override
		elseif type(themeObj) == "table" and type(override) == "table" then
			parseAccent(themeObj, override)
		end
	end
end

local function updateThemes(target, theme, accent)
	local function deepUpdate(target, new)
		for key, value in pairs(new) do
			if type(value) == "table" and type(target[key]) == "table" and not value.Value then
				deepUpdate(target[key], value)
			elseif target[key] and value and value.Value ~= nil then
				target[key].Value = value.Value
			end
		end
	end
	deepUpdate(target, theme)

	if accent and accent[theme._id] then
		parseAccent(target, accent[theme._id])
	end
end

--// Initialize
cascade.New = function(properties: types.AppProperties): types.App
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end

	properties = properties or {}

	local initialTheme = properties.Theme or themes.Light
	local initialAccent = properties.Accent or accents.Blue

	local currentBaseTheme = initialTheme

	properties.Theme = deepCopy(initialTheme)
	properties.Accent = deepCopy(initialAccent)

	updateThemes(properties.Theme, initialTheme, initialAccent)

	local container = utility.ProtectUI(create("ScreenGui")({
		Name = "Cascade",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 200,

		OnTopOfCoreBlur = true,
	})) :: ScreenGui

	local pill = create("ImageButton")({
		Name = "WindowPill",
		AnchorPoint = Vector2.new(0.5, 0),
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Image = "rbxassetid://93520763686656",
		ImageTransparency = 0.5,
		Position = UDim2.new(0.5, 0, 0, 10),
		Size = UDim2.fromOffset(180, 5),
		Parent = container.__instance,

		create("UICorner")({
			Name = "UICorner",
			CornerRadius = UDim.new(1, 0),
		}),
	}) :: ImageButton

	pill.MouseEnter:Connect(function()
		if currentTween then
			currentTween:Cancel()
		end

		currentTween = tweenService:Create(pill.__instance, tweenInfo, {
			ImageTransparency = 0.15,
		})

		if currentTween then
			currentTween:Play()
		end
	end)

	pill.MouseLeave:Connect(function()
		if currentTween then
			currentTween:Cancel()
		end

		currentTween = tweenService:Create(pill.__instance, tweenInfo, {
			ImageTransparency = 0.5,
		})

		if currentTween then
			currentTween:Play()
		end
	end)

	local object = binder.Wrap(properties, {
		WindowPill = function(value: boolean)
			pill.Visible = value
		end,
		Theme = function(newTheme)
			currentBaseTheme = newTheme
			updateThemes(properties.Theme, newTheme, properties.Accent)
		end,
		Accent = function(newAccent)
			properties.Accent = deepCopy(newAccent, newAccent._id)
			updateThemes(properties.Theme, currentBaseTheme, newAccent)
		end,
	}, container, { "Theme", "Accent" })

	object.Structures = {
		WindowPill = pill,
	}

	for component, make in pairs(components) do
		object[component] = make
	end

	binder.Apply(properties, object)
	task.defer(binder.Apply, properties, object)

	return object
end

return cascade
