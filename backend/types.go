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
	ID       uuid.UUID
	Postcode string
}

type User struct {
	ID           uuid.UUID
	Household    *Household
	Weight       int32
	Sex          Sex
	AgeRange     AgeRange
	PasscodeHash string
}

type FoodItem struct {
	ID              uuid.UUID
	Household       *Household
	ShortName       string
	FoodDescription string
	BestBy          time.Time
}

type Appliance struct {
	ID        uuid.UUID
	Household *Household
}

type DietaryRequirement struct {
	ID              uuid.UUID
	Household       *Household
	RequirementType DietaryRequirementType
}

type DonationCenter struct {
	ID            uuid.UUID
	TradeName     string
	StreetAddress string
}
