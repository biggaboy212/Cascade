# TitleStack

A `TitleStack` is a vertical stack with title and subtitle label's that people can read, but not edit.

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Title` | `#!luau string?` | The text content of the title label |
| `Subtitle` | `#!luau string?` | The text content of the subtitle label. Subtitle becomes non visible if left nil. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type TitleStackProperties = Frame & {
    Title: string?,
    Subtitle: string?,
}

type TitleStack = BaseComponent & Components & TitleStackProperties
```

### Function Signature

```luau
function(self, properties: TitleStackProperties): TitleStack
```

## Example

```luau
local titleStack = row:Left():TitleStack({
    Title = "Toggle (Off)",
    Subtitle = "Lets people choose between a pair of opposing states, like on and off, using a different appearance to indicate each state.",
})

print(titleStack:IsA("Frame")) --> true
print(titleStack.ClassName) --> "Frame"
print(titleStack.Type) --> "TitleStack"
```
