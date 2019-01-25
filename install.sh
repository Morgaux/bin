#!/bin/sh

##
#
# http://gitlab.com/morgaux/bin
#
# Installs bin files
#
##

# Definitions
NAME="~/bin Installer"
VERSION="1.0.0"
MESG="Installer commit"

# Functions

main()
{
	[ -d "$HOME/bin" ] || mkdir -p "$HOME/bin"
	[ $# -gt 0 ] && readFlags $@ || usage
}

usage()
{
	echo "usage:"
	echo "./install.sh [ -h ] | [ -c | -p  MESSAGE ] | [ -i DIRECTORY ]"
	echo ""
	echo "options:"
	echo "-h, --help		show this message"
	echo "-c message		commit local changes"
	echo "-p message		push commits to repo"
	echo "-i, --install DIRECTORY	install bin/DIRECTORY files"
	echo ""
	echo "$NAME - v$VERSION"
	exit 0
}

readFlags()
{
	while [ $# -gt 0 ] ; do
		case $1 in
			-h|--help)
				usage # exit implicit
				;;
			-c|--commit)
				shift
				[ $# -gt 0 ] || die "-c requires message"
				MESG="$@"
				selfCommit
				exit $?
				;;
			-p|--push)
				shift
				[ $# -gt 0 ] || die "-p requires message"
				MESG="$@"
				selfPush
				exit $?
				;;
			-i|--install)
				shift
				[ $# -gt 0 ] || die "-i requires message"
				while [ $# -gt 0 ] ; do
					selfInstall $1
					shift
				done
				;;
			*)
				die "$1 option unknown"
				;;
		esac
	done
}

selfInstall()
{
	if [ -d $1 ] ; then
		for i in $1/* ; do
			echo "Installing $i..."
			cp -uf ~/src/bin/$i ~/bin/.
		done
		return
	fi
	die "directory $1 not found"
}

selfCommit()
{
	[ -x "$(command -v git)" ] || die "git not installed"
	echo "Adding changes..."
	git add .
	echo "Commiting changes \"$MESG\""
	git diff-index --quiet HEAD -- || git commit -m "$MESG"
}

selfPush()
{
	selfCommit
	echo "Pushing commit..."
	git log --oneline -1
	#git push
	until git push ; do
		echo "Retrying" 1>&2
	done
}

die()
{
	echo "$NAME: error: $@" 1>&2
	exit 1
}

main $@

exit $?

