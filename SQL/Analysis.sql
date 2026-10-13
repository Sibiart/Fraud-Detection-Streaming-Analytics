/*
Project: Fraud Detection & Streaming Analytics
File: Analysis.sql
Purpose: Exploratory SQL analysis of credit-card transactions

Notes:
- Run against the source table: fraud_detection.creditcard.
- `Time` represents elapsed time in the source dataset, not a calendar timestamp.
*/

USE fraud_detection;

-- 1. Transaction counts by class
SELECT
    Class,
    COUNT(*) AS transaction_count
FROM creditcard
GROUP BY Class
ORDER BY Class;


-- 2. Overall transaction amount statistics
SELECT
    SUM(Amount) AS total_transaction_amount,
    AVG(Amount) AS average_transaction_amount,
    MIN(Amount) AS minimum_transaction_amount,
    MAX(Amount) AS maximum_transaction_amount
FROM creditcard;


-- 3. Overall fraud percentage
SELECT
    COUNT(CASE WHEN Class = 1 THEN 1 END) * 100.0
        / NULLIF(COUNT(*), 0) AS fraud_percentage
FROM creditcard;


-- 4. Transaction count and percentage by class
SELECT
    Class,
    COUNT(*) AS transaction_count,
    COUNT(*) * 100.0
        / NULLIF((SELECT COUNT(*) FROM creditcard), 0) AS percentage
FROM creditcard
GROUP BY Class
ORDER BY Class;


-- 5. Transaction amount statistics by class
SELECT
    Class,
    SUM(Amount) AS total_transaction_amount,
    AVG(Amount) AS average_transaction_amount,
    MIN(Amount) AS minimum_transaction_amount,
    MAX(Amount) AS maximum_transaction_amount
FROM creditcard
GROUP BY Class
ORDER BY Class;


-- 6. Transaction activity grouped into elapsed-time hour buckets
-- Note: hour_bucket is derived from elapsed seconds, not a real clock hour.
SELECT
    FLOOR(`Time` / 3600) AS hour_bucket,
    COUNT(*) AS total_transactions,
    SUM(Amount) AS total_transaction_amount,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM creditcard
GROUP BY FLOOR(`Time` / 3600)
ORDER BY hour_bucket;


-- Optional analysis: five hour buckets with the highest fraud counts.
-- Uncomment to run.
-- SELECT
--     FLOOR(`Time` / 3600) AS hour_bucket,
--     COUNT(*) AS total_transactions,
--     SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
-- FROM creditcard
-- GROUP BY FLOOR(`Time` / 3600)
-- ORDER BY fraud_transactions DESC
-- LIMIT 5;


-- Optional analysis: compare each bucket's fraud count with the next bucket.
-- Uncomment to run.
-- WITH hourly_data AS (
--     SELECT
--         FLOOR(`Time` / 3600) AS hour_bucket,
--         COUNT(*) AS total_transactions,
--         SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
--     FROM creditcard
--     GROUP BY FLOOR(`Time` / 3600)
-- )
-- SELECT
--     hour_bucket,
--     total_transactions,
--     fraud_transactions,
--     LEAD(fraud_transactions) OVER (ORDER BY hour_bucket)
--         AS next_hour_fraud_transactions
-- FROM hourly_data
-- ORDER BY hour_bucket;
