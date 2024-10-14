package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"time"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

func main() {

	var upgrader = websocket.Upgrader{
		ReadBufferSize:   1024,
		WriteBufferSize:  1024,
		HandshakeTimeout: 5 * time.Second,
	}

	http.HandleFunc("/websocket", func(w http.ResponseWriter, r *http.Request) {
		conn, _ := upgrader.Upgrade(w, r, nil)

		for {
			msgType, msg, err := conn.ReadMessage()
			if err != nil {
				return
			}
			fmt.Printf("%s receive: %s\n", conn.RemoteAddr(), string(msg))

			if err = conn.WriteMessage(msgType, msg); err != nil {
				return
			}
		}
	})

	http.ListenAndServe(":1234", nil)
}

func test() {

	num := rand.Intn(1000)
	now := time.Now().UnixMilli()
	println(num)
	println(now)

	user := map[string]string{
		"name": "qifen",
		"pass": "777",
	}
	delete(user, "pass")
	user["sex"] = "male"
	for k, v := range user {
		fmt.Println(k, v)
	}

	var per person
	per.name = "qifen"
	per.city = "jiangxi"
	per.age = 99
	fmt.Println(per)

	var sayer Sayer
	cat := cat{}
	dog := dog{}
	sayer = cat
	sayer.say()
	sayer = dog
	sayer.say()
}

func request() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!\n")
	})

	e.Logger.Fatal(e.Start(":7777"))
}

type person struct {
	name string
	city string
	age  int
}

type Sayer interface {
	say()
}

type dog struct{}

type cat struct{}

func (d dog) say() {
	fmt.Println("汪汪汪")
}

func (c cat) say() {
	fmt.Println("喵喵喵")
}
