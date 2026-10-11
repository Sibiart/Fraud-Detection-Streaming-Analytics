# Data Validation Report

## 1. Objective
Verify that the fraud detection dataset, Python calculations, MySQL tables and Power BI visuals are consistent.

## 2. Data Quality
- Check total row count.
- Check missing values.
- Check duplicate records.
- Verify the valid values of `Class`.
- Check the data types of important columns.

## 3. Fraud Rule Validation
- Validate the Amount >100 flag.
- Validate the Amount >1000 flag.
- Calculate true positives, false positives, true negatives and false negatives.
- Verify precision and recall.

## 4. Dashboard Validation
- Compare Power BI KPI values with SQL.
- Check chart filters and aggregation settings.
- Verify amount totals and fraud rate.
- Confirm the report refreshes successfully.

## 5. Limitations
- Threshold flags indicate transactions requiring investigation; they do not prove fraud.
- The calendar timestamps in the sample analysis are simulated.
- Streaming results represent simulated batch processing unless a continuous streaming pipeline is implemented.

## 6. Results
Record the actual query outputs, expected values, pass/fail status, and any corrective actions taken.