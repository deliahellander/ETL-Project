-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/CKQLlV
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Restaurant_Info] (
    [restaurant_name] varchar  NOT NULL ,
    [restaurant_url] varchar  NOT NULL ,
    [address] varchar  NOT NULL ,
    [zip_code] varchar  NOT NULL ,
    CONSTRAINT [PK_Restaurant_Info] PRIMARY KEY CLUSTERED (
        [restaurant_name] ASC
    )
)

CREATE TABLE [Restaurant_Rating] (
    [restaurant_name] varchar  NOT NULL ,
    [yelp_rating] int  NOT NULL ,
    [google_rating] int  NOT NULL ,
    [trip_advisor_rating] int  NOT NULL ,
    [average_rating] int  NOT NULL ,
    [num_of_reviews] int  NOT NULL ,
    CONSTRAINT [PK_Restaurant_Rating] PRIMARY KEY CLUSTERED (
        [restaurant_name] ASC
    )
)

ALTER TABLE [Restaurant_Info] WITH CHECK ADD CONSTRAINT [FK_Restaurant_Info_restaurant_name] FOREIGN KEY([restaurant_name])
REFERENCES [Restaurant_Rating] ([restaurant_name])

ALTER TABLE [Restaurant_Info] CHECK CONSTRAINT [FK_Restaurant_Info_restaurant_name]

COMMIT TRANSACTION QUICKDBD