--// Types
type ExpectedObject = ((...any) -> ...any) | Instance | SomeOtherService

--// Variables
local utility = {}

--// Initialize
utility.Clone = function(object: any)
	local clonedObject: any

	if type(object) == "function" then
		clonedObject = clonefunction and clonefunction(object)
	elseif typeof(object) == "Instance" then
		clonedObject = cloneref and cloneref(object)
	end

	return clonedObject or object
end

utility.ProtectUI = function(gui: Instance): ScreenGui | string
	local sHiddenUi, hiddenUi = pcall(function()
		return gethui()
	end)

	local sCoreGui, coreGui = pcall(function()
		local layer = utility.Clone(game:GetService("CoreGui"))

		if layer and layer.ClassName then
			return layer
		end

		return
	end)

	local success, returned = pcall(function()
		gui.Parent = sHiddenUi and hiddenUi
			or sCoreGui and coreGui
			or utility.Clone(game:GetService("Players")).LocalPlayer.PlayerGui
	end)

	return success and gui or returned
end

return utility
