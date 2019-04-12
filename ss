#!/bin/sh

#
# save a Screen Shot
#

hasX || exit 1

[ -x "$(command -v scrot)" ] || err "scrot not found" || exit 1
[ -x "$(command -v xdg-user-dir)" ] || err "xdg-user-dir not found" || exit 1
[ -d "$(xdg-user-dir PICTURES)/Screenshots" ] && mkdir -p "$(xdg-user-dir PICTURES)/Screenshots"

# note: single quotes around -e argument to prevent envirmoment varaibles leaking
scrot "$@" '%s.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/' || exit 2

log "Screenshot saved to $(xdg-user-dir PICTURES)/Screenshots/"

