package db

import (
	"context"
	"log"
	"time"

	"github.com/google/uuid"
	hackathon "github.com/shivam-909/mckinsey-digital-2022"
)

const (
	insertInPantry = `INSERT INTO food_item ( household_id,
		short_name,
		food_description,
		best_by
	) VALUES ($1,$2,$3,$4);`

	retrieveAllInPantry = `SELECT * FROM food_item;`
)

func InsertIntoPantry(ctx context.Context, householdID uuid.UUID, name string, description string, bestby time.Time) error {
	_, err := Datastore.conn.Exec(ctx, insertInPantry, householdID, name, description, bestby)
	return err
}

func GetPantryItems(ctx context.Context) ([]*hackathon.FoodItem, error) {
	rows, err := Datastore.conn.Query(ctx, retrieveAllInPantry)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var items []*hackathon.FoodItem
	h2id := map[uuid.UUID]uuid.UUID{}
	for rows.Next() {
		i := &hackathon.FoodItem{}
		var hid uuid.UUID
		err := rows.Scan(&i.ID, &hid, &i.ShortName, &i.FoodDescription, &i.BestBy)
		if err != nil {
			return nil, err
		}

		h2id[i.ID] = hid

		items = append(items, i)
	}

	for _, i := range items {
		h, err := LookupHousehold(ctx, h2id[i.ID])
		if err != nil {
			return nil, err
		}

		i.Household = h
	}

	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	return items, nil
}
