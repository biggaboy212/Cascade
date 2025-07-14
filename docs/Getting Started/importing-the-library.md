# Importing the Library

## From Source

!!! tip
    This is the recommended method.

1. Clone it into your `packages/_index` folder:

    ```bash
    git clone https://github.com/biggaboy212/Cascade.git packages/_index/Cascade
    ```

    !!! note
        You can also download the source manually from Github and place it into your packages index folder.

2. Add a loader module directly into your `packages` folder:

    ```luau
    -- packages/cascade.luau
    return require("./_index/Cascade/src/init.luau")
    ```

3. At this point your project should look something like this:

    ![Project Preview](../assets/projectPreview.png)

4. Now you can easily access the Cascade API:

    ```luau
    -- To use aliases such as "@packages", use a .luaurc file.
    local cascade = require("@packages/cascade")
    ```

---

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

### Manual

This method is usually unstable on bundlers like darklua, however if it does work, it is faster than dynamic loading since it is already included in source and not fetched via web.

1. Download a valid release:

    [Cascade Releases](https://github.com/biggaboy212/Cascade/releases)

2. Place the `luau` module into your project (e.g., under `packages/`).
