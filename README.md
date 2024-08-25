# backdash-macro
an autohotkey macro that automatically does backdash cancel for you.


## Overview
This script is designed for users who want to automate the backdash cancel technique using AutoHotkey. While many people use programs like MacroGamer for this purpose, those programs often lack advanced features and customization options. This script aims to provide a more powerful and flexible alternative.

## Key Features
- **Uninterupted user handling**:    Any type of user input such as holding the S key or the W key would not affect the execution of the backdash cancel, this allows for more freedom during backdash cancel

- **High-precision timing**:         In spite of the fact that using DLLCalls for sleep timing is unnecessary, I decided why not? and such, this script uses DLLCalls (highprecisionsleep) instead of sleep

- **A Suspend/Unsuspend hotkey!**    You would have to manually open MacroGamer and stop the macro itself from running, quite obnoxious in my opinion.


## Prerequirements
To run this script, you would need the following:

- [Autohotkey v2](https://autohotkey.com)


## Installation

To install, simply head over to the [release](https://github.com/yxnc/backdash-macro/releases) page and choose which version you want.

## Usage



Run **macro.ahk** or **debug.ahk** with autohotkey version 2



### Keybinds


> [!NOTE]
> Keybinds below are my own preferred set. Feel free to modify the keybinds to your preference!




- 'E' = Does backdash cancel for the 3rd move
- 'R' = Does backdash cancel for the 2nd move
- 'T' = Does backdash cancel for the 1st move
- 'C' = Does backdash cancel for the 4th move
- 'Alt + Z' = Suspends/Unsuspends the script
