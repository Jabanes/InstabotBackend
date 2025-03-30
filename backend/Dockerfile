
# CACHE_BUST=2025-03-30
# Use a Python base image
FROM python:3.10-slim

# Install required dependencies for Chrome
RUN apt-get update && apt-get install -y \
    wget gnupg unzip curl ca-certificates fonts-liberation libappindicator3-1 \
    libasound2 libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
    libgdk-pixbuf2.0-0 libnspr4 libnss3 libx11-xcb1 libxcomposite1 \
    libxdamage1 libxrandr2 xdg-utils --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome manually via .deb file
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Set environment variables
ENV CHROME_PATH="/usr/bin/google-chrome"
ENV PATH="${PATH}:/usr/bin"

# Create working directory
WORKDIR /app

# Copy source code
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose port for Django
EXPOSE 8000

# Run your Django app (or gunicorn if needed)
CMD ["gunicorn", "myproj.wsgi:application", "--bind", "0.0.0.0:8000"]
