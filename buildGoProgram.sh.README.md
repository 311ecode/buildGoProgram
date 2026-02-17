# buildGoProgram.sh - Go Program Build System

A comprehensive Bash script for compiling Go programs across multiple platforms with architecture detection capabilities.

## Parameters

**Required Parameters:**
- `source_directory` - Path to the Go source code directory containing the main package
- `binary_directory` - Path where compiled binaries will be placed

**Optional Parameters:**
- `program_name` - Name of the output binary (defaults to 'filescanGo')

## Supported Platforms

The script builds for the following platforms:
- **Linux** (amd64) - `progname-linux-amd64`
- **Darwin/macOS** (amd64) - Intel Macs
- **Darwin/macOS** (arm64) - Apple Silicon (M1/M2/M3/M4)
- **Windows** (amd64) - `progname-windows-amd64.exe`
- **Current Platform** (native) - Compiled for your local machine

## Error Handling

- Returns exit code 1 if source directory doesn't exist.
- Creates binary directory if it doesn't exist.
- Continues building for other platforms if one fails.
- Returns to original directory after completion.

## License

Proprietary Software - See LICENSE file for terms.
Copyright © 2025 Imre Toth <tothimre@gmail.com>
