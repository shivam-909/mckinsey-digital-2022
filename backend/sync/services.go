package syncexternal

import (
	"flag"
	"log"
)

var (
	fs_client = flag.String("fs_client", "", "")
	fs_secret = flag.String("fs_secret", "", "")

	FSClient = &fatSecretClient{
		BaseURL: "platform.fatsecret.com/rest/server.api?",
	}
)

type fatSecretClient struct {
	BaseURL      string
	ClientID     string
	ClientSecret string
	AccessToken  string
}

func Init() {
	flag.Parse()
	FSClient.ClientID = *fs_client
	FSClient.ClientSecret = *fs_secret

	err := FSClient.refreshToken()
	if err != nil {
		log.Fatalf("failed to authenticate fatsecret: %v", err)
	}
}
