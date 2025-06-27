# Tab

A `Tab` separates content into different pages, and lets users navigate between them using a button on the sidebar.

![Component preview](../assets/component_sidebar.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Title` | `#!luau string?` | The tab and page's title. |
| `Icon` | `#!luau string?` | The `rbassetid://` of the image to display. You can use cascade.Symbols for pre-made symbols. |
| `Indentation` | `#!luau boolean?` | The tab indentation/How far right it is. This is automatically increased by `1` when you chain a tab on another tab. |
| `Selected` | `#!luau boolean?` | Whether or not the tab is selected by default. Defaults to false. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type TabProperties = Frame & {
    Title: string?,
    Icon: string?,
    Indentation: number?,
    Selected: boolean?,
}

type Tab = BaseComponent & Components & TabProperties
```

### Function Signature

```luau
function(self, properties: TabProperties): Tab
```

## Example

```luau
local tab = section:Tab({
    Selected = true,
    Title = "Tab",
    Icon = cascade.Symbols.squareStack3dUp,
})

print(tab:IsA("Frame")) --> true
print(tab.ClassName) --> "Frame"
print(tab.Type) --> "Tab"
```
