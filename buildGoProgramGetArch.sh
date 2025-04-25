#!/bin/bash
buildGoProgramGetArch() {
  echo "[DEBUG] buildGoProgramGetArch: Determining architecture..." >&2
  local arch
  arch=$(uname -m)
  echo "[DEBUG] buildGoProgramGetArch: uname -m returned: $arch" >&2
  case "$arch" in
    x86_64|amd64)  echo "[DEBUG] buildGoProgramGetArch: Returning amd64" >&2; echo "amd64" ;;
    arm64|aarch64) echo "[DEBUG] buildGoProgramGetArch: Returning arm64" >&2; echo "arm64" ;;
    *)             echo "[DEBUG] buildGoProgramGetArch: Unknown architecture: $arch" >&2; echo "unknown" && return 1 ;;
  esac
  return 0
}