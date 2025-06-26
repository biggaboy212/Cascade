# Base Component

`BaseComponent` is the base class from which all Cascade components inherit. It provides core fields such as `Type`, `Theme`, and `Structures`.

---

## Summary

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `Type` | `string` | **[Read-only]** Defines the Component's class. |
| `Theme` | `string` | **[Read-only]** Inherited theme from the calling component. |
| `Structures` | `table` | **[Read-only]** Table of defined component structures. |

---

## Types

```lua
export type BaseComponent = {
    Type: string,
    Theme: Theme,
    Structures: { [string]: Instance | { any } },
}
```
