#!/bin/bash

# Function to build Go program for multiple platforms
buildGoProgram() {
  local src_dir="$1"
  local bin_dir="$2"
  local prog_name="${3:-$(basename "$src_dir")}"
  
  echo "[DEBUG] buildGoProgram: src_dir=$src_dir, bin_dir=$bin_dir, prog_name=$prog_name" >&2
  
  if [ ! -d "$src_dir" ]; then
    echo "[DEBUG] buildGoProgram: Source directory $src_dir does not exist" >&2
    return 1
  fi
  
  # Create bin directory if it doesn't exist
  mkdir -p "$bin_dir"
  
  # Preserve the current directory
  local current_dir
  current_dir=$(pwd)
  echo "[DEBUG] buildGoProgram: current_dir=$current_dir" >&2
  
  # Navigate to source directory
  cd "$src_dir" || return 1
  echo "[DEBUG] buildGoProgram: Changed to directory: $(pwd)" >&2
  
  echo "[DEBUG] buildGoProgram: Building for Linux (amd64)..." >&2
  GOOS=linux GOARCH=amd64 go build -o "$bin_dir/$prog_name-linux-amd64" . || {
    echo "[DEBUG] buildGoProgram: Failed to build for Linux amd64" >&2
  }
  
  echo "[DEBUG] buildGoProgram: Building for macOS (amd64)..." >&2
  GOOS=darwin GOARCH=amd64 go build -o "$bin_dir/$prog_name-darwin-amd64" . || {
    echo "[DEBUG] buildGoProgram: Failed to build for macOS amd64" >&2
  }
  
  echo "[DEBUG] buildGoProgram: Building for Windows (amd64)..." >&2
  GOOS=windows GOARCH=amd64 go build -o "$bin_dir/$prog_name-windows-amd64.exe" . || {
    echo "[DEBUG] buildGoProgram: Failed to build for Windows amd64" >&2
  }
  
  echo "[DEBUG] buildGoProgram: Building for current platform as default..." >&2
  go build -o "$bin_dir/$prog_name" . || {
    echo "[DEBUG] buildGoProgram: Failed to build for current platform" >&2
  }
  
  # Return to original directory
  cd "$current_dir" || return 1
  echo "[DEBUG] buildGoProgram: Returned to directory: $(pwd)" >&2
  
  echo "[DEBUG] buildGoProgram: Build process completed for $prog_name" >&2
  return 0
}