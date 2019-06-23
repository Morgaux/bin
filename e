#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the prefered editor
#

[ -n "$EDITOR" ] || err "EDITOR not set" || exit 1

env "$EDITOR" "$@"

