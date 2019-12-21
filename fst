#!/bin/sh
# http://gitlab.com/morgaux/bin
# Credit http://github.com/mitchweaver/bin

# floating st wrapper for dwm

for dependancy in st tabbed hacksaw
do
	if [ -x "$(command -v "$dependancy")" ]
	then
		continue
	fi

	echo "$(basename "$0"): error: $dependancy is not installed." 1>&2
	exit 1
done

FST_CLASS="floating-st"

(tabbed -n "$FST_CLASS" -c -g "$(hacksaw)" -r 2 st -w '' &)

