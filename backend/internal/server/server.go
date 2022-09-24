package server

import (
	"strconv"

	"github.com/gin-gonic/gin"
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

	r.Run(":http")
}
