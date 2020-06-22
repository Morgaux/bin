#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the preferred editor
#

if [ ! -x "$EDITOR" ]
then
	echo "$(basename "$0"): error: no valid editor set" 1>&2
	exit 1
fi

while [ "$#" -gt 0 ]
do
	env "$EDITOR" "$1"
	shift
done

