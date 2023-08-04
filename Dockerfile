# Use the official Python image as the base image
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY python/requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY /home/opc/crc-back-end/python/src/visitor_counter.py /app/visitor_counter.py


# Expose port 8000 for the Flask app
EXPOSE 8000

# Command to run the application
CMD ["python", "/app/visitor_counter.py"]
