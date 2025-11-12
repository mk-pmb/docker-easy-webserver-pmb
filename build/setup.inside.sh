#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

set -o errexit -o pipefail
[ -d "$DEW_LIBDIR" ] || exit 2$(echo E: 'Emtpy DEW_LIBDIR!' >&2)

# Create backups of config files that we want to automatically modify
# on container start:
VAL='
  /etc/hosts
  /etc/lighttpd/lighttpd.conf
  '
for VAL in $VAL; do
  cp --no-target-directory -- "$VAL"{,.orig} || return $?
done
