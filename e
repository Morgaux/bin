#!/bin/sh

#
# Edit a file with the prefered editor
#

[ ! -z "$EDITOR" ] && env "$EDITOR" "$@"

