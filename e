#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the preferred editor
#

[ -x "$EDITOR" ] && exec env "$EDITOR" "$@"

echo "$(basename "$0"): error: no valid editor set" 1>&2
exit 1

