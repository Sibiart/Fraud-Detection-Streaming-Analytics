# Data Dictionary — Fraud Detection & Streaming Analytics

This document describes the main columns used by the notebook, MySQL output table, and Power BI report. Confirm the exact columns and data types in your current `fraud_detection_results` table; schemas may differ depending on how the notebook was run.

## Core Transaction Fields

| Column | Meaning | Typical type | Notes |
|---|---|---|---|
| `Time` | Elapsed time value supplied by the original dataset | Numeric | Not a real calendar date or clock time. |
| `V1`–`V28` | Anonymized numerical transaction features | Numeric | Feature meanings are not individually explained in the dataset. |
| `Amount` | Transaction amount | Decimal / numeric | Used by the amount-threshold rules. |
| `Class` | Known target label | Integer | `0` = legitimate transaction; `1` = fraud transaction. |

## Derived Rule Fields

| Column | Meaning | Values / rule |
|---|---|---|
| `rule_flag_100` | Amount-threshold alert for review | `1` when `Amount > 100`; otherwise `0`. |
| `rule_flag` | Higher amount-threshold alert for review | `1` when `Amount > 1000`; otherwise `0`. |

**Interpretation:** A flag means the rule identified a transaction for review. It does not prove that the transaction is fraudulent. The two rules overlap: every transaction above 1,000 is also above 100.

## Optional Derived Fields

The following fields may exist in sample tables or earlier versions of the report. Include them only if they are present in the current data model.

| Field | Meaning | Important note |
|---|---|---|
| `DateTime` | Generated timestamp used for sample time charts | Simulated, if created from elapsed time and an assumed start date; not an actual transaction timestamp. |
| `Hour Bucket` | Grouped elapsed-time interval | If calculated as `FLOOR(Time / 3600, 1)`, it represents elapsed-hour buckets, not clock hours. |
| `rule_flag_1000` | Alternative name sometimes used for the >1,000 rule | Do not assume it exists; the notebook in this project uses `rule_flag` for this rule. |

## Metrics Used in the Report

| Metric | Definition |
|---|---|
| Total Transactions | Count of transaction rows after any active filters. |
| Fraud Transactions | Count of rows with `Class = 1`. |
| Fraud Rate (%) | `Fraud Transactions / Total Transactions × 100`. |
| Total Flagged | Count of rows with the selected rule flag equal to `1`. |
| Flagged Rate (%) | `Total Flagged / Total Transactions Processed × 100`. |
| True Positive (TP) | `Class = 1` and rule flag `= 1`. |
| False Positive (FP) | `Class = 0` and rule flag `= 1`. |
| False Negative (FN) | `Class = 1` and rule flag `= 0`. |
| True Negative (TN) | `Class = 0` and rule flag `= 0`. |
| Precision (%) | `TP / (TP + FP) × 100`, when the denominator is non-zero. |
| Recall (%) | `TP / (TP + FN) × 100`, when the denominator is non-zero. |

## Data Quality Notes

- The raw dataset previously contained 284,807 rows.
- The earlier cleaning run removed 1,081 exact duplicate rows, producing 283,726 rows.
- Previously observed cleaned class counts were 283,253 legitimate transactions and 473 fraud transactions.
- These are historical reference values, not a guarantee of the current MySQL table's contents. Re-run notebook and SQL checks before reporting them.
- If a synthetic test row was inserted into the source table, remove or exclude it carefully before producing final portfolio metrics. Confirm the exact row and uniqueness before deleting anything.
- Do not publish credentials, private connection strings, or restricted data in this documentation.
