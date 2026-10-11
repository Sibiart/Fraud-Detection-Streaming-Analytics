use fraud_detection

-- SQL row counts
SELECT COUNT(*) AS total_rows FROM fraud_detection_results;

SELECT
    SUM(CASE WHEN Class = 0 THEN 1 ELSE 0 END) AS legitimate,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud
FROM fraud_detection_results;

-- Verification of rule flag
SELECT
    SUM(rule_flag_100) AS flagged_over_100,
    SUM(rule_flag) AS flagged_over_1000
FROM fraud_detection_results;

-- Fraud Rate check
SELECT
    COUNT(*) AS total_transactions,
    SUM(Class) AS fraud_transactions,
    ROUND(100.0 * SUM(Class) / COUNT(*), 4) AS fraud_rate_percent
FROM fraud_detection_results;

-- Rule check
SELECT
    SUM(CASE WHEN Class = 1 AND rule_flag_100 = 1 THEN 1 ELSE 0 END) AS true_positive,
    SUM(CASE WHEN Class = 0 AND rule_flag_100 = 1 THEN 1 ELSE 0 END) AS false_positive,
    SUM(CASE WHEN Class = 1 AND rule_flag_100 = 0 THEN 1 ELSE 0 END) AS false_negative,
    SUM(CASE WHEN Class = 0 AND rule_flag_100 = 0 THEN 1 ELSE 0 END) AS true_negative
FROM fraud_detection_results;
