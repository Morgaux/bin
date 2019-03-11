#!/bin/sh

#
# save a Screen Shot
#

hasX || err "$0: X not running" || exit 1

[ -x "$(command -v scrot)" ] && [ -x "$(command -v xdg-user-dir)" ] || exit 1
[ -d "$(xdg-user-dir PICTURES)/Screenshots" ] && mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"

scrot "$@" '%s.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/'

