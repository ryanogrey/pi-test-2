FROM python:3.9-slim AS builder

# Set working directory
WORKDIR /code

# Install build dependencies (optional, if needed for compilation)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to leverage caching
COPY ./requirements.txt /code/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r /code/requirements.txt

# Final stage
FROM python:3.9-slim

WORKDIR /code

# Copy only the installed dependencies from builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/

# Copy application code
COPY ./app /code/app

# Expose port (optional, for documentation)
EXPOSE 80

# Run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
