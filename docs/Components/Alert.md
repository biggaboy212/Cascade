# Alert

An `Alert` presents a modal message that requires the user's attention before they can continue. Use alerts for situations that are consequential, disruptive, or that require a deliberate choice, not for routine feedback or status updates (use `Notification` for those).

Cascade handles layout automatically based on the number and style of actions declared. You do not specify button positions manually.

## Summary

### Properties

| Property      | Type                                             | Description                                                                                          |
| ------------- | ------------------------------------------------ | ---------------------------------------------------------------------------------------------------- |
| `Title`       | `#!luau string?`                                 | The primary headline of the alert.                                                                   |
| `Message`     | `#!luau string?`                                 | Secondary text providing more detail about the situation.                                            |
| `Icon`        | `#!luau string?`                                 | An optional `40 x 40` image asset ID displayed above the title. You can use `cascade.Symbols`.       |
| `Layout`      | `#!luau ("Auto" \| "Horizontal" \| "Vertical")?` | Controls how non-cancel actions are arranged. Defaults to `"Auto"`. See [Layout](#layout) for rules. |
| `Dismissable` | `#!luau boolean?`                                | When `true`, clicking the backdrop closes the alert and fires `Dismissed`. Defaults to `false`.      |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method  | Signature                     | Description                                              |
| ------- | ----------------------------- | -------------------------------------------------------- |
| `Close` | `#!luau (self: Alert) -> nil` | Programmatically closes the alert and fires `Dismissed`. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event       | Signature                         | Description                                                                                                         |
| ----------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `Dismissed` | `#!luau (self: Alert) -> unknown` | Fired when the alert is closed, either by an action, by `Close()`, or by the backdrop when `Dismissable` is `true`. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

---

## Actions

Actions are declared as an ordered array of `AlertAction` tables. Each action becomes a button rendered inside the alert.

### AlertAction Properties

| Property | Type                                                            | Description                                                                                                                |
| -------- | --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `Label`  | `#!luau string`                                                 | The text displayed on the button. **Required.**                                                                            |
| `Style`  | `#!luau ("Default" \| "Primary" \| "Destructive" \| "Cancel")?` | Visual weight of the action and its layout role. Defaults to `"Default"`. See [Action Styles](#action-styles) for details. |
| `Pushed` | `#!luau ((self: Alert) -> unknown)?`                            | Called when the user taps or clicks this action.                                                                           |

### Action Styles

| Style           | Appearance                          | Layout behavior                                                                              |
| --------------- | ----------------------------------- | -------------------------------------------------------------------------------------------- |
| `"Default"`     | Secondary button                    | Participates in the main action group.                                                       |
| `"Primary"`     | Filled accent-colored button        | Participates in the main action group. Visually dominant.                                    |
| `"Destructive"` | Secondary button with red label     | Participates in the main action group. Signals an irreversible operation.                    |
| `"Cancel"`      | Plain text button, visually subdued | **Always rendered last, visually separated from the main action group.** Only one per alert. |

!!! warning
    Only declare one `"Cancel"` action per alert. If multiple are declared, only the first is used.

---

## Layout

The `Layout` property controls how the **main action group** (all actions except `"Cancel"`) is arranged. The `"Cancel"` action is always placed below the main group with a visual separator, regardless of `Layout`.

| Value          | Behavior                                                                                      |
| -------------- | --------------------------------------------------------------------------------------------- |
| `"Auto"`       | Cascade chooses. Horizontal for 1–2 main actions with short labels; vertical for 3 or more.   |
| `"Horizontal"` | Main actions are arranged side by side. Use when you want to force horizontal with 2 actions. |
| `"Vertical"`   | Main actions are stacked. Use when you want to force vertical with 2 actions.                 |

---

## Types

```luau
type AlertAction = {
    Label: string,
    Style: ("Default" | "Primary" | "Destructive" | "Cancel")?,
    Pushed: ((self: Alert) -> unknown)?,
}

type AlertProperties = Frame & {
    Title: string?,
    Message: string?,
    Icon: string?,
    Layout: ("Auto" | "Horizontal" | "Vertical")?,
    Actions: { AlertAction }?,
    Dismissed: ((self: Alert) -> unknown)?,
    Dismissable: boolean?,
}

type Alert = BaseComponent & Components & AlertProperties & {
    Close: (self: Alert) -> nil,
}
```

### Function Signature

```luau
function(self, properties: AlertProperties?): Alert
```

---

## Examples

### Simple confirmation

A single primary action. Cascade renders it full-width.

```luau
local alert = app:Alert({
    Icon = cascade.Symbols.trash,
    Title = "Delete File",
    Message = "This will permanently delete the file. You can't undo this action.",
    Actions = {
        { Label = "Delete", Style = "Primary", Pushed = function(self)
            deleteFile()
            self:Close()
        end },
    },
})
```

### Two actions, horizontal (Auto)

The default for two short-label actions. No `Layout` needed.

```luau
local alert = app:Alert({
    Title = "Unsaved Changes",
    Message = "You have unsaved changes. Do you want to discard them?",
    Actions = {
        { Label = "Keep Editing", Style = "Default" },
        { Label = "Discard",      Style = "Destructive", Pushed = function(self)
            discardChanges()
            self:Close()
        end },
    },
})
```

### Two actions, forced vertical

Same content as above but stacked. Use when labels are longer or the context calls for it.

```luau
local alert = app:Alert({
    Title = "Update Available",
    Message = "A new version is available. Updating now will restart the experience.",
    Layout = "Vertical",
    Actions = {
        { Label = "Update Now",   Style = "Primary",  Pushed = function(self) ... end },
        { Label = "Remind Later", Style = "Default" },
    },
})
```

### Multiple actions with Cancel

Three or more non-cancel actions trigger vertical layout automatically. `"Cancel"` is always pulled to the bottom.

```luau
local alert = app:Alert({
    Icon = cascade.Symbols.square_and_arrow_up,
    Title = "Open With",
    Message = "Choose how to open this file.",
    Actions = {
        { Label = "App A", Style = "Primary",  Pushed = function(self) ... end },
        { Label = "App B", Style = "Default",  Pushed = function(self) ... end },
        { Label = "App C", Style = "Default",  Pushed = function(self) ... end },
        { Label = "Cancel", Style = "Cancel" },
    },
})
```

### Dismissable alert

The alert closes if the user clicks outside it.

```luau
local alert = app:Alert({
    Title = "Session Expired",
    Message = "Your session has expired. Please log in again.",
    Dismissable = true,
    Dismissed = function(self)
        redirectToLogin()
    end,
    Actions = {
        { Label = "Log In", Style = "Primary", Pushed = function(self)
            self:Close()
        end },
    },
})
```

### Programmatic close

```luau
local alert = app:Alert({
    Title = "Loading",
    Message = "Please wait...",
})

task.delay(3, function()
    alert:Close()
end)
```

```luau
print(alert:IsA("Frame"))  --> true
print(alert.ClassName)     --> "Frame"
print(alert.Type)          --> "Alert"
```
