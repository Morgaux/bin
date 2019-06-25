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

run_as_root() {
	[ "$(id -u)" = "0" ] && return 0

	case "$(uname -a | tr '[:upper:]' '[:lower:]')" in
		*linux*)
			exec sudo "$0" || return "$?" ;;
		*openbsd*)
			exec doas "$0" || return "$?" ;;
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
		curl -Ls -o /dev/null -w %{url_effective} "$VERURL" 2>&1 | grep -o "tag.*" | cut -c 5-
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

main() { # void, ( string[] )
	[ -x "$(command -v neofetch)" ] && exec neofetch


	get_latest || die "could not download neofetch"
	nf_install || die "could not install"
	main "$@"

	exit "$?"
}

main "$@"

