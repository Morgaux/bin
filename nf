#!/bin/sh
#http://gitlab.com/morgaux/bin

#
# Execute or install neofetch
#

PREFIX="/usr"
TMPDIR="/tmp"
SRCURL="https://raw.githubusercontent.com/dylanaraps/neofetch"
VERURL="https://github.com/dylanaraps/neofetch/releases/latest"
MANDIR="$PREFIX/share/man"

run_as_root() { # void, ( void )
	[ "$(id -u)" = "0" ] && return 0

	case "$(uname -a | tr '[:upper:]' '[:lower:]')" in
		*linux*)
			exec sudo -- "$0" "$ARGV" ;;
		*openbsd*)
			exec doas -- "$0" "$ARGV" ;;
		*)
			return 1 ;;
	esac
}

nf_install() { # void, ( void )
	run_as_root || die "could not install as root"

	mkdir -p "$PREFIX/bin" || return "$?"
	mkdir -p "$MANDIR/man1" || return "$?"
	cp -p "$TMPDIR/neofetch" "$PREFIX/bin/neofetch" || return "$?"
	cp -p "$TMPDIR/neofetch.1" "$MANDIR/man1" || return "$?"
	chmod 755 "$PREFIX/bin/neofetch" || return "$?"
}

nf_uninstall() { # void, ( void )
	run_as_root || die "could not uninstall as root"

	rm -rf "$PREFIX/bin/neofetch" || return "$?"
	rm -rf "$MANDIR/man1/neofetch.1"* || return "$?"
}

err() { # err, ( string[] )
	echo "$@" 1>&2
	return 1
}

die() { # err, ( string[] )
	err "$@"
	exit 1
}

get_version() { # string, ( void )
	if [ -x "$(command -v wget)" ]
	then
		wget --spider "$VERURL" 2>&1 | grep -i location | tail -1 | awk '{print $2}' | grep -o "tag.*" | cut -c 5-
		return 0
	fi

	if [ -x "$(command -v curl)" ]
	then
		curl -Ls -o /dev/null -w '%{url_effective}' "$VERURL" 2>&1 | grep -o "tag.*" | cut -c 5-
		return 0
	fi

	return 1
}

get_latest() { # void, ( void )
	if [ -x "$(command -v wget)" ]
	then
		wget -O- "$SRCURL/$(get_version)/neofetch" > "$TMPDIR/neofetch" 2>/dev/null
		wget -O- "$SRCURL/$(get_version)/neofetch.1" > "$TMPDIR/neofetch.1" 2>/dev/null
		return 0
	fi

	if [ -x "$(command -v curl)" ]
	then
		curl -s "$SRCURL/$(get_version)/neofetch" > "$TMPDIR/neofetch" 2>/dev/null
		curl -s "$SRCURL/$(get_version)/neofetch.1" > "$TMPDIR/neofetch.1" 2>/dev/null
		return 0
	fi

	return 1
}

print_latest() { # void, ( void )
	if [ -x "$(command -v wget)" ]
	then
		wget -O- "$SRCURL/$(get_version)/neofetch" 2>/dev/null
		return 0
	fi

	if [ -x "$(command -v curl)" ]
	then
		curl -s "$SRCURL/$(get_version)/neofetch" 2>/dev/null
		return 0
	fi

	return 1
}

usage() { # void, ( void )
	echo "	$(basename "$0") - a neofetch installer and shortcut"
	echo "	usage: [ -eiIruU] [ -h | --help ]"
	echo "	options:"
	echo "		-e"
	echo "			Execute neofetch if it exists, do not attempt install"
	echo "			if neofetch is not found."
	echo ""
	echo "		-i"
	echo "			Install neofetch if it doesn't exist, do not run after."
	echo "			Overrides -e flag and will install and then execute."
	echo ""
	echo "		-I"
	echo "			Like -ie, default."
	echo ""
	echo "		-r"
	echo "			Run neofetch by piping through bash, do not install."
	echo "			Allows quick and easy way to run neofetch with out"
	echo "			installing permanently or overriding existing install."
	echo ""
	echo "		-u"
	echo "			Uninstall neofetch if it has been installed. Removes"
	echo "			executable and man page."
	echo ""
	echo "		-U"
	echo "			Update neofetch to latest version, or install latest"
	echo "			version if not installed yet. Like -i but will force"
	echo "			install even if previous install found."
	echo ""
	echo "		-h"
	echo "			Display this message."
	echo ""

	exit 0
}

nf_execute() {
	if [ -x "$(command -v neofetch)" ]
	then
		exec neofetch
	else
		return 1
	fi
}

try_nf_install() {
	if [ -x "$(command -v neofetch)" ]
	then
		return 1
	else
		nf_install
		return 0
	fi
}

remote_execute() {
	[ -x "$(command -v bash)" ] || die "Bash not installed, cannot run from source."

	print_latest | bash

	exit $?
}

nf_update() {
	nf_uninstall
	nf_install
}

default() {
	try_nf_install
	nf_execute
}

main() { # void, ( string[] )
	ARGV="$*" # Remember original args

	if [ "$#" -gt 0 ]
	then
		echo "$@" | \
			cut -c 2- | \
			tr '[:space:]' '\n' | \
			tr -d '\n' | \
			sed -e 's/\(.\)/\1\n/g' | \
			while read -r i
		do
			case "$i" in
				e) nf_execute ;;
				h) usage ;;
				i) try_nf_install ;;
				I) default ;;
				r) remote_execute ;;
				u) nf_uninstall ;;
				U) nf_update ;;
				*) die "option: $i unknown." ;;
			esac
		done
	else
		default
	fi

}

main "$@"

