#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

GEOMETRY=""

hasX || erro "no display found..." || exit 1

[ -x "$(command -v st)" ] || err "st not found" || exit 1
[ -x "$(command -v tabbed)" ] || err "tabbed not found" || exit 1
[ -x "$(command -v hacksaw)" ] && GEOMETRY=$(hacksaw -n) || err "hacksaw not found" || exit 1

if [ -z "$GEOMETRY" ]
then
	st -T floating-st -c floating-st &
	err "Could not set window geometry, using fallback" || exit 2
fi

tabbed -n floating-st -d -c -g "$GEOMETRY" -r 2 st -w '' -T floating-st &

exit 0

