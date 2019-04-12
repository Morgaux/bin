#!/bin/sh

#
# Edit a file with the prefered editor
#

[ ! -z "$EDITOR" ] || err "EDITOR not set"

log "$EDITOR $@"

env "$EDITOR" "$@"

