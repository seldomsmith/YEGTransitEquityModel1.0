#!/bin/bash
# setup_data.sh
# Automation script to re-download necessary large files in GitHub Codespaces

echo "🚀 Setting up Transit Equity Dashboard Data..."

# Create directories
mkdir -p data/EDM/raw
mkdir -p data/EDM/region/statscan_boundaries
mkdir -p data/EDM/osm
mkdir -p data/EDM/gtfs

# 1. Download Alberta OSM (Large File ~200MB)
echo "Downloading Alberta OSM Data..."
if [ ! -f "data/EDM/osm/edmonton.osm.pbf" ]; then
    wget -O data/EDM/osm/edmonton.osm.pbf https://download.geofabrik.de/north-america/canada/alberta-latest.osm.pbf
    echo "✅ OSM Download Complete"
else
    echo "✅ OSM file already exists"
fi

# 2. Download Statistics Canada Boundaries (Large File ~200MB)
echo "Downloading Census Boundaries..."
if [ ! -f "data/EDM/region/lda_000b21a_e.zip" ]; then
    wget -O data/EDM/region/lda_000b21a_e.zip https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-le/boundary-limites/files-fichiers/lda_000b21a_e.zip
    # Unzip specifically the shapefile parts
    unzip -o data/EDM/region/lda_000b21a_e.zip -d data/EDM/region/statscan_boundaries
    echo "✅ Boundary Download Complete"
else
    echo "✅ Boundary file already exists"
fi

# 3. Create Placeholder Demographics (Small Script)
echo "Generating Placeholder Demographics..."
python generate_placeholders.py

# 4. Process Region Files (Heavy Lifting)
echo "Processing Region Boundaries..."
python process_region.py

echo "🎉 Data Setup Complete! You are ready to run: python test_pipeline.py"
