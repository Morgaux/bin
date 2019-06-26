#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

[ -x "$(command -v st)" ] || exit 1

FST_CLASS="floating-st"

if [ -x "$(command -v hacksaw)" ] && [ -x "$(command -v tabbed)" ]
then
	tabbed -n "$FST_CLASS" -d -c -g "$(hacksaw)" -2 st -w '' &
else
	st -c "$FST_CLASS" &
fi

