# buildGoProgram.sh - Go Program Build System

A comprehensive Bash script for compiling Go programs across multiple platforms with architecture detection capabilities.

## Parameters

**Required Parameters:**
- `source_directory` - Path to the Go source code directory containing the main package
- `binary_directory` - Path where compiled binaries will be placed

**Optional Parameters:**
- `program_name` - Name of the output binary (defaults to 'filescanGo')

## Usage Examples

```bash
# Build with default program name
buildGoProgram ./src ./bin

# Build with custom program name
buildGoProgram ./src ./bin myapp

# Enable debug output
DEBUG=1 buildGoProgram ./src ./bin

# Build with verbose debugging
DEBUG=true buildGoProgram /path/to/source /path/to/output custom-program
```

## Supported Platforms

The script builds for the following platforms:
- **Linux** (amd64) - `progname-linux-amd64`
- **Darwin/macOS** (amd64) - `progname-darwin-amd64` 
- **Windows** (amd64) - `progname-windows-amd64.exe`
- **Current Platform** (native) - `progname`

## Debug Mode

Enable detailed debugging information by setting the `DEBUG` environment variable:

```bash
DEBUG=1 buildGoProgram ./src ./bin
DEBUG=true buildGoProgram ./src ./bin myprogram
```

Debug mode provides:
- Parameter validation and values
- Directory navigation tracking
- Build command execution details
- Success/failure status for each platform
- File path verification

## Error Handling

- Returns exit code 1 if source directory doesn't exist
- Creates binary directory if it doesn't exist
- Continues building for other platforms if one fails
- Returns to original directory after completion
- Reports success count: `Completed X/Y builds for program_name`

## Integration Features

- Registers with function database via `registerToFunctionsDB`
- Supports help text injection via `markdown-show-help-registration`
- Minimum 3 parameters enforced by upper management layer
- Alias support: `grp=gitRelativePath`

## Dependencies

- Go toolchain must be installed and accessible
- Source directory must contain valid Go main package
- Sufficient disk space for multiple binary outputs

## Related Utilities

- `buildGoProgramGetArch.sh` - Architecture detection (amd64, arm64)
- `buildGoProgramGetOS.sh` - Operating system detection (linux, darwin, windows)

## License

Proprietary Software - See LICENSE file for terms.
Copyright © 2025 Imre Toth <tothimre@gmail.com>
