#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function prepare_inside_docker_cli_init () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  echo "D:$(printf -- ' ‹%s›' "$0" "$@""
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?

  echo D: $FUNCNAME: "Running as pid $$ for user $(whoami) in $(pwd)"
  ls -alF

  echo; echo D: 'Starting the actual webserver.'
  exec lighttpd # -f /etc/lighttpd/lighttpd.conf
}










prepare_inside_docker_cli_init "$@"; exit $?
