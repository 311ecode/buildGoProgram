#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

# Function to check DEBUG variable
is_debug_mode_buildGoProgram() {
  [ -n "$DEBUG" ] && [ "${DEBUG,,}" != "0" ] && [ "${DEBUG,,}" != "false" ]
}

# Function to build Go program for multiple platforms
buildGoProgram() {
  eval "$(markdown-show-help-registration --minimum-parameters 3)"
  local src_dir="$1"
  local bin_dir="$2"
  local prog_name="${3}" # Default to 'filescanGo' if not provided
  local build_success=0

  # Array of platforms: OS, ARCH, EXTENSION
  local -a platforms=(
    "linux:amd64:"
    "darwin:amd64:"
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

  # Loop through platforms
  for platform in "${platforms[@]}"; do
    # Split platform into OS, ARCH, EXT
    IFS=':' read -r os arch ext <<<"$platform"

    # Set output binary name
    local output_bin
    if [ "$os" == "current" ]; then
      output_bin="$bin_dir/$prog_name"
    else
      output_bin="$bin_dir/$prog_name-${os}-${arch}${ext}"
    fi

    # Determine platform description
    local platform_desc
    if [ "$os" == "current" ]; then
      platform_desc="current platform"
    else
      platform_desc="${os} (${arch})"
    fi

    if is_debug_mode_buildGoProgram; then
      echo "[DEBUG] buildGoProgram: Building for $platform_desc..." >&2
    fi

    # Build command
    if [ "$os" == "current" ]; then
      go build -o "$output_bin" .
    else
      GOOS=$os GOARCH=$arch go build -o "$output_bin" .
    fi

    # Check if build was successful
    if [ $? -eq 0 ] && [ -f "$output_bin" ]; then
      if is_debug_mode_buildGoProgram; then
        echo "[INFO] Build successful for $platform_desc: $(realpath "$output_bin")" >&2
      fi
      ((build_success++))
    else
      if is_debug_mode_buildGoProgram; then
        echo "[DEBUG] buildGoProgram: Failed to build for $platform_desc" >&2
      fi
    fi
  done

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

alias grp=gitRelativePath

registerToFunctionsDB
