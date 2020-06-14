# Script: light-polybar-windows

A [Polybar](https://github.com/jaagr/polybar) script from [polybar-windows](https://github.com/aroma1994/polybar-windows) repository that shows opened and minimized windows on your current display (if there's an active window it's underlined in the **default decorated version** or marked by **#** in the simple version). 

- *Left-click* on any window title to **activate** that window (expands minimized) or to **minimize** it if it is already active.
- *Right-click* on a title to **close** the corresponding window.

## Screenshots

Simple version:

![polybar-windows](screenshots/polybar-windows.png)

Decorated version:

![polybar-windows](screenshots/polybar-windows-decorated.png)

## Dependencies

* `xprop`
* `wmctrl`

## Configuration

You can easily customize the plugin by adjusting parameters in  [polybar-windows.awk](polybar-windows.awk)

Comment 'Decorated version' block and uncomment 'Simple version' block to easily switch on the simple version.

## Module

```ini
[module/polybar-windows]
type = custom/script
exec = polybar-windows.sh
tail = true
```

It is better to change the paths to the scripts to `~/.config/polybar/scripts/polybar.windows.sh` and  `~/.config/polybar/scripts/polybar.windows.awk` (and to move them over there).
