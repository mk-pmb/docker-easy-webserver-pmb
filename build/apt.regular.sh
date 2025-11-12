#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

set -o errexit -o pipefail
[ -d "$DEW_LIBDIR" ] || exit 2$(echo E: 'Emtpy DEW_LIBDIR!' >&2)

export DEBIAN_FRONTEND=noninteractive

echo D: 'Install the regular apt packages:'
# … some of which are more "demanding" than those in `apt.basics.sh`,
# e.g. would complain about stuff like missing locales.

APT_PKG=(
  lighttpd
  )
echo y | apt-get install "${APT_PKG[@]}"
