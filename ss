#!/bin/sh
# shellcheck disable=SC2116

#http://gitlab.com/morgaux/bin

#
# save a Screen Shot
#

set -e

# Color declarations for colourful output (if supported) {{{
RESET="$(   [ -x "$(command -v tput)" ] && tput sgr0    2>/dev/null || true)"
BLACK="$(   [ -x "$(command -v tput)" ] && tput setaf 0 2>/dev/null || true)"
RED="$(     [ -x "$(command -v tput)" ] && tput setaf 1 2>/dev/null || true)"
GREEN="$(   [ -x "$(command -v tput)" ] && tput setaf 2 2>/dev/null || true)"
YELLOW="$(  [ -x "$(command -v tput)" ] && tput setaf 3 2>/dev/null || true)"
BLUE="$(    [ -x "$(command -v tput)" ] && tput setaf 4 2>/dev/null || true)"
MAGENTA="$( [ -x "$(command -v tput)" ] && tput setaf 5 2>/dev/null || true)"
CYAN="$(    [ -x "$(command -v tput)" ] && tput setaf 6 2>/dev/null || true)"
WHITE="$(   [ -x "$(command -v tput)" ] && tput setaf 7 2>/dev/null || true)"
BOLD="$(    [ -x "$(command -v tput)" ] && tput bold    2>/dev/null || true)"
# Color declarations for colourful output (if supported) }}}

err() { # {{{
	echo "${YELLOW}ERROR${RESET}: ${BOLD}$@${RESET}" 1>&2
	return 1
} # }}}

die() { # {{{
	echo "${RED}FATAL ERROR${RESET}: ${BOLD}$@${RESET}" 1>&2
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

