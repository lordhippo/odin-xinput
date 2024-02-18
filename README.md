# odin-xinput
XInput binding for Odin. It is based on an auto-generated binding by using [odin-binding-generator](https://github.com/Breush/odin-binding-generator) on a manually pre-processed **xinput.h** header file that is available in the original folder. It was then manually cleaned up and modified.
# Usage
The API is identical to the original. The main difference is that enum-like constants are converted to Odin **enum**s, and flag-like constants are converted to **bit_set**s. They both have the correct WIN32 backing types.
# Examples
Exapmples of the usage of the API are available under the **examples** folder.