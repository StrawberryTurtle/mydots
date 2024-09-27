#!/bin/sh

ibus start &
dbus-update-activation-environment DISPLAY
udiskie -ant &
sxhkd &
/usr/bin/lxpolkit &
autohide_polybar &
exec bspwm
