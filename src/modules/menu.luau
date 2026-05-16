--// Imports

local services = require("@modules/services")

--// Variables

local menu = {}

local userInputService = services.UserInputService
local guiService = services.GuiService
local workspace = services.Workspace

--// Constants

local EDGE_BUFFER = 6
local DEFAULT_VERTICAL_PADDING = 6

--// Public Methods

function menu.anchor(body: GuiObject, popup: GuiObject, options)
	options = options or {}

	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	local bodyPos = body.AbsolutePosition
	local bodySize = body.AbsoluteSize
	local popupSize = popup.AbsoluteSize
	local viewportSize = camera.ViewportSize

	local desiredX = bodyPos.X + (options.HorizontalOffset or -1)
	local desiredY = bodyPos.Y + bodySize.Y + (options.VerticalPadding or DEFAULT_VERTICAL_PADDING)

	if options.AnchorElement then
		desiredX = options.AnchorElement.AbsolutePosition.X + (options.HorizontalOffset or -1)
	end

	local maxX = math.max(EDGE_BUFFER, viewportSize.X - EDGE_BUFFER - popupSize.X)
	local maxY = math.max(EDGE_BUFFER, viewportSize.Y - EDGE_BUFFER - popupSize.Y)

	popup.Position = UDim2.new(
		0,
		math.clamp(desiredX, EDGE_BUFFER, maxX),
		0,
		math.clamp(desiredY, EDGE_BUFFER, maxY)
	)
end

function menu.resize(menuFrame: ScrollingFrame, maxHeight: number?)
	local limit = maxHeight or 239

	menuFrame.AutomaticSize = Enum.AutomaticSize.XY

	task.defer(function()
		local menuHeight = menuFrame.AbsoluteSize.Y

		if menuHeight >= limit then
			menuFrame.AutomaticSize = Enum.AutomaticSize.X
			menuFrame.Size = UDim2.fromOffset(0, limit)
		else
			menuFrame.Size = UDim2.fromOffset(0, menuHeight)
			menuFrame.AutomaticSize = Enum.AutomaticSize.X
		end
	end)
end

function menu.connectOutsideClose(body: GuiObject, popup: GuiObject, isExpanded: () -> boolean, close: () -> ())
	return userInputService.InputBegan:Connect(function(input)
		if
			not isExpanded()
			or (
				input.UserInputType ~= Enum.UserInputType.MouseButton1
				and input.UserInputType ~= Enum.UserInputType.Touch
			)
		then
			return
		end

		local mouse = userInputService:GetMouseLocation()
		local inset = guiService:GetGuiInset()
		local popupPos = popup.AbsolutePosition
		local popupSize = popup.AbsoluteSize
		local bodyPos = body.AbsolutePosition
		local bodySize = body.AbsoluteSize
		local adjustedMouseY = mouse.Y - inset.Y

		local inPopup = mouse.X >= popupPos.X
			and mouse.X <= popupPos.X + popupSize.X
			and adjustedMouseY >= popupPos.Y
			and adjustedMouseY <= popupPos.Y + popupSize.Y

		local inBody = mouse.X >= bodyPos.X
			and mouse.X <= bodyPos.X + bodySize.X
			and adjustedMouseY >= bodyPos.Y
			and adjustedMouseY <= bodyPos.Y + bodySize.Y

		if not inPopup and not inBody then
			close()
		end
	end)
end

function menu.trackLifecycle(root: Instance, cleanup: () -> ())
	return root.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			cleanup()
		end
	end)
end

--// Publish

return menu
