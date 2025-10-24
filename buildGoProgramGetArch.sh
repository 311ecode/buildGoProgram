#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

# Function to check DEBUG variable
is_debug_mode_buildGoProgramGetArch() {
  [ -n "$DEBUG" ] && [ "${DEBUG,,}" != "0" ] && [ "${DEBUG,,}" != "false" ]
}

buildGoProgramGetArch() {
  if is_debug_mode_buildGoProgramGetArch; then
    echo "[DEBUG] buildGoProgramGetArch: Determining architecture..." >&2
  fi
  local arch
  arch=$(uname -m)
  if is_debug_mode_buildGoProgramGetArch; then
    echo "[DEBUG] buildGoProgramGetArch: uname -m returned: $arch" >&2
  fi
  case "$arch" in
  x86_64 | amd64)
    if is_debug_mode_buildGoProgramGetArch; then
      echo "[DEBUG] buildGoProgramGetArch: Returning amd64" >&2
    fi
    echo "amd64"
    ;;
  arm64 | aarch64)
    if is_debug_mode_buildGoProgramGetArch; then
      echo "[DEBUG] buildGoProgramGetArch: Returning arm64" >&2
    fi
    echo "arm64"
    ;;
  *)
    if is_debug_mode_buildGoProgramGetArch; then
      echo "[DEBUG] buildGoProgramGetArch: Unknown architecture: $arch" >&2
    fi
    echo "unknown" && return 1
    ;;
  esac
  return 0
}
