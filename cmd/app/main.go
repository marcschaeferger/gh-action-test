package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/google/uuid"
)

var version = "dev"

func handler(w http.ResponseWriter, r *http.Request) {
	id := uuid.New()
	fmt.Fprintf(w, "hello from go-only app %s (id=%s)\n", version, id.String())
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", handler)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	if err := http.ListenAndServe(":"+port, mux); err != nil {
		panic(err)
	}
}
