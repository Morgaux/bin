#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

GEOMETRY=""

hasX || err "no display found..." || exit 1

dependencies st tabbed hacksaw || exit 1

GEOMETRY=$(hacksaw -n) 

if [ -z "$GEOMETRY" ]
then
	st -T floating-st -c floating-st &
	err "Could not set window geometry, using fallback" || exit 2
fi

tabbed -n floating-st -d -c -g "$GEOMETRY" -r 2 st -w '' -T floating-st &

exit 0

