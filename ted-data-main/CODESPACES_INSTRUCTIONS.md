# Edmonton Transit Equity Dashboard - GitHub Codespaces Instructions

You are ready to run this project in the cloud!

## 1. Upload to GitHub

Upload all files in this directory to your GitHub repository.
**Note:** Do NOT upload the large `data/` files (OSM, Shapefiles). The `.gitignore` file will handle this for you.

## 2. Launch Codespace

1. Go to your repository on GitHub.
2. Click the green **Code** button.
3. Select the **Codespaces** tab.
4. Click **Create codespace on main**.

Wait ~2-3 minutes for the environment to build. It will automatically install:

- Python 3.11
- Java 21 (OpenJDK)
- All required libraries (geopandas, r5py, etc.)

## 3. Run the Setup & Test

Once the Codespace opens, open the terminal (Ctrl+`) and run:

```bash
# 1. Download the large data files (OSM, Census Boundaries) automatically
./setup_data.sh

# 2. Run the pipeline test logic
python test_pipeline.py
```

If you see `OK - Transport network built successfully!`, you are ready to start building the full dashboard!
