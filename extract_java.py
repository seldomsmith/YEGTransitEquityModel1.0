import zipfile
import os

zip_path = "java_jdk.zip"
extract_path = "java_portable"

print(f"Extracting {zip_path} to {extract_path}...")

if not os.path.exists(extract_path):
    os.makedirs(extract_path)

try:
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(extract_path)
    print("✅ Extraction successful!")
except Exception as e:
    print(f"❌ Extraction failed: {e}")
