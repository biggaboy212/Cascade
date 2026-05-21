--// Imports
local services = require("@modules/services")

--// References
local httpService = services.HttpService

--// Variables
local AppRecorder = {}
AppRecorder.__index = AppRecorder

local INTERNAL_KEYS = {
	Accent = true,
	Structures = true,
	Tabs = true,
	Theme = true,
	__cascadeRecorder = true,
	__cascadeRecorderNode = true,
	__container = true,
	__window = true,
	addToHistory = true,
}

local CALLBACK_KEYS = {
	BindPressed = true,
	Closed = true,
	Pushed = true,
	TextChanged = true,
	ValueChanged = true,
}

local COMPONENT_KEYS = {
	App = { "WindowPill", "Theme", "Accent" },
	Window = {
		"Title",
		"Subtitle",
		"Searching",
		"Draggable",
		"Resizable",
		"CanExit",
		"CanMinimize",
		"CanZoom",
		"Maximized",
		"Minimized",
		"Dropshadow",
		"UIBlur",
		"Size",
		"Position",
	},
	Section = { "Title", "Disclosure", "Expanded", "LayoutOrder", "Visible" },
	Tab = { "Title", "Icon", "Indentation", "Selected", "LayoutOrder", "Visible" },
	Page = { "LayoutOrder", "Visible" },
	PageSection = { "Title", "Subtitle", "LayoutOrder", "Visible" },
	Form = { "LayoutOrder", "Visible" },
	Row = { "SearchIndex", "LayoutOrder", "Visible" },
	HStack = { "Padding", "HorizontalAlignment", "VerticalAlignment", "LayoutOrder", "Visible" },
	VStack = { "Padding", "HorizontalAlignment", "VerticalAlignment", "LayoutOrder", "Visible" },
	TitleStack = { "Title", "Subtitle", "LayoutOrder", "Visible" },
	Label = {
		"Text",
		"RichText",
		"TextXAlignment",
		"TextYAlignment",
		"TextWrapped",
		"LayoutOrder",
		"Visible",
		"Size",
		"Position",
	},
	Symbol = { "Image", "Style", "LayoutOrder", "Visible", "Size", "Position" },
	ImageSurface = { "Image", "ImageColor", "SurfaceColor", "Gradient", "LayoutOrder", "Visible" },
	Toggle = { "Value", "LayoutOrder", "Visible" },
	TextField = { "Placeholder", "Value", "LayoutOrder", "Visible" },
	KeybindField = { "Placeholder", "Value", "LayoutOrder", "Visible" },
	Slider = { "Minimum", "Maximum", "Value", "LayoutOrder", "Visible" },
	Button = { "State", "Label", "LayoutOrder", "Visible" },
	Stepper = { "Minimum", "Maximum", "Step", "Fielded", "Value", "LayoutOrder", "Visible" },
	RadioButtonGroup = { "Options", "Value", "LayoutOrder", "Visible" },
	PopUpButton = { "Options", "Expanded", "Anchor", "Maximum", "Value", "LayoutOrder", "Visible" },
	PullDownButton = { "Options", "Expanded", "Anchor", "Label", "Value", "LayoutOrder", "Visible" },
	Notification = { "Title", "Subtitle", "App", "AppIcon", "Icon", "Duration", "LayoutOrder", "Visible" },
}

local INSTANCE_PROPERTIES = {
	"Visible",
	"Active",
	"AnchorPoint",
	"Position",
	"Size",
	"AutomaticSize",
	"BackgroundColor3",
	"BackgroundTransparency",
	"BorderColor3",
	"BorderMode",
	"BorderSizePixel",
	"ClipsDescendants",
	"LayoutOrder",
	"Rotation",
	"Selectable",
	"SelectionGroup",
	"Text",
	"RichText",
	"TextColor3",
	"TextTransparency",
	"TextSize",
	"TextTruncate",
	"TextWrapped",
	"TextXAlignment",
	"TextYAlignment",
	"FontFace",
	"LineHeight",
	"PlaceholderText",
	"Image",
	"ImageColor3",
	"ImageTransparency",
	"ImageRectOffset",
	"ImageRectSize",
	"ScaleType",
	"SliceCenter",
	"SliceScale",
	"CanvasSize",
	"AutomaticCanvasSize",
	"ScrollBarImageColor3",
	"ScrollBarImageTransparency",
	"ScrollBarThickness",
	"Padding",
	"PaddingBottom",
	"PaddingLeft",
	"PaddingRight",
	"PaddingTop",
	"CornerRadius",
	"FillDirection",
	"HorizontalAlignment",
	"VerticalAlignment",
	"SortOrder",
	"Wraps",
	"Color",
	"Transparency",
	"Thickness",
	"Enabled",
	"ResetOnSpawn",
	"DisplayOrder",
	"IgnoreGuiInset",
	"ZIndexBehavior",
}

--// Functions
local function read(object, key)
	local ok, value = pcall(function()
		return object[key]
	end)

	if ok then
		return value
	end

	return nil
end

local function getInstance(object)
	if typeof(object) == "Instance" then
		return object
	end

	if typeof(object) == "table" then
		local instance = read(object, "__instance")

		if typeof(instance) == "Instance" then
			return instance
		end
	end

	return nil
end

local function fullName(instance: Instance)
	local ok, value = pcall(function()
		return instance:GetFullName()
	end)

	return ok and value or instance.Name
end

local function roundByte(value: number)
	return math.clamp(math.floor(value * 255 + 0.5), 0, 255)
end

local function serializeValue(value, seen, depth)
	depth = depth or 0

	if depth > 8 then
		return {
			_type = "MaxDepth",
		}
	end

	local valueType = typeof(value)

	if valueType == "nil" or valueType == "string" or valueType == "number" or valueType == "boolean" then
		return value
	elseif valueType == "function" then
		return nil
	elseif valueType == "Color3" then
		local r = roundByte(value.R)
		local g = roundByte(value.G)
		local b = roundByte(value.B)

		return {
			_type = "Color3",
			r = r,
			g = g,
			b = b,
			hex = string.format("#%02X%02X%02X", r, g, b),
		}
	elseif valueType == "UDim" then
		return {
			_type = "UDim",
			scale = value.Scale,
			offset = value.Offset,
		}
	elseif valueType == "UDim2" then
		return {
			_type = "UDim2",
			x = {
				scale = value.X.Scale,
				offset = value.X.Offset,
			},
			y = {
				scale = value.Y.Scale,
				offset = value.Y.Offset,
			},
		}
	elseif valueType == "Vector2" then
		return {
			_type = "Vector2",
			x = value.X,
			y = value.Y,
		}
	elseif valueType == "Vector3" then
		return {
			_type = "Vector3",
			x = value.X,
			y = value.Y,
			z = value.Z,
		}
	elseif valueType == "Rect" then
		return {
			_type = "Rect",
			min = serializeValue(value.Min, seen, depth + 1),
			max = serializeValue(value.Max, seen, depth + 1),
		}
	elseif valueType == "NumberRange" then
		return {
			_type = "NumberRange",
			min = value.Min,
			max = value.Max,
		}
	elseif valueType == "NumberSequence" then
		local keypoints = {}

		for _, keypoint in ipairs(value.Keypoints) do
			table.insert(keypoints, {
				time = keypoint.Time,
				value = keypoint.Value,
				envelope = keypoint.Envelope,
			})
		end

		return {
			_type = "NumberSequence",
			keypoints = keypoints,
		}
	elseif valueType == "ColorSequence" then
		local keypoints = {}

		for _, keypoint in ipairs(value.Keypoints) do
			table.insert(keypoints, {
				time = keypoint.Time,
				value = serializeValue(keypoint.Value, seen, depth + 1),
			})
		end

		return {
			_type = "ColorSequence",
			keypoints = keypoints,
		}
	elseif valueType == "EnumItem" then
		return {
			_type = "EnumItem",
			enum = tostring(value.EnumType),
			name = value.Name,
			value = value.Value,
			path = tostring(value),
		}
	elseif valueType == "Font" then
		return {
			_type = "Font",
			family = value.Family,
			weight = value.Weight and value.Weight.Name,
			style = value.Style and value.Style.Name,
		}
	elseif valueType == "Instance" then
		return {
			_type = "Instance",
			className = value.ClassName,
			name = value.Name,
			path = fullName(value),
		}
	elseif valueType ~= "table" then
		return {
			_type = valueType,
			value = tostring(value),
		}
	end

	if seen[value] then
		return {
			_type = "CircularReference",
		}
	end

	seen[value] = true

	if value.Value ~= nil and typeof(value.Connect) == "function" then
		local serialized = {
			_type = "ValueState",
			value = serializeValue(value.Value, seen, depth + 1),
		}

		seen[value] = nil
		return serialized
	end

	local count = 0
	local maxIndex = 0
	local onlyArrayKeys = true

	for key in pairs(value) do
		if typeof(key) == "number" and key % 1 == 0 and key >= 1 then
			maxIndex = math.max(maxIndex, key)
		else
			onlyArrayKeys = false
		end

		count += 1
	end

	local output = {}

	if onlyArrayKeys and count == maxIndex then
		for index = 1, maxIndex do
			local serialized = serializeValue(value[index], seen, depth + 1)
			output[index] = serialized ~= nil and serialized or {
				_type = "Unsupported",
			}
		end
	else
		for key, childValue in pairs(value) do
			local serialized = serializeValue(childValue, seen, depth + 1)

			if serialized ~= nil then
				output[tostring(key)] = serialized
			end
		end
	end

	seen[value] = nil
	return output
end

local function shouldSerializeProperty(key, value)
	if INTERNAL_KEYS[key] or CALLBACK_KEYS[key] then
		return false
	end

	if typeof(key) ~= "string" and typeof(key) ~= "number" then
		return false
	end

	if typeof(value) == "function" then
		return false
	end

	return true
end

local function serializeProperties(properties, object, componentType)
	local output = {}
	local seen = {}

	if componentType == "App" and object then
		local theme = read(object, "Theme")
		local accent = read(object, "Accent")

		if typeof(theme) == "table" and theme._id then
			output.Theme = theme._id
		end

		if typeof(accent) == "table" and accent._id then
			output.Accent = accent._id
		end
	end

	if typeof(properties) == "table" then
		for key, value in pairs(properties) do
			if shouldSerializeProperty(key, value) then
				local serialized = serializeValue(value, seen, 0)

				if serialized ~= nil then
					output[tostring(key)] = serialized
				end
			end
		end
	end

	for _, key in ipairs(COMPONENT_KEYS[componentType] or {}) do
		if shouldSerializeProperty(key, true) then
			local value = object and read(object, key)
			local serialized = serializeValue(value, seen, 0)

			if serialized ~= nil then
				output[key] = serialized
			end
		end
	end

	return output
end

local function serializeAttributes(instance)
	local ok, attributes = pcall(function()
		return instance:GetAttributes()
	end)

	if not ok then
		return {}
	end

	return serializeValue(attributes, {}, 0)
end

local function serializeInstanceProperties(instance)
	local output = {}

	for _, property in ipairs(INSTANCE_PROPERTIES) do
		local value = read(instance, property)
		local serialized = serializeValue(value, {}, 0)

		if serialized ~= nil then
			output[property] = serialized
		end
	end

	return output
end

local function serializeInstance(instance, includeChildren: boolean?)
	if not instance then
		return nil
	end

	local output = {
		className = instance.ClassName,
		name = instance.Name,
		path = fullName(instance),
		properties = serializeInstanceProperties(instance),
		attributes = serializeAttributes(instance),
	}

	if includeChildren then
		output.children = {}

		for _, child in ipairs(instance:GetChildren()) do
			table.insert(output.children, serializeInstance(child, true))
		end
	end

	return output
end

local function serializeNode(node, options)
	local output = {
		type = node.Type,
		properties = serializeProperties(node.Properties, node.Object, node.Type),
		children = {},
	}

	local instance = node.Instance or getInstance(node.Object)

	if options.IncludeInstanceProperties ~= false and instance then
		output.instance = serializeInstance(instance, false)
	end

	for _, child in ipairs(node.Children) do
		table.insert(output.children, serializeNode(child, options))
	end

	return output
end

local function encode(output)
	return httpService:JSONEncode(output)
end

local function makeRoot(app)
	return {
		Type = "App",
		Properties = nil,
		Object = app,
		Instance = getInstance(app),
		Children = {},
	}
end

--// Initialize
function AppRecorder.new(app, options)
	local self = setmetatable({
		Active = false,
		App = app,
		Options = options or {},
		Root = makeRoot(app),
		_objectNodes = setmetatable({}, { __mode = "k" }),
		_stack = {},
	}, AppRecorder)

	self._objectNodes[app] = self.Root

	if typeof(app) == "table" then
		app.__cascadeRecorder = self
		app.__cascadeRecorderNode = self.Root
	end

	return self
end

function AppRecorder.FromContext(context)
	if typeof(context) ~= "table" then
		return nil
	end

	local recorder = read(context, "__cascadeRecorder")

	if typeof(recorder) == "table" and getmetatable(recorder) == AppRecorder then
		return recorder
	end

	return nil
end

function AppRecorder:Start(options)
	if options and options.Reset then
		self:Clear()
	end

	self.Active = true

	if typeof(self.App) == "table" then
		self.App.__cascadeRecorder = self
		self.App.__cascadeRecorderNode = self.Root
	end

	return self
end

function AppRecorder:Stop()
	self.Active = false

	return self
end

function AppRecorder:Clear()
	table.clear(self.Root.Children)
	table.clear(self._stack)

	self._objectNodes = setmetatable({}, { __mode = "k" })
	self._objectNodes[self.App] = self.Root

	return self
end

function AppRecorder:_Begin(context, componentType, properties)
	if not self.Active then
		return nil
	end

	local parentNode = self._stack[#self._stack]

	if not parentNode then
		parentNode = read(context, "__cascadeRecorderNode") or self._objectNodes[context] or self.Root
	end

	local node = {
		Type = componentType,
		Properties = properties,
		Object = nil,
		Instance = nil,
		Children = {},
	}

	table.insert(parentNode.Children, node)
	table.insert(self._stack, node)

	return node
end

function AppRecorder:_Commit(node, object, instance)
	if not node then
		return
	end

	if self._stack[#self._stack] == node then
		table.remove(self._stack)
	end

	node.Object = object
	node.Instance = instance or getInstance(object)

	if typeof(object) == "table" then
		self._objectNodes[object] = node
		object.__cascadeRecorder = self
		object.__cascadeRecorderNode = node
	end
end

function AppRecorder:_Cancel(node)
	if self._stack[#self._stack] == node then
		table.remove(self._stack)
	end
end

function AppRecorder:Dump(options)
	options = options or self.Options or {}

	local output = {
		format = "CascadeAppDump",
		version = 1,
		mode = "recorder",
		root = serializeNode(self.Root, options),
	}

	if options.IncludeInstanceTree then
		output.instanceTree = serializeInstance(getInstance(self.App), true)
	end

	return encode(output)
end

function AppRecorder.DumpApp(app, options)
	local recorder = AppRecorder.FromContext(app)

	if recorder then
		return recorder:Dump(options)
	end

	return encode({
		format = "CascadeAppDump",
		version = 1,
		mode = "instance",
		root = serializeInstance(getInstance(app), true),
	})
end

return AppRecorder
