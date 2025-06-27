# Form

A `Form` is a vertical container that organizes interface elements into clearly separated rows, using consistent styling like dividers to emphasize structure.

## Summary

### Properties

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type FormProperties = Frame

type Form = BaseComponent & Components & FormProperties
```

### Function Signature

```luau
function(self, properties: FormProperties): Form
```

## Example

```luau
local form = section:Form()

print(form:IsA("Frame")) --> true
print(form.ClassName) --> "Frame"
print(form.Type) --> "Form"
```
