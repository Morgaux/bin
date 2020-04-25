#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Run a Python3 script
#

set -e

dependencies python3

exec python3 "$@"

