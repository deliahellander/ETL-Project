-- test
SELECT * FROM "Cuisine_Type";

--alter tables to drop not null contraint 
ALTER TABLE "Yelp_Rating" ALTER COLUMN yelp_price_level DROP NOT NULL;

--drop PK for cuisine table
ALTER TABLE "Cuisine_Type" DROP CONSTRAINT "pk_Cuisine_Type";

--alter tables to drop not null contraint 
ALTER TABLE "Google_Maps_Rating" ALTER COLUMN google_maps_rating TYPE varchar;
SELECT * FROM "Google_Maps_Rating";

-- Displaying resturants reviews from places that has reviews on all three websites(Yelp, Google Maps, TripAdvisor)
SELECT restaurant_id, restaurant_name
FROM "Restaurant_Info"
WHERE "Restaurant_Into".restaurant_id = "Yelp_Rating".restaurant_id
(
  SELECT restaurant_id, yelp_rating
  FROM "Yelp_Rating"
  WHERE "Yelp_Rating".restaurant_id = "Google_Maps_Rating".restaurant_id
  (
    SELECT restaurant_id, google_maps_rating
    FROM "Google_Maps_Rating"
  )
);

