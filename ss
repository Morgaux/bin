#!/bin/sh

#
# save a Screen Shot
3

[ -x "$(command -v scrot)" ] && [ -x "$(command -v xdg-user-dir)" ] || exit 1
[ -d "$(xdg-user-dir PICTURES)/Screenshots" ] && mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"

scrot '%s.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/'

