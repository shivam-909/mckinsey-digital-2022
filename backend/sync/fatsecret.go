package syncexternal

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
)

type Method int

const (
	MethodUnknown      Method = 0
	MethodSearchFood   Method = 1
	MethodRefreshToken Method = 2
)

var (
	methodStrings = map[Method]string{
		MethodSearchFood: "foods.search",
	}
)

type searchFoodsRes struct {
	Foods foods `json:"foods"`
}

type foods struct {
	Food         []FatSecretFood `json:"food"`
	MaxResults   string          `json:"max_results"`
	PageNumber   string          `json:"page_number"`
	TotalResults string          `json:"total_results"`
}

type FatSecretFood struct {
	FoodDescription string `json:"food_description"`
	FoodID          string `json:"food_id"`
	FoodName        string `json:"food_name"`
	FoodType        string `json:"food_type"`
	FoodURL         string `json:"food_url"`
	BrandName       string `json:"brand_name,omitempty"`
}

func (f *fatSecretClient) SearchFoods(key string, offset, limit int) ([]FatSecretFood, error) {

	req, err := http.NewRequest("GET", f.constructURL(MethodSearchFood, key, offset, limit), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request for fatsecret: %v", err)
	}

	req.Header.Set("Authorization", "Bearer "+f.AccessToken)

	res, err := f.SendRequest(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request to fatsecret: %v", err)
	}

	b, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read fatsecret response: %v", err)
	}

	ar := &searchFoodsRes{}
	err = json.Unmarshal(b, ar)
	if err != nil {
		return nil, fmt.Errorf("failed to unmarshal fatsecret response: %v", err)
	}

	return ar.Foods.Food, nil
}

func (f *fatSecretClient) SendRequest(req *http.Request) (*http.Response, error) {
	hc := &http.Client{}
	res, err := hc.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request to fatsecret: %v", err)
	}

	switch res.StatusCode {
	case http.StatusUnauthorized:
		err := f.refreshToken()
		if err != nil {
			return nil, fmt.Errorf("failed to send request to fatsecret: %v", err)
		}
		return f.SendRequest(req)
	case http.StatusOK, http.StatusAccepted:
		return res, err
	default:
		return nil, fmt.Errorf("failed to send request to fatsecret: %v", res.StatusCode)
	}
}

func (f fatSecretClient) constructURL(m Method, args ...interface{}) string {
	switch m {
	case MethodSearchFood:
		term, _ := args[0].(string)
		offset, _ := args[1].(int)
		limit, _ := args[2].(int)
		return fmt.Sprintf("%vmethod=%v&search_expression=%v&format=json&page_number=%v&max_results=%v", f.BaseURL, methodStrings[MethodSearchFood], term, offset, limit)

	case MethodRefreshToken:
		return "https://oauth.fatsecret.com/connect/token?grant_type=client_credentials&scope=basic"
	default:
		return ""
	}
}

type accessTokenRes struct {
	AccessToken string `json:"access_token"`
	ExpiresIn   int    `json:"expires_in"`
	TokenType   string `json:"token_type"`
	Scope       string `json:"scope"`
}

func (f *fatSecretClient) refreshToken() error {

	payload := strings.NewReader("grant_type=client_credentials&scope=basic")

	req, err := http.NewRequest("POST", f.constructURL(MethodRefreshToken), payload)
	if err != nil {
		return fmt.Errorf("failed to create auth request for fatsecret: %v", err)
	}

	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Set("Authorization", "Basic MWI5NmI1N2I4NmQyNDVjZGJmMzc3YzA2NTg0ZWZiZjI6ZmEzNDhlZDE4YmU5NDM5OTk5Yjc3ZDEwYmU2MGYzY2U=")

	res, err := f.SendRequest(req)
	if err != nil {
		return fmt.Errorf("failed to send auth request to fatsecret: %v, %v", err, req.URL)
	}

	b, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return fmt.Errorf("failed to read fatsecret response: %v", err)
	}

	ar := &accessTokenRes{}
	err = json.Unmarshal(b, ar)
	if err != nil {
		return fmt.Errorf("failed to unmarshal fatsecret response: %v", err)
	}

	f.AccessToken = ar.AccessToken

	return nil
}
