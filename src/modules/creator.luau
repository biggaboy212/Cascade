local types = require("@types")
local binder = require("./binder")

local creator = {}

function creator.Value(value: any): types.ValueState
	local callbacks = {}

	return binder.Wrap({
		Value = value,
		Connect = function(self, fn)
			table.insert(callbacks, fn)
			return fn
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
				for property, valueObject: types.ValueState in pairs(value) do
					pcall(function()
						instance[property] = valueObject.Value
					end)

					valueObject:Connect(function(newValue)
						-- TODO: Find a way for contextKeys to not reference the old state
						-- i've been on this for 3 fucking days
						if properties["__contextKeys"] and properties["__contextKeys"][property] then
							pcall(function()
								instance[property] = properties["__contextKeys"][property]().Value
							end)
						else
							pcall(function()
								instance[property] = newValue
							end)
						end
					end)
				end

				continue
			end

			if typeof(value) == "table" and value.__unique then
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
