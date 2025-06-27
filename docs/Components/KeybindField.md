# KeybindField

A `KeybindField` is a rectangular area in which people can enter and store `Enum.KeyCode` `InputObject`'s, then trigger a callback after pressing the stored KeyCode

![Component preview](../assets/component_field.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Placeholder` | `#!luau string?` | The text placeholder to instruct users on how to interact with the component. |
| `Value` | `#!luau Enum.Keycode?` | The default shortcut the `KeybindField` is bound to. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature     | Description |
|----------------|---------------|-------------|
| `BindPressed` | `#!luau ((self: KeybindField, value: Enum.KeyCode, inputComplete: boolean, gameProcessedEvent: boolean) -> unknown)?` | A Callback function that is triggered when the `Value` KeyCode has been pressed. |
| `ValueChanged` | `#!luau ((self: KeybindField, value: Enum.KeyCode) -> unknown)?` | A Callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type KeybindFieldProperties = Frame & {
    Placeholder: string?,
    Value: Enum.KeyCode?,
    BindPressed: ((
        self: KeybindField,
        value: Enum.KeyCode,
        inputComplete: boolean,
        gameProcessedEvent: boolean
    ) -> unknown)?,
    ValueChanged: ((self: KeybindField, value: Enum.KeyCode) -> unknown)?,
}

type KeybindField = BaseComponent & Components & KeybindFieldProperties
```

### Function Signature

```luau
function(self, properties: KeybindFieldProperties): KeybindField
```

## Example

```luau
local keybindField = row:Right():KeybindField({
    ValueChanged = function(self, value: Enum.KeyCode)
        print("Value changed:", value)
    end,
    BindPressed = function(
        self,
        value: Enum.KeyCode,
        inputComplete: boolean,
        gameProcessedEvent: boolean
    )
        if not inputComplete or gameProcessedEvent then
            return
        end

        print("Pressed bind:", value)
    end,
})

print(keybindField:IsA("Frame")) --> true
print(keybindField.ClassName) --> "Frame"
print(keybindField.Type) --> "KeybindField"

keybindField.Value = Enum.KeyCode.Z --> Value changed: Enum.KeyCode.Z
```
