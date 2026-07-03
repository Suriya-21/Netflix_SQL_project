## Netflix_SQL_project
This project analyzes the Netflix Titles dataset using PostgreSQL to solve real-world business problems through SQL. It covers data cleaning, data transformation, aggregations, window functions, Common Table Expressions (CTEs), subqueries, string manipulation, date functions, and business-focused analytical queries.

![Netflix logo](https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940)

## Project Highlights
- Imported and analyzed the Netflix Titles dataset in PostgreSQL
- Solved 25+ business-oriented SQL case studies
- Performed data cleaning and transformation using SQL functions
- Used CTEs, subqueries, window functions, CASE statements, and regular expressions
- Extracted actionable insights on content trends, genres, ratings, countries, actors, directors, and release patterns
## SQL Concepts Covered
- SELECT, WHERE, GROUP BY, HAVING
- JOINs
- Aggregate Functions
- CASE Statements
- Window Functions
- CTEs (WITH)
- Subqueries
- Date Functions
- String Functions
- Regular Expressions
- Data Cleaning Techniques

This project demonstrates practical SQL skills commonly used by Data Analysts to transform raw data into meaningful business insights.
## Schema
```sql
CREATE TABLE Netflix(
show_id	VARCHAR(10),
type VARCHAR(10),	
title VARCHAR(150),	
director VARCHAR(250),	
casts VARCHAR(1000),	
country	VARCHAR(150),
date_added VARCHAR(50),	
release_year INT, 	
rating VARCHAR(10),	
duration VARCHAR(20),	
listed_in VARCHAR(100),	
description VARCHAR(300)
);
```
## Business problems and its solution
- **1. Count the number of Movies and TV Shows**
  ```sql
  SELECT 
	type,
	COUNT (*) AS total_content FROM Netflix
	GROUP BY type
  ```
- **2. Find the most common rating for Movies and TV Shows**
    ```sql
    WITH T1 AS(
	SELECT type,rating, COUNT(*) as total_titles
	FROM Netflix
	GROUP BY type,rating
	),
	T2 AS(
	SELECT type,rating,total_titles,
	RANK() OVER(PARTITION BY type ORDER BY total_titles DESC) as ranking
	FROM T1
	)
	SELECT type,rating
	FROM T2
	WHERE ranking = 1
    ```
- **3. List all the Movies in a Specific year (Eg. 2020)**
    ```sql
    SELECT * FROM Netflix
	WHERE 
		type = 'Movie' AND release_year = 2020
    ```
- **4. Find the top 5 countries with the most content on Netflix**
    ```sql
    SELECT 
		TRIM(UNNEST(STRING_TO_ARRAY(country,','))) as new_country,
		COUNT(show_id) as totalcontent
		FROM Netflix
		GROUP BY new_country ORDER BY totalcontent DESC
    ```
- **5. Identify the longest movie**
  ```sql
  SELECT * FROM Netflix
	WHERE 
		type = 'Movie' 
		AND
		duration = (SELECT MAX(duration) FROM Netflix)
  ```
- **6. Find the content that was added in the last 5 years**
  ```sql
  SELECT * FROM Netflix
	WHERE
		TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
  ```
- **7. Find all the Movies/TV Shows by director 'Rajiv Chilaka'**
  ```sql
  SELECT * FROM Netflix
		WHERE director LIKE '%Rajiv Chilaka%'
  ```
- **8. List all TV Shows with more than 5 Seasons**
  ```sql
  WITH tv_shows AS(
	SELECT 
	*,
	SPLIT_PART(duration,' ',1)::INT AS Seasons
	FROM Netflix 
	WHERE type = 'TV Show'
	)
	SELECT *
	FROM tv_shows
		WHERE Seasons >= 5
  ```
- **9. Count the number of content in each genre**
  ```sql
  SELECT 
		UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre,
		COUNT(show_id) AS total_content
		FROM Netflix
		GROUP BY 1;
  ```
- **10. Find the average number of content released by India on Netflix for each year and return top 5 year with high average**
  ```sql
  SELECT 
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) AS year,
	COUNT(*) as yearly_content,
	ROUND(COUNT(*)::numeric/(SELECT COUNT(*) FROM Netflix  WHERE TRIM(country) = 'India')::numeric * 100, 2) AS avg_content_per_year
	FROM Netflix
	WHERE TRIM(country) ='India'
	GROUP BY year
  ```
- **11. List all the movies that are Documentaries**
  ```sql
  SELECT 
	*,
	UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre 
	FROM Netflix
		WHERE type = 'Movie' AND listed_in = TRIM('Documentaries')
  ```

   __Alternative__
   ```sql 
   SELECT * FROM Netflix
		WHERE 
			listed_in ILIKE '%documentaries%'
    ```
			
- **12. Find all the content without director**
 ```sql
	SELECT * FROM Netflix
		WHERE 
			director IS NULL
 ```

- **13. Movies salman khan appeared in last 10 years**
```sql
  SELECT * FROM Netflix
		WHERE casts ILIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10
```
- **14. Find top 10 actors who have appeared in the highest number of movies produced in India**
  ```sql
	SELECT 
		UNNEST(STRING_TO_ARRAY(casts,',')) AS actors,
		COUNT(*) AS total_content
		FROM Netflix
		WHERE country ILIKE '%India%'
		GROUP BY actors
		ORDER BY total_content DESC
		LIMIT 10
  ```
- **15. Categorize the content based on the presence of keywords 'kill' and 'violence' in the description field. Label the content containing these keywords as 'Bad' and all other as 'Good'. Count how many items fall into each category**
  ```sql
		SELECT 
		CASE 
			WHEN description ~* '\mkill'
				OR description ~* '\mviolence'
			THEN 'Bad'
			ELSE 'Good'
		END AS category,
		COUNT (*) AS total_content
		FROM Netflix
		GROUP BY category
	```	
  
