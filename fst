#!/bin/sh

# floating st wrapper for dwm

hasX || erro "no display found..." || exit 1

[ -x "$(command -v st)" ]
[ -x "$(command -v hacksaw)" ] || PATH="$PATH:$HOME/.cargo/bin"
[ -x "$(command -v hacksaw)" ] || err "hacksaw not found" || exit 1

tabbed -g "$(hacksaw -n)" -n floating-st -c -k -r 2 st -w '' -c floating-st -t st

