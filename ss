#!/bin/sh
# shellcheck disable=SC2116

#http://gitlab.com/morgaux/bin

#
# save a Screen Shot
#

for dependancy in scrot xdg-user-dir
do
	if [ -x "$(command -v "$dependancy")" ]
	then
		continue
	fi

	echo "$(basename "$0"): error: $dependancy is not installed." 1>&2
	exit 1
done

if ! hasX
then
	echo "$(basename "$0"): requires X11" 1>&2
	exit 1
fi

SAVE_DIR="$(xdg-user-dir PICTURES)/Screenshots/"

[ -d "$SAVE_DIR" ] || mkdir -p "$SAVE_DIR"

scrot '%s.png' -e "$(echo "mv \$f $SAVE_DIR")" $@ || exit 2

