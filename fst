#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm


FST_CLASS="floating-st"

[ -x "$(command -v st)" ] &&
	if [ -x "$(command -v hacksaw)" ] &&
		[ -x "$(command -v tabbed)" ]
	then
		( tabbed -n "$FST_CLASS" -c -g "$(hacksaw)" -r 2 st -w '' &)
	else
		( st -c "$FST_CLASS" -n "$FST_CLASS" &)
	fi && exit 0

exit 1

