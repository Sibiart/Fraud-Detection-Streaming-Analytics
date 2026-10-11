# Dashboard Guide — Fraud Detection & Streaming Analytics

This guide explains the four pages of the Power BI report and how to interpret their key metrics.

## Data Source

- **Source database:** MySQL
- **Source table:** `fraud_detection_results`
- **Report file:** `Fraud_Detection_Dashboard.pbix`
- **Refresh mode:** If the report uses Import mode, select **Home → Refresh** in Power BI Desktop to load the latest database values.

Check that the report is connected to the intended MySQL database and table before presenting results.

## Page 1 — Fraud Overview

**Purpose:** Provide a high-level view of transaction volume, fraud prevalence, and flagged activity.

Suggested visuals and interpretation:

- **Total Transactions:** Number of rows in the processed table.
- **Fraud Transactions:** Count of rows where `Class = 1`.
- **Fraud Rate:** Fraud transactions divided by total transactions, expressed as a percentage.
- **Flagged Transactions (>100):** Count of rows where `rule_flag_100 = 1`.
- **Total Amount:** Sum of the `Amount` column, if that is how the card is configured.
- **Class Distribution:** Compare legitimate (`Class = 0`) and fraud (`Class = 1`) transaction counts.
- **Threshold comparison:** Compare how many transactions each amount rule flags.

**Interpretation:** Fraud is a small minority class in this dataset. Always show the denominator or transaction count near a percentage so viewers understand the scale.

## Page 2 — Rule Analysis

**Purpose:** Explain how the amount-based rules behave against the known `Class` labels.

Rules:

- `rule_flag_100 = 1` when `Amount > 100`.
- `rule_flag = 1` when `Amount > 1000`.

Key metrics:

- **True Positive (TP):** Fraud transaction flagged by the rule.
- **False Positive (FP):** Legitimate transaction flagged by the rule.
- **False Negative (FN):** Fraud transaction not flagged by the rule.
- **True Negative (TN):** Legitimate transaction not flagged by the rule.
- **Precision:** `TP / (TP + FP)`. Of the flagged transactions, the proportion that are fraud.
- **Recall:** `TP / (TP + FN)`. Of the known fraud transactions, the proportion the rule flags.

**Interpretation:** A lower amount threshold can catch more fraud cases but may flag many legitimate transactions. A flagged transaction should be reviewed; it is not confirmed fraud. Confirm the report's measures match the validation SQL and notebook output.

## Page 3 — Transaction & Time Analysis

**Purpose:** Explore amount patterns by class and any time-based charts included in the report.

- **Average Transaction Amount by Class:** Compare the average `Amount` for legitimate and fraud-labelled rows.
- **Time or hour-bucket charts:** The source `Time` field is elapsed time, not a real-world clock time.
- **Simulated date charts:** If the report uses a generated `DateTime` column for a sample table, those dates are simulated and must not be interpreted as actual transaction timestamps.

**Required disclosure for simulated dates:**

> **Data Note:** The `DateTime` values in this sample are simulated from elapsed transaction time using an assumed start date of January 1, 2023. They do not represent actual transaction timestamps. Time-based trends are for demonstration and analytical practice only.

Only keep the disclosure wording if it matches the actual transformation used in your report. If the assumed start date or transformation differs, update the note.

## Page 4 — Simulated Streaming Monitoring

**Purpose:** Demonstrate batch-processing monitoring metrics over stored data.

Suggested visuals:

- **Total Transactions Processed:** Number of rows processed by the simulation.
- **Total Flagged:** Number flagged by the selected rule.
- **Flagged Rate:** Flagged transactions divided by processed transactions.
- **Flagged vs Not Flagged:** Compare counts for the selected rule.
- **Flagged Transaction Details:** A table for reviewing rows that meet the selected rule.

**Important:** This page represents simulated batch processing, not a live payment stream. Label it **“Simulated Streaming Monitoring”** unless a real streaming source has been implemented.

If a chart compares both rules, remember that the rule groups overlap: a transaction with `Amount > 1000` also meets `Amount > 100`. Do not add the two flag totals together as though they represent distinct transactions.

## Refresh and Validation Procedure

1. Confirm MySQL is running and the `fraud_detection_results` table is correct.
2. Run the SQL validation queries in the project's `sql/` folder.
3. Open the `.pbix` file in Power BI Desktop.
4. Select **Home → Refresh**.
5. Check that the transaction count, fraud count, fraud rate, and rule-flag totals agree with SQL.
6. Verify precision, recall, and confusion-matrix metrics against the notebook.
7. Check slicers and filters; visual totals may change when filters are applied.
8. Save the report after changes.

## Known Limitations

- Amount thresholds are simple baseline rules, not a production fraud model.
- Many flagged transactions may be legitimate (false positives).
- Fraud detection metrics depend on the selected dataset and any filters applied.
- Power BI Import mode does not update continuously; it must be refreshed.
- Simulated timestamps and batch processing must be clearly disclosed.
