package syncexternal

import (
	"log"
)

var (
	FSClient = &fatSecretClient{
		BaseURL: "https://platform.fatsecret.com/rest/server.api?",
	}

	SClient = &spoonClient{
		AccessToken: "2f2aac06d29543b4a89dbc8ef1801d0a",
		BaseURL:     "https://api.spoonacular.com/",
	}
)

type fatSecretClient struct {
	BaseURL      string
	ClientID     string
	ClientSecret string
	AccessToken  string
}

type spoonClient struct {
	BaseURL     string
	AccessToken string
}

func Init() {
	err := FSClient.refreshToken()
	if err != nil {
		log.Fatalf("failed to authenticate fatsecret: %v", err)
	}
}
