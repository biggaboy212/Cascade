# The API

## Summary

### Properties

| Property  | Type                          | Description                                                                                                                 |
| --------- | ----------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `Themes`  | `#!luau { [string]: Theme }`  | **[Read-only]** Provides default application theme modes . See [all themes](./themes.md).                                   |
| `Accents` | `#!luau { [string]: Accent }` | **[Read-only]** Provides preset accents. See [all accents](./accents.md).                                                   |
| `Symbols` | `#!luau { [string]: string }` | **[Read-only]** A large list of symbols (exported from Apple SF Symbols). See [all symbols](https://sf-symbols.pages.dev/). |

### Methods

| Method              | Arguments                                 | Description                                                                                                      | Returns                             |
| ------------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| `New`               | `#!luau properties: AppProperties`        | Creates a new [App](./app.md), this returns every component you can then call and will appear on screen.         | [App](./app.md)                     |
| `Component`         | `#!luau properties: ComponentProperties?` | Creates a standalone [component context](./standalone.md) without `App` `ScreenGui` overhead.                    | [ComponentContext](./standalone.md) |
| `RegisterComponent` | `#!luau (name: string, maker: function)`  | Register a custom component to the API. Reference [Custom Components](../../Custom%20Components/introduction.md) | void                                |
