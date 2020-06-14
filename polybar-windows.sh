#!/bin/sh

xprop -root -notype -spy _NET_ACTIVE_WINDOW _NET_CURRENT_DESKTOP _NET_CLIENT_LIST | \
"${0%.*}.awk"
