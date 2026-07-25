# Mutual Fund Analytics - Data Dictionary

This document details the core schema structure implemented in the SQLite Database (`bluestock_mf.db`) for the Capstone Project.

## 1. dim_fund (Dimension Table)
| Column Name | Data Type | Description |
|---|---|---|
| amfi_code | TEXT (PK) | Unique AMFI India code for the Mutual Fund scheme |
| fund_house | TEXT | Name of the Asset Management Company (AMC) |
| scheme_name | TEXT | The full name of the Mutual Fund scheme |
| category | TEXT | Broad Asset Class (Equity, Debt, Hybrid) |
| expense_ratio_pct | REAL | Annual operating expenses charged by the fund (%) |
| fund_manager | TEXT | Primary portfolio manager for the fund |

## 2. fact_nav (Fact Table)
| Column Name | Data Type | Description |
|---|---|---|
| amfi_code | TEXT (FK) | Reference code linking to `dim_fund` |
| date | TEXT | Daily timestamp of the NAV declaration |
| nav | REAL | Net Asset Value per unit on that specific date |

## 3. fact_transactions (Fact Table)
| Column Name | Data Type | Description |
|---|---|---|
| investor_id | TEXT | Unique identifier for the simulated retail investor |
| transaction_date| TEXT | Date when the order was successfully completed |
| transaction_type| TEXT | Type of order: SIP, LUMPSUM, or REDEMPTION |
| amount_inr | REAL | Total financial value of the transaction in Rupees |
| state | TEXT | Indian state location of the investor |
| kyc_status | TEXT | Investor verification status (VERIFIED/PENDING) |

## 4. fact_performance (Fact Table)
| Column Name | Data Type | Description |
|---|---|---|
| amfi_code | TEXT (PK/FK)| Unique scheme reference code |
| return_3yr | REAL | Annualised historical return over 3 Years (%) |
| return_5yr | REAL | Annualised historical return over 5 Years (%) |
| sharpe_ratio | REAL | Measure of risk-adjusted return performance |
| is_negative_sharpe| INTEGER | Boolean Flag (1 if Sharpe Ratio < 0, else 0) |