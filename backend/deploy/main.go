package main

import (
	"context"

	"github.com/shivam-909/mckinsey-digital-2022/internal/db"
	"github.com/shivam-909/mckinsey-digital-2022/internal/server"
)

func main() {
	ctx := context.Background()
	db.Init(ctx)
	server.Init()
}
