local new = require("./new.luau")
local old = require("./old.luau")
local fs = require("@lune/fs")

local missingSymbols: { [string]: string } = {}

for symbol, assetId in old do
	if not new[symbol] then
		missingSymbols[symbol] = assetId
	end
end

local count = 0
for _ in missingSymbols do
	count += 1
end

print("Total missing symbols: " .. count)

if count > 0 then
	print("Generating Compatible build...")

	local newContent = fs.readFile("./new.luau")
	newContent = newContent:gsub("%s*}%s*$", "")

	local lines = {
		newContent,
		"",
		"  -- Legacy Symbols",
	}

	for symbol, assetId in missingSymbols do
		table.insert(lines, string.format('  ["%s"] = "%s",', symbol, assetId))
	end

	table.insert(lines, "}")

	fs.writeFile("./compat.luau", table.concat(lines, "\n"))

	print("Done! Written to compat.luau")
end
