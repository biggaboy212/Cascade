# Format

New components should be seperated into two files: `init` and `ui` inside of a directory with the name of the component.

## `init`

`init` should contain the logic for said component. This can handle animations, state, etc. If said handlers get too complex, you might want to consider seperating them into their own seperate files, such as `animations` for a component with heavy animations.

Note that the component directory, when accessed, automatically redirects to the `init` file when it exists. You do not need to say `Component/init`, darklua automatically handles this for you.

> To extend on the above, there is a quirk with init files which makes you have to use `@self` alias instead of `./` to access the members of the directory.

## `ui`

`ui` should contain the actual UI creation for said component, you can make them in a similar format to `src/structures`, they simply return their objects in a `tuple`, or you could return them in a structured table. It does not matter as long as they are easily accessible.
