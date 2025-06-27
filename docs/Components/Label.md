# Label

A `Label` is a static piece of text that people can read, but not edit.

![Component preview](../assets/component_label.png)

## Summary

### Properties

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-properties)

### Methods

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-methods)

### Events

[View all inherited from `TextLabel`](https://create.roblox.com/docs/reference/engine/classes/TextLabel#summary-events)

## Types

```luau
type LabelProperties = TextLabel

type Label = BaseComponent & Components & FormProperties
```

### Function Signature

```luau
function(self, properties: LabelProperties): Label
```

## Example

```luau
local label = row:Right():Label({
    Text = "Label"
})

print(label:IsA("TextLabel")) --> true
print(label.ClassName) --> "TextLabel"
print(label.Type) --> "Label"
```
