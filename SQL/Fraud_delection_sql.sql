-- create database fraud_detection;
  use fraud_detection;
SHOW TABLES;
SELECT * FROM CREDITCARD;
select count(*) from fraud_detection_results;
-- SELECT COUNT(*) FROM CREDITCARD;
select * from first_5000_data;
alter table first_5000_data add column DateTime timestamp;

ALTER TABLE creditcard
ADD COLUMN DateTime timestamp;
ALTER TABLE fraud_detection_results
ADD COLUMN DateTime timestamp;

ALTER TABLE creditcard
ADD COLUMN id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE fraud_detection_results
ADD COLUMN id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;


select count(*) from fraud_detection_results;

INSERT INTO creditcard (
    Time,
    V1, V2, V3, V4, V5, V6, V7, V8, V9,
    V10, V11, V12, V13, V14, V15, V16, V17, V18, V19,
    V20, V21, V22, V23, V24, V25, V26, V27, V28,
    Amount,
    Class
)
VALUES (
    999999,
    0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0,
    999.99,
    0
);

SELECT COUNT(*) AS total_rows
FROM fraud_detection_results;

select * from first_5000_data;
alter table first_5000_data add column DateTime timestamp;

-- SHOW KEYS FROM first_5000_data
-- WHERE Key_name = 'PRIMARY';

UPDATE first_5000_data
SET `DateTime` = DATE_ADD(
    '2023-01-01 00:00:00',
    INTERVAL `Time` SECOND
)
WHERE `Time` >= 0;

DESCRIBE first_5000_data;

SHOW INDEX FROM first_5000_data;

ALTER TABLE first_5000_data
ADD COLUMN id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

UPDATE first_5000_data
SET `DateTime` = DATE_ADD(
    '2023-01-01 00:00:00',
    INTERVAL `Time` SECOND
)
WHERE id > 0;

UPDATE creditcard
SET DateTime = DATE_ADD(
    '2023-01-01 00:00:00',
    INTERVAL `Time` SECOND
)
WHERE id > 0;

UPDATE fraud_detection_results
SET DateTime = DATE_ADD(
    '2023-01-01 00:00:00',
    INTERVAL `Time` SECOND
)
WHERE id > 0;

UPDATE first_5000_data
SET DateTime = DATE_ADD(
    '2023-01-01 00:00:00',
    INTERVAL (
        FLOOR((id - 1) / 500) * 86400
        + MOD(`Time`, 86400)
    ) SECOND
)
WHERE id > 0;

SELECT id, `Time`, `DateTime`, `Amount`, `Class`
FROM first_5000_data
ORDER BY id
LIMIT 10;

SELECT
    DATE(DateTime) AS TransactionDate,
    COUNT(*) AS TotalTransactions,
    SUM(Class) AS FraudTransactions
FROM first_5000_data
GROUP BY DATE(DateTime)
ORDER BY TransactionDate;