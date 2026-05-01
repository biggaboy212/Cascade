# Building From Source

[aftman]: <https://github.com/LPGhatguy/aftman>
[environment variables]: <https://www.howtogeek.com/787217/how-to-edit-environment-variables-on-windows-10-or-11/>
[cd]: <https://en.wikipedia.org/wiki/Cd_(command)>
[cascade repository]: <https://github.com/biggaboy212/Cascade>
[ProCMP]: <https://github.com/Proton-Utilities/ProCMP>

Before we do anything, open a terminal and set its [cd] to the Cascade source repo. You can download a release from the official [cascade repository].
!!! tip
    You can use `#!bash git clone "https://github.com/biggaboy212/Cascade.git"` if you have `git` installed

## Installing [aftman] & dependencies

Aftman is a package manager, it will help you automatically install all the required dependencies that are needed to build cascade.

1. First, you must install [aftman] if you don't already have it.

    > Ensure it's in your [environment variables], this lets us access [aftman] from a terminal.

2. Run `aftman install` in the cascade directory to install all required dependencies

## Building a release

Cascade uses [ProCMP] for build composition.

- To build a release with [ProCMP], use `pcmp pipeline/.pcmp.json`, this will run the compositor program using our PCMP config. After this, you can select from a build configuration, such as debug.
- Artifacts will appear in `generated/`.
