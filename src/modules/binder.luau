local binder = {}

function binder.Apply(properties: { [string]: any }, object: any, excludes: { [number]: string }?): any
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

function binder.ReactiveTable(initial, onChange)
	local raw = table.clone(initial or {})
	local proxy = {}

	local mt = {
		__index = function(_, key)
			return raw[key]
		end,
		__newindex = function(_, key, value)
			raw[key] = value
			if onChange then
				onChange(raw)
			end
		end,
		__len = function()
			return #raw
		end,
		__pairs = function()
			return pairs(raw)
		end,
		__ipairs = function()
			return ipairs(raw)
		end,
		__metatable = false,
	}

	return setmetatable(proxy, mt)
end

function binder.Wrap(
	object: { [string]: any },
	bindings: { [string]: (any) -> () },
	instance: Instance?,
	excludeSets: { [number]: any }?
): any
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

				if not (excludeSets and table.find(excludeSets, key)) then
					object[key] = value
				end
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
