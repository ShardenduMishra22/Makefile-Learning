# Makefile Learning Project

A comprehensive Go project demonstrating Makefile best practices, including building, testing, coverage reporting, and deployment automation.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Available Commands](#available-commands)
- [Project Structure](#project-structure)
- [Documentation](#documentation)
- [Development](#development)
- [Testing](#testing)
- [License](#license)

## Overview

This project is a learning resource for understanding and implementing Makefiles in Go projects. It includes:

- A simple HTTP server with health and version endpoints
- Comprehensive Makefile with common development tasks
- Test coverage reporting
- Code formatting and linting automation
- Build optimization with LDFLAGS

## Features

- **HTTP Server**: Simple web server with multiple endpoints
  - `/` - Welcome page
  - `/health` - Health check endpoint
  - `/version` - Version information
- **Automated Build Pipeline**: Complete build automation using Make
- **Testing & Coverage**: Automated test execution with coverage reports
- **Code Quality**: Integrated formatting, vetting, and linting
- **Optimized Builds**: Binary size optimization using build flags

## Prerequisites

- **Go**: Version 1.25.3 or later
- **Make**: GNU Make utility
- **Optional**: golangci-lint for linting

Install golangci-lint (optional):
```bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ShardenduMishra22/Makefile-Learning.git
   cd Makefile-Learning
   ```

2. **Install dependencies**:
   ```bash
   make deps
   ```

3. **Build the application**:
   ```bash
   make build
   ```

4. **Run the application**:
   ```bash
   make run
   ```

5. **Access the server**:
   - Open your browser and navigate to `http://localhost:3000`
   - Health check: `http://localhost:3000/health`
   - Version: `http://localhost:3000/version`

## Available Commands

Run `make help` to see all available commands:

| Command | Description |
|---------|-------------|
| `make all` | Run all tasks (clean, format, vet, test, build) |
| `make build` | Build the application binary |
| `make run` | Run the application without building |
| `make clean` | Remove build artifacts and cache |
| `make test` | Run all tests with race detection |
| `make coverage` | Generate test coverage report (HTML) |
| `make fmt` | Format Go code |
| `make vet` | Run go vet for code analysis |
| `make lint` | Run golangci-lint |
| `make deps` | Download and tidy dependencies |
| `make install` | Install the binary to $GOPATH/bin |
| `make help` | Show help message |

## Project Structure

```
.
├── main.go              # Main application source
├── main_test.go         # Test files
├── Makefile             # Build automation
├── go.mod               # Go module definition
├── Makefile.md          # Makefile documentation
├── Worker_Pool.md       # Worker pool examples
├── coverage.html        # Test coverage report
└── build/
    └── makefile-app     # Compiled binary
```

## Documentation

- **[Makefile.md](Makefile.md)**: Complete guide to Makefile syntax and best practices
- **[Worker_Pool.md](Worker_Pool.md)**: Examples of implementing worker pools in Go

## Development

### ilding

Build the optimized binary:
```bash
make build
```

The binary will be created at `build/makefile-app` with the following optimizations:
- `-s`: Strip symbol table
- `-w`: Strip DWARF debugging information

### nning Tests

Run all tests:
```bash
make test
```

Generate coverage report:
```bash
make coverage
```

This will create `coverage.html` which you can open in your browser.

### de Quality

Format code:
```bash
make fmt
```

Run static analysis:
```bash
make vet
```

Run linter (requires golangci-lint):
```bash
make lint
```

### mplete Workflow

Run all quality checks and build:
```bash
make all
```

This executes: clean → format → vet → test → build

## Testing

The project includes comprehensive tests with:
- Race condition detection
- Coverage reporting
- HTML coverage visualization

Example test output:
```bash
$ make test
Running tests...
go test -v -race ./...
```

## Configuration

### stomizing Build

Edit the `Makefile` to customize:

```makefile
BINARY_NAME=makefile-app    # Change binary name
BUILD_DIR=build             # Change build directory
LDFLAGS=-ldflags "-s -w"    # Modify build flags
```

### anging Server Port

Edit `main.go`:
```go
port := "3000"  // Change to desired port
```

## Troubleshooting

**Issue**: `make: command not found`
- **Solution**: Install GNU Make for your OS

**Issue**: Go version mismatch
- **Solution**: Update Go to version 1.25.3 or later

**Issue**: Permission denied on binary
- **Solution**: Run `chmod +x build/makefile-app`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Contact

**Shardendu Mishra** - [@ShardenduMishra22](https://github.com/ShardenduMishra22)

Project Link: [https://github.com/ShardenduMishra22/Makefile-Learning](https://github.com/ShardenduMishra22/Makefile-Learning)

## Learning Resources

- [GNU Make Manual](https://www.gnu.org/software/make/manual/)
- [Go by Example](https://gobyexample.com/)
- [Effective Go](https://golang.org/doc/effective_go.html)