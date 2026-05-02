# The Standalone API

The Standalone API lets you create individual Cascade components without a full [App](./app.md). This gives you access to the component primitives without the overhead of an app.

## Summary

### Properties

| Property | Type               | Description                                                       |
| -------- | ------------------ | ----------------------------------------------------------------- |
| Theme    | `#!luau Theme?`    | Light or Dark mode. See [Themes](./themes.md). Defaults to Light. |
| Accent   | `#!luau Accent?`   | Accent color palette. See [Accents](./accents.md).                |
| Parent   | `#!luau Instance?` | Default parent for components created on this context.            |

## Types

```luau
type ComponentProperties = {
    Theme: Theme?,
    Accent: Accent?,
    Parent: Instance?,
}

type ComponentContext = ComponentProperties & Components
```

### Function Signature

```luau
function(properties: ComponentProperties?): ComponentContext
```

## Examples

### Creating standalone components

```luau
local ctx = cascade.Component({
    Theme = cascade.Themes.Dark,
    Accent = cascade.Accents.Blue,
})

-- Returns our wrapped object and the raw Roblox instance
local object, instance = ctx:Toggle({
    Parent = someFrame,
    Value = true,
    ValueChanged = function(self, value: boolean)
        print("Value changed:", value)
    end,
})

print(object.__instance)
```

### Shared parent

If most of your components share the same parent, you can set `Parent` on the context itself:

```luau
local ctx = cascade.Component({
    Theme = cascade.Themes.Dark,
    Parent = someFrame,
})

-- Both components are automatically parented to someFrame
local toggle = ctx:Toggle({ Value = false })
local slider = ctx:Slider({ Value = 0.5, Minimum = 0, Maximum = 1 })
```

!!! note
    You can still override `Parent` for a shared component group.

### Different contexts

```luau
-- This one will use the `Light` theme with the `Red` accent.
do
    local ctx = cascade.Component({
        Theme = cascade.Themes.Light,
        Accent = cascade.Accents.Red,
    })

    local toggle = ctx:Toggle({ Value = false })
end

-- This one will use the `Dark` theme with the `Blue` accent.
do
    local ctx = cascade.Component({
        Theme = cascade.Themes.Dark,
        Accent = cascade.Accents.Blue,
    })

    local toggle = ctx:Toggle({ Value = true })
end
```
