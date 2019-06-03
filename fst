#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

GEOMETRY=""

[ -x "$(command -v slop)" ] && \
	GEOMETRY=$(slop -q -o -f '%x %y %w %h' | awk '{print $3x$4+$1+$2}')

[ -x "$(command -v hacksaw)" ] && \
	[ -z "GEOMETRY" ] && GEOMETRY=$(hacksaw -n)

[ -z "$GEOMETRY" ] && {
	tabbed -n floating-st -d -c -g "$GEOMETRY" -r 2 st -w '' -T floating-st &
	exit 0
} || st -T floating-st -c floating-st &

err "Could not set window geometry, using fallback" || exit 2

