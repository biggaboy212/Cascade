--// Imports
local createStructure = require("@structures/DropdownMenu")
local services = require("@modules/services")
local utility = require("@modules/utility")

--// Types
type DropdownMenuConfig = {
	Name: string?,
	Anchor: any?,
	AnchorMode: string?,
	Gap: number?,
	MaxHeight: number?,
	AutoScroll: boolean?,
	ShowsCheckmarks: boolean?,
	OnSelected: ((any, number) -> ())?,
}

--// Constants
local EDGE_BUFFER = 6
local HORIZONTAL_OFFSET = -1
local PULLDOWN_GAP = 6

--// Variables
local DropdownMenu = {}
DropdownMenu.__index = DropdownMenu

local userInputService = services.UserInputService
local tweenService = services.TweenService
local workspace = services.Workspace
local guiService = services.GuiService

--// Private Methods
local function unwrap(object)
	if typeof(object) == "table" then
		local success, instance = pcall(function()
			return object.__instance
		end)

		if success and typeof(instance) == "Instance" then
			return instance
		end
	end

	return object
end

local function pointInside(guiObject: GuiObject?, x: number, y: number): boolean
	if not guiObject then
		return false
	end

	local position = guiObject.AbsolutePosition
	local size = guiObject.AbsoluteSize

	return x >= position.X
		and x <= position.X + size.X
		and y >= position.Y
		and y <= position.Y + size.Y
end

local function firstSelectedIndex(value): number?
	if typeof(value) == "table" then
		return value[1]
	end

	if typeof(value) == "number" then
		return value
	end

	return nil
end

local function readAnchorValue(anchor, key)
	if typeof(anchor) ~= "table" then
		return nil
	end

	return anchor[key]
end

local function mountMenuContainer(container): boolean
	local instance = unwrap(container)

	if typeof(instance) ~= "Instance" then
		return false
	end

	if instance.Parent then
		return true
	end

	return typeof(utility.ProtectUI(instance)) == "Instance"
end

--// Public Methods
function DropdownMenu.new(context, componentStructures, config: DropdownMenuConfig?)
	config = config or {}

	local menuStructures = createStructure(context, {
		Name = config.Name,
	})

	componentStructures.MenuContainer = menuStructures.Container.__instance
	componentStructures.MenuBody = menuStructures.Body
	componentStructures.Menu = menuStructures.Menu
	componentStructures.Options = componentStructures.Options or {}

	local self = setmetatable({
		Context = context,
		Structures = componentStructures,
		MenuStructures = menuStructures,
		Object = nil,
		Anchor = config.Anchor,
		AnchorMode = config.AnchorMode or "BelowButton",
		Gap = config.Gap or PULLDOWN_GAP,
		MaxHeight = config.MaxHeight,
		ShowsCheckmarks = config.ShowsCheckmarks == true,
		AutoScroll = config.AutoScroll ~= false,
		OnSelected = config.OnSelected,
		SelectedValue = nil,
		Tween = nil,
		TweenToken = 0,
		Bound = false,
	}, DropdownMenu)

	return self
end

function DropdownMenu:SetObject(object)
	self.Object = object
	self:Bind()
end

function DropdownMenu:SetAnchor(anchor)
	self.Anchor = anchor
	self:AnchorMenu()
end

function DropdownMenu:SetAnchorMode(anchorMode: string)
	self.AnchorMode = anchorMode
	self:AnchorMenu()
end

function DropdownMenu:SetValue(value)
	self.SelectedValue = value
	self:AnchorMenu()
end

function DropdownMenu:GetAnchorElement(): GuiObject?
	local anchor = self.Anchor
	local anchorInstance = unwrap(anchor)

	if typeof(anchorInstance) == "Instance" then
		return anchorInstance
	end

	local anchorElement = readAnchorValue(anchor, "Object")
		or readAnchorValue(anchor, "Element")
		or readAnchorValue(anchor, "Label")
		or self.Structures.CurrentTab
		or self.Structures.Body

	return unwrap(anchorElement)
end

function DropdownMenu:GetAnchorOption(): number
	return readAnchorValue(self.Anchor, "Option") or firstSelectedIndex(self.SelectedValue) or 1
end

function DropdownMenu:GetAnchorOffsets(): (number, number)
	local anchor = self.Anchor
	local offset = readAnchorValue(anchor, "Offset")
	local xOffset = readAnchorValue(anchor, "XOffset") or 0
	local yOffset = readAnchorValue(anchor, "YOffset") or 0

	if typeof(offset) == "Vector2" then
		xOffset += offset.X
		yOffset += offset.Y
	end

	return xOffset, yOffset
end

function DropdownMenu:GetOptionLabel(index: number): TextLabel?
	local option = self.Structures.Options[index]

	if not option then
		return nil
	end

	return option:FindFirstChild("Label") :: TextLabel?
end

function DropdownMenu:ScrollToAnchorOption()
	local menu = self.Structures.Menu

	if not menu then
		return
	end

	local option = self.Structures.Options[self:GetAnchorOption()]
	local contentHeight = menu.AbsoluteCanvasSize.Y
	local viewportHeight = menu.AbsoluteSize.Y
	local maxCanvasY = math.max(0, contentHeight - viewportHeight)

	if not option or maxCanvasY <= 0 then
		menu.CanvasPosition = Vector2.new(menu.CanvasPosition.X, 0)
		return
	end

	local optionY = option.AbsolutePosition.Y - menu.AbsolutePosition.Y + menu.CanvasPosition.Y
	local optionHeight = option.AbsoluteSize.Y
	local desiredCanvasY = optionY - ((viewportHeight - optionHeight) / 2)

	menu.CanvasPosition = Vector2.new(menu.CanvasPosition.X, math.clamp(desiredCanvasY, 0, maxCanvasY))
end

function DropdownMenu:Resize()
	local menu = self.Structures.Menu

	if not menu then
		return
	end

	menu.AutomaticSize = Enum.AutomaticSize.XY

	if not self.MaxHeight then
		return
	end

	task.defer(function()
		if not menu then
			return
		end

		local menuHeight = menu.AbsoluteSize.Y

		if menuHeight >= self.MaxHeight then
			menu.AutomaticSize = Enum.AutomaticSize.X
			menu.Size = UDim2.fromOffset(0, self.MaxHeight)
		else
			menu.Size = UDim2.fromOffset(0, menuHeight)
			menu.AutomaticSize = Enum.AutomaticSize.X
		end

		self:AnchorMenu()
	end)
end

function DropdownMenu:AnchorMenu()
	local body = unwrap(self.Structures.Body)
	local menu = self.Structures.Menu
	local menuParent = menu and menu.Parent

	if not menu or not body or not menuParent then
		return
	end

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	if self.AutoScroll then
		self:ScrollToAnchorOption()
	end

	local bodyPosition = body.AbsolutePosition
	local bodySize = body.AbsoluteSize
	local menuPosition = menu.AbsolutePosition
	local parentPosition = menuParent.AbsolutePosition
	local menuSize = menu.AbsoluteSize
	local viewportSize = camera.ViewportSize
	local desiredScreenX = bodyPosition.X + bodySize.X - menuSize.X + HORIZONTAL_OFFSET
	local desiredScreenY = bodyPosition.Y + bodySize.Y + self.Gap
	local xOffset, yOffset = self:GetAnchorOffsets()

	if self.AnchorMode == "SelectedLabel" then
		local anchorElement = self:GetAnchorElement()
		local optionLabel = self:GetOptionLabel(self:GetAnchorOption())

		if anchorElement and optionLabel then
			local labelOffset = optionLabel.AbsolutePosition - menuPosition

			desiredScreenX = anchorElement.AbsolutePosition.X - labelOffset.X
			desiredScreenY = anchorElement.AbsolutePosition.Y - labelOffset.Y
		elseif anchorElement then
			desiredScreenX = anchorElement.AbsolutePosition.X + HORIZONTAL_OFFSET
			desiredScreenY = anchorElement.AbsolutePosition.Y
		end
	end

	desiredScreenX += xOffset
	desiredScreenY += yOffset

	local maxX = math.max(EDGE_BUFFER, viewportSize.X - EDGE_BUFFER - menuSize.X)
	local maxY = math.max(EDGE_BUFFER, viewportSize.Y - EDGE_BUFFER - menuSize.Y)

	desiredScreenX = math.clamp(desiredScreenX, EDGE_BUFFER, maxX)
	desiredScreenY = math.clamp(desiredScreenY, EDGE_BUFFER, maxY)

	menu.Position = UDim2.fromOffset(desiredScreenX - parentPosition.X, desiredScreenY - parentPosition.Y)
end

function DropdownMenu:SetExpanded(value: boolean)
	local expand = value == true
	local body = unwrap(self.Structures.Body)
	local container = unwrap(self.Structures.MenuContainer)

	self.TweenToken += 1
	local tweenToken = self.TweenToken

	if self.Tween then
		self.Tween:Cancel()
		self.Tween = nil
	end

	if expand and body then
		self.Structures.MenuBody.GroupTransparency = 1

		if not mountMenuContainer(self.Structures.MenuContainer) then
			return
		end
	elseif not expand and container and not container.Parent then
		self.Structures.MenuBody.GroupTransparency = 1
		return
	end

	self:Resize()
	self:AnchorMenu()
	task.defer(function()
		self:AnchorMenu()
	end)

	local goal = { GroupTransparency = expand and 0 or 1 }
	local tweenInfo = TweenInfo.new(expand and 0 or 0.4, Enum.EasingStyle.Exponential)
	local tween = tweenService:Create(self.Structures.MenuBody, tweenInfo, goal)

	self.Tween = tween
	tween:Play()
	tween.Completed:Connect(function(playbackState)
		if tweenToken ~= self.TweenToken then
			return
		end

		if self.Tween == tween then
			self.Tween = nil
		end

		if playbackState ~= Enum.PlaybackState.Completed then
			return
		end

		if not expand and self.Object and self.Object.Expanded == false then
			self.Structures.MenuContainer.Parent = nil
		end
	end)
end

function DropdownMenu:SetSelectedMap(selected)
	if not self.ShowsCheckmarks then
		return
	end

	for index, option in ipairs(self.Structures.Options) do
		if not option then
			continue
		end

		local checkmark = option:FindFirstChild("Checkmark")
		local checkmarkReplacement = option:FindFirstChild("CheckmarkRepl")
		local isSelected = selected[index] == true

		if checkmark then
			checkmark.Visible = isSelected
		end

		if checkmarkReplacement then
			checkmarkReplacement.Visible = not isSelected
		end
	end
end

function DropdownMenu:ResetItemColors(option: TextButton)
	local label = option:FindFirstChild("Label")
	local checkmark = option:FindFirstChild("Checkmark")

	option.BackgroundTransparency = 1

	if label then
		label.TextColor3 = self.Context.Theme.Text.Primary[1].Value
		label.TextTransparency = self.Context.Theme.Text.Primary[2].Value
	end

	if checkmark then
		checkmark.ImageColor3 = self.Context.Theme.Text.Primary[1].Value
		checkmark.ImageTransparency = self.Context.Theme.Text.Primary[2].Value
	end
end

function DropdownMenu:HighlightItem(option: TextButton)
	local label = option:FindFirstChild("Label")
	local checkmark = option:FindFirstChild("Checkmark")

	option.BackgroundTransparency = self.Context.Theme.Controls.SelectionFocused[2].Value

	if label then
		label.TextColor3 = self.Context.Theme.Controls.SelectionFocusedAccent[1].Value
		label.TextTransparency = self.Context.Theme.Controls.SelectionFocusedAccent[2].Value
	end

	if checkmark then
		checkmark.ImageColor3 = self.Context.Theme.Controls.SelectionFocusedAccent[1].Value
		checkmark.ImageTransparency = self.Context.Theme.Controls.SelectionFocusedAccent[2].Value
	end
end

function DropdownMenu:AddOption(name: string?, index: number): TextButton
	local option = self.MenuStructures.Item(name, index, self.ShowsCheckmarks)

	self.Structures.Options[index] = option

	option:GetPropertyChangedSignal("GuiState"):Connect(function()
		if not self.Object or not self.Object.Expanded then
			return
		end

		if option.GuiState == Enum.GuiState.Hover then
			self:HighlightItem(option)
		else
			self:ResetItemColors(option)
		end
	end)

	option.MouseButton1Click:Connect(function()
		if self.OnSelected and self.Object then
			self.OnSelected(self.Object, index)
		end
	end)

	self:Resize()
	task.defer(function()
		self:AnchorMenu()
	end)

	return option
end

function DropdownMenu:ClearOptions()
	for _, option in ipairs(self.Structures.Options) do
		option:Destroy()
	end

	table.clear(self.Structures.Options)
	self:Resize()
end

function DropdownMenu:RemoveOption(index: number?)
	if index and self.Structures.Options[index] then
		self.Structures.Options[index]:Destroy()
		self.Structures.Options[index] = nil
	end

	self:Resize()
end

function DropdownMenu:Bind()
	if self.Bound then
		return
	end

	self.Bound = true

	self.Structures.Body:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		self:AnchorMenu()
	end)
	self.Structures.Body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		self:AnchorMenu()
	end)
	self.Structures.Menu:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		self:AnchorMenu()
	end)

	userInputService.InputBegan:Connect(function(input)
		if
			not self.Object
			or not self.Object.Expanded
			or (
				input.UserInputType ~= Enum.UserInputType.MouseButton1
				and input.UserInputType ~= Enum.UserInputType.Touch
			)
		then
			return
		end

		local mouse = userInputService:GetMouseLocation()
		local inset = guiService:GetGuiInset()
		local adjustedY = mouse.Y - inset.Y
		local body = unwrap(self.Structures.Body)
		local insideBody = pointInside(body, mouse.X, adjustedY) or pointInside(body, mouse.X, mouse.Y)

		if
			not pointInside(self.Structures.Menu, mouse.X, adjustedY)
			and not insideBody
		then
			self.Object.Expanded = false
		end
	end)

	self.Structures.Body.MouseButton1Click:Connect(function()
		if self.Object then
			self.Object.Expanded = not self.Object.Expanded
		end
	end)
end

--// Publish
return DropdownMenu
