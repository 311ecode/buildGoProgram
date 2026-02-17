#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

buildGoProgram() {
  command -v markdown-show-help-registration &>/dev/null && eval "$(markdown-show-help-registration --minimum-parameters 3)"
  local src_dir="$1"
  local bin_dir="$2"
  local prog_name="${3}"

  # Now retrieving platforms from the external utility
  local -a platforms=($(buildGoProgramGetPlatforms))

  if is_debug_mode_buildGoProgram; then
    echo "[DEBUG] buildGoProgram: src_dir=$src_dir, bin_dir=$bin_dir, prog_name=$prog_name" >&2
    echo "[DEBUG] buildGoProgram: Target platforms: ${platforms[*]}" >&2
  fi

  if [ ! -d "$src_dir" ]; then
    return 1
  fi

  mkdir -p "$bin_dir"
  local current_dir=$(pwd)
  cd "$src_dir" || return 1

  # Pass the retrieved platforms to the builder
  buildGoProgram_platforms "$bin_dir" "$prog_name" "$current_dir" "${platforms[@]}"
  local build_success=$?

  cd "$current_dir" || return 1

  if [ $build_success -eq ${#platforms[@]} ]; then
    is_debug_mode_buildGoProgram && echo "[INFO] All builds completed successfully for $prog_name" >&2
  else
    is_debug_mode_buildGoProgram && echo "[INFO] Completed $build_success/${#platforms[@]} builds for $prog_name" >&2
  fi

  return 0
}

alias grp=gitRelativePath
registerToFunctionsDB
