package db

import (
	"context"

	"github.com/google/uuid"
	hackathon "github.com/shivam-909/mckinsey-digital-2022"
)

const (
	insertHousehold = `
		INSERT INTO household (postcode) VALUES ($1);
	`

	retrieve = `
	SELECT * FROM household WHERE id = $1 LIMIT 1;
`
)

func InsertHousehold(ctx context.Context, postcode string) error {
	_, err := Datastore.conn.Exec(ctx, insertHousehold, postcode)
	return err
}

func LookupHousehold(ctx context.Context, id uuid.UUID) (*hackathon.Household, error) {
	h := &hackathon.Household{}
	err := Datastore.conn.QueryRow(ctx, retrieve, id).Scan(&h.ID, &h.Postcode)
	return h, err
}
