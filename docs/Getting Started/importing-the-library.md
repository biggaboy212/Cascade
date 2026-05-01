# Importing the Library

## Over HTTP

!!! note
    This will only work if the environment you are in supports `loadstring`.

!!! warning
    If you are always importing from the latest release you could be subject to deprecation and other changes.

This method will download the release dynamically using `loadstring` & `HttpGet`.

=== "Latest release"
    ```luau
    local function importRelease(owner, repo, version, file)
        local tag = (version == "latest" and "latest/download" or "download/"..version)

        return loadstring(game:HttpGetAsync(("https://github.com/%s/%s/releases/%s/%s"):format(owner, repo, tag, file)), file)()
    end

    local cascade = importRelease("biggaboy212", "Cascade", "latest", "dist.luau")
    ```

=== "Specific release"
    ```luau
    local function importRelease(owner, repo, version, file)
        local tag = (version == "latest" and "latest/download" or "download/"..version)

        return loadstring(game:HttpGetAsync(("https://github.com/%s/%s/releases/%s/%s"):format(owner, repo, tag, file)), file)()
    end

    local cascade = importRelease("biggaboy212", "Cascade", "v1.1.0-beta.1", "dist.luau")
    ```

=== "Cached loading"
    !!! warning
        `writefile`, `readfile`, and `makefolder` (or equivalent filesystem functions) must be supported in your environment for this method to work.

    ```luau
    local function importReleaseCached(owner, repo, version, file)
        local tag = (version == "latest" and "latest/download" or "download/" .. version)
        local url = ("https://github.com/%s/%s/releases/%s/%s"):format(owner, repo, tag, file)

        local cacheFolder = ".cache"
        if not isfolder(cacheFolder) then
            makefolder(cacheFolder)
        end

        local cacheVersion = version:gsub("[^%w%-_%.]", "-")
        local cacheFile = file:gsub("[^%w%-_%.]", "-")
        local cachePath = ("%s/%s-%s"):format(cacheFolder, cacheVersion, cacheFile)

        if not isfile(cachePath) then
            writefile(cachePath, game:HttpGetAsync(url))
        end

        return loadstring(readfile(cachePath), file)()
    end

    local cascade = importReleaseCached("biggaboy212", "Cascade", "latest", "dist.luau")
    ```

> `importRelease` is just a helper function, if you didn't want to use it you can simply `loadstring` : `HttpGet` the raw link to the release content.

## Local Build

1. Download a valid release: [Cascade Releases](https://github.com/biggaboy212/Cascade/releases)
2. Place the `luau` module into your project (e.g., under `packages/`).

## Building From Source

Proceed to [Building From Source](./building-from-source.md)
