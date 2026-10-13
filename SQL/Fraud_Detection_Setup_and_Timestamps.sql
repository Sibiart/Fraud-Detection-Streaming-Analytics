/*
Project: Fraud Detection & Streaming Analytics
File: Fraud_Detection_Setup_and_Timestamps.sql
Purpose: Database inspection and optional schema/timestamp experiments

Important:
- Review each ALTER TABLE statement before running it.
- Do not rerun ADD COLUMN statements if the column already exists.
- The DateTime values generated below are synthetic, based on an assumed
  start date. They are not original transaction timestamps.
- The INSERT statement adds a test row to the source table. Run it only
  when you intentionally want test data; it changes the dataset.
*/

USE fraud_detection;


-- 1. Inspect available tables and row counts
SHOW TABLES;

SELECT COUNT(*) AS processed_row_count
FROM fraud_detection_results;


-- Optional: preview source and sample tables
-- These queries may return a large number of rows. Use LIMIT when needed.
-- SELECT * FROM creditcard LIMIT 10;
-- SELECT * FROM first_5000_data LIMIT 10;


-- 2. Optional schema changes
-- Run each statement only if the corresponding column does not already exist.

-- ALTER TABLE first_5000_data
--     ADD COLUMN DateTime TIMESTAMP NULL;

-- ALTER TABLE creditcard
--     ADD COLUMN DateTime TIMESTAMP NULL;

-- ALTER TABLE fraud_detection_results
--     ADD COLUMN DateTime TIMESTAMP NULL;

-- Add an auto-incrementing primary key only if the table does not already
-- have a suitable primary key. This may fail if a primary key already exists.
-- ALTER TABLE creditcard
--     ADD COLUMN id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- ALTER TABLE fraud_detection_results
--     ADD COLUMN id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- ALTER TABLE first_5000_data
--     ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;


-- 3. Optional test row
-- WARNING: This INSERT permanently adds a synthetic record to creditcard.
-- Uncomment only when deliberately testing and after confirming the schema.
-- INSERT INTO creditcard (
--     `Time`,
--     V1, V2, V3, V4, V5, V6, V7, V8, V9,
--     V10, V11, V12, V13, V14, V15, V16, V17, V18, V19,
--     V20, V21, V22, V23, V24, V25, V26, V27, V28,
--     Amount,
--     Class
-- )
-- VALUES (
--     999999,
--     0, 0, 0, 0, 0, 0, 0, 0, 0,
--     0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
--     0, 0, 0, 0, 0, 0, 0, 0, 0,
--     999.99,
--     0
-- );


-- 4. Inspect the sample table's schema and indexes
-- Run only if first_5000_data exists.
-- DESCRIBE first_5000_data;
-- SHOW INDEX FROM first_5000_data;


-- 5. Optional synthetic DateTime generation
-- These examples assume the DateTime and id columns already exist.
-- Choose one approach; do not run all approaches sequentially.

-- Approach A: derive a synthetic timestamp from elapsed seconds.
-- UPDATE first_5000_data
-- SET DateTime = DATE_ADD('2023-01-01 00:00:00', INTERVAL `Time` SECOND)
-- WHERE `Time` >= 0;

-- UPDATE creditcard
-- SET DateTime = DATE_ADD('2023-01-01 00:00:00', INTERVAL `Time` SECOND)
-- WHERE id > 0;

-- UPDATE fraud_detection_results
-- SET DateTime = DATE_ADD('2023-01-01 00:00:00', INTERVAL `Time` SECOND)
-- WHERE id > 0;


-- Approach B: spread sample rows across synthetic days in batches of 500.
-- This is a simulation for visualization, not real transaction timing.
-- UPDATE first_5000_data
-- SET DateTime = DATE_ADD(
--     '2023-01-01 00:00:00',
--     INTERVAL (
--         FLOOR((id - 1) / 500) * 86400
--         + MOD(`Time`, 86400)
--     ) SECOND
-- )
-- WHERE id > 0;


-- 6. Preview generated values and aggregate by simulated date
-- SELECT
--     id,
--     `Time`,
--     DateTime,
--     Amount,
--     Class
-- FROM first_5000_data
-- ORDER BY id
-- LIMIT 10;

-- SELECT
--     DATE(DateTime) AS transaction_date,
--     COUNT(*) AS total_transactions,
--     SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
-- FROM first_5000_data
-- GROUP BY DATE(DateTime)
-- ORDER BY transaction_date;
