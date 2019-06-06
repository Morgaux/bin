#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Run a Python3 script
#

dependencies python3 || exit 1

python3 "$@"

