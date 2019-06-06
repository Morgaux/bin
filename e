#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the prefered editor
#

[ ! -z "$EDITOR" ] || err "EDITOR not set" || exit 1

log "$EDITOR $*"
SELF="$(basename "$0")"
SELF_UPPER="$(echo "$SELF" | tr '[:lower:]' '[:upper:]')"

usage() {
	echo "$SELF - edit a file with \$EDITOR"
	echo "usage: $SELF [${SELF_UPPER}_OPTS] [EDITOR_OPTS] FILE"
	echo "	${SELF_UPPER}_OPTS				Options for $SELF, see below"
	echo "	EDITOR_OPTS			Options for the \$EDITOR"
	echo "	FILE				Target file"
	echo ""
	echo "options:"
	echo "	-h	--help			Show this message"
	echo ""
	exit 0
}

case $1 in
	"-h"|"--help")	usage;;
	*);;
esac

env "$EDITOR" "$@"

