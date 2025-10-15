FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy everything from your outer 'mysite1' folder
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose Django port
EXPOSE 8000

# Run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

