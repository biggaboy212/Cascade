# The API

## Summary

### Properties

| Property       | Type       | Description |
|----------------|------------|-------------|
| `Themes`       | `{ Dark: { [any]: any }, Light { [any]: any }` | **[Read-only]** A list of predefined themes, which by default includes `Dark` and `Light`. |
| `Symbols`      | `{ [string]: string }` | **[Read-only]** A large list of symbols (Exported from Apple SF Symbols). |

!!! tip
    You can view all symbols here: <https://sf-symbols-one.vercel.app/>

### Methods

| Method | Arguments | Description | Returns |
|--------|-----------|-------------|---------|
| `New`  | `properties: AppProperties` | Creates a new [App](./app.md), this returns every component you can then call and will appear on screen. | [App](./app.md) |
