# Notification

A `Notification` is a non-disruptive, transient message that appears on screen to alert the user of important information, events, or state changes within an application.

## Summary

### Properties

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

| Name | Type | Description |
| --- | --- | --- |
| `Title` | `string` | The primary headline of the notification. |
| `Subtitle` | `string` | The secondary text providing more context. |
| `App` | `string?` | Optional text to display what feature or app triggered the notification. |
| `AppIcon` | `string?` | Optional image asset ID to show an icon in the top left. |
| `Icon` | `string?` | Optional image asset ID to show an icon in the top left, next to the title. |
| `Duration` | `number?` | How long (in seconds) the notification remains before auto-closing. Defaults to `6`. Use `0` for manual close only. |

### Methods

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

| Name | Returns | Description |
| --- | --- | --- |
| `Close()` | `nil` | Manually dismisses the notification. |

### Events

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

| Name | Parameters | Description |
| --- | --- | --- |
| `Closed` | `(self: Notification, fromUser: boolean)` | Fired when the notification is closed either via timeout or by the user. |

## Types

```luau
type NotificationProperties = Frame & {
    Title: string,
    Subtitle: string,
    App: string?,
    Icon: string?,
    AppIcon: string?,
    Duration: number?,
    Closed: ((self: Notification, fromUser: boolean) -> unknown)?,
}

type Notification = BaseComponent & Components & NotificationProperties & {
    Close: (self: Notification) -> nil,
}
```

### Function Signature

```luau
function(self, properties: NotificationProperties): Notification
```

## Example

```luau
local notification = app:Notification({
    Title = "New Message",
    Subtitle = "You received a new message from a friend.",
    App = "CHAT",
    Icon = cascade.Symbols.bell,
    AppIcon = "rbxassetid://132228700346004",
    Duration = 5,
    Closed = function(self, fromUser)
        print("Notification was dismissed! (from user: " .. tostring(fromUser) .. ")")
    end
})

-- Sometime later, if you need to manually close it:
-- notification:Close()
```
