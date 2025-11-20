# vinted-sql-portfolio
SQL portfolio project analyzing user engagement and marketplace data.

## 🧩 Project Overview
This project was created to simulate a real-world SQL analysis aligned with **Vinted’s mission**: enabling circular fashion through second-hand shopping.  
This is an end-to-end SQL portfolio project designed to demonstrate:

- Joins  
- Aggregations  
- Retention metrics  
- A/B testing logic  
- Business storytelling

The project includes **4 interconnected tables**, all data provided is **fictional**. 

The goal is to analyze:
- User engagement  
- Listing behavior  
- Promo code effectiveness   

---

## 📊 Database Schema

### Tables

- `users` – basic user information  
- `listings` – uploaded clothing items  
- `sessions` – user activity data   
- `promo_codes` – marketing experiment data  

See `schema.sql` for full table definitions.

---

## 📂 Dataset

The dataset consists of 10 rows per table (see `data.sql`). All values are crafted to resemble realistic marketplace behavior.

---

## 🧠 Business Questions & Tasks

### 1. Marketplace Performance

- Find the top-performing categories and brands  
- Identify countries with highest listing activity  
- Analyze listing conditions (Good, Very Good, Like New)  
- Analyze pricing distributions  

### 2. User Metrics

- Calculate daily / weekly / monthly active users  
- Compare engagement across devices  
- Identify "high-contribution" users  

### 3. Promo Campaign Effectiveness

- Compare usage across campaigns  
- Determine if promo usage correlates with session activity  

---

## 💻 Solutions / Queries

```sql

-- TOP-PERFORMING CATEGORIES AND BRANDS

SELECT * FROM listings;

SELECT brand, SUM(price) AS total_sales
FROM listings
GROUP BY brand
ORDER BY total_sales DESC
LIMIT 3;

SELECT category, SUM(price) AS total_sales
FROM listings
GROUP BY category
ORDER BY total_sales DESC
LIMIT 3;

| Brand    | Total Sales |
| -------- | ----------- |
| Uniqlo   | 40          |
| Nike     | 35          |
| Converse | 30          |

| Category | Total Sales |
| -------- | ----------- |
| Shoes    | 65          |
| Coats    | 40          |
| Dresses  | 30.5        |

-- COUNTRIES WITH HIGHEST LISTING ACTIVITY

SELECT l.user_id, COUNT(*) AS listing_count, u.country 
FROM listings AS l 
JOIN users AS u 
ON l.user_id = u.user_id
GROUP BY u.country
ORDER BY listing_count DESC;

| User ID | Listing Count | Country     |
| ------- | ------------- | ----------- |
| 1       | 2             | Germany     |
| 7       | 1             | UK          |
| 6       | 1             | Spain       |
| 2       | 1             | Poland      |
| 5       | 1             | Netherlands |
| 8       | 1             | Lithuania   |
| 10      | 1             | Italy       |
| 3       | 1             | Greece      |
| 4       | 1             | France      |

-- ANALYSE LISTING CONDITIONS

SELECT 
    condition, 
    ROUND(AVG(price), 2) AS avg_price, 
    SUM(price) AS total_sales, 
    COUNT(*) AS listing_count
FROM listings
GROUP BY condition
ORDER BY listing_count DESC, total_sales DESC;

| Condition | Avg Price (€) | Total Sales (€) | Listing Count |
| --------- | ------------- | --------------- | ------------- |
| Good      | 19.58         | 117.5           | 6             |
| Very Good | 28.50         | 57              | 2             |
| Like New  | 20.00         | 40              | 2             |

-- ANALYSE PRICING DISTRIBUTIONS

-- Average price
SELECT ROUND(AVG(price), 2) AS avg_price FROM listings;

-- Min / Max price
SELECT MIN(price) AS min_price, MAX(price) AS max_price FROM listings;

-- Price ranges
SELECT
    CASE 
        WHEN price <= 13 THEN '0-13'
        WHEN price <= 26 THEN '13-26'
        ELSE '26-40'
    END AS price_range,
    COUNT(*) AS listing_count
FROM listings
GROUP BY price_range
ORDER BY listing_count DESC;

| avg_price | min_price | max_price |
| --------- | --------- | --------- |
| 21.45     | 8         | 40        |

| price_range | listing_count |
| ----------- | ------------- |
| 13–26       | 4             |
| 26–40       | 3             |
| 0–13        | 3             |

-- HIGH-CONTRIBUTION USERS

SELECT user_id, SUM(price) AS total_sales, COUNT(*) AS listing_count
FROM listings
GROUP BY user_id
ORDER BY listing_count DESC, total_sales DESC;

| user_id | total_sales | listing_count |
| ------- | ----------- | ------------- |
| 5       | 40          | 1             |
| 2       | 35          | 1             |
| 7       | 30          | 1             |
| 4       | 25          | 1             |
| 6       | 22          | 1             |
| 10      | 18          | 1             |
| 9       | 15          | 1             |
| 1       | 12.5        | 1             |
| 8       | 9           | 1             |
| 3       | 8           | 1             |

-- DAILY/WEEKLY/MONTHLY ACTIVE USERS

SELECT * FROM sessions;
UPDATE sessions
set session_date = '2024-05-15'
where session_id = 5;

-- Daily
SELECT session_date, COUNT(DISTINCT user_id) AS unique_users
FROM sessions
GROUP BY session_date
ORDER BY session_date;

| session_date | unique_users |
| ------------ | ------------ |
| 2024-02-10   | 1            |
| 2024-02-22   | 1            |
| 2024-03-10   | 1            |
| 2024-04-27   | 1            |
| 2024-05-15   | 1            |
| 2024-06-25   | 1            |
| 2024-08-02   | 1            |
| 2024-08-20   | 1            |
| 2024-09-15   | 1            |
| 2024-09-28   | 1            |

-- Weekly
SELECT STRFTIME('%Y', session_date) AS year,
       STRFTIME('%W', session_date) AS week,
       COUNT(DISTINCT user_id) AS unique_users
FROM sessions
GROUP BY year, week
ORDER BY year, week;

| Year | Week | Unique Users |
| ---- | ---- | ------------ |
| 2024 | 06   | 1            |
| 2024 | 08   | 1            |
| 2024 | 10   | 1            |
| 2024 | 17   | 1            |
| 2024 | 20   | 1            |
| 2024 | 26   | 1            |
| 2024 | 31   | 1            |
| 2024 | 34   | 1            |
| 2024 | 37   | 1            |
| 2024 | 39   | 1            |

-- Monthly
SELECT
    STRFTIME('%Y', session_date) AS year,
    CASE STRFTIME('%m', session_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END AS month,
    COUNT(DISTINCT user_id) AS unique_users
FROM sessions
GROUP BY year, month
ORDER BY year, STRFTIME('%m', session_date);

| Year | Month     | Unique Users |
| ---- | --------- | ------------ |
| 2024 | February  | 2            |
| 2024 | March     | 1            |
| 2024 | April     | 1            |
| 2024 | May       | 1            |
| 2024 | June      | 1            |
| 2024 | August    | 2            |
| 2024 | September | 2            |

-- ENGAGEMENT ACROSS DEVICES

SELECT
    device,
    SUM(views) AS total_views,
    ROUND(AVG(duration_minutes), 2) AS avg_duration
FROM sessions
GROUP BY device
ORDER BY total_views DESC, avg_duration DESC;

| Device  | Total Views | Avg Duration (minutes) |
| ------- | ----------- | ---------------------- |
| Mobile  | 77          | 9.17                   |
| Tablet  | 18          | 7.50                   |
| Desktop | 11          | 4.50                   |

-- USAGE ACROSS CAMPAIGNS

SELECT  
    campaign, 
    COUNT(*) AS usage
FROM promo_codes
WHERE used != 0
GROUP BY campaign
ORDER BY usage DESC;

| Campaign   | Usage |
| ---------- | ----- |
| Flash10    | 2     |
| WinterSale | 1     |
| Summer20   | 1     |
| Autumn5    | 1     |

-- PROMO USAGE CORRELATION TO USER ACTIVITY

SELECT
    p.used AS promo_used,
    COUNT(DISTINCT s.user_id) AS total_users,
    SUM(s.views) AS total_views,
    ROUND(AVG(s.duration_minutes), 2) AS avg_duration
FROM promo_codes AS p
JOIN sessions AS s
    ON p.user_id = s.user_id
GROUP BY p.used
ORDER BY p.used DESC;

| Promo Used | Total Users | Total Views | Avg Duration (minutes) |
| ---------- | ----------- | ----------- | ---------------------- |
| 1          | 5           | 68          | 9.6                    |
| 0          | 5           | 38          | 6.2                    |










