#!/usr/bin/env bash
buildGoProgram_platforms() {
  local bin_dir="$1"
  local prog_name="$2"
  local original_dir="$3"
  shift 3
  local -a platforms=("$@")
  local build_success=0

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
      echo "[DEBUG] buildGoProgram_platforms: Building for $platform_desc..." >&2
      echo "[DEBUG] buildGoProgram_platforms: Selected binary name: $output_bin" >&2
    fi

    # Build command
    if [ "$os" == "current" ]; then
      if is_debug_mode_buildGoProgram; then
        echo "[DEBUG] buildGoProgram_platforms: Executing: go build -o \"$output_bin\" ." >&2
      fi
      go build -o "$output_bin" .
    else
      if is_debug_mode_buildGoProgram; then
        echo "[DEBUG] buildGoProgram_platforms: Executing: GOOS=$os GOARCH=$arch go build -o \"$output_bin\" ." >&2
      fi
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
        echo "[DEBUG] buildGoProgram_platforms: Failed to build for $platform_desc" >&2
      fi
    fi
  done

  return $build_success
}