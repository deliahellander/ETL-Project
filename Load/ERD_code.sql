-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/CKQLlV
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Restaurant_Info" (
    "restaurant_id" int   NOT NULL,
    "restaurant_name" varchar   NOT NULL,
    "restaurant_website" varchar   NOT NULL,
    "address1" varchar   NOT NULL,
    "city" varchar   NOT NULL,
    "state" varchar   NOT NULL,
    "zip_code" varchar   NOT NULL,
    CONSTRAINT "pk_Restaurant_Info" PRIMARY KEY (
        "restaurant_id"
     )
);

CREATE TABLE "Yelp_Rating" (
    "restaurant_id" int   NOT NULL,
    "yelp_url" varchar   NOT NULL,
    "yelp_rating" varchar   NOT NULL,
    "yelp_price_level" varchar   NOT NULL,
    CONSTRAINT "pk_Yelp_Rating" PRIMARY KEY (
        "restaurant_id"
     )
);

CREATE TABLE "Cuisine_Type" (
    "restaurant_id" int   NOT NULL,
    "cuisine_type" varchar   NOT NULL
);

CREATE TABLE "Google_Maps_Rating" (
    "restaurant_id" int   NOT NULL,
    "google_maps_url" varchar   NOT NULL,
    "google_maps_rating" varchar   NOT NULL,
    "google_maps_price_level" varchar   NOT NULL,
    CONSTRAINT "pk_Google_Maps_Rating" PRIMARY KEY (
        "restaurant_id"
     )
);

CREATE TABLE "Trip_Advisor_Rating" (
    "restaurant_id" int   NOT NULL,
    "trip_advisor_rating" varchar   NOT NULL,
    "trip_advisor_price_level" varchar   NOT NULL,
    CONSTRAINT "pk_Trip_Advisor_Rating" PRIMARY KEY (
        "restaurant_id"
     )
);

ALTER TABLE "Yelp_Rating" ADD CONSTRAINT "fk_Yelp_Rating_restaurant_id" FOREIGN KEY("restaurant_id")
REFERENCES "Restaurant_Info" ("restaurant_id");

ALTER TABLE "Cuisine_Type" ADD CONSTRAINT "fk_Cuisine_Type_restaurant_id" FOREIGN KEY("restaurant_id")
REFERENCES "Restaurant_Info" ("restaurant_id");

ALTER TABLE "Google_Maps_Rating" ADD CONSTRAINT "fk_Google_Maps_Rating_restaurant_id" FOREIGN KEY("restaurant_id")
REFERENCES "Restaurant_Info" ("restaurant_id");

ALTER TABLE "Trip_Advisor_Rating" ADD CONSTRAINT "fk_Trip_Advisor_Rating_restaurant_id" FOREIGN KEY("restaurant_id")
REFERENCES "Restaurant_Info" ("restaurant_id");

