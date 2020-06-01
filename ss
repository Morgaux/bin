#!/bin/sh
# shellcheck disable=SC2116

#http://gitlab.com/morgaux/bin

#
# save a Screen Shot
#

set -e

err() { # {{{
	echo "$(basename "$0"): error, $@" 1>&2
} # }}}

die() { # {{{
	err "$@"
	exit 1
} # }}}

for dependancy in scrot xdg-user-dir # {{{
do
	if [ ! -x "$(command -v "$dependancy")" ]
	then
		die "${dependancy} is not installed."
	fi
done # }}}

if ! xset q >/dev/null 2>&1 # {{{
then
	die "xorg is not running." 1>&2
fi # }}}

# Setup {{{
XDG="$(xdg-user-dir PICTURES)"
DIR="${XDG:-"$HOME/var/Pictures"}/Screenshots/"
CMD="$(echo "mv \$f $DIR")"
FMT="%s.png"
# Setup }}}

if [ ! -d "$DIR" ] # {{{
then
	mkdir -p "$DIR" || die "couldn't create the '$DIR' directory"
fi # }}}

if ! scrot "$FMT" -e "$CMD" $@ # {{{
then
	die "scrot failed with error code '$?'"
fi # }}}

