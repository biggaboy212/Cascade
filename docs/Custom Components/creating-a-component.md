# Creating a Component

Building a custom component in Cascade involves understanding the component lifecycle and the context it lives in.

## The Component Maker

Every component is defined by a "maker" function. This function receives two arguments: `#!luau self` and `#!luau properties`.

### `#!luau self`

`self` is the chain context. eg

```luau
cascade.RegisterComponent("Test", function(self)
    print(self.Type)
end)

ctx:Toggle():Test() -- "Toggle"
```

### `#!luau properties`

`properties` is the table passed by the user when calling your component. You should use this to customize the appearance and behavior of your component.

---

## Example: A "Card" Component

You can build a component using Cascade's internal modules or just return a raw Roblox instance.

```luau
local creator = cascade.Creator
local create = creator.Create

cascade.RegisterComponent("Card", function(self, properties)
    -- Create the instance using cascade.Creator
    -- self.Theme is automatically available
    local frame = create("Frame")({
        Name = properties.Name or "Card",
        Size = properties.Size or UDim2.fromOffset(200, 100),
        Parent = properties.Parent or self.__container,

        -- Reactive State: You can use cascades built in __contextKeys and __dynamicKeys tables for reactive components. View existing cascade components for the best examples on this.

        create("UICorner")({
            CornerRadius = UDim.new(0, 8),
        }),
    })

    self:Label({
        Text = properties.Title or "Card Title",
        Parent = frame.__instance,
    })

    return frame
end)
```
