"""Quick script to inspect the Statistics Canada boundary file"""
import geopandas as gpd

# Read the shapefile
print("Reading shapefile...")
gdf = gpd.read_file('data/EDM/region/statscan_boundaries/lda_000b21a_e.shp')

print(f"\nTotal DAs in file: {len(gdf)}")
print(f"\nColumns available: {list(gdf.columns)}")
print(f"\nFirst 3 rows:")
print(gdf.head(3))

# Filter to Alberta (PRUID = 48)
print("\n" + "="*60)
print("Filtering to Alberta...")
alberta = gdf[gdf['PRUID'] == '48'].copy()
print(f"Alberta DAs: {len(alberta)}")

# Check for Edmonton (CMA code or CSD)
print("\n" + "="*60)
print("Checking for Edmonton identifiers...")
print(f"Unique CMAUID values in Alberta: {alberta['CMAUID'].unique()[:10]}")
print(f"Unique CSDUID values in Alberta: {alberta['CSDUID'].unique()[:10]}")
