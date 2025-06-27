# PageSection

A `PageSection` separates content in a page into digestible sections via a Title stack. For example, a settings page might have:

- Appearance
- Input
- Effects

![Component preview](../assets/component_sidebar.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Title` | `#!luau string?` | The section's title. |
| `Subtitle` | `#!luau string?` | The section's sub-title. If left nil, the subtitle will be non-visible. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type PageSectionProperties = Frame & {
    Title: string?,
    Subtitle: string?,
}

type PageSection = BaseComponent & Components & PageSectionProperties
```

### Function Signature

```luau
function(self, properties: PageSectionProperties): PageSection
```

## Example

```luau
local pageSection = tab:PageSection({
    Title = "Effects",
    Subtitle = "These effects may be resource intensive across different systems.",
})

print(pageSection:IsA("Frame")) --> true
print(pageSection.ClassName) --> "Frame"
print(pageSection.Type) --> "PageSection"
```
