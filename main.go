package main

import (
	"fmt"
	"log"
	"net/http"
)

const (
	defaultPort = "8080"
	version     = "1.0.0"
)

func main() {
	port := "3000"
	if port == "" {
		port = defaultPort
	}

	http.HandleFunc("/", handleRoot)
	http.HandleFunc("/health", handleHealth)
	http.HandleFunc("/version", handleVersion)

	log.Printf("Starting server on port %s...", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello! Welcome to the Go Makefile Project!\n")
}

func handleHealth(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "OK\n")
}

func handleVersion(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Version: %s\n", version)
}
