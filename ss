#!/bin/sh
#
# http://gitlab.com/morgaux/bin
#

# save a Screen Shot

[ -x "$(command -v scrot)" ] || exit 1
[ -x "$(command -v xdg-user-dir)" ] || exit 1
[ -d "$(xdg-user-dir PICTURES)/Screenshots" ] && mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"

scrot '%s.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/'

