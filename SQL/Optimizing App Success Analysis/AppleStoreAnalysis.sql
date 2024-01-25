-- Joining tables to create on with all info relating app descriptions
CREATE TABLE applestore_despcription_comb AS

SELECT * FROM appleStore_description1
UNION ALL 
SELECT * FROM appleStore_description2
UNION ALL 
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4 
/* not needed if original appleStore_description file runs without issue*/

** Exploratory data analysis **
--Check the number of unique apps in tables to avoid discrepancies

SELECT COUNT (DISTINCT id) AS UniqueAppIDs 
FROM AppleStore

SELECT COUNT (DISTINCT id) AS UniqueAppIDs 
FROM AppleStore
applestore_despcription_comb;

--Check for any missing values in key fields
SELECT COUNT(*) AS MissingValues 
FRom AppleStore
WHERE track_name ISNULL OR user_rating ISNULL or prime_genre ISNULL

SELECT COUNT(*) AS MissingValues 
FRom applestore_despcription_comb
WHERE app_desc ISNULL;

-- Find out the number of apps per genre ro provide overview and identify dominating genres
SELECT prime_genre, COUNT(*) AS NumApps
FRom AppleStore
GROUP by prime_genre 
ORDER by NumApps DESC;

-- Get an overview of the app ratings
SELECT min(user_rating) AS MinRating,
		max(user_rating) AS MaxRating,
        avg(user_rating) AS AvgRating
FROM AppleStore;

** Data Analysis **

-- Determine whether paid apps have higher ratings than free apps
SELECT CASE
	When price > 0 THEN 'Paid'
    ELSE 'Free'
    ENd as App_Type,
    avg(user_rating) AS Avg_Rating
From AppleStore
GROUP by App_Type;
/* Paid app have higher avg user ratings */ 


-- Determine if apps with more supported languages have higher ratings 
SELECT CASE
	when lang_num < 10 then '< 10 languages'
    When lang_num BETWEEN 10 and 30 THEN '10-30 languages'
    ELSE '>30 langauges'
    end as Language_Bucket,
    avg(user_rating) AS Avg_Rating
from AppleStore
group by Language_Bucket
order by Avg_Rating DESC;
/* 10-30 languages have highest avg user ratings */

-- Look into it a bit further 
SELECT CASE
	when lang_num BETWEEN 10 and 20 Then  '10-20 languages'
    ELSE '20+ langauges'
    end as Language_Bucket,
    avg(user_rating) AS Avg_Rating
from AppleStore
group by Language_Bucket
order by Avg_Rating DESC;
/* Specifically, 10-20 supported langauges have highest avg user rating  */

--Check gneres with low ratings
SELECT prime_genre, 
	avg(user_rating) AS Avg_Rating
From AppleStore
GROUP by prime_genre
order by Avg_Rating ASC
Limit 10; 
/* The lowest three app genres are catalogs, finance and book. There is a greater opportunity to app in the space */

--Check if there is correleation between the lengthe of app description and the user rating 
SELECT CASE
	when length(b.app_desc) < 500 then 'short'
    when length(b.app_desc) between 500 and 1000 then 'medium'
    ELSE 'long'
    end as Description_len_bucket,
	avg(user_rating) AS Avg_Rating
FROM AppleStore as a 
join applestore_despcription_comb as b 
on a.id = b.id
GROUP by Description_len_bucket
order by Avg_Rating DESC;
/* Apps with long descriptions (over 1000) have higher avg user ratings */

--Check the top rated apps for each genre 
select prime_genre, 
	track_name,
    user_rating
From (
  		SELECT prime_genre, 
		track_name,
    	user_rating,
  		RANK() OVER(PARTITION by prime_genre order by user_rating DESC, rating_count_tot DESC) AS rank
  		From AppleStore
  	) AS a 
where a.rank = 1 
/* Books = Color Therapy Adult Coloring Book for Adults, 
Business = TurboScan™ Pro - document & receipt scanner: scan multiple pages and photos to PDFAppleStore
Catalogs = CPlus for Craigslist app - mobile classifieds
These show the highest performing apps under the 3 app genres with the lowest ratings. 
Uncovering a great spot where user needs are not being fully met resprenting a market of opportunity. */

