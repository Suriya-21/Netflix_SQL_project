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
