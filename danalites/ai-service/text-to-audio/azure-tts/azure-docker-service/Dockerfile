FROM python:3.8-slim-buster

# Set up working directory
WORKDIR /app

# Install dependencies
RUN pip install azure-cognitiveservices-speech flask gunicorn

# Copy source code into the container
COPY app.py .

# Expose port 5000
EXPOSE 5000

# Set entrypoint command
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]