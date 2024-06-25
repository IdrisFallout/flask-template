# Define build argument for Python version
ARG PYTHON_VERSION=3.9

# Use the build argument in the FROM instruction
FROM python:${PYTHON_VERSION}-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Gunicorn
RUN pip install gunicorn

# Copy requirements
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application
COPY . /app

# Expose port 80
EXPOSE 80

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:80", "wsgi:app"]
