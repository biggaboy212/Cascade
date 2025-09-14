# Importing the Library

> Note that you can clone the entire Cascade repo into your project using something similar to wally, but this can be unstable.

## Pre-built releases

Cascade also has pre-built `luau` modules.

### Over HTTP

This method will download the release dynamically using HttpGet.

```luau
local function import(owner, release, version, file)
    local tag = (version == "latest" and "latest" or "download/"..version)

    return loadstring(game:HttpGet(("https://github.com/%s/%s/releases/%s/%s"):format(owner, release, tag, file)), file)()
end

local cascade = import("biggaboy212", "Cascade", "latest", "dist.luau")
-- If you want to use a specific release (i.e, beta releases), replace 'latest' with it's release tag.
```

### Local Build

1. Download a valid release:

    [Cascade Releases](https://github.com/biggaboy212/Cascade/releases)

2. Place the `luau` module into your project (e.g., under `packages/`).
