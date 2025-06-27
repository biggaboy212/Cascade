# Section

A `Section` organizes sidebar content by grouping related tabs together with optional disclosure.

![Component preview](../assets/component_sidebar.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Title` | `#!luau string?` | The displayed section title. |
| `Disclosure` | `#!luau boolean?` | Whether the section's content should be hideable. Defaults to false. |
| `Expanded` | `#!luau boolean?` | Whether the section should be expanded by default. Defaults to true. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type SectionProperties = Frame & {
    Title: string?,
    Disclosure: boolean?,
    Expanded: boolean?,
}

type Section = BaseComponent & Components & SectionProperties
```

### Function Signature

```luau
function(self, properties: SectionProperties): Section
```

## Example

```luau
local section = window:Section({
    Disclosure = true,
    Title = "Settings",
})

print(section:IsA("Frame")) --> true
print(section.ClassName) --> "Frame"
print(section.Type) --> "Section"
```
