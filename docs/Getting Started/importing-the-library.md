# Importing the Library

!!! note
    You can clone the entire Cascade repo into your project with something *similar* to wally, but there isn't currently a package manager that I know of which smoothly works with non roblox-dependent projects.

## Pre-built releases

Cascade also has pre-built `luau` modules.

### Over HTTP

This method will download the release dynamically using HttpGet.

```luau
local function import(owner, repo, version, file)
    local tag = (version == "latest" and "latest/download" or "download/"..version)

    return loadstring(game:HttpGetAsync(("https://github.com/%s/%s/releases/%s/%s"):format(owner, repo, tag, file)), file)()
end

local cascade = import("biggaboy212", "Cascade", "latest", "dist.luau")
-- If you want to use a specific release (i.e, beta releases), replace 'latest' with it's release tag.
```

### Local Build

1. Download a valid release: [Cascade Releases](https://github.com/biggaboy212/Cascade/releases)
2. Place the `luau` module into your project (e.g., under `packages/`).
