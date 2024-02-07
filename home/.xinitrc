#!/bin/sh

ibus start &
dbus-update-activation-environment DISPLAY
sxhkd &
/usr/bin/lxpolkit &
exec bspwm
