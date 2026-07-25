import pandas as pd
import os

datasets = [
    "01_fund_master.csv", "02_nav_history.csv", "03_aum_by_fund_house.csv",
    "04_monthly_sip_inflows.csv", "05_category_inflows.csv", "06_industry_folio_count.csv",
    "07_scheme_performance.csv", "08_investor_transactions.csv", "09_portfolio_holdings.csv",
    "10_benchmark_indices.csv"
]

raw_data_path = "data/raw/"

for dataset in datasets:
    file_path = os.path.join(raw_data_path, dataset)
    if os.path.exists(file_path):
        print(f"\n{"="*40}\nLoading: {dataset}\n{"="*40}")
        df = pd.read_csv(file_path)

        print(f"Shape: {df.shape}")
        print("\nData Types:")
        print(df.dtypes)
        print("\nFirst 5 Rows:")
        print(df.head())
    else:
        print(f"Warning: {dataset} not found in {raw_data_path}")