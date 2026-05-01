<!-- markdownlint-disable MD046 -->

# Themes

[Cascade default dark theme]: <https://github.com/biggaboy212/Cascade/blob/main/src/themes/Dark.luau>
[Cascade default light theme]: <https://github.com/biggaboy212/Cascade/blob/main/src/themes/Light.luau>

This section will teach you how to make your own Theme for cascade.

## Getting started

The best way to get started, is simply copying an existing Cascade theme. For example, if you wanted to make a dark-based theme you can copy the [Cascade default dark theme], or, for a light-based theme, the [Cascade default light theme].

Whichever one you choose, doing this pre-places all the required Cascade theme keys to give you a starting point.

!!! tip
    Make sure to replace the imports with your actual references, for example, this:
    ```luau
    local creator = require("@modules/creator")
    ```

    might become:

    ```luau
    local cascade = require("@packages/cascade")
    local creator = cascade.Creator
    ```

## Using your own theme instead of a default theme

Now that you've created your theme, using it is very simple, find where you create your Cascade `App`, and replace the Theme property with your new theme:

```luau
local app = cascade.New({
    Theme = {
        {
            _id = "MyNewTheme",

            Text = {
                ...
            },

            ...
        }
    }
})
```

!!! tip
    It is not recommended to define your theme inline like it was done above. It's better practice to put your theme's in a seperate file, or simply defined somewhere else, this way your main definition dosen't get cluttered and polluted.
