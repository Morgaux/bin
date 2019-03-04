#!/bin/sh

#
# Python3 file: edit  and run in one step
#

[ -x "$(command -v python3)" ] || exit 1

e "$1" && python3 "$1"

