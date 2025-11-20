-----------------------------------------------------
-- INSERT DATA INTO USERS
-----------------------------------------------------
INSERT INTO users (user_id, username, country, join_date) VALUES
(1, 'ecoEmma', 'Germany', '2024-01-10'),
(2, 'vintageVlad', 'Poland', '2024-02-14'),
(3, 'greenSofia', 'Greece', '2024-03-02'),
(4, 'retroLina', 'France', '2024-04-19'),
(5, 'minimalMia', 'Netherlands', '2024-05-05'),
(6, 'secondChance', 'Spain', '2024-06-12'),
(7, 'reuseRon', 'UK', '2024-07-23'),
(8, 'urbanOlga', 'Lithuania', '2024-08-09'),
(9, 'fashionTheo', 'Germany', '2024-09-01'),
(10, 'recycleRay', 'Italy', '2024-09-20');

-----------------------------------------------------
-- INSERT DATA INTO LISTINGS
-----------------------------------------------------
INSERT INTO listings (listing_id, user_id, brand, category, price, condition, upload_date) VALUES
(1, 1, 'H&M', 'Dresses', 12.50, 'Good', '2024-02-01'),
(2, 2, 'Nike', 'Shoes', 35.00, 'Very Good', '2024-02-20'),
(3, 3, 'Zara', 'Tops', 8.00, 'Good', '2024-03-05'),
(4, 4, 'Adidas', 'Sportswear', 25.00, 'Like New', '2024-04-25'),
(5, 5, 'Uniqlo', 'Coats', 40.00, 'Good', '2024-05-10'),
(6, 6, 'Levis', 'Jeans', 22.00, 'Very Good', '2024-06-20'),
(7, 7, 'Converse', 'Shoes', 30.00, 'Good', '2024-07-30'),
(8, 8, 'H&M', 'Skirts', 9.00, 'Good', '2024-08-15'),
(9, 9, 'Casio', 'Accessories', 15.00, 'Like New', '2024-09-10'),
(10, 10, 'Mango', 'Dresses', 18.00, 'Good', '2024-09-25');

-----------------------------------------------------
-- INSERT DATA INTO SESSIONS
-----------------------------------------------------
INSERT INTO sessions (session_id, user_id, session_date, device, views, duration_minutes) VALUES
(1, 1, '2024-02-10', 'Mobile', 12, 8),
(2, 2, '2024-02-22', 'Desktop', 5, 4),
(3, 3, '2024-03-10', 'Mobile', 20, 15),
(4, 4, '2024-04-27', 'Tablet', 7, 6),
(5, 5, '2024-05-15', 'Mobile', 14, 10),
(6, 6, '2024-06-25', 'Mobile', 9, 7),
(7, 7, '2024-08-02', 'Desktop', 6, 5),
(8, 8, '2024-08-20', 'Mobile', 18, 12),
(9, 9, '2024-09-15', 'Tablet', 11, 9),
(10, 10, '2024-09-28', 'Mobile', 4, 3);

-----------------------------------------------------
-- INSERT DATA INTO PROMO CODES
-----------------------------------------------------
INSERT INTO promo_codes (promo_id, user_id, campaign, sent_date, used, used_date) VALUES
(1, 1, 'Summer20', '2024-06-01', TRUE, '2024-06-03'),
(2, 2, 'Summer20', '2024-06-01', FALSE, NULL),
(3, 3, 'Flash10', '2024-07-10', TRUE, '2024-07-11'),
(4, 4, 'Flash10', '2024-07-10', FALSE, NULL),
(5, 5, 'Autumn5', '2022024-09-01', TRUE, '2024-09-05'),
(6, 6, 'Autumn5', '2024-09-01', FALSE, NULL),
(7, 7, 'Autumn5', '2024-09-01', FALSE, NULL),
(8, 8, 'Flash10', '2024-09-15', TRUE, '2024-09-16'),
(9, 9, 'WinterSale', '2024-10-01', FALSE, NULL),
(10, 10, 'WinterSale', '2024-10-01', TRUE, '2024-10-03');

-----------------------------------------------------
