#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Run a Python3 script
#

[ -x "$(command -v python3)" ] && exec python3 "$@"

