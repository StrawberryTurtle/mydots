#!/bin/sh

ibus start &
dbus-update-activation-environment DISPLAY
sxhkd &
exec bspwm
