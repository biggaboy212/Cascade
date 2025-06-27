# Row

A `Row` is a horizontal container that splits its contents into `Left` and `Right` sections, providing a clear visual distinction between primary and secondary elements.

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `SearchIndex` | `#!luau string?`   | A string that determines what the user has to type in to show this row in their search query |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `Left`  | `#!luau () -> Row` | Returns a shallow clone of `Row` with the container set to the row's **left** container. |
| `Right` | `#!luau () -> Row` | Returns a shallow clone of `Row` with the container set to the row's **right** container. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

## Types

```luau
type RowProperties = Frame & {
    SearchIndex: string?,
}

type Row = BaseComponent & Components & RowProperties & {
    Left: (self: Row) -> Row,
    Right: (self: Row) -> Row,
}
```

### Function Signature

```luau
function(self, properties: RowProperties): Row
```

## Example

```luau
local row = section:Row({
    SearchIndex = "Cool Row"
})

print(row:IsA("Frame")) --> true
print(row.ClassName) --> "Frame"
print(row.Type) --> "Row"
```
