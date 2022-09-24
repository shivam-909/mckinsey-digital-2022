package service

type Service interface {
	Register()
	Login()
	UpdateHousehold()
	AddInhabitant()
	UpdatePantry()
	GetFoodItems()
	GetRecipes()
	GetVolunteeringLocations()
}
