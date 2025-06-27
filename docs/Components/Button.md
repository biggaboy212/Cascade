<!-- markdownlint-disable MD056 -->

# Button

A `Button` initiates an instantaneous action.

![Component preview](../assets/component_button.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `State` | `#!luau ("Primary" | "Secondary" | "Destructive")?` | Determines the weight of the button. Suggests to the user it's impact to the content around it |
| `Label` | `#!luau string?` | The text content of the button. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `TextButton`](https://create.roblox.com/docs/reference/engine/classes/TextButton#summary-properties)

### Methods

[View all inherited from `TextButton`](https://create.roblox.com/docs/reference/engine/classes/TextButton#summary-methods)

### Events

| Event   | Signature                         | Description |
|---------|-----------------------------------|-------------|
| `Pushed` | `#!luau ((self: Button) -> unknown)?` | A callback function that is triggered when the button has been fully clicked or tapped. |

[View all inherited from `TextButton`](https://create.roblox.com/docs/reference/engine/classes/TextButton#summary-events)

## Types

```luau
type ButtonProperties = TextButton & {
    State: ("Primary" | "Secondary" | "Destructive")?,
    Label: string?,
    Pushed: ((self: Button) -> unknown)?,
}

type Button = BaseComponent & Components & ButtonProperties
```

### Function Signature

```luau
function(self, properties: ButtonProperties): Button
```

## Example

```luau
local button = row:Right():Button({
    Label = "Button",
    State = "Primary",
    Pushed = function(self)
        print("Pushed")
    end,
})

print(button:IsA("TextButton")) --> true
print(button.ClassName) --> "TextButton"
print(button.Type) --> "Button"
```
