#!/bin/sh

xprop -root -notype -spy _NET_ACTIVE_WINDOW _NET_CURRENT_DESKTOP _NET_CLIENT_LIST | \
$HOME/.config/polybar/scripts/polybar-windows.awk