#!/bin/sh
printf '\033c\033]0;%s\a' Projeto jogo IFSP
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Projeto jogo IFSP.x86_64" "$@"
