 
 -- Showing some steps in the Load Process
        -- test
        SELECT * FROM "Cuisine_Type";

        --alter tables to drop not null contraint 
        ALTER TABLE "Yelp_Rating" ALTER COLUMN yelp_price_level DROP NOT NULL;

        --drop PK for cuisine table
        ALTER TABLE "Cuisine_Type" DROP CONSTRAINT "pk_Cuisine_Type";

        --alter tables to drop not null contraint 
        ALTER TABLE "Google_Maps_Rating" ALTER COLUMN google_maps_rating TYPE varchar;
        SELECT * FROM "Google_Maps_Rating";
        ALTER TABLE "Yelp_Rating" ALTER COLUMN yelp_rating DROP NOT NULL;
-- Query Example
-- Displaying restaurants reviews from places that has reviews on all three websites(Yelp, Google Maps, TripAdvisor)
SELECT "Restaurant_Info".restaurant_id, "Restaurant_Info".restaurant_name,"Restaurant_Info".restaurant_website,
       "Yelp_Rating".yelp_rating, "Google_Maps_Rating".google_maps_rating
FROM "Restaurant_Info"
INNER JOIN "Yelp_Rating" ON "Restaurant_Info".restaurant_id = "Yelp_Rating".restaurant_id
INNER JOIN "Google_Maps_Rating" ON "Google_Maps_Rating".restaurant_id = "Yelp_Rating".restaurant_id
INNER JOIN "Trip_Advisor_Rating" ON "Trip_Advisor_Rating".restaurant_id = "Google_Maps_Rating".restaurant_id;


