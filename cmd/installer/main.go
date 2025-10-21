package main

import (
	"encoding/json"
	"fmt"
)

var version = "dev" // wird via -ldflags überschrieben

type Out struct {
	Version string `json:"version"`
}

func main() {
	b, _ := json.MarshalIndent(Out{Version: version}, "", "  ")
	fmt.Println(string(b))
}
