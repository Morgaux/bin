#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Edit a file with the prefered editor
#

[ ! -z "$EDITOR" ] || err "EDITOR not set" || exit 1

log "$EDITOR $@"
SELF="$(basename $0)"
SELF_UPPER="$(echo $SELF | tr '[a-z]' '[A-Z]')"

usage() {
	echo "$SELF - edit a file with \$EDITOR"
	echo "usage: $SELF [${SELF_UPPER}_OPTS] [EDITOR_OPTS] FILE"
	echo "	${SELF_UPPER}_OPTS				Options for $SELF, see below"
	echo "	EDITOR_OPTS			Options for the \$EDITOR"
	echo "	FILE				Target file"
	echo ""
	echo "options:"
	echo "	-h	--help			Show this message"
	echo "	-r	--run [CMD [ARGS]]	Run the file as an executable."
	echo "					Tries to use the shebang line"
	echo "					or /bin/sh if none found. The"
	echo "					command to run can be overriden"
	echo "					by passing a CMD paramater."
	echo ""
	exit 0
}

run_file() {
	[ "$#" -gt 0] || err "error in trying to run file, no filename given" || exit 1
}

case $1 in
	"-h"|"--help")usage;;
	*);;
esac

env "$EDITOR" "$@"

