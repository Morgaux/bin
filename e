#!/bin/sh
#
# https://gitlab.com/morgaux/bin
#
# Edit a file with the prefered editor
#


# cleanly open a file if no args given and EDITOR is set
[ $# -gt 0 ] || [ -z "$EDITOR" ] || { env "$EDITOR" ; exit $? ; }


#
# unless option(s) given, below is unreachable
#


getEDITOR()
{
	# try to guess EDITOR if not set
	[ ! -z "EDITOR" ] && for i in vim vi nano ; do
		[ -x "$(command -v $i)" ] || continue
		export EDITOR="$(which $i)"
		return 0
	done > /dev/null

	die "valid editor not found"
}

validateEDITOR()
{
	# check properties of EDITOR variable
	[ ! -z "$EDITOR" ] || return 1
	[ -x "$(command -v $EDITOR)" ] || return 1
}

die()
{
	# print an error and exit
	err "$@"
	exit 1
}

editFile()
{
	# if EDITOR is valid, edit a file
	validateEDITOR || getEDITOR

	FILEPATH="$1"
	shift

	# give editor flags and file
	env "$EDITOR" "$@" "$FILEPATH"
}

readOption()
{
	case $1 in
		-E)
			# use a substitue EDITOR
			[ $# -gt 1 ] || die "$1 option requires argument"
			export EDITOR="$2"
			validateEDITOR || die "$2 is not a valid EDITOR"
			# tell arg reader to shift once extra
			return 1
			;;
		*)
			die "unknown option $1"
	esac
}

while [ $# -gt 0 ] ; do
	case "$1" in
		-*)
			# readOption func "fails" if extra shift required
			readOption "$@" || shift
			shift
			;;
		*)
			editFile $1
			shift
			;;
	esac
done

