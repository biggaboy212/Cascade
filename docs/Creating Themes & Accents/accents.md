# Accents

[pre-made accents]: https://github.com/biggaboy212/Cascade/blob/main/src/themes/accents.luau

## What are accents?

In cascade, the term `Accents` is analogous to theme key overrides. It's simply a table of keys you want to override in the main `App.Theme` property.

## Getting started

Similar to [Themes](./themes.md), the best way to get started is copying one of our [pre-made accents].

!!! important
Unlike Themes, Accents should NOT have their keys wrapped in a `ValueState`. You can use raw color values.

Your accent table must have a `_id` defining it's name, as well as a variant for each theme you plan to use the accent for. In most cases thats just one `Dark` table and one `Light` table.

## Example

```luau
local function makeGradient(topHex, bottomHex)
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex(topHex)),
        ColorSequenceKeypoint.new(1, Color3.fromHex(bottomHex)),
    })
end

App.Accent = {
    _id = "Pink",
    
    Dark = {
        SwitchAccent = Color3.fromHex("#FF375F"),
        Selection = Color3.fromHex("#D4163E"),
        SelectionFocused = Color3.fromHex("#E83058"),
        Toggle = { SwitchOn = Color3.fromHex("#FF375F") },
        Button = { FillPrimary = makeGradient("#E83058", "#C00030") },
    },
    Light = {
        SwitchAccent = Color3.fromHex("#FF2D55"),
        Selection = Color3.fromHex("#C8103A"),
        SelectionFocused = Color3.fromHex("#DC2A50"),
        Toggle = { SwitchOn = Color3.fromHex("#FF2D55") },
        Button = { FillPrimary = makeGradient("#DC2A50", "#B4002C") },
    },
}
```
