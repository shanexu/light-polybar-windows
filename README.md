# Script: polybar-windows

A [Polybar](https://github.com/jaagr/polybar) script forked from original [polybar-windows](https://github.com/aroma1994/polybar-windows) that shows opened and minimized windows on your current display (if there's an active window it's marked by #). You can click on any window title to switch on that window (or expand minimized window), and click on an active window to minimize it.

This version changes the .sh file to a compilable .awk file (in the .awk form it is already significantly sped up)

Simple version:

![polybar-windows](screenshots/polybar-windows.png)

Decorated version:

![polybar-windows](screenshots/polybar-windows-decorated.png)

### If you really want speed:

I suggest installing [awka](https://github.com/noyesno/awka) to compile the awk script for ~30% speedup, [here](Makefile) is a makefile to facilitate the process.

Just install awka,  use `make` and then change `polybar-windows.awk` to `polybar-windows` in the .ini file.

## Dependencies

* `xprop`
* `wmctrl`

### Optional dependencies

* `awka`

## Configuration

Comment 'Decorated version' block and uncomment 'Simple version' block to switch on simple version.

## Module

```ini
[module/polybar-windows]
type = custom/script
exec = polybar-windows.awk
format = <label>
label = %output%
label-padding = 1
interval = 1
```
