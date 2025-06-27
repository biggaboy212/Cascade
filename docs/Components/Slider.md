# Slider

A `Slider` is a horizontal track with a control, called a thumb, that people can adjust between a minimum and maximum value.

![Component preview](../assets/component_slider.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Minimum` | `#!luau number?` | The minimum value the slider can go. |
| `Maximum` | `#!luau number?` | The maximum value the slider can reach. |
| `Value` | `#!luau number?` | The slider's current value. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-properties)

### Methods

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-methods)

### Events

| Event          | Signature     | Description |
|----------------|---------------|-------------|
| `ValueChanged` | `#!luau ((self: Slider, value: number) -> unknown)?` | A Callback function that is triggered when the `Value` property has been modified. |

[View all inherited from `ImageLabel`](https://create.roblox.com/docs/reference/engine/classes/ImageLabel#summary-events)

## Types

```luau
type SliderProperties = ImageLabel & {
    Minimum: number?,
    Maximum: number?,
    Value: number?,
    ValueChanged: ((self: Slider, value: number) -> unknown)?,
}

type Slider = BaseComponent & Components & SliderProperties
```

### Function Signature

```luau
function(self, properties: SliderProperties): Slider
```

## Example

```luau
local slider = row:Right():Slider({
    Minimum = 0,
    Maximum = 10
    Value = 5,
    ValueChanged = function(self, value: number)
        print("Value changed:", value)
    end,
})

print(slider:IsA("ImageLabel")) --> true
print(slider.ClassName) --> "ImageLabel"
print(slider.Type) --> "Slider"

slider.Value += 1 --> Value changed: 6
```
