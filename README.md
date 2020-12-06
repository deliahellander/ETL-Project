# ETL Project Report
#### Group 7: Deepa, Raul, Tom, and Delia

## Restaurants of Morris County NJ

![rest](Resources/restaurant.png)

### Abstract:

   Our database contains information and ratings on restaurants in Morris County, NJ.  We have broken the database into 5 tables: “Restaurant Info”, “Yelp Rating”, “Google Maps Rating”, “Trip Advisor Rating” and “Cuisine Type”.  What makes this database unique is that we will be including ratings from Yelp, Trip Advisor, and Google Maps to show a variety of ratings from popular restaurant review sources.  This database can be used by anyone who wishes to obtain data on the restaurants in Morris County, whether it be some friends looking for the best Thai food around, or an entrepreneur looking to open up a new restaurant but first needing to know what kinds of restaurants are successful in the area. 

### Data Sources:
* **Yelp**: Scraped data from https://www.yelp.com/search?find_desc=Restaurants&find_loc=Morris+County%2C+NJ&ns=1 (.html) Saved scraped data to yelp_data.csv
* **Trip Advisor**: Scraped data from https://www.tripadvisor.com/Tourism-g6787210-Morris_County_New_Jersey-Vacations.html (.html) Saved scraped data to tripadvisor_data.csv
* **Google**: Google Places API and Place Details API to find restaurants in Morris County.  Saved scraped data to google_data.csv


### ETL Process:

   #### Extract:
   * Scrape yelp website using requests, Beautiful Soup and splinter to find all restaurants in Morris County, NJ
       * First retrieved restaurant name, yelp url for restaurant, restaurant rating, price-level and cuisine from yelp.
       * Using the yelp_url for each restaurant, retrieved the restaurant address and restaurant’s website
       * Saved yelp dataframe to a csv file
   
   * Used Google Places API and Place Details API to find restaurants within 6 different long and lat locations in Morris County.
       * Using Google Places API, retrieved restaurant name, place_id, price-level and restaurant rating
       * Using Google Place Details API, retrieved restaurant address, restaurant website and google maps url
       * Saved google dataframe to a csv file
   * Scrape Tripadvisor with the help of BeautifulSoup and Splinter to get datapoints for all restaurants in Morris County, NJ.
       * Retrieved the restaurant name, price level, and cuisine type from main Tripadvisor page.
       * Using the Tripadvisor link for each individual restaurant, found the remaining datapoints: restaurant address and rating on a scale from 1 to 5.

       * 
   * Notes: 
      * Google does not give a comprehensive list of all restaurants in Morris County. The Google Places API returns only 60 results per query. To counter this, we used the Google Places API to retrieve restaurants for 6 different latitude and longitude locations in Morris County getting a total of 360         
      * The restaurant categorization for google and yelp is different. For example: Google returns Subway, Dunkin Donuts, Gas stations that serve food as restaurants. These cannot be found in the Yelp data. 
      * Complications arose when trying to extract the restaurants' websites from Tripadvisor. Hyperlink would not show up and the source of this issue could not be found.   

#### Transform:
   * Extract raw data files (in csv, json, html. Etc. format)  into DataFrames
   * Clean DataFrame: 
        * Remove any restaurants outside of Morris County; 
        * Dropping duplicate restaurant_name and address values; 
        * filling in empty cells; 
        * Split yelp’s price_cuisine column into price_level and cuisine column...etc.
        * Split address into address1, city, state and zip code
        * Clearing restaurant website if it is not a website
   * Combination of concat and merge to combine yelp and google dataframes to get unique restaurants in Morris County.
   * Added restaurant_id column to uniquely identify each restaurant
   * Create new datasets with combined restaurant data: 
        * Restaurant Dataset: contains restaurant_id, restaurant_name, restaurant_website, address1, city, state and zip code
        * Google Dataset: restaurant_id, google_price_level, google_rating, google_maps_url
        * Yelp Dataset: restaurant_id, yelp_price_level, yelp_rating, yelp_url
        * Cuisine Dataset: cuisine, restaurant_id
   * Saved the above dataframes to csv files.


   #### Load:
   * 5 tables: restaurant_info, yelp_rating, google_maps_rating, trip_advisor_rating and cuisine_type.
        * All linked by restaurant_id
        * Used QuickDBD to formulate the ERD below, exported the corresponding code and ran it in PgAdmin to formulate tables.
        * Imported the csv files from the "Transformation" folder into database tables.
        * Format tables to allow null cells for urls, rating, and price level.
        * Create Queries between tables, code in "Load" folder > "Query Example" folder titled "Query_code.sql"
        ![ERD](https://github.com/deliahellander/ETL-Project/blob/load/Load/ERD.png?raw=true)


   ##### Query Example:
   * Displaying restaurants reviews from places that has reviews on all three websites(Yelp, Google Maps, Trip Advisor).
   * Query Yelp rating and cuisine sorted by best rating:
   ![ERD](https://github.com/deliahellander/ETL-Project/blob/load/Load/Query_Examples/Yelp_Rating_sorted_Desc_by_rating.png?raw=true)
   * See other Query examples in "Load" folder > "Query_Examples" folder.




