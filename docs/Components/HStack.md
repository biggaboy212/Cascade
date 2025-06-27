# HStack

A `HStack` is a frame that horizontally sorts content.

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Padding` | `#!luau UDim?` | The padding between objects. |
| `HorizontalAlignment` | `#!luau Enum.HorizontalAlignment?` | The content X axis alignment. |
| `VerticalAlignment` | `#!luau Enum.VerticalAlignment?` | The content Y axis alignment. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type StackProperties = Frame & {
    Padding: UDim?,
    HorizontalAlignment: Enum.HorizontalAlignment?,
    VerticalAlignment: Enum.VerticalAlignment?,
}

type Stack = BaseComponent & Components & StackProperties
```

### Function Signature

```luau
function(self, properties: StackProperties): Stack
```

## Example

```luau
local hStack = row:Right():HStack()

print(hStack:IsA("Frame")) --> true
print(hStack.ClassName) --> "Frame"
print(hStack.Type) --> "HStack"
```
