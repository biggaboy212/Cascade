# Tab

A `Tab` separates content into different pages, and lets users navigate between them using a button on the sidebar. Each tab has an associated [Page](./Page.md) that displays when the tab is selected.

![Component preview](../assets/component_sidebar.png)

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Title` | `#!luau string?` | The tab's display title. |
| `Icon` | `#!luau string?` | The `rbxassetid://` of the image to display. You can use cascade.Symbols for pre-made symbols. |
| `Indentation` | `#!luau number?` | The tab indentation level/how far right it is. This is automatically increased by `1` when you nest a tab on another tab. |
| `Selected` | `#!luau boolean?` | Whether or not the tab is selected by default. Defaults to false. Only one tab in a section should be selected. |
| `Page` | `#!luau Page?` | A custom page component to use for this tab. If not provided, a default page is automatically created. See [Page](./Page.md) for more information. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method       | Signature | Description |
|----------------|------------|-------------|
| `Navigate` | `(self: Tab, page: Page) -> nil` | Switch the tab's displayed page to a different page. Useful for multi-step workflows or navigating between different views within a tab. |

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
    Page: Page?,
}

type Tab = BaseComponent & Components & TabProperties & {
    Navigate: (self: Tab, page: Page) -> nil,
}
```

### Function Signature

```luau
function(self, properties: TabProperties?): Tab
```

## Creating Tabs

```luau
local tab = section:Tab({
    Title = "Settings",
    Icon = cascade.Symbols.gear,
})
```

### Tab with Custom Page

Tabs automatically make pages for you, but you can pass a custom one.

```luau
local customPage = app:Page()

-- Add content to the page
customPage:Form():Row():Right():Toggle({
    Value = false,
})

-- Use the page in a tab
local tab = section:Tab({
    Title = "Settings",
    Page = customPage,
})
```

## Navigating between Pages

The `Navigate` method allows you to switch pages within a tab. This is useful for multi-step workflows or progressive disclosure:

```luau
local tab = section:Tab({
    Title = "Workflow",
    Selected = true,
})

local page1 = app:Page()
local page2 = app:Page()

-- Setup pages with navigation buttons
do
    local form = page1:Form()
    form:Row():Right():Button({
        Label = "Next",
        Pushed = function()
            tab:Navigate(page2)
        end,
    })
end

do
    local form = page2:Form()
    form:Row():Right():Button({
        Label = "Back",
        State = "Secondary",
        Pushed = function()
            tab:Navigate(page1)
        end,
    })
end

-- Show page 1 initially
tab:Navigate(page1)
```

## Nested Tabs

Tabs can be nested for hierarchical navigation. Indentation is automatically handled:

```luau
local mainTab = section:Tab({
    Title = "Main",
    Icon = cascade.Symbols.squareStack3dUp,
})

-- Chain additional tabs to create indentation
mainTab:Tab({
    Title = "Sub 1",
})

mainTab:Tab({
    Title = "Sub 2",
})
```

## Tab Selection

Only one tab in a section can be selected at a time. Clicking a tab automatically deselects others:

```luau
local tab1 = section:Tab({
    Title = "Tab 1",
    Selected = true,  -- This tab starts selected
})

local tab2 = section:Tab({
    Title = "Tab 2",
    Selected = false,  -- Defaults to false
})

-- When tab2 is clicked, tab1 is automatically deselected
```

Manually change the selected state:

```luau
local tab1 = section:Tab({ Title = "Tab 1" })
local tab2 = section:Tab({ Title = "Tab 2" })

-- Later in your code
tab2.Selected = true  -- Selects tab2
-- tab1 is automatically deselected by the system
```

## Examples

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
