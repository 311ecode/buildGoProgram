# Go Program Build System

A comprehensive build system for compiling Go programs across multiple platforms with architecture detection capabilities.

## Overview

This system provides a set of Bash scripts for building Go programs for multiple target platforms while maintaining proper directory structure and providing detailed debugging information.

## Available Commands

### buildGoProgram

Builds a Go program for multiple target platforms.

**Usage:**
```bash
buildGoProgram <source_directory> <binary_directory> [program_name]

```

**Parameters:**

* `source_directory` (required): Path to the Go source code directory
* `binary_directory` (required): Path where compiled binaries will be placed
* `program_name` (optional): Name of the output binary (defaults to 'filescanGo')

**Supported Platforms:**

* Linux (amd64)
* Darwin/macOS (amd64)
* Darwin/macOS (arm64 - Apple Silicon)
* Windows (amd64 with .exe extension)
* Current platform (native build)


**Examples:**
```bash
# Build with default program name
buildGoProgram ./src ./bin

# Build with custom program name
buildGoProgram ./src ./bin myapp

# With debug output
DEBUG=1 buildGoProgram ./src ./bin
```

### buildGoProgramGetArch

Detects and returns the current system architecture.

**Usage:**
```bash
buildGoProgramGetArch
```

**No parameters required**

**Supported Architectures:**
- amd64 (x86_64)
- arm64 (aarch64)

**Output:**
Returns the detected architecture as a string (amd64, arm64, or unknown)

**Example:**
```bash
arch=$(buildGoProgramGetArch)
echo "Building for architecture: $arch"
```

### buildGoProgramGetOS

Detects and returns the current operating system.

**Usage:**
```bash
buildGoProgramGetOS
```

**No parameters required**

**Supported Operating Systems:**
- linux
- darwin (macOS)
- windows

**Output:**
Returns the detected OS as a string (linux, darwin, windows, or unknown)

**Example:**
```bash
os=$(buildGoProgramGetOS)
echo "Building for OS: $os"
```

## Debug Mode

All commands support debug mode through the `DEBUG` environment variable:

```bash
DEBUG=1 buildGoProgram ./src ./bin
DEBUG=true buildGoProgramGetArch
DEBUG=1 buildGoProgramGetOS
```

When debug mode is enabled, detailed information about the build process and system detection will be displayed.

## File Structure

The build system consists of the following components:

- `buildGoProgram.sh` - Main build script for cross-platform compilation
- `buildGoProgramGetArch.sh` - Architecture detection utility
- `buildGoProgramGetOS.sh` - Operating system detection utility

## Error Handling

- All commands return appropriate exit codes (0 for success, non-zero for failure)
- Missing directories are handled gracefully with informative error messages
- Failed builds are reported but don't stop the entire build process
- Unknown architectures/OS are reported as "unknown" with exit code 1

## Integration

The system integrates with the project's function database through `registerToFunctionsDB` and supports help text injection through `markdown-show-help-registration`.

For detailed help on any command, use the `-h` or `--help` flag (when available through the upper management layer).

## License

Proprietary Software - See LICENSE file for terms.
Copyright © 2025 Imre Toth <tothimre@gmail.com>
