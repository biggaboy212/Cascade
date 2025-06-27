# TextField

A `TextField` is a rectangular area in which people enter or edit small, specific pieces of text.

![Component preview](../assets/component_field.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Placeholder` | `#!luau string?` | The text placeholder to instruct users on how to interact with the component. |
| `Value` | `#!luau Enum.Keycode?` | The text in the field. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature     | Description |
|----------------|---------------|-------------|
| `TextChanged` | `#!luau ((self: TextField, text: string) -> unknown)?` | A Callback function that is triggered when the text field's text has been modified. |
| `ValueChanged` | `#!luau ((self: TextField, value: string) -> unknown)?` | A Callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type TextFieldProperties = Frame & {
    Placeholder: string?,
    Value: string?,
    TextChanged: ((self: TextField, text: string) -> unknown)?,
    ValueChanged: ((self: TextField, value: string) -> unknown)?,
}

type TextField = BaseComponent & Components & TextFieldProperties
```

### Function Signature

```luau
function(self, properties: TextFieldProperties): TextField
```

## Example

```luau
local textField = row:Right():TextField({
    Value = "Label",
    ValueChanged = function(self, value: string)
        print("Value changed:", value)
    end,
    TextChanged = function(self, value: string)
        print("Text changed:", value)
    end,
})

print(textField:IsA("Frame")) --> true
print(textField.ClassName) --> "Frame"
print(textField.Type) --> "TextField"

textField.Value = "Hi" --> Value changed: "Hi"
```
