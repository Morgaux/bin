#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

[ -x "$(command -v st)" -a -x "$(command -v tabbed)" ] || exit 1

FST_CLASS="floating-st"

if [ -x "$(command -v hacksaw)" ]
then
	GEOMETRY=$(hacksaw) 
	tabbed -n "$FST_CLASS" -d -c -g "$GEOMETRY" -2 st -w '' &
else
	st -c "$FST_CLASS" &
fi

