# RadioButtonGroup

A `RadioButtonGroup` lets people choose an option from a set of mutually exclusive choices, using a circular indicator to show the selected option.

![Component preview](../assets/component_radioButtonGroup.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Options` | `#!luau {[number]: string}?` | You can use this table to pre-define options. Note that doing it this way will not give you access to the option instances themselves. |
| `Value` | `#!luau number?` | The numeric index of the option to be selected. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method         | Signature     | Description |
|----------------|---------------|-------------|
| `Option` | `#!luau (Name: string?) -> Frame` | Can be used to seperately create options, use this if you want to access the option instances themselves. An example of use would be a dynamically updating playerlist. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event          | Signature     | Description |
|----------------|---------------|-------------|
| `ValueChanged` | `#!luau ((self: TextField, value: string) -> unknown)?` | A Callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type RadioButtonGroupProperties = Frame & {
    Options: {[number]: string}?,
    Value: number?,
    ValueChanged: ((self: RadioButtonGroup, value: number) -> unknown)?,
}

 type RadioButtonGroup = BaseComponent & Components & RadioButtonGroupProperties & {
    Option: (Name: string?) -> Frame,
}
```

### Function Signature

```luau
function(self, properties: RadioButtonGroupProperties): RadioButtonGroup
```

## Example

```luau
local radioButtonGroup = row:Right():RadioButtonGroup({
    Options = {
        "Option 1",
        "Option 2",
    },
    ValueChanged = function(self, value: number)
        print("Value changed:", self.Options[value])
    end,
})

print(radioButtonGroup:IsA("Frame")) --> true
print(radioButtonGroup.ClassName) --> "Frame"
print(radioButtonGroup.Type) --> "RadioButtonGroup"

radioButtonGroup.Value = 2 --> Value changed: "Option 2"

local option3 = radioButtonGroup:Option("Option 3")

print(option3.ClassName) --> Frame
radioButtonGroup.Value = 3 --> Value changed: "Option 3"
```
