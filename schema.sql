-----------------------------------------------------
-- USERS TABLE
-----------------------------------------------------
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    country VARCHAR(50),
    join_date DATE
);

-----------------------------------------------------
-- LISTINGS TABLE
-----------------------------------------------------
CREATE TABLE listings (
    listing_id INT PRIMARY KEY,
    user_id INT,
    brand VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    condition VARCHAR(20),
    upload_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-----------------------------------------------------
-- SESSIONS TABLE
-----------------------------------------------------
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    user_id INT,
    session_date DATE,
    device VARCHAR(30),
    views INT,
    duration_minutes INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-----------------------------------------------------
-- PROMO CODES TABLE
-----------------------------------------------------
CREATE TABLE promo_codes (
    promo_id INT PRIMARY KEY,
    user_id INT,
    campaign VARCHAR(50),
    sent_date DATE,
    used BOOLEAN,
    used_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
