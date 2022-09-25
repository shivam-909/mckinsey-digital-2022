package server

import (
	"log"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"github.com/shivam-909/mckinsey-digital-2022/internal/db"
	"github.com/shivam-909/mckinsey-digital-2022/service"
	syncexternal "github.com/shivam-909/mckinsey-digital-2022/sync"
)

func Init() {
	r := gin.New()
	api := r.Group("/api")

	api.GET("/health", func(c *gin.Context) {
		c.JSON(200, map[string]string{
			"OK": "OK",
		})
	})

	api.GET("/search", func(c *gin.Context) {
		term := c.Query("term")
		offset := c.Query("offset")
		limit := c.Query("limit")

		if term == "" {
			c.JSON(400, "no term")
			return
		}

		o := 0
		l := 10
		if offset != "" {
			p, err := strconv.Atoi(offset)
			if err != nil {
				c.JSON(400, "invalid offset")
				return
			}
			o = p
		}

		if limit == "" {
			p, err := strconv.Atoi(limit)
			if err != nil {
				c.JSON(400, "invalid limit")
				return
			}
			l = p
		}

		res, err := syncexternal.FSClient.SearchFoods(term, o, l)
		if err != nil {
			c.JSON(500, res)
			return
		}

		c.JSON(200, res)
	})

	api.GET("/recipebyname", func(c *gin.Context) {
		term := c.Query("term")
		res, err := syncexternal.SClient.GetRecipes(syncexternal.SearchByName, term)
		if err != nil {
			c.JSON(500, res)
			return
		}

		c.JSON(200, res)
	})

	api.GET("/recipebyid", func(c *gin.Context) {
		term := c.Query("id")
		res, err := syncexternal.SClient.GetRecipeByID(term)
		if err != nil {
			c.JSON(500, res)
			return
		}

		c.JSON(200, res)
	})

	api.GET("/pantryrecipes", func(c *gin.Context) {
		res, err := db.GetPantryItems(c)
		if err != nil {
			log.Println(err)
			c.JSON(500, err)
			return
		}

		var names []string
		for _, i := range res {
			names = append(names, i.ShortName)
		}

		res2, err := syncexternal.SClient.GetRecipesByIngredient(syncexternal.SearchByIngredients, names)
		if err != nil {
			log.Println(err)
			c.JSON(500, err)
			return
		}

		c.JSON(200, res2)
	})

	api.POST("/pantry", func(c *gin.Context) {
		r := &service.AddToPantryRequest{}

		err := c.Bind(r)
		if err != nil {
			log.Printf("failed to bind: %v", err)
			c.JSON(400, err)
			return
		}

		id, err := uuid.Parse(string(r.HouseholdID))
		if err != nil {
			log.Printf("failed to parse uuid: %v", err)
			c.JSON(400, err)
			return
		}

		t := time.Unix(r.BestBy, 0)

		err = db.InsertIntoPantry(c, id, r.ShortName, r.FoodDescription, t)
		if err != nil {
			log.Println(err)
			c.JSON(500, err)
			return
		}

		c.Status(200)
	})

	api.GET("/pantry", func(c *gin.Context) {

		res, err := db.GetPantryItems(c)
		if err != nil {
			log.Println(err)
			c.JSON(500, err)
			return
		}

		c.JSON(200, res)
	})

	api.POST("/household", func(c *gin.Context) {
		r := &service.NewHouseholdRequest{}

		err := c.Bind(r)
		if err != nil {
			c.JSON(400, err)
			return
		}

		err = db.InsertHousehold(c, r.Postcode)
		if err != nil {
			log.Println(err)
			c.JSON(500, err)
			return
		}

		c.Status(200)
	})

	r.Run(":http")
}
