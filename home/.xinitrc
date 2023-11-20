#!/bin/sh

dbus-update-activation-environment DISPLAY
sxhkd &
exec bspwm
