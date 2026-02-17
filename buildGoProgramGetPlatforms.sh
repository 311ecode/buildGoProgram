#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

buildGoProgramGetPlatforms() {
  # Returns the list of target platforms in the format OS:ARCH:EXTENSION
  local -a platforms=(
    "linux:amd64:"
    "darwin:amd64:"
    "darwin:arm64:"
    "windows:amd64:.exe"
    "current::"
  )
  echo "${platforms[@]}"
}
