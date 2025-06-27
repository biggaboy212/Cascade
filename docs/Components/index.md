# Base Component

`BaseComponent` is the base class from which all Cascade components inherit. It provides core fields such as `Type`, `Theme`, and `Structures`.

---

## Summary

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `Type` | `#!luau string` | **[Read-only]** Defines the Component's class. |
| `Theme` | `#!luau string` | **[Read-only]** Inherited theme from the calling component. |
| `Structures` | `#!luau {[string]: Instance?}` | **[Read-only]** Table of defined component structures. |

!!! warning
    Note that to access a component's actual instance, you will need to index `__instance` on it, this will return the actual roblox object instead of a merged metatable with the custom object.

---

## Types

```luau
export type BaseComponent = {
    Type: string,
    Theme: Theme,
    Structures: { [string]: Instance | { any } },
}
```
