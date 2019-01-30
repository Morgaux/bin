#!/bin/sh

##
#
# http://gitlab.com/morgaux/bin
#
# Installs bin files
#
##

# Definitions
SRCDIR="$(dirname $(readlink -f "$0"))"
NAME="~/bin Installer"
VERSION="2.0.0"
MESG="Installer commit"

# Functions

main()
{
	[ -d "$HOME/bin" ] || mkdir -p "$HOME/bin"
	[ $# -gt 0 ] && readFlags $@ || usage
}

usage()
{
	echo "$NAME v$VERSION - usage:"
	echo "./install.sh [ -h ] | [ -i DIRECTORY ]"
	echo ""
	echo "options:"
	echo "-h, --help		show this message"
	echo "-i, --install 		install files to ~/bin"
	exit 0
}

readFlags()
{
	while [ $# -gt 0 ] ; do
		case $1 in
			-h|--help)
				usage # exit implicit
				;;
			-i|--install)
				shift
				selfInstall
				;;
			*)
				die "$1 option unknown"
				;;
		esac
	done
}

selfInstall()
{
	echo "Installing..."
	for i in e tt uf weather ; do
		echo "$i	->	~/bin"
		cp -uf $SRCDIR/$i $HOME/bin/.
	done
}

die()
{
	echo "$NAME: error: $@" 1>&2
	exit 1
}

main $@

exit $?

