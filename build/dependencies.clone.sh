#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function install_deps () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  set -o errexit -o pipefail
  local REPO_DIR="$(readlink -m -- "$BASH_SOURCE"/../..)"
  cd -- "$REPO_DIR"
  local DBGLV="${DEBUGLEVEL:-0}"
  local DEPS_BASEPATH='tmp.dependemcies'

  exec < <(grep -Pe '^\w' -- build/dependencies.want.txt)

  local DEST_BFN= DEST_GIT= FROM=
  while IFS= read -r FROM; do
    FROM="${FROM// /}"
    DEST_BFN="${FROM%%=*}"
    FROM="${FROM#*=}"
    echo -n "Dependency $DEST_BFN: "
    DEST_GIT="$DEPS_BASEPATH/$DEST_BFN.git"
    if [ -f "$DEST_GIT/config" ]; then
      echo 'have.'
      continue
    fi
    case "$FROM" in
      github:* ) clone_one_dep_repo "$DEST_BFN" "${FROM#*:}";;
      * ) echo E: "Unsupported dependency syntax: '$FROM'" >&2; return 4;;
    esac
  done
  echo 'Looks like we have all dependencies.'
}


function clone_one_dep_repo () {
  local GIT_CMD=( git clone --bare --single-branch )
  if [[ "$FROM" == *'#'* ]]; then
    GIT_CMD+=( --branch "${FROM##*'#'}" )
    FROM="${FROM%'#'*}"
  fi
  [ "${FROM%/}" == "$FROM" ] || FROM+="$DEST_BFN"
  FROM="${FROM/#github:/https://github.com/}"

  local HAVE="
    dependencies.@$HOSTNAME
    $HOME/lib
    $HOME/lib/node_modules
    $HOME/.node_modules
    "
  for HAVE in $HAVE; do
    for HAVE in "$HAVE/$DEST_BFN"{,/}.git/config ''; do
      [ -f "$HAVE" ] || continue
      FROM="${HAVE%/*}"
      break
    done
    [ -z "$HAVE" ] || break
  done

  GIT_CMD+=( -- "$FROM" "$DEST_GIT" )
  echo "gonna clone from: $FROM"
  [ "$DBGLV" -lt 2 ] || echo D: "clone cmd: ${GIT_CMD[*]}" >&2
  "${GIT_CMD[@]}"
}












install_deps "$@"; exit $?
