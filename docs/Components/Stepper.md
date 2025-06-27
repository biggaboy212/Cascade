# Stepper

A `Stepper` is a two-segment control that people use to increase or decrease an incremental value.

![Component preview](../assets/component_stepper.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Minimum` | `#!luau number?` | The minimum value the stepper can drop. |
| `Maximum` | `#!luau number?` | The maximum value the stepper can reach. |
| `Step` | `#!luau number?` | The increment to increase by on increase/decrease. |
| `Fielded` | `#!luau boolean?` | Whether the stepper should be attached to a editable field. Defaults to false. |
| `Value` | `#!luau number?` | The stepper's current value. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-properties)

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `Increment`  | `#!luau () -> nil` | This increments the `Value` of the stepper by the given step number. |
| `Decrement`  | `#!luau () -> nil` | This decrements the `Value` of the stepper by the given step number. |

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-methods)

### Events

| Event          | Signature     | Description |
|----------------|---------------|-------------|
| `ValueChanged` | `#!luau ((self: Stepper, value: number) -> unknown)?` | A Callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-events)

## Types

```luau
type StepperProperties = ImageLabel & {
    Minimum: number?,
    Maximum: number?,
    Step: number?,
    Fielded: boolean?,
    Value: number?,
    ValueChanged: ((self: Stepper, value: number) -> unknown)?,
}

type Stepper = BaseComponent & Components & StepperProperties & {
    Increment: () -> nil,
    Decrement: () -> nil,
}
```

### Function Signature

```luau
function(self, properties: StepperProperties): Stepper
```

## Example

```luau
local stepper = row:Right():Stepper({
    Minimum = 0,
    Maximum = 5,
    Step = 0.1,
    Fielded = true,
    Value = 3,
    ValueChanged = function(self, value: number)
        print("Value changed:", value)
    end,
})

print(stepper:IsA("ImageLabel")) --> true
print(stepper.ClassName) --> "ImageLabel"
print(stepper.Type) --> "Stepper"

stepper:Increment() --> Value changed: 3.01
stepper.Value += 1 --> Value changed: 4.01
```
