package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strconv"
	"sync"

	"github.com/julienschmidt/httprouter"
)

func init() { log.SetFlags(log.Lshortfile | log.Lmicroseconds) }

type Server struct {
	Router   *httprouter.Router
	database map[string]float64 // map username to their money
	mu       *sync.Mutex        // protect the database
}

func NewServer() *Server {
	s := &Server{
		Router:   httprouter.New(),
		database: make(map[string]float64),
		mu:       &sync.Mutex{},
	}
	s.Router.HandlerFunc(http.MethodGet, "/user/:username",
		func(w http.ResponseWriter, r *http.Request) {
			username := GetURLParam(r, "username")
			if username == "" {
				w.WriteHeader(http.StatusBadRequest)
				LogError(w.Write([]byte("empty username")))
				return
			}
			s.mu.Lock()
			money, found := s.database[username]
			s.mu.Unlock()
			if !found {
				w.WriteHeader(http.StatusBadRequest)
				LogError(w.Write([]byte("username not found")))
				return
			}
			LogError(w.Write([]byte(strconv.FormatFloat(money, 'f', 3, 64))))
		})
	s.Router.HandlerFunc(http.MethodPost, "/deposit",
		func(w http.ResponseWriter, r *http.Request) {
			type DepositReq struct {
				Username string
				Amount   float64
			}
			body, err := io.ReadAll(r.Body)
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				LogError(w.Write([]byte(err.Error())))
				return
			}
			var rObj DepositReq
			err = json.Unmarshal(body, &rObj)
			//log.Printf("debug request %+v", rObj)
			if err != nil {
				w.WriteHeader(http.StatusBadRequest)
				LogError(w.Write([]byte(err.Error())))
				return
			}
			var updated float64
			s.mu.Lock()
			s.database[rObj.Username] += rObj.Amount
			updated = s.database[rObj.Username]
			s.mu.Unlock()
			LogError(w.Write([]byte(strconv.FormatFloat(updated, 'f', 3, 64))))
		})
	return s
}

// GetURLParam returns the value of the first param of the input key,
// if no matching param is found: an empty string is returned
func GetURLParam(r *http.Request, key string) string {
	for _, v := range httprouter.ParamsFromContext(r.Context()) {
		if v.Key == key {
			return v.Value
		}
	}
	return ""
}

// LogError conveniently logs ResponseWriter.Write error
func LogError(n int, err error) {
	if err != nil {
		log.Println(err)
	}
}

func main() {
	s := NewServer()
	listeningPort := ":8888"
	log.Printf("listen HTTP on port %v\n", listeningPort)
	err := http.ListenAndServe(listeningPort, s.Router)
	if err != nil {
		log.Printf("error ListenAndServe: %v", err)
	}
	//curl -i -X POST 'http://127.0.0.1:8888/deposit' --data '{"username":"user0", "amount":1000}'
	//curl -i 'http://127.0.0.1:8888/user/user0'
}
