#!/bin/sh

ibus start &
dbus-update-activation-environment DISPLAY
udiskie -ant &
sxhkd &
/usr/bin/lxpolkit &
~/.config/bspwm/scripts/autohide_polybar &
exec bspwm
