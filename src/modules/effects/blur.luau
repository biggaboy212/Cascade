--[[
	@original dawid-script/Fluent/src/modules/Acrylic
]]

--// Imports
local services = require("@modules/services")
local creator = require("@modules/creator")

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
		CanTouch = false,
		CanCollide = false,
		CanQuery = false,
		Locked = true,
		CastShadow = false,
		Transparency = 0.98,

		create("SpecialMesh")({
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	}) :: Part
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

	return onChange, model
end

return function(frame: GuiObject, distance: number?)
	local blur = {}
	local onChange, model = createBlur(distance)

	blur.SetVisibility = function(Value)
		model.Transparency = Value and 0.98 or 1
	end

	frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		onChange(frame)
	end)

	frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		onChange(frame)
	end)

	frame:GetPropertyChangedSignal("Visible"):Connect(function()
		blur.SetVisibility(frame.Visible)
	end)

	frame.Destroying:Connect(function()
		model:Destroy()
	end)

	blur.Model = model

	onChange(frame)

	return blur
end
