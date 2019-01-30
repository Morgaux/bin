#!/bin/sh
#
# https://gitlab.com/morgaux/bin
#

err()
{
	echo "error: $@" 1>&2
	exit 1
}

[ -z "$EDITOR" ] && err "EDITOR unset"

env "$EDITOR" "$@" 

exit $?

