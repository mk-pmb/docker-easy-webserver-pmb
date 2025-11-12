#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

set -o errexit -o pipefail
[ -d "$DEW_LIBDIR" ] || exit 2$(echo E: 'Emtpy DEW_LIBDIR!' >&2)

export DEBIAN_FRONTEND=noninteractive

echo D: 'Update apt package lists:'
[ -z "$https_proxy" ] || echo "Acquire::http::Proxy \"$https_proxy\";" \
  | tee -- /etc/apt/apt.conf.d/00proxy
apt-get update

echo D: 'Install the most basic apt packages,' \
  'i.e. the ones we need for smoothly installing the others later:'

APT_PKG=(
  locales
  )
echo y | apt-get install
