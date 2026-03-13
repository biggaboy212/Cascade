# The API

## Summary

### Properties

| Property  | Type                   | Description                                                                                                                      |
| --------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `Themes`  | `{ [string]: Theme }`  | **[Read-only]** Provides default application theme modes . See [all themes](./themes.md).                                        |
| `Accents` | `{ [string]: Accent }` | **[Read-only]** Provides preset accents. See [all accents](./accents.md).                                                        |
| `Symbols` | `{ [string]: string }` | **[Read-only]** A large list of symbols (exported from Apple SF Symbols). See [all symbols](https://sf-symbols-one.vercel.app/). |

### Methods

| Method              | Arguments                          | Description                                                                                                      | Returns                             |
| ------------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| `New`               | `properties: AppProperties`        | Creates a new [App](./app.md), this returns every component you can then call and will appear on screen.         | [App](./app.md)                     |
| `Component`         | `properties: ComponentProperties?` | Creates a standalone [component context](./standalone.md) without `App` `ScreenGui` overhead.                    | [ComponentContext](./standalone.md) |
| `RegisterComponent` | `(name: string, maker: function)`  | Register a custom component to the API. Reference [Custom Components](../../Custom%20Components/introduction.md) | void                                |
