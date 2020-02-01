#!/bin/sh
# shellcheck disable=SC2005
#http://gitlab.com/morgaux/bin

#
# Execute or install neofetch
#

NEO_FILE="$HOME/.neofetch"

# Exec
[ -x "$(command -v neofetch)" ] && exec neofetch $@
[ -f "$NEO_FILE"              ] && exec "$NEO_FILE" $@

if ! { [ -x "$(command -v wget)" ] || [ -x "$(command -v curl)" ] ; }
then
	echo "$(basename "$0"): error: at least one of curl or wget must be installed." 1>&2
	exit 1
fi

# Install
VERURL="https://github.com/dylanaraps/neofetch/releases/latest"
SRCURL="https://raw.githubusercontent.com/dylanaraps/neofetch"

get_latest_tag() {
	if [ -x "$(command -v wget)" ]
	then
		wget -O /dev/null -S --spider "$VERURL" 2>&1 | awk '/Location/ {print $2}'
	else
		curl -Ls -o /dev/null -w "%{url_effective}\n" "$VERURL"
	fi | tr '/' '\n' | tail -1
}

get_latest_url() {
	echo "${SRCURL}/$(get_latest_tag)/neofetch"
}

download_from() {
	if [ -x "$(command -v wget)" ]
	then
		wget -q -O - "$1"
	else
		curl -s "$1"
	fi
}

download_from "$(get_latest_url)" > "$NEO_FILE"
chmod 755 "$NEO_FILE"

exec "$NEO_FILE" $@

