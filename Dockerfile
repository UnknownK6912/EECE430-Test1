# Use a lightweight Python base image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first for better caching
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project into /app
COPY . /app/

# Expose Django's default port
EXPOSE 8000

# Run manage.py from its actual location
CMD ["python", "mysite1/manage.py", "runserver", "0.0.0.0:8000"]
