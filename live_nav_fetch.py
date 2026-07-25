import requests
import pandas as pd
import os

schemes = {
    "125497": "HDFC_Top_100",
    "119551": "SBI_Bluechip",
    "120503": "ICICI_Bluechip",
    "118632": "Nippon_Large_Cap",
    "119092": "Axis_Bluechip",
    "120841": "Kotak_Bluechip"
}

output_dir = "data/raw"
os.makedirs(output_dir, exist_ok=True)

for code, name in schemes.items():
    url = f"https://api.mfapi.in/mf/{code}"
    print(f"Fetching data for {name} (Code: {code})...")

    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        nav_list = data['data']
        df = pd.DataFrame(nav_list)

        file_path = os.path.join(output_dir, f"{code}_{name}_raw.csv")
        df.to_csv(file_path, index=False)
        print(f"Saved successfully to {file_path}")
    else:
        print(f"Failed to fetch data for {name}")