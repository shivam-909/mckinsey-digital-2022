package service

import (
	hackathon "github.com/shivam-909/mckinsey-digital-2022"
)

type RegisterRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
	Postcode string `json:"postcode"`
}

type LoginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type NewHouseholdRequest struct {
	Postcode string `json:"postcode"`
}

type AddInhabitantRequest struct {
	Weight       int32              `json:"weight"`
	Sex          hackathon.Sex      `json:"sex"`
	AgeRange     hackathon.AgeRange `json:"age_range"`
	PasscodeHash string             `json:"passcode_hash"`
}

type UpdatePantryRequest struct {
	PantryItems []hackathon.FoodItem `json:"pantry_items"`
}

type AddToPantryRequest struct {
	HouseholdID     string `json:"household_id"`
	ShortName       string `json:"short_name"`
	FoodDescription string `json:"food_description"`
	BestBy          int64  `json:"best_by"`
	Image           string `json:"image"`
}

type GetFoodItemsRequest struct {
	SearchTerm string `json:"search_term"`
}

type GetFoodItemsResponse struct {
	FoodItems []hackathon.FoodItem `json:"food_items"`
}

type GetRecipesRequest struct{}

type GetRecipesReponse struct {
	Recipes map[string]string `json:"recipes"`
}

type GetVolunteeringLocationsRequest struct{}

type GetVolunteeringLocationsResponse struct {
	Locations []hackathon.DonationCenter `json:"locations"`
}
