# Creating an Application

You can create a new app by calling the `New` method from the Cascade API. This returns a custom object merged with a `ScreenGui`.

The returned object exposes all built-in components such as `Window`, `Tab`, and others for UI composition.

## Summary

### Properties

| Property | Type | Description |
|--------|--------|--------|
| Theme | `Theme?` | Defines the color pallete used by the overall application. |

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-properties)

### Methods

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-methods)

### Events

[View all inherited from ScreenGui](https://create.roblox.com/docs/reference/engine/classes/ScreenGui#summary-events)

## Types

```lua
type AppProperties = ScreenGui & {
    Theme: Theme?,
}

type App = AppProperties & Components
```

### Function Signature

```lua
function(properties: AppProperties): App
```

## Example

```lua linenums="1"
local app = cascade.New({
    Theme = cascade.Themes.Light
})
```
