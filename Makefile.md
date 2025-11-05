# Makefile Mastery — Complete Guide

## 1. Overview

A **Makefile** is a declarative build script interpreted by the `make` utility.  
It defines *targets*, *dependencies*, and *commands* to automate repetitive tasks such as compiling, testing, packaging, or deploying.

It is **language-agnostic** — usable with Go, C++, Python, Docker, etc.

---

## 2. Core Syntax

```makefile
target: dependencies
<TAB>command
````

Example:

```makefile
app: main.o utils.o
 g++ main.o utils.o -o app

main.o: main.cpp
 g++ -c main.cpp

utils.o: utils.cpp
 g++ -c utils.cpp
```

* `target` — the output file to build.
* `dependencies` — input files required to build it.
* `command` — shell command(s) to execute (must be tab-indented).
* Make rebuilds targets only if dependencies are newer (timestamp-based).

---

## 3. Makefile with Go

### Simple Go Project

```makefile
APP=myapp

build:
 go build -o $(APP) main.go

run: build
 ./$(APP)

clean:
 rm -f $(APP)
```

### Multi-Package Project

```makefile
APP=server
PKG=./cmd/server

build:
 go build -o $(APP) $(PKG)

test:
 go test ./...

clean:
 rm -f $(APP)
```

### Go + Docker Integration

```makefile
APP=api
DOCKER_IMAGE=myapp:latest

build:
 go build -o $(APP) ./cmd/api

docker:
 docker build -t $(DOCKER_IMAGE) .

run:
 docker run -p 8080:8080 $(DOCKER_IMAGE)

clean:
 rm -f $(APP)
```

---

## 4. Variables

| Type        | Syntax | Evaluated          |
| ----------- | ------ | ------------------ |
| Recursive   | `=`    | When used          |
| Simple      | `:=`   | Immediately        |
| Append      | `+=`   | Adds more text     |
| Conditional | `?=`   | If not already set |

Example:

```makefile
SRC := $(wildcard *.go)
BIN := bin/myapp

build:
 go build -o $(BIN) $(SRC)
```

---

## 5. Automatic Variables

| Variable | Meaning            |
| -------- | ------------------ |
| `$@`     | Target name        |
| `$<`     | First dependency   |
| `$^`     | All dependencies   |
| `$?`     | Newer dependencies |

Example:

```makefile
%.o: %.go
 go build -o $@ $<
```

---

## 6. Pattern Rules and Phony Targets

### Pattern Rules

```makefile
%.o: %.go
 go build -o $@ $<
```

### Phony Targets

```makefile
.PHONY: build clean

build:
 go build -o app .

clean:
 rm -f app
```

---

## 7. Dependencies and Chaining

```makefile
run: build
 ./app

test: build
 go test ./...

deploy: test
 kubectl apply -f k8s/
```

---

## 8. Advanced Features

### Conditionals

```makefile
ifeq ($(MODE),prod)
    GO_FLAGS=-ldflags "-s -w"
else
    GO_FLAGS=
endif

build:
 go build $(GO_FLAGS) -o app .
```

### Including Other Makefiles

```makefile
include config.mk
include docker.mk
```

### Environment Variables

```makefile
build:
 go build -ldflags "-X main.VERSION=$(VERSION)" -o app .
```

Run with:

```bash
VERSION=1.2.0 make build
```

### Multi-Directory Builds

```makefile
backend:
 $(MAKE) -C backend

frontend:
 $(MAKE) -C frontend
```

---

## 9. Parallel Builds and Optimization

Run parallel jobs:

```bash
make -j4
```

Suppress command echo:

```makefile
build:
 @go build -o app .
```

Force rebuild:

```makefile
.PHONY: run
run:
 go run main.go
```

---

## 10. Debugging and Diagnostics

| Command          | Purpose                                 |
| ---------------- | --------------------------------------- |
| `make -n`        | Dry run (show commands without running) |
| `make -d`        | Full debug trace                        |
| `make -p`        | Print all variables and rules           |
| `make print-VAR` | Print specific variable                 |

To print variables:

```makefile
print-%:
 @echo $* = $($*)
```

---

## 11. CI/CD Integration

### Example GitHub Actions Workflow

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-go@v5
        with:
          go-version: '1.23'
      - run: make build
      - run: make test
```

### Environment Configuration

```makefile
ENV ?= dev

build:
 @if [ "$(ENV)" = "prod" ]; then \
  go build -ldflags "-s -w" -o app .; \
 else \
  go build -o app .; \
 fi
```

---

## 12. Versioning and Metadata

```makefile
VERSION := $(shell git describe --tags --always)
BUILD := $(shell date +%Y-%m-%dT%H:%M:%S)
LDFLAGS := -ldflags "-X main.Version=$(VERSION) -X main.BuildTime=$(BUILD)"

build:
 go build $(LDFLAGS) -o app .
```

---

## 13. Example Production-Grade Makefile

```makefile
APP=backend
REGISTRY=docker.io/username
VERSION=$(shell git describe --tags --always)
LDFLAGS=-ldflags "-s -w -X main.Version=$(VERSION)"
BIN=bin/$(APP)

.PHONY: all build run test clean docker push deploy

all: test build

build:
 go build $(LDFLAGS) -o $(BIN) ./cmd/$(APP)

test:
 go test ./...

run:
 ./$(BIN)

docker:
 docker build -t $(REGISTRY)/$(APP):$(VERSION) .

push: docker
 docker push $(REGISTRY)/$(APP):$(VERSION)

deploy:
 kubectl apply -f deploy/

clean:
 rm -rf $(BIN)
```

---

## 14. Help Target

```makefile
help:
 @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
```

Example:

```makefile
build: ## Build the Go app
 go build -o app .
```

Run:

```bash
make help
```

---

## 15. Summary

**Makefile Advantages:**

* Language-agnostic automation.
* Incremental, dependency-based builds.
* Centralized CI/CD command orchestration.
* Extensible with shell commands, Docker, Git, and Kubernetes.

**Core Commands Recap:**

```md
make           → build default target
make -n        → simulate build
make -j4       → parallel build
make clean     → cleanup build artifacts
make -C dir    → execute in subdirectory
```
