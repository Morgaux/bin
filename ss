#!/bin/sh
#
# http://gitlab.com/morgaux/bin
#

# save a Screen Shot

[ -d ~/var/Pictures ] && [ -x "$(command -v scrot)" ] || exit 1

 scrot '%s.png' -e 'mv $f ~/var/Pictures/'

