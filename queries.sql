-----------------------------------------------------
-- TOP-PERFORMING CATEGORIES AND BRANDS
-----------------------------------------------------
SELECT * FROM listings;
-----------------------------------------------------
SELECT brand, SUM(price) AS total_sales
FROM listings
GROUP BY brand
ORDER BY total_sales DESC LIMIT 3;
-----------------------------------------------------
SELECT category, SUM(price) AS total_sales
FROM listings
GROUP BY category
ORDER BY total_sales DESC LIMIT 3;
-----------------------------------------------------
-- COUNTRIES WITH HIGHEST LISTING ACTIVITY
-----------------------------------------------------
SELECT l.user_id, COUNT(*) AS listing_count, u.country 
FROM listings AS l 
JOIN users AS u 
ON l.user_id = u.user_id
GROUP by u.country
order by listing_count DESC;
-----------------------------------------------------
-- ANALYSE LISTING CONDITIONS
-----------------------------------------------------
SELECT 
    condition, 
    ROUND(AVG(price), 2) AS avg_price, 
    SUM(price) AS total_sales, 
    COUNT(*) AS listing_count
from listings
GROUP BY condition
ORDER BY listing_count DESC, total_sales DESC;
-----------------------------------------------------
-- ANALYSE PRICING DISTRIBUTIONS
-----------------------------------------------------
-- FIND AVERAGE 
-----------------------------------------------------
SELECT ROUND(AVG(price), 2) AS avg_price FROM listings;
-----------------------------------------------------
-- FIND MIN
-----------------------------------------------------
SELECT MIN(PRICE) AS min_price FROM listings;
-----------------------------------------------------
-- FIND MAX
-----------------------------------------------------
SELECT MAX(PRICE) AS max_price FROM listings;
-----------------------------------------------------
-- PRICING DISTRIBUTION
-----------------------------------------------------
SELECT
    CASE 
    WHEN price <= 13 THEN '0-13'
    when price <= 26 then '13-26'
    else '26-40'
    END AS price_range,
    COUNT(*) AS listing_count
FROM listings
GROUP BY price_range
ORDER BY listing_count DESC;
-----------------------------------------------------
-- HIGH-CONTRIBUTION USERS
-----------------------------------------------------
SELECT 
    user_id, 
    SUM(price) AS total_sales, 
    Count(*) as listing_count
from listings 
group by user_id 
order by listing_count DESC, total_sales DESC;
-----------------------------------------------------
-- DAILY/WEEKLY/MONTHLY ACTIVE USERS
-----------------------------------------------------
SELECT * FROM sessions;
UPDATE sessions
set session_date = '2024-05-15'
where session_id = 5;
-----------------------------------------------------
SELECT 
    session_date, 
    COUNT(distinct user_id) AS unique_users 
FROM sessions
group by DATE(session_date)
ORDER BY DATE(session_date);
-----------------------------------------------------
SELECT
    STRFTIME('%Y', session_date) AS year,
    STRFTIME('%W', session_date) AS week,
    COUNT(DISTINCT user_id) AS unique_users
FROM sessions
GROUP BY year, week
ORDER BY year, week;
-----------------------------------------------------
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
-----------------------------------------------------
-- ENGAGEMENT ACROSS DEVICES
-----------------------------------------------------
SELECT
    device,
    SUM(views) AS total_views,
    ROUND(AVG(duration_minutes), 2) AS avg_duration
FROM sessions
GROUP BY device
ORDER BY total_views DESC, avg_duration DESC;
-----------------------------------------------------
-- USAGE ACROSS CAMPAIGNS
-----------------------------------------------------
SELECT * FROM promo_codes;
-----------------------------------------------------
SELECT  
    campaign, 
    COUNT(*) AS usage
FROM promo_codes
WHERE used != 0
GROUP BY campaign
ORDER BY usage DESC;
-----------------------------------------------------
-- PROMO USAGE CORRELATION TO USER ACTIVITY
-----------------------------------------------------
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
-----------------------------------------------------
