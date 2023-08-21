# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Download Oracle Instant Client from Oracle's website
RUN dnf install -y wget unzip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/2111000/instantclient-basic-linux.x64-21.11.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-21.11.0.0.0dbru.zip -d /app && \
    rm instantclient-basic-linux.x64-21.11.0.0.0dbru.zip && \
    dnf remove -y wget unzip && \
    dnf clean all

# Set environment variables for Oracle Instant Client
ENV LD_LIBRARY_PATH=/app/instantclient_21_11
ENV PATH=/app/instantclient_21_11:$PATH

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
