# Change Log

## Release

## Beta

### `v1.0.0-beta.6`

```diff
! Fixed an issue where menus (pop-up menu, pull-down menu) would show behind the main window.
! Fixed an issue where the search field would not be visible at first.
```

### `v1.0.0-beta.5`

```diff
+ Added pull-down buttons

! Fixed an issue where clicking off a menu (pull down buttons, pop up buttons) is offset around 30-40 pixels. This was fixed by counter-accounting for topbar inset.

? Possibly fixed an issue with the toggle's theme not using the correct theme on startup
```

### `v1.0.0-beta.4`

```diff
+ Added pop-up buttons

- Removed a leftover print statement in symbols (Prints its style)

! Optimized toggles slightly by not putting them in a canvas groups, this should improve memory consumption.
! Changed the way a tab indent's itself, now instead of it's size being changed, the contents margins shrink to the right.
! Fixed unchanged statements in radio button groups (docs) from a copied component document in the docs.
! Fixed radio button groups having a default value if no value was given.
! Fixed accessory sizing behavior in rows (particularly the issue was for text fields, but this extends to all components.)
```

### `v1.0.0-beta.3`

```diff
! Fixed errors on minimize if blur was disabled on startup.
! Fixed the search field not being set as non-visible if it was touching something on startup.

+ Added Auto-step when a stepper increment/decrement arrow is held.

? Possibly fixed an issue with the toggle's theme not using the correct theme on startup
```

### (Previous releases were untracked)
