# Netflix Content Analysis Using SQL

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset.

## Objectives
- Analyze the distribution of content types (Movies vs. TV Shows).
- Identify the most common ratings for Movies and TV Shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset
The data for this project is sourced from Kaggle.

**Dataset Link**: [Netflix Movies Dataset](https://www.kaggle.com/)

### Schema
```sql
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## Findings and Conclusion

- **Content Distribution**: The dataset contains a diverse range of movies and TV shows.  
- **Common Ratings**: Insights into ratings help understand the target audience.  
- **Geographical Insights**: The analysis highlights content distribution by region and India’s contribution.  
- **Content Categorization**: Keyword-based categorization provides insights into content themes.  

