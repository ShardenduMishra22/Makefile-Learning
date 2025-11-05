# Go 

BINARY_NAME=makefile-app
BUILD_DIR=build
GO_FILES=$(shell find . -name '*.go' -not -path "./vendor/*")
MAIN_FILE=main.go

# Build flags
LDFLAGS=-ldflags "-s -w"

.PHONY: all build clean test coverage run fmt vet lint help

all: clean fmt vet test build	## Run all tasks (clean, format, vet, test, build)

build:	## Build the application
	@echo "Building $(BINARY_NAME)..."
	@mkdir -p $(BUILD_DIR)
	go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_FILE)
	@echo "Build complete: $(BUILD_DIR)/$(BINARY_NAME)"

run:	## Run the application
	@echo "Running $(BINARY_NAME)..."
	go run $(MAIN_FILE)

clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR) coverage.out coverage.html
	@go clean -cache -testcache
	@echo "Clean complete"


test:	## Run tests
	@echo "Running tests..."
	go test -v -race ./...

coverage:	## Run tests with coverage
	@echo "Running tests with coverage..."
	go test -v -race -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

fmt:	## Format Go code
	@echo "Formatting code..."
	go fmt ./...
	@echo "Format complete"

vet:	## Run go vet
	@echo "Vetting code..."
	go vet ./...
	@echo "Vet complete"

lint:	## Run golangci-lint (requires golangci-lint installed)
	@echo "Linting code..."
	@if command -v golangci-lint >/dev/null 2>&1; then \
		golangci-lint run ./...; \
	else \
		echo "golangci-lint not installed. Install with: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest"; \
	fi

deps:	## Download dependencies
	@echo "Downloading dependencies..."
	go mod download
	go mod tidy
	@echo "Dependencies downloaded"

install:	## Install the binary
	@echo "Installing $(BINARY_NAME)..."
	go install $(LDFLAGS) $(MAIN_FILE)
	@echo "Install complete"

help:	## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
