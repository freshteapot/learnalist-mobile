package main

import (
    "io"
    "io/ioutil"
	"log"
	"net/http"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func main() {
	helloHandler := func(w http.ResponseWriter, req *http.Request) {
		io.WriteString(w, "Hello, world!\n")
	}


    fileHandler := func(w http.ResponseWriter, req *http.Request) {
        switch req.Method {
        case http.MethodPut:
            // Create a new record.
            defer req.Body.Close()
            content, err := ioutil.ReadAll(req.Body)

            if err != nil {
                log.Fatal(err)
            }
            err = ioutil.WriteFile("./test.txt", content, 0644)
            check(err)

            io.WriteString(w, "Hello, world!\n")
        default:
            // Give an error message.
            http.Error(w, "Invalid request method.", 405)
        }
    }
    
    http.HandleFunc("/hello", helloHandler)
    http.HandleFunc("/export", fileHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
