--// Imports
local binder = require ('@modules/binder')
local creator = require ('@modules/creator')
local services = require ('@modules/services')
local types = require ('@types')
local utility = require ('@modules/utility')

local components = require ('@components/init')
local symbols = require ('@modules/symbols')
local themes = require ('@themes/init')

--// References
local create = creator.Create

local tweenService = services.TweenService

--// Variables
local cascade = { Themes = themes, Symbols = symbols }

local tweenInfo =
    TweenInfo.new (0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local currentTween: Tween? = nil

--// Functions
local function deepCopy (original)
    local copy = {}
    for key, value in pairs (original) do
        local vType = typeof (value)
        if vType == 'table' then
            if
                value.Value ~= nil
                and value.Connect
                and typeof (value.Connect) == 'function'
            then
                copy[key] = creator.Value (value.Value)
            else
                copy[key] = deepCopy (value)
            end
        else
            copy[key] = value
        end
    end
    return copy
end

--// Initialize
cascade.New = function (properties: types.AppProperties): types.App
    if not game:IsLoaded () then
        game.Loaded:Wait ()
    end

    properties = properties or {}

    local initialTheme = properties.Theme or themes.Light
    properties.Theme = deepCopy (initialTheme)

    local container = utility.ProtectUI (create ('ScreenGui') ({
        Name = 'Cascade',
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 200,

        OnTopOfCoreBlur = true,
    })) :: ScreenGui

    local pill = create ('ImageButton') ({
        Name = 'WindowPill',
        AnchorPoint = Vector2.new (0.5, 0),
        AutoButtonColor = false,
        BackgroundColor3 = Color3.fromRGB (255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB (0, 0, 0),
        BorderSizePixel = 0,
        Image = 'rbxassetid://93520763686656',
        ImageTransparency = 0.5,
        Position = UDim2.new (0.5, 0, 0, 10),
        Size = UDim2.fromOffset (180, 5),
        Parent = container.__instance,

        create ('UICorner') ({
            Name = 'UICorner',
            CornerRadius = UDim.new (1, 0),
        }),
    }) :: ImageButton

    pill.MouseEnter:Connect (function ()
        if currentTween then
            currentTween:Cancel ()
        end

        currentTween = tweenService:Create (pill.__instance, tweenInfo, {
            ImageTransparency = 0.15,
        })

        if currentTween then
            currentTween:Play ()
        end
    end)

    pill.MouseLeave:Connect (function ()
        if currentTween then
            currentTween:Cancel ()
        end

        currentTween = tweenService:Create (pill.__instance, tweenInfo, {
            ImageTransparency = 0.5,
        })

        if currentTween then
            currentTween:Play ()
        end
    end)

    local object = binder.Wrap (properties, {
        WindowPill = function (value: boolean)
            pill.Visible = value
        end,
        Theme = function (theme)
            local function deepUpdate (target, new)
                for key, value in pairs (new) do
                    if
                        typeof (value) == 'table'
                        and typeof (target[key]) == 'table'
                        and not value.Value
                    then
                        deepUpdate (target[key], value)
                    elseif target[key] and value and value.Value ~= nil then
                        target[key].Value = value.Value
                    end
                end
            end

            deepUpdate (properties.Theme, theme)
        end,
    }, container, { 'Theme' })

    object.Structures = {
        WindowPill = pill,
    }

    for component, make in pairs (components) do
        object[component] = make
    end

    binder.Apply (properties, object)
    task.defer (binder.Apply, properties, object)

    return object
end

return cascade
