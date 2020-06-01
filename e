#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the preferred editor
#

if [ -x "$EDITOR" ]
then
	exec env "$EDITOR" "$@"
fi

echo "$(basename "$0"): error: no valid editor set" 1>&2
exit 1

