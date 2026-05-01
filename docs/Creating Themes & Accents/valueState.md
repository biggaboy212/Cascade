# `ValueState`

Before you can begin creating a custom theme or override, you must first get familiar with the Cascade `ValueState`.

## What is a `ValueState`?

A `ValueState` is a connectable handle that lets Cascade know when a certain value is changed.

This is especially important in the case of theme systems, for reactivity. Otherwise we would have to re-poll every second for changes to each theme key. `ValueState`'s instead simply let us Connect to it, and the connection gets fired whenever the Value is changed.

## How does this tie into creating a theme?

Cascade's theme system only support `ValueState`, so you need to get familiar with the concept and reason why `ValueState` is important in a reactive UI system.

## Examples of using `ValueState`

```luau
--// Imports
local cascade = require("@packages/cascade")

--// References
local creator = cascade.Creator
local value = creator.Value

--// ValueStates
local fruit = value("Apple")

--// Main
fruit:Connect(function(new) -- We will first connect to the ValueState, so whenever a change is made, our function will fire.
    print("The fruit was changed to ", new)
end)

-- Now, whenever .Value is set, the Connection will be fired, invocating the function.
fruit.Value = "Orange"
```
