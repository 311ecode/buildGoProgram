#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

# Function to check DEBUG variable
is_debug_mode_buildGoProgramGetOS() {
  [ -n "$DEBUG" ] && [ "${DEBUG,,}" != "0" ] && [ "${DEBUG,,}" != "false" ]
}

buildGoProgramGetOS() {
  if is_debug_mode_buildGoProgramGetOS; then
    echo "[DEBUG] buildGoProgramGetOS: Determining OS..." >&2
  fi
  local os
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  if is_debug_mode_buildGoProgramGetOS; then
    echo "[DEBUG] buildGoProgramGetOS: uname -s returned: $os" >&2
  fi
  case "$os" in
  linux*)
    if is_debug_mode_buildGoProgramGetOS; then
      echo "[DEBUG] buildGoProgramGetOS: Returning linux" >&2
    fi
    echo "linux"
    ;;
  darwin*)
    if is_debug_mode_buildGoProgramGetOS; then
      echo "[DEBUG] buildGoProgramGetOS: Returning darwin" >&2
    fi
    echo "darwin"
    ;;
  msys* | mingw64* | cygwin*)
    if is_debug_mode_buildGoProgramGetOS; then
      echo "[DEBUG] buildGoProgramGetOS: Returning windows" >&2
    fi
    echo "windows"
    ;;
  *)
    if is_debug_mode_buildGoProgramGetOS; then
      echo "[DEBUG] buildGoProgramGetOS: Unknown OS: $os" >&2
    fi
    echo "unknown" && return 1
    ;;
  esac
  return 0
}
