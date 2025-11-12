#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-
set -e
REPO_DIR="$(readlink -m -- "$BASH_SOURCE"/../..)"
cd -- "$REPO_DIR"
BX=(
  docker buildx build
  # --no-cache
  --progress plain
  --file build/dockerfile.conf
  --build-arg https_proxy --network host
  )
"${BX[@]}" . |& tee -- tmp.buildx.log
