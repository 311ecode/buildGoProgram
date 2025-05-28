#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
buildGoProgramGetOS() {
  echo "[DEBUG] buildGoProgramGetOS: Determining OS..." >&2
  local os
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  echo "[DEBUG] buildGoProgramGetOS: uname -s returned: $os" >&2
  case "$os" in
  linux*)
    echo "[DEBUG] buildGoProgramGetOS: Returning linux" >&2
    echo "linux"
    ;;
  darwin*)
    echo "[DEBUG] buildGoProgramGetOS: Returning darwin" >&2
    echo "darwin"
    ;;
  msys* | mingw64* | cygwin*)
    echo "[DEBUG] buildGoProgramGetOS: Returning windows" >&2
    echo "windows"
    ;;
  *)
    echo "[DEBUG] buildGoProgramGetOS: Unknown OS: $os" >&2
    echo "unknown" && return 1
    ;;
  esac
  return 0
}
