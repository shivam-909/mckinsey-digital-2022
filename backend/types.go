package hackathon

import (
	"time"

	"github.com/google/uuid"
)

type Sex int

const (
	SexUnknown Sex = 0
	SexMale    Sex = 1
	SexFemale  Sex = 2
)

type AgeRange int

const (
	AgeRangeUnknown AgeRange = 0
	Child           AgeRange = 1
	Teenager        AgeRange = 2
	Adult           AgeRange = 3
)

type DietaryRequirementType int

const (
	DietaryRequirementTypeUnkown                        = 0
	Halal                        DietaryRequirementType = 1
	Kosher                       DietaryRequirementType = 2
	Coeliac                      DietaryRequirementType = 3
	Vegan                        DietaryRequirementType = 4
	Vegetarian                   DietaryRequirementType = 5
	NonBeef                      DietaryRequirementType = 6
)

type Household struct {
	ID       uuid.UUID `json:"id"`
	Postcode string    `json:"postcode"`
}

type Inhabitant struct {
	ID           uuid.UUID  `json:"id"`
	Household    *Household `json:"household"`
	Weight       int32      `json:"weight"`
	Sex          Sex        `json:"sex"`
	AgeRange     AgeRange   `json:"age_range"`
	PasscodeHash string     `json:"passcode_hash"`
}

type FoodItem struct {
	ID              uuid.UUID  `json:"id"`
	Household       *Household `json:"household"`
	ShortName       string     `json:"short_name"`
	FoodDescription string     `json:"food_description"`
	BestBy          time.Time  `json:"best_by"`
	Image           string     `json:"image"`
}

type Appliance struct {
	ID        uuid.UUID  `json:"id"`
	Household *Household `json:"household"`
}

type DietaryRequirement struct {
	ID              uuid.UUID              `json:"id"`
	Household       *Household             `json:"household"`
	RequirementType DietaryRequirementType `json:"requirement_type"`
}

type DonationCenter struct {
	ID            uuid.UUID `json:"id"`
	TradeName     string    `json:"trade_name"`
	StreetAddress string    `json:"street_address"`
}
