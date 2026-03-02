# ── Dockerfile for FastAPI on EC2 ─────────────────────────────────────────────

# Use official Python 3.12 slim image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies for building Python packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install FastAPI and Uvicorn
RUN pip install --upgrade pip
RUN pip install fastapi uvicorn[standard]

# Copy your FastAPI app
COPY main.py .

# Expose port
EXPOSE 8000

# Start the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
