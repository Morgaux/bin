#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# save a Screen Shot
#

hasX && \
	[ -x "command -v scrot" ] && \
	[ -x "command -v xdg-user-dir" ] && \
	exit 1

SAVE_DIR="$(xdg-user-dir PICTURES)/Screenshots/"
[ -d "$SAVE_DIR" ] || mkdir -p "$SAVE_DIR"

scrot "$*" '%s.png' -e "$(echo "mv \$f $SAVE_DIR")" || exit 2

