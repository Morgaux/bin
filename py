#!/bin/sh
#
# https://gitlab.com/morgaux/bin
#

#
# Python3 file: edit  and run in one step
#

[ -x "$(command -v python3)" ] || exit

e "$1" || python3 "$1"

