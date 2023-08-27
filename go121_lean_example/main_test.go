package main

import (
	"io"
	"net/http"
	"net/http/httptest"
	"strconv"
	"strings"
	"sync"
	"testing"
)

func TestGETUser(t *testing.T) {
	s := NewServer()
	r := httptest.NewRequest("GET", "/user/user0", nil)
	w := httptest.NewRecorder()
	s.Router.ServeHTTP(w, r)
	if got, want := w.Result().StatusCode, http.StatusBadRequest; got != want {
		t.Errorf("error GET /user/:username: got %v, want %v", got, want)
	}
}

func TestPOSTDeposit(t *testing.T) {
	s := NewServer()

	wg := &sync.WaitGroup{}
	const nRequests = 10000
	for i := 0; i < nRequests; i++ {
		wg.Add(1)
		go func() {
			defer wg.Add(-1)
			r := httptest.NewRequest("POST", "/deposit",
				strings.NewReader(`{"username":"user0","amount":1}`))
			w := httptest.NewRecorder()
			s.Router.ServeHTTP(w, r)
			if got, want := w.Result().StatusCode, http.StatusOK; got != want {
				t.Errorf("error GET /user/:username: got %v, want %v", got, want)
			}
		}()
	}
	wg.Wait()

	r := httptest.NewRequest("GET", "/user/user0", nil)
	w := httptest.NewRecorder()
	s.Router.ServeHTTP(w, r)
	wBody, _ := io.ReadAll(w.Result().Body)
	sumDeposit, _ := strconv.ParseFloat(string(wBody), 64)
	if sumDeposit != float64(nRequests) {
		t.Errorf("error sumDeposit got %v, want %v", sumDeposit, nRequests)
	}
}
