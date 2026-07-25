-- ========================================================
-- BLUESTOCK MUTUAL FUND ANALYTICS - 10 SQL ANALYTICS QUERIES
-- ========================================================

-- Query 1: Top 5 Funds by Highest Return in 3 Years
SELECT scheme_name, fund_house, category, return_3yr
FROM dim_fund f
JOIN fact_performance p ON f.amfi_code = p.amfi_code
WHERE return_3yr IS NOT NULL
ORDER BY return_3yr DESC
LIMIT 5;

-- Query 2: Average NAV per Month for a Specific Fund (e.g., Code '125497')
SELECT strftime('%Y-%m', date) AS month, AVG(nav) as avg_nav
FROM fact_nav
WHERE amfi_code = '125497'
GROUP BY month
ORDER BY month;

-- Query 3: Total Transaction Inflow (SIP + Lumpsum) vs Outflow (Redemption)
SELECT transaction_type, SUM(amount_inr) as total_volume, COUNT(*) as total_transactions
FROM fact_transactions
GROUP BY transaction_type;

-- Query 4: Top 5 States by Total Investment Amount
SELECT state, SUM(amount_inr) as total_invested
FROM fact_transactions
WHERE transaction_type IN ('SIP', 'LUMPSUM')
GROUP BY state
ORDER BY total_invested DESC
LIMIT 5;

-- Query 5: Funds with Low Expense Ratio (< 1%) and Positive 5Yr Returns
SELECT f.scheme_name, f.fund_house, f.expense_ratio_pct, p.return_5yr
FROM dim_fund f
JOIN fact_performance p ON f.amfi_code = p.amfi_code
WHERE f.expense_ratio_pct < 1.0 AND p.return_5yr > 0
ORDER BY p.return_5yr DESC;

-- Query 6: Number of Transactions and Total Amount by Gender
SELECT gender, COUNT(*) as tx_count, SUM(amount_inr) as total_amount
FROM fact_transactions
GROUP BY gender;

-- Query 7: Identify Schemes with Negative Sharpe Ratios (High Risk / Low Return)
SELECT f.scheme_name, f.fund_house, p.sharpe_ratio
FROM dim_fund f
JOIN fact_performance p ON f.amfi_code = p.amfi_code
WHERE p.is_negative_sharpe = 1;

-- Query 8: Industry SIP Inflow Growth Trends Over Time
SELECT month, sip_inflow_crore, sip_accounts_crore
FROM fact_sip_industry
ORDER BY month DESC
LIMIT 12;

-- Query 9: Total Holdings Weightage by Sector (Asset Allocation)
SELECT sector, SUM(weight_pct) as total_sector_weight
FROM fact_portfolio
GROUP BY sector
ORDER BY total_sector_weight DESC;

-- Query 10: Count of Funds Managed by Each Fund Manager
SELECT fund_manager, COUNT(*) as total_funds_managed
FROM dim_fund
WHERE fund_manager IS NOT NULL
GROUP BY fund_manager
ORDER BY total_funds_managed DESC
LIMIT 5;