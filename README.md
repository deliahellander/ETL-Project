# ETL Project Report
#### Group 7: Deepa, Raul, Tom, and Delia

## Restaurants of Morris County NJ

![rest](Resources/restaurant.png)

### Abstract:

   Our database contains information and ratings on restaurants in Morris County, NJ.  We have broken the database into 5 tables: “Restaurant Info”, “Yelp Rating”, “Google Maps Rating”, “Trip Advisor Rating” and “Cuisine Type”.  What makes this database unique is that we will be including ratings from Yelp, Trip Advisor, and Google Maps to show a variety of ratings from popular restaurant review sources.  This database can be used by anyone who wishes to obtain data on the restaurants in Morris County, whether it be some friends looking for the best Thai food around, or an entrepreneur looking to open up a new restaurant but first needing to know what kinds of restaurants are successful in the area. 

### Data Sources:
* **Yelp**: Scraped data from https://www.yelp.com/search?find_desc=Restaurants&find_loc=Morris+County%2C+NJ&ns=1 (.html)   
Saved scraped data to yelp_data.csv
* **Trip Advisor**: Scraped data from https://www.tripadvisor.com/Restaurants-g6787210-Morris_County_New_Jersey.html (.html)   
Saved scraped data to tripadvisor_data.csv
* **Google**: Google Places API and Place Details API to find restaurants in Morris County.    
Saved scraped data to google_data.csv


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
       
   * Scrape trip advisor website using requests, Beautiful Soup and splinter to find all restaurants in Morris County, NJ
       * First retrieved restaurant name, trip advisor url, price_level and cuisine for restaurants.
       * Using the trip advisor url for each restaurant, retrieved the restaurant address and restaurant's rating
       * Saved trip advisor dataframe to a csv file
   
   * **Notes:** 
      * Google does not give a comprehensive list of all restaurants in Morris County. The Google Places API returns only 60 results per query. To counter this, we used the Google Places API to retrieve restaurants for 6 different latitude and longitude locations in Morris County getting a total of 360         
      * The restaurant categorization for google and yelp is different. For example: Google returns Subway, Dunkin Donuts, Gas stations that serve food as restaurants. These cannot be found in the Yelp data.  

#### Transform:
   * Extract raw data files (in csv, json, html. Etc. format)  into DataFrames
   * Clean DataFrame: 
        * Remove any restaurants outside of Morris County; 
        * Dropping duplicate restaurant_name and address values; 
        * filling in empty cells; 
        * Split yelp’s price_cuisine column into price_level and cuisine column.
        * Split address into address1, city, state and zip code
        * Clearing restaurant website if it is not a website
        * Removed numbered list from restaurant name in Trip Advisor data
   * Combination of concat and merge to combine yelp, google and trip advisor dataframes to get unique restaurants in Morris County.
   * Added restaurant_id column to uniquely identify each restaurant
   * Create new datasets with combined restaurant data: 
        * Restaurant Dataset: contains restaurant_id, restaurant_name, restaurant_website, address1, city, state and zip code
        * Google Dataset: restaurant_id, google_price_level, google_rating, google_maps_url
        * Yelp Dataset: restaurant_id, yelp_price_level, yelp_rating, yelp_url
        * Trip Advisor Dataset: restaurant_id, trip_advisor_price_level, trip_advisor_rating, trip_advisor_url
        * Cuisine Dataset: cuisine, restaurant_id
   * Saved the above dataframes to csv files.

   * **Notes:**
       * There are discrepancies in the restaurant name and address Eg Yelp has "Quiet Man Pub", Google has "The Quiet Man Pub/Restaurant" and Trip Advisor has "The Quiet Man" All 3 are the same restaurants. If we had time to standardize the addresses, we would have been able to compare and merge the restaurants.

#### Load:
   * 5 tables: restaurant_info, yelp_rating, google_maps_rating, trip_advisor_rating and cuisine_type.
        * All linked by restaurant_id
        * Used QuickDBD to formulate the ERD below, exported the corresponding code and ran it in PgAdmin to formulate tables.
        * Imported the csv files from the "Transformation" folder into database tables.
        * Format tables to allow null cells for urls, rating, and price level.
        * Create Queries between tables, code in "Load" folder > "Query Example" folder titled "Query_code.sql"
        ![ERD](https://github.com/deliahellander/ETL-Project/blob/load/Load/ERD.png?raw=true)


#### Recreate the Database:
1. Run all the files in Extract folder, in any order.   
   yelp-data-extraction Dependencies:  
       
```
import pandas as pd
import requests
from splinter import Browser
from bs4 import BeautifulSoup
import time
```    
       
   google-data-extraction Dependencies   
```
import pandas as pd
import requests
import json
import time
```       
 
   Trip-advisor Dependancies   
```
from splinter import Browser
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup
import pandas as pd
import time
import requests
```   
Running these 3 files will return yelp_data.csv, google_data.csv and tripadvisor_data.csv in the Resources folder.  

2. Run Transformation from the Transformation folder   
   Transformation Dependancies
```
import pandas as pd
import requests
import re
```
Running the transformation file results in restaurant_data.csv, google_final_data.csv, yelp_final_data.csv, tripadvisor_final_data.csv and cuisine_data.csv   


3. Load
     
    
   ##### Query Example:
   * Displaying restaurants reviews from places that has reviews on all three websites(Yelp, Google Maps, Trip Advisor).
   ![ERD](https://github.com/deliahellander/ETL-Project/blob/main/Load/Query_Examples/Ratings_From_all_3_sources.png?raw=true)
   * Query Yelp rating and cuisine sorted by best rating:
   ![ERD](https://github.com/deliahellander/ETL-Project/blob/load/Load/Query_Examples/Yelp_Rating_sorted_Desc_by_rating.png?raw=true)
   * See other Query examples in "Load" folder > "Query_Examples" folder.
  




