#!/bin/sh
#
# https://gitlab.com/morgaux/bin
#

[ -z "$EDITOR" ] && err "EDITOR unset"

env "$EDITOR" "$@" 

exit $?

