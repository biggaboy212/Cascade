--!nocheck

local dateTime = require ("@lune/datetime")
local fs = require ("@lune/fs")
local io = require ("@lune/stdio")
local net = require ("@lune/net")
local process = require ("@lune/process")
local serde = require ("@lune/serde")

local buildConfigPath = process.args[1] or ".build.json"
local deployConfigPath = process.args[2] or ".deployment.json"

if not fs.isFile (buildConfigPath) then
    print (`Error: Build configuration file not found: {buildConfigPath}`)
    process.exit (1)
end

if not fs.isFile (deployConfigPath) then
    print (`Error: Deployment configuration file not found: {deployConfigPath}`)
    process.exit (1)
end

local buildConfigTable = serde.decode ("json", fs.readFile (buildConfigPath))
local deployConfig = serde.decode ("json", fs.readFile (deployConfigPath))
local buildConfigs = buildConfigTable.buildConfigs

local buildName, buildVersion, buildContent

local function getBaseName (path)
    return path:match ("^.+[\\/](.+)$") or path
end

local function openInEditor (filePath)
    if process.os == "windows" then
        process.exec ("powershell", {
            "-ExecutionPolicy",
            "Bypass",
            "-NoProfile",
            "-Command",
            `code '{filePath}'`,
        })
    end
end

local configNames = {}
for _, config in pairs (buildConfigs) do
    table.insert (configNames, config.name)
end

local selected = io.prompt ("select", "Build configuration", configNames)
local configOptions = buildConfigs[selected]
buildName = configOptions.name

buildVersion = configOptions.promptVersion
        and io.prompt ("text", "Build version (vMAJOR.MINOR.PATCH)")
    or "v0.0.0"

local srcResult = process.exec ("darklua", {
    "process",
    configOptions.input,
    configOptions.output,
    "-c",
    configOptions.darkluaConfig,
})

if not srcResult.ok then
    print (`Darklua processing failed: {srcResult.stderr}`)
    process.exit (1)
end

buildContent = fs.readFile (configOptions.output)
local frame = fs.readFile (configOptions.frame)

frame = frame:gsub ("__COMPOSER%.Insert %(__COMPOSER%.build%)", function ()
    return buildContent or ""
end)

frame = frame:gsub ("__COMPOSER%.Insert %(__COMPOSER%.genDate%)", function ()
    return string.format ("%q", dateTime.now ():toIsoDate () or "")
end)

frame = frame:gsub ("__COMPOSER%.Insert %(__COMPOSER%.cfg%)", function ()
    return string.format ("%q", buildName or "")
end)

frame = frame:gsub ("__COMPOSER%.Insert %(__COMPOSER%.vers%)", function ()
    return string.format ("%q", buildVersion or "")
end)

fs.writeFile (configOptions.output, frame)
print (`Build complete: {configOptions.output}`)

if buildConfigTable.openComposedOutput then
    openInEditor (configOptions.output)
end

if configOptions.promptDeploy and deployConfig.enabled then
    local ghConfig = deployConfig.providers.github

    if
        io.prompt ("confirm", "Do you want to distribute this build publicly?")
    then
        if ghConfig and ghConfig.enabled then
            local tempDir = process.env.TEMP or process.env.TMP or "/tmp"
            local releaseBodyPath =
                `{tempDir}/{deployConfig.releaseBody.tempFile}`

            local releaseTemplate = ghConfig.releaseNotes.template
                :gsub ("{repo}", ghConfig.repo)
                :gsub ("{version}", buildVersion)

            fs.writeFile (releaseBodyPath, releaseTemplate)

            if ghConfig.releaseNotes.openEditor then
                openInEditor (releaseBodyPath)
            end

            if
                io.prompt ("confirm", "Add release notes, and confirm when done")
            then
                local response = net.request ({
                    url = `https://api.github.com/repos/{ghConfig.owner}/{ghConfig.repo}/releases`,
                    method = "POST",
                    headers = {
                        ["Authorization"] = `Bearer {ghConfig.apiKey}`,
                        ["Content-Type"] = "application/json",
                    },
                    body = serde.encode ("json", {
                        tag_name = buildVersion,
                        name = `{buildName} {buildVersion}`,
                        body = fs.isFile (releaseBodyPath)
                                and fs.readFile (releaseBodyPath)
                            or "",
                        draft = false,
                        prerelease = configOptions.prerelease,
                    }),
                })

                if response.ok then
                    print (`Deployment successful: {response.statusMessage}`)

                    local releaseData = serde.decode ("json", response.body)
                    local releaseId = releaseData.id

                    if
                        releaseId
                        and fs.isFile (configOptions.output)
                        and deployConfig.assets.uploadBuilds
                    then
                        local assetName = getBaseName (configOptions.output)
                        local uploadUrl =
                            `https://uploads.github.com/repos/{ghConfig.owner}/{ghConfig.repo}/releases/{releaseId}/assets?name={assetName}`

                        local uploadResponse = net.request ({
                            url = uploadUrl,
                            method = "POST",
                            headers = {
                                ["Authorization"] = `Bearer {ghConfig.apiKey}`,
                                ["Content-Type"] = deployConfig.assets.contentType,
                            },
                            body = fs.readFile (configOptions.output),
                        })

                        if uploadResponse.ok then
                            print (`Asset uploaded: {assetName}`)
                        else
                            print (
                                `Asset upload failed: {uploadResponse.statusMessage}`
                            )
                            print (uploadResponse.body)
                        end
                    else
                        print (
                            "Could not upload asset: release id or file missing"
                        )
                    end
                else
                    print (`Deployment failed: {response.statusMessage}`)
                    print (response.body)
                    if response.body:find ("Bad credentials") then
                        warn (
                            "❓ Did you set up GitHub deployment in the deployment configuration file?"
                        )
                    end
                end
            end

            if fs.isFile (releaseBodyPath) then
                fs.removeFile (releaseBodyPath)
            end
        end
    end
end
