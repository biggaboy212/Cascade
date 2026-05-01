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
function(self, properties: AppProperties): App
```

## Example

```luau
local app = cascade.New({
    WindowPill = true,
    Theme = cascade.Themes.Light,
    Accent = cascade.Accents.Blue,
})
```
