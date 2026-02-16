#!/bin/bash
# setup_data.sh - Run this FIRST in GitHub Codespaces
# Downloads all large data files and processes them

set -e

echo "=== Transit Equity Dashboard - Data Setup ==="

# Fix devcontainer folder name (Windows hides dot-folders)
if [ -d "devcontainer_config" ] && [ ! -d ".devcontainer" ]; then
    mv devcontainer_config .devcontainer
    echo "[OK] Renamed devcontainer_config to .devcontainer"
fi

# Install Python dependencies
echo "[1/5] Installing Python dependencies..."
pip install -r requirements.txt

# Create directory structure
mkdir -p data/EDM/raw
mkdir -p data/EDM/region/statscan_boundaries
mkdir -p data/EDM/osm
mkdir -p data/EDM/gtfs

# Download Alberta OSM (~200MB)
echo "[2/5] Downloading Alberta OSM data..."
if [ ! -f "data/EDM/osm/edmonton.osm.pbf" ]; then
    wget -q --show-progress -O data/EDM/osm/edmonton.osm.pbf \
        https://download.geofabrik.de/north-america/canada/alberta-latest.osm.pbf
else
    echo "  Already exists, skipping."
fi

# Download Statistics Canada DA Boundaries (~200MB)
echo "[3/5] Downloading Census boundaries..."
if [ ! -f "data/EDM/region/statscan_boundaries/lda_000b21a_e.shp" ]; then
    wget -q --show-progress -O data/EDM/region/lda_000b21a_e.zip \
        https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-le/boundary-limites/files-fichiers/lda_000b21a_e.zip
    unzip -o data/EDM/region/lda_000b21a_e.zip -d data/EDM/region/statscan_boundaries
else
    echo "  Already exists, skipping."
fi

# Download ETS GTFS Feed (~50MB)
echo "[4/5] Downloading Edmonton Transit GTFS..."
if [ ! -f "data/EDM/gtfs/ETS.zip" ]; then
    wget -q --show-progress -O data/EDM/gtfs/ETS.zip \
        https://gtfs.edmonton.ca/TMGTFSRealTimeWebService/GTFS/gtfs.zip
else
    echo "  Already exists, skipping."
fi

# Generate placeholder demographics and process boundaries
echo "[5/5] Processing region data..."
python generate_placeholders.py
python process_region.py

echo ""
echo "=== Setup Complete ==="
echo "Next: Run 'python test_pipeline.py' to test the pipeline."
