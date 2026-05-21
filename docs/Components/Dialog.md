# Dialog

A `Dialog` is a modal container for interactions that require user input before proceeding. Unlike `Alert`, which is self-contained and layout-managed, Dialog gives you a composable body, you build the content inside it using the standard Cascade component API.

Use Dialog when the user needs to fill in information, review details, or make a structured choice. Use `Alert` when you only need a message and a small set of simple actions.

## Summary

### Properties

| Property      | Type                       | Description                                                                                      |
| ------------- | -------------------------- | ------------------------------------------------------------------------------------------------ |
| `Title`       | `#!luau string?`           | The headline displayed at the top of the dialog.                                                 |
| `Message`     | `#!luau string?`           | Optional short description rendered below the title, above the composed body.                    |
| `Icon`        | `#!luau string?`           | An optional `40 x 40` image asset ID displayed above the title. You can use `cascade.Symbols`.   |
| `Actions`     | `#!luau { DialogAction }?` | Buttons rendered in the action bar at the bottom of the dialog. See [Actions](#actions).         |
| `Dismissable` | `#!luau boolean?`          | When `true`, clicking the backdrop closes the dialog and fires `Dismissed`. Defaults to `false`. |

[View all inherited from `BaseComponent`](./index.md/#properties)

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-properties)

### Methods

| Method  | Signature                      | Description                                               |
| ------- | ------------------------------ | --------------------------------------------------------- |
| `Close` | `#!luau (self: Dialog) -> nil` | Programmatically closes the dialog and fires `Dismissed`. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-methods)

### Events

| Event       | Signature                          | Description                                                                                                          |
| ----------- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `Dismissed` | `#!luau (self: Dialog) -> unknown` | Fired when the dialog is closed, either by an action, by `Close()`, or by the backdrop when `Dismissable` is `true`. |

[View all inherited from `Frame`](https://create.roblox.com/docs/reference/engine/classes/Frame#summary-events)

### Actions

Actions are declared as an ordered array of `DialogAction` tables. They are always rendered as a horizontal row in the dialog's action bar at the bottom. The `Slot` property controls which side of the action bar an action belongs to.

#### DialogAction Properties

| Property | Type                                                | Description                                                                                       |
| -------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `Label`  | `#!luau string`                                     | The text displayed on the button. **Required.**                                                   |
| `Style`  | `#!luau ("Default" \| "Primary" \| "Destructive")?` | Visual weight of the action. Defaults to `"Default"`.                                             |
| `Slot`   | `#!luau ("Leading" \| "Trailing")?`                 | Which side of the action bar this button occupies. Defaults to `"Trailing"`. See [Slots](#slots). |
| `Pushed` | `#!luau ((self: Dialog) -> unknown)?`               | Called when the user taps or clicks this action.                                                  |

#### Slots

The action bar has two slots. Multiple actions in the same slot are grouped together in declaration order.

| Slot         | Position   | Typical use                                                                      |
| ------------ | ---------- | -------------------------------------------------------------------------------- |
| `"Leading"`  | Left side  | Destructive or low-priority actions that need visual separation (e.g. "Delete"). |
| `"Trailing"` | Right side | Primary and cancel actions (e.g. "Cancel", "Save"). This is the default.         |

!!! note
    Dialog does not have a dedicated `"Cancel"` style like `Alert`. If you want a cancel button, declare it as `Style = "Default"` in the `"Trailing"` slot. Dialog actions don't get auto-separated, you control placement entirely through `Slot`.

## Composing the body

Because `Dialog` inherits the full `Components` mixin, you call standard Cascade components directly on the dialog object. Anything you add this way renders inside the body area, between the message and the action bar.

```luau
local dialog = app:Dialog({ ... })

-- Compose directly on dialog
local stack = dialog:VStack({ Padding = UDim.new(0, 8) })
stack:Row():Left():Label({ Text = "Name:" })
stack:Row():Right():TextField({ Placeholder = "Enter name" })
```

There is no special content API, it works exactly like building inside a `Window` or `Section`.

## Types

```luau
type DialogAction = {
    Label: string,
    Style: ("Default" | "Primary" | "Destructive")?,
    Slot: ("Leading" | "Trailing")?,
    Pushed: ((self: Dialog) -> unknown)?,
}

type DialogProperties = Frame & {
    Title: string?,
    Message: string?,
    Icon: string?,
    Actions: { DialogAction }?,
    Dismissed: ((self: Dialog) -> unknown)?,
    Dismissable: boolean?,
}

type Dialog = BaseComponent & Components & DialogProperties & {
    Close: (self: Dialog) -> nil,
}
```

### Function Signature

```luau
function(self, properties: DialogProperties?): Dialog
```

## Examples

### Save sheet (matches macOS save dialog pattern)

`"Delete"` sits in the leading slot, isolated on the left. `"Cancel"` and `"Save"` are in the trailing slot, grouped on the right. The body composes a small form with labeled fields.

```luau
local dialog = app:Dialog({
    Icon = "rbxassetid://...",
    Title = 'Do you want to keep this new document "Untitled"?',
    Message = "You can choose to save your changes, or delete this document immediately. You can't undo this action.",

    Actions = {
        { Label = "Delete", Style = "Destructive", Slot = "Leading",  Pushed = function(self)
            deleteDocument()
            self:Close()
        end },
        { Label = "Cancel", Style = "Default",     Slot = "Trailing", Pushed = function(self)
            self:Close()
        end },
        { Label = "Save",   Style = "Primary",     Slot = "Trailing", Pushed = function(self)
            saveDocument(nameField.Value)
            self:Close()
        end },
    },
})

local stack = dialog:VStack({ Padding = UDim.new(0, 6) })

local nameRow = stack:Row()
nameRow:Left():Label({ Text = "Save as:" })
local nameField = nameRow:Right():TextField({ Value = "Untitled" })

local tagsRow = stack:Row()
tagsRow:Left():Label({ Text = "Tags:" })
tagsRow:Right():TextField({ Placeholder = "" })
```

### Simple confirmation dialog with no body

Not every dialog needs composed content. Trailing-only actions, no `Slot` needed.

```luau
local dialog = app:Dialog({
    Title = "Sign Out",
    Message = "You will be returned to the main menu.",
    Actions = {
        { Label = "Cancel",   Style = "Default",  Pushed = function(self) self:Close() end },
        { Label = "Sign Out", Style = "Primary",  Pushed = function(self)
            signOut()
            self:Close()
        end },
    },
})
```

### Settings dialog with a toggle and slider

```luau
local dialog = app:Dialog({
    Title = "Audio Settings",
    Actions = {
        { Label = "Cancel", Slot = "Trailing", Pushed = function(self) self:Close() end },
        { Label = "Apply",  Slot = "Trailing", Style = "Primary", Pushed = function(self)
            applySettings()
            self:Close()
        end },
    },
})

local form = dialog:Form()

form:Row():Left():Label({ Text = "Music" })
form:Row():Right():Toggle({ Value = true })

form:Row():Left():Label({ Text = "Volume" })
form:Row():Right():Slider({ Minimum = 0, Maximum = 100, Value = 80 })
```

### Programmatic close

```luau
local dialog = app:Dialog({
    Title = "Processing",
    Message = "Please wait while we apply your changes.",
})

task.delay(2, function()
    dialog:Close()
end)
```

```luau
print(dialog:IsA("Frame"))  --> true
print(dialog.ClassName)     --> "Frame"
print(dialog.Type)          --> "Dialog"
```
