--// Types
type ExpectedObject = ((...any) -> ...any) | Instance | SomeOtherService

--// Variables
local utility = {}

--// Initialize
utility.Clone = function(object: ExpectedObject)
	local clonedObject: ExpectedObject

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
