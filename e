#!/bin/sh
#
# https://gitlab.com/morgaux/bin
#
# Edit a file with the prefered editor
#

[ ! -z "$EDITOR" ] && { env "$EDITOR" "$@" ; exit $? ; }

err "EDITOR unset"

for i in vim vi nano leafpad gedit; do
	[ -x "$(command -v $i)" ] || continue
	env "$i" "@"
	exit 1
done > /dev/null

err "backup EDITOR could not be found"

exit 1

