# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

# Install system dependencies (Java, GDAL, Wget, Unzip)
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    libgdal-dev \
    g++ \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run the data setup script automatically during build or start
# (Note: For a real production app, we'd run this once and save to Cloud Storage)
RUN chmod +x setup_data.sh

# The command to run when the container starts
# For now, it just runs the test pipeline
CMD ["bash", "-c", "./setup_data.sh && python3 test_pipeline.py"]
