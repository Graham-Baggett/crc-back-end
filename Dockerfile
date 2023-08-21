# Use the official Oracle Linux 8 image as the base image
FROM ghcr.io/oracle/oraclelinux8-instantclient:21

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

# Command to run the application
CMD ["python", "visitor_counter.py"]
