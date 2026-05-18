local types = require("@types")

return function(self, properties: types.ImageSurfaceProperties): types.ImageSurface
	--// Imports
	local binder = require("@modules/binder")

	local ui = require("@self/ui")

	--// Variables
	local structures = ui(self)

	--// UI
	properties = properties or {}
	properties.SurfaceColor = properties.SurfaceColor or Color3.fromRGB(200, 200, 200)
	properties.ImageColor = properties.ImageColor or Color3.fromRGB(255, 255, 255)
	properties.Gradient = properties.Gradient ~= false

	--// Initialize
	local object
	local bindings = {
		Image = function(value: string)
			structures.Image.Image = value
		end,
		Gradient = function(value: boolean)
			structures.Gradient.Enabled = value
		end,
		SurfaceColor = function(value: Color3)
			structures.Surface.BackgroundColor3 = value
		end,
        ImageColor = function(value: Color3)
            structures.Image.ImageColor3 = value
        end
	}

	object = binder.Wrap(properties, bindings, structures.Body)

	object.Type = "ImageSurface"
	object.Theme = self.Theme
	object.Structures = structures

	binder.Apply(properties, object)

	return object
end
