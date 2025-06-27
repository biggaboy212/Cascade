# Window

`Window` is a high-level container that handles all base interaction with the user for you. Usually this is the first component called and most components stem from here.

![Component preview](../assets/component_window.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Searching` | `#!luau boolean?` | Shows a text field in the title bar which can be used to search pages for content. |
| `Draggable` |  `#!luau boolean?` | Enables window dragging via mouse or touch device. |
| `Resizable` | `#!luau boolean?` | Enables resizing via sides or corners. |
| `Title` | `#!luau string?` | Title displayed in the content titlebar. |
| `Subtitle` | `#!luau string?` | Subtitle displayed under the title. Will be visually disabled if not defined. |
| `Maximized` | `#!luau boolean?` | Should the window be maximized by default? |
| `Minimized` | `#!luau boolean?` | Should the window be minimized by default? |
| `Dropshadow` | `#!luau boolean?` | Enables a dropshadow effect on the window. |
| `UIBlur` | `#!luau boolean?` | Applies a background blur effect to the sidebar. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type WindowProperties = Frame & {
    Searching: boolean?,
    Draggable: boolean?,
    Resizable: boolean?,
    Title: string?,
    Subtitle: string?,
    Maximized: boolean?,
    Minimized: boolean?,

    -- These effects can be system resource intensive.
    Dropshadow: boolean?,
    UIBlur: boolean?, -- Detectable in some games.
}

type Window = BaseComponent & Components & WindowProperties
```

### Function Signature

```luau
function(self, properties: WindowProperties): Window
```

## Example

```luau
local window = app:Window({
    Title = "Cascade",
    Subtitle = "This is my subtitle.",
})

print(window:IsA("Frame")) --> true
print(window.ClassName) --> "Frame"
print(window.Type) --> "Window"
```
