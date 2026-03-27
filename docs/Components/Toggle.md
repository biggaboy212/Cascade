# Toggle

A `Toggle` lets people choose between a pair of opposing states, like on and off, using a different appearance to indicate each state.

![Component preview](../assets/component_toggle.png)

## Summary

### Properties

| Property | Type              | Description                                        |
| -------- | ----------------- | -------------------------------------------------- |
| `Value`  | `#!luau boolean?` | The toggle's state. `false` for off, `true` for on |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature                                             | Description                                                                        |
| -------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `ValueChanged` | `#!luau ((self: Toggle, value: boolean) -> unknown)?` | A callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type ToggleProperties = Frame & {
    Value: boolean?,
    ValueChanged: ((self: Toggle, value: boolean) -> unknown)?,
}

type Toggle = BaseComponent & Components & ToggleProperties
```

### Function Signature

```luau
function(self, properties: ToggleProperties): Toggle
```

## Example

```luau
local toggle = row:Right():Toggle({
    Value = true,
    ValueChanged = function(self, value: boolean)
        print("Value changed:", value)
    end,
})

print(toggle:IsA("Frame")) --> true
print(toggle.ClassName) --> "Frame"
print(toggle.Type) --> "Toggle"
```
