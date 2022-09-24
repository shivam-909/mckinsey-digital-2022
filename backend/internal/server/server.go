package server

import "github.com/gin-gonic/gin"

func Init() {
	r := gin.New()

	api := r.Group("/api")

	api.GET("/", func(c *gin.Context) {
		c.JSON(200, map[string]string{
			"OK": "OK",
		})
	})

	r.Run(":http")
}
