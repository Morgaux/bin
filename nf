#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Execute or install neofetch
#

# Exec
[ -x "$(command -v neofetch)" ] && exec neofetch

# Install

VERURL="https://github.com/dylanaraps/neofetch/releases/latest"

if [ ! "$(head -n 1 "$HOME/.neofetch" 2>/dev/null | cut -c -2)" = "#!" ]
then
	SRCURL="https://raw.githubusercontent.com/dylanaraps/neofetch/$(\
		echo "$(\
			[ -x "$(command -v wget)" ] && wget --spider "$VERURL" 2>&1 | grep -i location | tail -1 | awk '{print $2}' || \
			[ -x "$(command -v curl)" ] && curl -Ls -o /dev/null -w '%{url_effective}' "$VERURL" 2>&1 || exit 1 \
		)" | grep -o "tag.*" | cut -c 5-)/neofetch"
	[ -x "$(command -v wget)" ] && wget -O- "$SRCURL" 2>/dev/null > "$HOME/.neofetch" ||
	[ -x "$(command -v curl)" ] && curl -s "$SRCURL" 2>/dev/null > "$HOME/.neofetch" || exit 1
fi

chmod 755 "$HOME/.neofetch" && exec "$HOME/.neofetch"

