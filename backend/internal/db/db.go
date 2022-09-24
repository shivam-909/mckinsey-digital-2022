package db

import (
	"context"
	"flag"
	"log"

	"github.com/jackc/pgx/v4"
)

type DB struct {
	conn *pgx.Conn
}

var (
	db_connection_string = flag.String("db_string", "localhost:5432", "db string to connect to pg db")

	db *DB
)

func Init(ctx context.Context) {
	flag.Parse()

	config, err := pgx.ParseConfig(*db_connection_string)
	if err != nil {
		log.Fatalf("failed to parse config string")
	}

	conn, err := pgx.ConnectConfig(ctx, config)
	if err != nil {
		log.Fatalf("failed to connect to db")

	}

	db = &DB{conn: conn}
}
