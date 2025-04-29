#!/bin/bash

# Function to build Go program for multiple platforms
buildGoProgram() {
  local src_dir="$1"
  local bin_dir="$2"
  local prog_name="${3:-filescanGo}"  # Default to 'filescanGo' if not provided
  local build_success=0

  # Array of platforms: OS, ARCH, EXTENSION
  local -a platforms=(
    "linux:amd64:"
    "darwin:amd64:"
    "windows:amd64:.exe"
    "current::"
  )

  echo "[DEBUG] buildGoProgram: src_dir=$src_dir, bin_dir=$bin_dir, prog_name=$prog_name" >&2

  # Validate source directory
  if [ ! -d "$src_dir" ]; then
    echo "[DEBUG] buildGoProgram: Source directory $src_dir does not exist" >&2
    return 1
  fi

  # Create bin directory
  mkdir -p "$bin_dir"

  # Preserve current directory
  local current_dir=$(pwd)
  echo "[DEBUG] buildGoProgram: current_dir=$current_dir" >&2

  # Navigate to source directory
  cd "$src_dir" || return 1
  echo "[DEBUG] buildGoProgram: Changed to directory: $(pwd)" >&2

  # Loop through platforms
  for platform in "${platforms[@]}"; do
    # Split platform into OS, ARCH, EXT
    IFS=':' read -r os arch ext <<< "$platform"

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

    echo "[DEBUG] buildGoProgram: Building for $platform_desc..." >&2

    # Build command
    if [ "$os" == "current" ]; then
      go build -o "$output_bin" .
    else
      GOOS=$os GOARCH=$arch go build -o "$output_bin" .
    fi

    # Check if build was successful
    if [ $? -eq 0 ] && [ -f "$output_bin" ]; then
      echo "[INFO] Build successful for $platform_desc: $(realpath "$output_bin")" >&2
      ((build_success++))
    else
      echo "[DEBUG] buildGoProgram: Failed to build for $platform_desc" >&2
    fi
  done

  # Return to original directory
  cd "$current_dir" || return 1
  echo "[DEBUG] buildGoProgram: Returned to directory: $(pwd)" >&2

  # Final status
  if [ $build_success -eq ${#platforms[@]} ]; then
    echo "[INFO] All builds completed successfully for $prog_name" >&2
  else
    echo "[INFO] Completed $build_success/${#platforms[@]} builds for $prog_name" >&2
  fi

  return 0
}