#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

function ciprep_cli_main () {
  local REPO_DIR="$(readlink -m -- "$BASH_SOURCE"/../..)"
  cd -- "$REPO_DIR"

  local BRANCH="$(git branch --show-current)" # aka GITHUB_REF_NAME
  local COMMIT="$(git rev-parse HEAD)" # aka GITHUB_SHA

  local KEY= VAL=
  local -A DK=(
    [tags]=
    [push]='false'
  )
  case "$BRANCH" in
    master ) DK[tags]='%:latest';;
    release-* ) DK[tags]="%:${BRANCH#*-}";;

    experimental ) DK[tags]="%:$BRANCH";;
  esac

  local GH_REPO="${GITHUB_REPOSITORY:-gh-user/gh-repo}"
  local DK_TAG_BASE="$DOCKER_REGISTRY/$GH_REPO"
  if [ -n "${DK[tags]}" ]; then
    DK[push]='true'
    DK[tags]+=",%:${COMMIT:0:7}"
    DK[tags]="${DK[tags]//%/$DK_TAG_BASE}"
  fi

  [ -n "$GITHUB_OUTPUT" ] || local GITHUB_OUTPUT='tmp.ghoutput.vars'
  for KEY in "${!DK[@]}"; do
    echo "dkimg_$KEY=${DK[$KEY]}"
  done | sort -V >>"$GITHUB_OUTPUT"
  ghciu fmt_markdown_textblock__dump_ghoutput --open
}










ciprep_cli_main "$@"; exit $?
