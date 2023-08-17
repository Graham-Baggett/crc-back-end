# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY python/requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY python/src/visitor_counter.py .

# Expose port 8080 for the Flask app inside the container
EXPOSE 8080

# Save SSL certificate and key from build arguments to files
RUN echo "$SSL_CERT_FILE" > /app/ssl_cert.pem
RUN echo "$SSL_KEY_FILE" > /app/ssl_key.pem

# Command to run the application
CMD ["python", "visitor_counter.py"]
