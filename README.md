# Fraud Detection & Streaming Analytics

An end-to-end credit card fraud detection and analytics project built using Python, Pandas, MySQL, Machine Learning, and Power BI.

## Project Overview

This project analyzes credit card transactions to identify potentially fraudulent activities. It combines data processing, SQL-based analysis, rule-based fraud detection, simulated batch processing, and machine learning models to support fraud monitoring and decision-making.

## Technologies Used

- **Python:** Data processing and machine learning
- **Pandas & NumPy:** Data manipulation and analysis
- **MySQL:** Transaction storage and SQL-based analysis
- **Scikit-learn:** Machine learning model development and evaluation
- **Power BI:** Interactive dashboards and visualizations
- **Jupyter Notebook:** Development and experimentation

## Project Workflow

1. Loaded and explored credit card transaction data.
2. Processed transaction data using Python and Pandas.
3. Stored transaction records in MySQL.
4. Implemented rule-based fraud detection using transaction amount thresholds.
5. Simulated batch processing to monitor transaction records.
6. Trained Logistic Regression and Random Forest classifiers.
7. Evaluated models using Precision, Recall, F1 Score, Accuracy, ROC-AUC, and PR-AUC.
8. Stored machine learning predictions in a separate MySQL table.
9. Connected MySQL data to Power BI to build interactive dashboards.

## Machine Learning Results

The models were evaluated on a holdout test dataset containing 56,962 transactions, including 98 fraudulent transactions.

| Metric | Logistic Regression | Random Forest |
|---|---:|---:|
| Precision | 6.63% | 90.91% |
| Recall | 91.84% | 81.63% |
| F1 Score | 12.36% | 86.02% |
| Accuracy | 97.76% | 99.95% |
| ROC-AUC | 0.9830 | 0.9621 |
| PR-AUC | 0.7350 | 0.8641 |

Random Forest achieved better precision, F1 Score, and PR-AUC at the selected classification threshold. Logistic Regression achieved higher recall and ROC-AUC.

## Random Forest Prediction Results

| Result | Transactions |
|---|---:|
| Total tested | 56,962 |
| Actual fraud | 98 |
| Predicted fraud | 88 |
| True positives | 80 |
| False positives | 8 |
| False negatives | 18 |
| True negatives | 56,856 |

## Power BI Dashboard

The dashboard includes:
- Transaction and fraud KPIs
- Rule-based fraud analysis
- Simulated batch-processing analysis
- Machine learning prediction distribution
- Random Forest confusion matrix
- Fraud probability analysis
- Model performance comparison

## Project Structure

```text
Fraud-Detection-Streaming-Analytics/
├── Python/
│   ├── fraud_detection.ipynb
│   ├── fraud_detection_model.pkl
│   └── logistic_regression_model.pkl
├── PowerBI/
│   └── Fraud_Detection_Dashboard.pbix
├── SQL/
│   └── database_queries.sql
├── Dataset/
├── README.md
└── .gitignore
```
## Project Evidence & Resources

### Power BI Dashboard
- [View Dashboard Screenshots](./PowerBI/Screenshots/)
- [Download Power BI Dashboard](./PowerBI/Fraud_Detection_Dashboard.pbix)
- [View Interactive Dashboard](ADD_YOUR_PUBLISHED_POWER_BI_LINK_HERE)

### Python & Machine Learning
- [View Python Notebook](./Python/fraud_detection.ipynb)
- [Random Forest Model](./Python/fraud_detection_model.pkl)
- [Logistic Regression Model](./Python/logistic_regression_model.pkl)

### SQL
- [View SQL Queries](./SQL/database_queries.sql)

### Dataset
- [Original Dataset Source](www.kaggle.com)
- 
## Important Note

This project uses a publicly available credit card fraud dataset and simulated batch processing. The predictions represent holdout test-set evaluation, not a live banking fraud detection service.

## Author

**Sibi Manikandan**

GitHub: [Sibiart](https://github.com/Sibiart)
