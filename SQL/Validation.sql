/*
Project: Fraud Detection & Streaming Analytics
File: Validation.sql
Purpose: Validate row counts, class distribution, fraud rate, and rule flags

Expected table:
- fraud_detection_results
*/

USE fraud_detection;


-- 1. Total number of processed transactions
SELECT
    COUNT(*) AS total_rows
FROM fraud_detection_results;


-- 2. Legitimate and fraudulent transaction counts
SELECT
    SUM(CASE WHEN Class = 0 THEN 1 ELSE 0 END) AS legitimate_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM fraud_detection_results;


-- 3. Number of transactions flagged by each amount-based rule
-- rule_flag_100: Amount > 100
-- rule_flag:     Amount > 1000
SELECT
    SUM(rule_flag_100) AS flagged_over_100,
    SUM(rule_flag) AS flagged_over_1000
FROM fraud_detection_results;


-- 4. Overall fraud rate in the processed dataset
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        4
    ) AS fraud_rate_percent
FROM fraud_detection_results;


-- 5. Confusion-matrix counts for the Amount > 100 rule
SELECT
    SUM(CASE WHEN Class = 1 AND rule_flag_100 = 1 THEN 1 ELSE 0 END)
        AS true_positive,
    SUM(CASE WHEN Class = 0 AND rule_flag_100 = 1 THEN 1 ELSE 0 END)
        AS false_positive,
    SUM(CASE WHEN Class = 1 AND rule_flag_100 = 0 THEN 1 ELSE 0 END)
        AS false_negative,
    SUM(CASE WHEN Class = 0 AND rule_flag_100 = 0 THEN 1 ELSE 0 END)
        AS true_negative
FROM fraud_detection_results;
