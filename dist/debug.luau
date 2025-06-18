--!nolint
--!nocheck
--!optimize 2

--[[
    @author Proton-Utilities
    @name Cascade
    @description A LuaU UI library based on macOS
    @license MIT License

    This file was automatically generated with darklua, it is not intended for manual editing.
--]]

--// Types
type ExpectedObject__DARKLUA_TYPE_a = ((...any) -> ...any) | Instance | SomeOtherService
type ScreenGui__DARKLUA_TYPE_b = {
	-- Instance
	Name: string?,
	Parent: Instance?,
	Archivable: boolean?,
	ClassName: string?,

	-- GuiBase2d
	AutoLocalize: boolean?,
	RootLocalizationTable: LocalizationTable?,
	SelectionBehaviorDown: Enum.SelectionBehavior?,
	SelectionBehaviorLeft: Enum.SelectionBehavior?,
	SelectionBehaviorRight: Enum.SelectionBehavior?,
	SelectionBehaviorUp: Enum.SelectionBehavior?,
	SelectionGroup: boolean?,

	-- LayerCollector
	Enabled: boolean?,
	ResetOnSpawn: boolean?,
	ZIndexBehavior: Enum.ZIndexBehavior?,

	-- ScreenGui
	DisplayOrder: number?,
	IgnoreGuiInset: boolean?,
	ScreenInsets: Enum.ScreenInsets?,
	ClipToDeviceSafeArea: boolean?,
	SafeAreaCompatibility: Enum.SafeAreaCompatibility?
}

type Frame__DARKLUA_TYPE_c = {
	-- Instance
	Name: string?,
	Parent: Instance?,
	Archivable: boolean?,
	ClassName: string?,
	
	-- GuiObject
	AnchorPoint: Vector2?,
	BackgroundColor3: Color3?,
	BackgroundTransparency: number?,
	BorderColor3: Color3?,
	BorderMode: Enum.BorderMode?,
	BorderSizePixel: number?,
	ClipsDescendants: boolean?,
	LayoutOrder: number?,
	Position: UDim2?,
	Rotation: number?,
	Selectable: boolean?,
	SelectionImageObject: GuiObject?,
	Size: UDim2?,
	SizeConstraint: Enum.SizeConstraint?,
	Visible: boolean?,
	ZIndex: number?,
	AutomaticSize: Enum.AutomaticSize?,

	-- Frame
	Style: Enum.FrameStyle?
}

type ValueState__DARKLUA_TYPE_d = {
	Value: any,
	Connect: (...any) -> any
}

type Theme__DARKLUA_TYPE_e = {[any]: any} -- TODO

type Window__DARKLUA_TYPE_f = Frame__DARKLUA_TYPE_c & {
	WindowControls: {
		Exit: boolean?,
		Minimize: boolean?,
		Zoom: boolean?	
}?,
	
	Draggable: boolean?,
	Resizable: boolean?,
	SidebarButton: boolean?,
	Navigation: boolean?,
	SearchField: boolean?,
	Title: string?,
	Description: string?,

	Dropshadow: boolean?,
	UIBlur: boolean?
}

type AppProperties__DARKLUA_TYPE_g = ScreenGui__DARKLUA_TYPE_b & {
	Theme: Theme__DARKLUA_TYPE_e?
}

type App__DARKLUA_TYPE_h = AppProperties__DARKLUA_TYPE_g & {
	Window: ((Window__DARKLUA_TYPE_f) -> Window__DARKLUA_TYPE_f)
}
local __DIST __DIST={cache={}, load=function(m)if not __DIST.cache[m]then __DIST.cache[m]={c=__DIST[m]()}end return __DIST.cache[m].c end}do function __DIST.a()
--// Variables



local utility = {}

--// Initialize
utility.Clone = function(object: ExpectedObject__DARKLUA_TYPE_a)
	local clonedObject: ExpectedObject__DARKLUA_TYPE_a

	if type(object) == "function" then
		clonedObject = clonefunction and clonefunction(object)
	elseif typeof(object) == "Instance" then
		clonedObject = cloneref and cloneref(object)
	end

	return clonedObject or object
end

utility.ProtectUI = function(gui: Instance): ScreenGui | string
	local success, returned = pcall(function()
		gui.Parent = utility.Clone(game:GetService("RunService")):IsStudio()
				and utility.Clone(game:GetService("Players")).LocalPlayer.PlayerGui
			or gethui and gethui()
			or utility.Clone(game:GetService("CoreGui"))
	end)

	return success and gui or returned
end

return utility
end function __DIST.b()





























































































return 1
end function __DIST.c()
local binder = {}

function binder.Apply(properties: { [string]: any }, object: any, excludes: {[number]: string}?): any
	for property, value in pairs(properties) do
		if excludes and table.find(excludes, property) then
			continue
		end
		
		pcall(function()
			object[property] = value
		end)
	end

	return object
end

function binder.Wrap(object: { [string]: any }, bindings: { [string]: (any) -> () }, instance: Instance?): any
	local proxy = {}

	setmetatable(proxy, {
		__index = function(_, key)
			if object[key] ~= nil then
				return object[key]
			elseif instance then
				local ok, value = pcall(function()
					return instance[key]
				end)

				if ok then
					return value
				end
			end

			return
		end,

		__newindex = function(_, key, value)
			local handler = bindings[key]

			if handler then
				handler(value)

				object[key] = value
			elseif instance then
				local ok, _ = pcall(function()
					instance[key] = value
				end)

				if not ok then
					object[key] = value
				end
			else
				object[key] = value
			end
		end,
	})

	return proxy
end

return binder
end function __DIST.d()
local types = __DIST.load('b')
local binder = __DIST.load('c')
local creator = {}

function creator.Value(value: any): ValueState__DARKLUA_TYPE_d	
local callbacks = {}

	return binder.Wrap({
		Value = value,
		Connect = function(self, fn)
			table.insert(callbacks, fn)
		end,
	}, {
		Value = function(newValue)
			for _, callback in pairs(callbacks) do
				pcall(callback, newValue)
			end
		end,
	})
end

function creator.Create(className: string)
	return function(properties)
		properties = properties or {}

		local instance = Instance.new(className)

		for key, value in pairs(properties) do
			if key == "__dynamicKeys" and type(value) == "table" then
				for property, valueObject: ValueState__DARKLUA_TYPE_d in pairs(value) do
					pcall(function()
						instance[property] = valueObject.Value
					end)

					valueObject:Connect(function(newValue)
						pcall(function()
							instance[property] = newValue
						end)
					end)
				end

				continue
			elseif typeof(value) == "table" and value.__unique then
				value.Parent = instance
			end

			pcall(function()
				instance[key] = value
			end)
		end

		return setmetatable({ __unique = true }, {
			__metatable = instance,
			__index = function(_, key)
				if key == "__instance" then
					return instance
				end

				local value = instance[key]

				if typeof(value) == "function" then
					return function(_, ...)
						return value(instance, ...)
					end
				else
					return value
				end
			end,
			__newindex = function(_, key, value)
				instance[key] = value
			end,
		})
	end
end

return creator
end function __DIST.e()--// Imports

local creator = __DIST.load('d')

--// References
local value = creator.Value

--// Functions
local function Color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex("#" .. color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100))
	}
end

--// Initialize
return {
	Accents = {
		Red = Color4("FF453A", 100),
	},

	Controls = {
		Sidebar = Color4("000000", 45)
	},
}end function __DIST.f()--// Imports

local creator = __DIST.load('d')

--// References
local value = creator.Value

--// Functions
local function Color4(color: Color3 | string, alpha: number)
	local parsedColor = (typeof(color) == "Color3" and color) or (typeof(color) == "string" and Color3.fromHex(color))

	return {
		Color = value(parsedColor),
		Transparency = value(1 - (alpha / 100)),
	}
end

--// Initialize
return {
	Accents = {
		Red = Color4("FF3B30", 100),
	},

	Controls = {
		Sidebar = Color4("EAEAEA", 84)
	},
}
end function __DIST.g()
return {
	Dark = __DIST.load('e'),
	Light = __DIST.load('f'),
}
end function __DIST.h()--// Imports

local creator = __DIST.load('d')

--// References
local create = creator.Create

--// Initialize
return function(parent: GuiObject, color: Color3, transparency: number, spread: number)
	local function gaussian(n, sigma)
		local weights = {}
		local sum = 0

		for i = -n, n do
			local weight = math.exp(-((i ^ 2) / (2 * sigma ^ 2)))
			table.insert(weights, weight)
			sum += weight
		end

		for i = 1, #weights do
			weights[i] = (weights[i] / sum) * (1 - transparency)
		end

		return weights
	end

	local sigma = spread / 2
	local weights = gaussian(spread, sigma)
	local layers = create("Folder")({
		Name = "ShadowLayers",
	})

	local function changed()
		layers:ClearAllChildren()
		layers.Parent = parent.Parent

		if not parent.Visible then
			return
		end

		for i, opacity in ipairs(weights) do
			local index = i - math.floor(#weights / 2)
			local offsetAmount = math.abs(index) - 1

			local layer = create("Frame")({
				Name = `Layer{i}`,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = parent.ZIndex - 1,
				AnchorPoint = parent.AnchorPoint,
				Position = parent.Position,
				Size = UDim2.fromOffset(
					parent.AbsoluteSize.X + (offsetAmount * 2),
					parent.AbsoluteSize.Y + (offsetAmount * 2)
				),
				Parent = layers.__instance,

				create("UIStroke")({
					Name = "UIStroke",
					Color = color,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = 1 - opacity,
				}),
			})

			local corner = parent:FindFirstChildOfClass("UICorner")
			if corner then
				corner:Clone().Parent = layer.__instance
			end
		end
	end

	changed()

    parent:GetPropertyChangedSignal("Visible"):Connect(changed)
	parent:GetPropertyChangedSignal("ZIndex"):Connect(changed)
	parent:GetPropertyChangedSignal("Position"):Connect(changed)
	parent:GetPropertyChangedSignal("Size"):Connect(changed)
	parent:GetPropertyChangedSignal("AnchorPoint"):Connect(changed)
	parent.ChildAdded:Connect(changed)
	parent.ChildRemoved:Connect(changed)
	parent.AncestryChanged:Connect(changed)
    parent.Destroying:Connect(function()
		layers:Destroy()
	end)

	return layers
end
end function __DIST.i()--// Imports

local utility = __DIST.load('a')

--// Functions
local function cast(service: string): any
	return utility.Clone(game:GetService(service))
end

--// Initialize
return {
	TweenService = cast("TweenService") :: TweenService,
	RunService = cast("RunService") :: RunService,
	UserInputService = cast("UserInputService") :: UserInputService,

	Workspace = cast("Workspace") :: Workspace,
	Players = cast("Players") :: Players,
	Lighting = cast("Lighting") :: Lighting,
}
end function __DIST.j()--[[
	@original dawid-script/Fluent/src/modules/Acrylic
]]

--// Imports

local services = __DIST.load('i')
local creator = __DIST.load('d')

--// References
local workspace = services.Workspace
local lighting = services.Lighting

local create = creator.Create

--// Functions
local function map(value, inMin, inMax, outMin, outMax)
	return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
end

local function viewportPointToWorld(location, distance)
	local unitRay = workspace.CurrentCamera:ScreenPointToRay(location.X, location.Y)
	return unitRay.Origin + unitRay.Direction * distance
end

local function getOffset()
	local viewportSizeY = workspace.CurrentCamera.ViewportSize.Y
	return map(viewportSizeY, 0, 2560, 8, 56)
end

--// Initialize
local function createBlur(distance: number?)
	local blurEffects = Instance.new("Folder", workspace.CurrentCamera)
	local connections = {}

	local triPositions = {
		topLeft = Vector2.new(),
		topRight = Vector2.new(),
		bottomRight = Vector2.new(),
	}
	local model = create("Part")({
		Color = Color3.new(0, 0, 0),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
		CanCollide = false,
		Locked = true,
		CastShadow = false,
		Transparency = 1,

		create("SpecialMesh")({
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),

		create("Highlight")({
			FillColor = Color3.fromRGB(255, 255, 255),
			FillTransparency = 1,
			OutlineTransparency = 1,
		})
	})
	local effect = create("DepthOfFieldEffect")({
		FarIntensity = 0,
		NearIntensity = 1,
		InFocusRadius = 0.1,
		Parent = lighting,
	})
	local mesh = model:FindFirstChildWhichIsA("SpecialMesh")

	distance = distance or 0.001

	local function updatePositions(size, position)
		triPositions.topLeft = position
		triPositions.topRight = position + Vector2.new(size.X, 0)
		triPositions.bottomRight = position + size
	end

	local function render()
		local camera = workspace.CurrentCamera
		local cameraTransform = if camera then camera.CFrame else CFrame.identity

		local topLeft = triPositions.topLeft
		local topRight = triPositions.topRight
		local bottomRight = triPositions.bottomRight

		local topLeft3D = viewportPointToWorld(topLeft, distance)
		local topRight3D = viewportPointToWorld(topRight, distance)
		local bottomRight3D = viewportPointToWorld(bottomRight, distance)

		local width = (topRight3D - topLeft3D).Magnitude
		local height = (topRight3D - bottomRight3D).Magnitude

		model.CFrame = CFrame.fromMatrix(
			(topLeft3D + bottomRight3D) / 2,
			cameraTransform.XVector,
			cameraTransform.YVector,
			cameraTransform.ZVector
		)

		if mesh then
			mesh.Scale = Vector3.new(width, height, 0)
		end
	end

	local function onChange(rbx)
		local offset = getOffset()
		local size = rbx.AbsoluteSize - Vector2.new(offset, offset)
		local position = rbx.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

		updatePositions(size, position)
		task.spawn(render)
	end

	local function renderOnChange()
		local camera = workspace.CurrentCamera

		if not camera then
			return
		end

		connections[#connections + 1] = camera:GetPropertyChangedSignal("CFrame"):Connect(render)
		connections[#connections + 1] = camera:GetPropertyChangedSignal("ViewportSize"):Connect(render)
		connections[#connections + 1] = camera:GetPropertyChangedSignal("FieldOfView"):Connect(render)

		task.spawn(render)
	end

	model.Parent = blurEffects

	model.Destroying:Connect(function()
		for _, item in connections do
			pcall(function()
				effect:Destroy()
				blurEffects:Destroy()
				item:Disconnect()
			end)
		end
	end)

	renderOnChange()

	return onChange, model, model:FindFirstChildOfClass("Highlight")
end

return function(frame: GuiObject, distance: number?)
	local blur = {}
	local onChange, model, highlight: Highlight = createBlur(distance)

	onChange(frame)

	frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		onChange(frame)
	end)

	frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		onChange(frame)
	end)

	blur.SetVisibility = function(Value)
		highlight.Enabled = Value
	end

	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		blur.SetVisibility(frame.Visible)
	end)

	blur.Model = model

	return blur
end
end function __DIST.k()
return {
	Dropshadow = __DIST.load('h'),
	UIBlur = __DIST.load('j'),
}
end function __DIST.l()
local types = __DIST.load('b')

return function(self, properties: Window__DARKLUA_TYPE_f)
	--// Imports
	local effects = __DIST.load('k')
	local creator = __DIST.load('d')
	local binder = __DIST.load('c')

	--// References
	local create = creator.Create

	--// Variables
	local structures = {}

	--// UI
	properties = {
		WindowControls = {
			Exit = properties and properties.WindowControls and properties.WindowControls.Exit or true,
			Minimize = properties and properties.WindowControls and properties.WindowControls.Minimize or true,
			Zoom = properties and properties.WindowControls and properties.WindowControls.Zoom or true,
		},

		Draggable = properties and properties.Draggable or true,
		Resizable = properties and properties.Resizable or true,
		SidebarButton = properties and properties.SidebarButton or true,
		Navigation = properties and properties.Navigation or true,
		SearchField = properties and properties.SearchField or true,
		Title = properties and properties.Title or "Title",
		Description = properties and properties.Description or "Description",

		Dropshadow = properties and properties.Dropshadow or true,
		UIBlur = properties and properties.UIBlur or true,
	}

	structures.Body = binder.Apply(
		properties,
		create("Frame")({
			Name = "Body",
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(850, 530),
			Parent = self.__instance,

			__dynamicKeys = {
				BackgroundColor3 = self.Theme.Controls.Sidebar.Color,
				BackgroundTransparency = self.Theme.Controls.Sidebar.Transparency,
			},

			create("UICorner")({
				Name = "UICorner",
				CornerRadius = UDim.new(0, 10),
			}),

			create("UIDragDetector")({
				ActivatedCursorIcon = "rbxasset://0",
				CursorIcon = "rbxasset://0",
				DragUDim2 = UDim2.fromOffset(11, 0),
				SelectionModeDragSpeed = UDim2.fromScale(1, 1),
			}),

			create("UIListLayout")({
				Name = "UIListLayout",
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, -1),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),

			create("Folder")({
				Name = "Handles",

				create("TextButton")({
					Name = "W",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 0.5),
					Selectable = false,
					Size = UDim2.new(0, 5, 1, -10),
					Text = "",
				}),

				create("TextButton")({
					Name = "N",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.5, 0),
					Selectable = false,
					Size = UDim2.new(1, -10, 0, 5),
					Text = "",
				}),

				create("TextButton")({
					Name = "SE",
					Active = false,
					AnchorPoint = Vector2.new(1, 1),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 1),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "NW",
					Active = false,
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "SW",
					Active = false,
					AnchorPoint = Vector2.new(0, 1),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0, 1),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("TextButton")({
					Name = "S",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(0.5, 1),
					Selectable = false,
					Size = UDim2.new(1, -10, 0, 5),
					Text = "",
				}),

				create("TextButton")({
					Name = "E",
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0.5),
					Selectable = false,
					Size = UDim2.new(0, 5, 1, -10),
					Text = "",
				}),

				create("TextButton")({
					Name = "NE",
					Active = false,
					AnchorPoint = Vector2.new(1, 0),
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.fromScale(1, 0),
					Selectable = false,
					Size = UDim2.fromOffset(8, 8),
					Text = "",
				}),

				create("Frame")({
					Name = "TopArea",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 52),
				}),
			}),
		})
	) :: Frame

	--// Initialize
	structures.Dragger = structures.Body:FindFirstChild("UIDragDetector") :: UIDragDetector
	structures.Handles = structures.Body:FindFirstChild("Handles") :: Folder

	structures.Dragger.BoundingUI = structures.Handles:FindFirstChild("TopArea")

	local object = binder.Wrap(properties, {
		Draggable = function(state: boolean)
			structures.Dragger.Enabled = state
		end,
		Dropshadow = function(state: boolean)
			if structures["ShadowLayers"] then
				structures["ShadowLayers"]:Destroy()
			end

			if state then
				structures.ShadowLayers = effects.Dropshadow(structures.Body, Color3.new(0, 0, 0), 0.25, 14)
			end
		end,
		UIBlur = function(state: boolean)
			if structures["BlurModel"] then
				structures["BlurModel"].Model:Destroy()
				structures["BlurModel"] = nil
			end

			if state then
				structures.BlurModel = effects.UIBlur(structures.Body)
			end
		end,
	}, structures.Body)

	binder.Apply(properties, object)

	return object
end
end function __DIST.m()
return {
	Window = __DIST.load('l'),
}
end end--// Imports

local utility = __DIST.load('a')
local types = __DIST.load('b')
local creator = __DIST.load('d')
local binder = __DIST.load('c')

local themes = __DIST.load('g')
local components = __DIST.load('m')

--// References
local create = creator.Create

--// Variables
local cascade = { Themes = themes }

--// Initialize
cascade.New = function(properties: AppProperties__DARKLUA_TYPE_g): App__DARKLUA_TYPE_h	
properties = {
		Theme = properties and properties.Theme or themes.Light,
	}

	local container = utility.ProtectUI(create("ScreenGui")({
		Name = "Cascade",
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ScreenInsets = Enum.ScreenInsets.None,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

		OnTopOfCoreBlur = true,
	}))

	local object = binder.Wrap(properties, {
		Theme = function(value)
			cascade.Theme = value
		end,
	}, container)

	for component, make in pairs(components) do
		properties[component] = function(...)
			return make(object, ...)
		end
	end

	binder.Apply(properties, object)

	return object
end

return cascade
