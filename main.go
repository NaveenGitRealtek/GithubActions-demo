package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World!!!!")
    fmt.Fprintf(w,  " Hey Docker-Hub Iam Here.0")
    fmt.Fprintf(w,  "Hello Bye....")
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
