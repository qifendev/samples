package main

import (
	"fmt"
	"log"

	"github.com/gorilla/websocket"
)

func main() {

	url := "ws://localhost:1234/websocket"
	c, res, err := websocket.DefaultDialer.Dial(url, nil)
	if err != nil {
		log.Fatal("连接失败:", err)
	}
	log.Printf("响应:%s", fmt.Sprint(res))
	defer c.Close()
	done := make(chan struct{})
	err = c.WriteMessage(websocket.TextMessage, []byte("你好,我是FunTester"))
	if err != nil {
		fmt.Println(err)
	}
	for {
		_, message, err := c.ReadMessage()
		if err != nil {
			log.Fatal(err)
			break
		}
		log.Printf("收到消息: %s", message)

	}
	<-done
}
