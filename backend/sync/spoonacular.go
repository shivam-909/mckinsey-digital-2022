package syncexternal

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strings"
)

type SearchType int

const (
	SearchByName        = 1
	SearchByIngredients = 2
	SearchByID          = 3
)

type getResponse struct {
	Results []struct {
		ID        int    `json:"id"`
		Title     string `json:"title"`
		Image     string `json:"image"`
		ImageType string `json:"imageType"`
	} `json:"results"`
	Offset       int `json:"offset"`
	Number       int `json:"number"`
	TotalResults int `json:"totalResults"`
}

func (s *spoonClient) GetRecipes(method SearchType, args interface{}) (*getResponse, error) {
	req, err := http.NewRequest("GET", s.constructURL(method, args), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create spoon request: %v", err)
	}

	res, err := s.SendRequest(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request to spoon: %v", err)
	}

	b, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response from spoon: %v", err)
	}

	log.Println(string(b))

	m := &getResponse{}
	err = json.Unmarshal(b, m)

	return m, err
}

type getByIngredientRes []struct {
	ID                    int    `json:"id"`
	Title                 string `json:"title"`
	Image                 string `json:"image"`
	ImageType             string `json:"imageType"`
	UsedIngredientCount   int    `json:"usedIngredientCount"`
	MissedIngredientCount int    `json:"missedIngredientCount"`
	MissedIngredients     []struct {
		ID           int      `json:"id"`
		Amount       float64  `json:"amount"`
		Unit         string   `json:"unit"`
		UnitLong     string   `json:"unitLong"`
		UnitShort    string   `json:"unitShort"`
		Aisle        string   `json:"aisle"`
		Name         string   `json:"name"`
		Original     string   `json:"original"`
		OriginalName string   `json:"originalName"`
		Meta         []string `json:"meta"`
		Image        string   `json:"image"`
	} `json:"missedIngredients"`
	UsedIngredients []struct {
		ID           int      `json:"id"`
		Amount       float64  `json:"amount"`
		Unit         string   `json:"unit"`
		UnitLong     string   `json:"unitLong"`
		UnitShort    string   `json:"unitShort"`
		Aisle        string   `json:"aisle"`
		Name         string   `json:"name"`
		Original     string   `json:"original"`
		OriginalName string   `json:"originalName"`
		Meta         []string `json:"meta"`
		Image        string   `json:"image"`
		ExtendedName string   `json:"extendedName,omitempty"`
	} `json:"usedIngredients"`
	UnusedIngredients []struct {
		ID           int           `json:"id"`
		Amount       float64       `json:"amount"`
		Unit         string        `json:"unit"`
		UnitLong     string        `json:"unitLong"`
		UnitShort    string        `json:"unitShort"`
		Aisle        string        `json:"aisle"`
		Name         string        `json:"name"`
		Original     string        `json:"original"`
		OriginalName string        `json:"originalName"`
		Meta         []interface{} `json:"meta"`
		Image        string        `json:"image"`
	} `json:"unusedIngredients"`
	Likes int `json:"likes"`
}

func (s *spoonClient) GetRecipesByIngredient(method SearchType, args interface{}) (getByIngredientRes, error) {
	req, err := http.NewRequest("GET", s.constructURL(method, args), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create spoon request: %v", err)
	}

	res, err := s.SendRequest(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request to spoon: %v", err)
	}

	b, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response from spoon: %v", err)
	}

	log.Println(string(b))

	m := make(getByIngredientRes, 0)
	err = json.Unmarshal(b, &m)

	return m, err
}

type recipeRes struct {
	Vegetarian               bool    `json:"vegetarian"`
	Vegan                    bool    `json:"vegan"`
	GlutenFree               bool    `json:"glutenFree"`
	DairyFree                bool    `json:"dairyFree"`
	VeryHealthy              bool    `json:"veryHealthy"`
	Cheap                    bool    `json:"cheap"`
	VeryPopular              bool    `json:"veryPopular"`
	Sustainable              bool    `json:"sustainable"`
	LowFodmap                bool    `json:"lowFodmap"`
	WeightWatcherSmartPoints int     `json:"weightWatcherSmartPoints"`
	Gaps                     string  `json:"gaps"`
	PreparationMinutes       int     `json:"preparationMinutes"`
	CookingMinutes           int     `json:"cookingMinutes"`
	AggregateLikes           int     `json:"aggregateLikes"`
	HealthScore              int     `json:"healthScore"`
	CreditsText              string  `json:"creditsText"`
	License                  string  `json:"license"`
	SourceName               string  `json:"sourceName"`
	PricePerServing          float64 `json:"pricePerServing"`
	ExtendedIngredients      []struct {
		ID           int      `json:"id"`
		Aisle        string   `json:"aisle"`
		Image        string   `json:"image"`
		Consistency  string   `json:"consistency"`
		Name         string   `json:"name"`
		NameClean    string   `json:"nameClean"`
		Original     string   `json:"original"`
		OriginalName string   `json:"originalName"`
		Amount       float64  `json:"amount"`
		Unit         string   `json:"unit"`
		Meta         []string `json:"meta"`
		Measures     struct {
			Us struct {
				Amount    float64 `json:"amount"`
				UnitShort string  `json:"unitShort"`
				UnitLong  string  `json:"unitLong"`
			} `json:"us"`
			Metric struct {
				Amount    float64 `json:"amount"`
				UnitShort string  `json:"unitShort"`
				UnitLong  string  `json:"unitLong"`
			} `json:"metric"`
		} `json:"measures"`
	} `json:"extendedIngredients"`
	ID             int           `json:"id"`
	Title          string        `json:"title"`
	ReadyInMinutes int           `json:"readyInMinutes"`
	Servings       int           `json:"servings"`
	SourceURL      string        `json:"sourceUrl"`
	Image          string        `json:"image"`
	ImageType      string        `json:"imageType"`
	Summary        string        `json:"summary"`
	Cuisines       []interface{} `json:"cuisines"`
	DishTypes      []string      `json:"dishTypes"`
	Diets          []interface{} `json:"diets"`
	Occasions      []string      `json:"occasions"`
	WinePairing    struct {
		PairedWines    []interface{} `json:"pairedWines"`
		PairingText    string        `json:"pairingText"`
		ProductMatches []interface{} `json:"productMatches"`
	} `json:"winePairing"`
	Instructions         string `json:"instructions"`
	AnalyzedInstructions []struct {
		Name  string `json:"name"`
		Steps []struct {
			Number      int    `json:"number"`
			Step        string `json:"step"`
			Ingredients []struct {
				ID            int    `json:"id"`
				Name          string `json:"name"`
				LocalizedName string `json:"localizedName"`
				Image         string `json:"image"`
			} `json:"ingredients"`
			Equipment []struct {
				ID            int    `json:"id"`
				Name          string `json:"name"`
				LocalizedName string `json:"localizedName"`
				Image         string `json:"image"`
			} `json:"equipment"`
			Length struct {
				Number int    `json:"number"`
				Unit   string `json:"unit"`
			} `json:"length"`
		} `json:"steps"`
	} `json:"analyzedInstructions"`
	OriginalID           interface{} `json:"originalId"`
	SpoonacularSourceURL string      `json:"spoonacularSourceUrl"`
}

func (s *spoonClient) GetRecipeByID(id string) (*recipeRes, error) {
	req, err := http.NewRequest("GET", s.constructURL(SearchByID, id), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create spoon request: %v", err)
	}

	res, err := s.SendRequest(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request to spoon: %v", err)
	}

	b, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response from spoon: %v", err)
	}

	m := &recipeRes{}
	err = json.Unmarshal(b, m)

	return m, err

}

func (s *spoonClient) SendRequest(req *http.Request) (*http.Response, error) {
	hc := &http.Client{}
	res, err := hc.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to do request to spoon: %v", err)
	}

	switch res.StatusCode {

	case http.StatusOK, http.StatusAccepted:
		return res, err
	default:
		return nil, fmt.Errorf("failed to send request to fatsecret: %v", res.StatusCode)
	}
}

func (s spoonClient) constructURL(method SearchType, query interface{}) string {
	switch method {
	case SearchByName:
		v, _ := query.(string)
		return fmt.Sprintf("https://api.spoonacular.com/recipes/complexSearch?apiKey=%v&query=%v", s.AccessToken, v)

	case SearchByIngredients:
		v, _ := query.([]string)
		str := strings.Join(v, ",")
		return fmt.Sprintf("https://api.spoonacular.com/recipes/findByIngredients?apiKey=%v&ingredients=%v", s.AccessToken, str)

	case SearchByID:
		v, _ := query.(string)
		return fmt.Sprintf("https://api.spoonacular.com/recipes/%v/information?apiKey=%v&query=pasta", v, s.AccessToken)

	default:
		return ""
	}
}
