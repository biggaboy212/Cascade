# Internal Modules

Cascade exposes its core internal modules via the `cascade` object. These modules are essential for building high-quality, reactive components.

## `cascade.Creator`

The `Creator` module is responsible for creating and styling Roblox instances.

### `Creator.Create(className: string)`

Returns a function that allows you to create an instance and apply properties. It also supports nesting of children.

```luau
local create = cascade.Creator.Create

local frame = create("Frame")({
    Name = "MyFrame",
    Size = UDim2.fromScale(1, 1),

    create("UICorner")({ CornerRadius = UDim.new(0, 4) }),
})
```

### `Creator.Value(initial: any)`

Creates a reactive value (a "State"). When the value of this state changes, any instance properties bound to it will automatically update.

---

## `cascade.Binder`

The `Binder` module provides the glue between your custom component objects and the underlying Roblox instances.

### `Binder.Wrap(object, bindings, instance?, excludes?)`

Creates a proxy that merges your object's custom logic with the Roblox instance's properties.

- **`object`**: Your custom table containing component state and methods.
- **`bindings`**: A table of functions to call when specific keys are set on the proxy.
- **`instance`**: The raw Roblox instance to proxy properties to.
- **`excludes`**: A list of property names that should not be automatically applied to the instance.

### `Binder.Apply(properties, object, excludes?)`

Sets a table of properties onto an object, ignoring any keys in `excludes`. This is typically used to apply user-provided properties during component initialization.

---

## `cascade.Symbols`

A lookup table containing hundreds of icons.

```luau
local icon = cascade.Symbols.squareStack3dUp
```

---

## Hidden Properties

When your component is called as a child of another, it gains access to specific internal properties via `self`:

- **`self.__container`**: The instance that children should be parented to. For example, `Window` sets this to its body area. This is why you should always fallback to `self.__container` for parenting.
