#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Run a Python3 script
#

[ -x "$(command -v python3)" ] || err "Python3 not found, please install" || exit 1

python3 "$@"

