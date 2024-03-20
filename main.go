package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// global variable to store the database connection
var db *gorm.DB

type VinylRecord struct {
	ID          uint   `gorm:"primaryKey"`
	Title       string `json:"title"`
	Artist      string `json:"artist"`
	ReleaseYear int    `json:"release_year"`
	Genre       string `json:"genre"`
}

func setupDatabase() {
	//connection string
	dsn := "user=user password=password dbname=vinyl_records_db host=db port=5433 sslmode=disable TimeZone=UTC"
	//connect
	var err error
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	//migrate the database schema based on the defined model
	db.AutoMigrate(&VinylRecord{})
}

func main() {
	app := fiber.New()
	setupDatabase()

	// define route
	app.Get("/", func(c *fiber.Ctx) error {
		if c.Path() == "/" { // Check if it's the home page
			return c.SendString("Welcome to Vinyl Records App")
		}

		// if it's not the home page, assume it's an API request
		var vinyls []VinylRecord
		db.Find(&vinyls)
		return c.JSON(vinyls)
	})

	log.Fatal(app.Listen(":8000"))
}
