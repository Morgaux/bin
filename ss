#!/bin/sh
#
# http://gitlab.com/morgaux/bin
#

# save a Screen Shot

[ -d "$(xdg-user-dir PICTURES)/Screenshots" ] && mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"
[ -x "$(command -v scrot)" ] || exit 1

 scrot '%s.png' -e 'mv $f ~/var/Pictures/'

