# App

You can create a new app by calling the `New` method from the Cascade API. This returns a custom object merged with a `ScreenGui`.

The returned object exposes all built-in [Components](../../Components/index.md) such as [Window](../../Components/Window.md), [Tab](../../Components/Tab.md), and others for UI composition.

## Summary

### Properties

| Property   | Type              | Description                                                        |
| ---------- | ----------------- | ------------------------------------------------------------------ |
| WindowPill | `#!luau boolean?` | Whether or not the window minimize/restore pill should be visible. |
| Theme      | `#!luau Theme?`   | Light or Dark mode. See [Themes](./themes.md)                      |
| Accent     | `#!luau Accent?`  | Accent color palette. See [Accents](./accents.md)                  |

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-properties)

### Methods

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-methods)

### Events

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-events)

## Types

```luau

type AppProperties = ScreenGui & {
    WindowPill: boolean?,
    Theme: Theme?,
    Accent: Accent?,
}

type App = AppProperties & Components
```

### Function Signature

```luau
function(properties: AppProperties?): App
```

## Example

```luau
local app = cascade.New({
    WindowPill = true,
    Theme = cascade.Themes.Light,
    Accent = cascade.Accents.Blue,
})
```

## Dumping an App

Use `AppRecorder` when you want a compact, Cascade-aware dump of the components you create.

```luau
local app = cascade.New({
    Theme = cascade.Themes.Dark,
    Accent = cascade.Accents.Blue,
})

local recorder = cascade.AppRecorder.new(app)
recorder:Start()

local window = app:Window({
    Title = "Cascade",
    Subtitle = "Cascade demo app",
})

window:Section({
    Title = "Navigation",
})

recorder:Stop()

if setclipboard then
    setclipboard(recorder:Dump())
end
```

`recorder:Dump()` returns JSON with a `CascadeAppDump` root, each recorded component, serializable component properties, and the current root instance properties for each component. Functions are skipped because they cannot be recreated outside Roblox.

If you did not start a recorder, `cascade.AppDump(app)` still works, but it falls back to a raw rendered instance tree:

```luau
local dump = cascade.AppDump(app)
```

You can include the full rendered tree alongside recorder data when you need pixel-level implementation details:

```luau
local dump = recorder:Dump({
    IncludeInstanceTree = true,
})
```
