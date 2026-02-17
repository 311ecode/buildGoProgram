#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

# Function to check DEBUG variable


# Function to build Go program for multiple platforms
buildGoProgram() {
  command -v markdown-show-help-registration &>/dev/null && eval "$(markdown-show-help-registration --minimum-parameters 3)"
  local src_dir="$1"
  local bin_dir="$2"
  local prog_name="${3}" # Default to 'filescanGo' if not provided
  local build_success=0

  # Array of platforms: OS, ARCH, EXTENSION
  local -a platforms=(
    "linux:amd64:"
    "darwin:amd64:"
    "darwin:arm64:"
    "windows:amd64:.exe"
    "current::"
  )

  if is_debug_mode_buildGoProgram; then
    echo "[DEBUG] buildGoProgram: src_dir=$src_dir, bin_dir=$bin_dir, prog_name=$prog_name" >&2
  fi

  # Validate source directory
  if [ ! -d "$src_dir" ]; then
    if is_debug_mode_buildGoProgram; then
      echo "[DEBUG] buildGoProgram: Source directory $src_dir does not exist" >&2
    fi
    return 1
  fi

  # Create bin directory
  mkdir -p "$bin_dir"

  # Preserve current directory
  local current_dir=$(pwd)
  if is_debug_mode_buildGoProgram; then
    echo "[DEBUG] buildGoProgram: current_dir=$current_dir" >&2
  fi

  # Navigate to source directory
  cd "$src_dir" || return 1
  if is_debug_mode_buildGoProgram; then
    echo "[DEBUG] buildGoProgram: Changed to directory: $(pwd)" >&2
  fi

  # Call platform building function
  buildGoProgram_platforms "$bin_dir" "$prog_name" "$current_dir" "${platforms[@]}"
  local build_success=$?

  # Return to original directory
  cd "$current_dir" || return 1
  if is_debug_mode_buildGoProgram; then
    echo "[DEBUG] buildGoProgram: Returned to directory: $(pwd)" >&2
  fi

  # Final status
  if [ $build_success -eq ${#platforms[@]} ]; then
    if is_debug_mode_buildGoProgram; then
      echo "[INFO] All builds completed successfully for $prog_name" >&2
    fi
  else
    if is_debug_mode_buildGoProgram; then
      echo "[INFO] Completed $build_success/${#platforms[@]} builds for $prog_name" >&2
    fi
  fi

  return 0
}

# Helper function to build for specific platforms


alias grp=gitRelativePath

registerToFunctionsDB
