# CACHE_BUST=2025-03-30

# ✅ Use Python slim base image
FROM python:3.10-slim

# ✅ Install system dependencies required for Google Chrome headless
RUN apt-get update && apt-get install -y \
    wget gnupg unzip curl \
    fonts-liberation libappindicator3-1 libasound2 \
    libatk-bridge2.0-0 libatk1.0-0 libcups2 libdbus-1-3 \
    libgdk-pixbuf2.0-0 libnspr4 libnss3 libx11-xcb1 \
    libxcomposite1 libxdamage1 libxrandr2 libgbm1 \
    xdg-utils lsb-release libxshmfence1 --no-install-recommends

# ✅ Install Chrome stable directly via official .deb
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# ✅ Ensure the Chrome binary is executable
RUN chmod +x /usr/bin/google-chrome

# ✅ Set environment variables to inform undetected-chromedriver where Chrome lives
ENV CHROME_PATH="/usr/bin/google-chrome"
ENV PATH="${PATH}:/usr/bin"

# ✅ Set working directory
WORKDIR /app

# ✅ Copy source code
COPY backend/ . 

# ✅ Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# ✅ Expose port
EXPOSE 8000

# ✅ Run Django using Gunicorn
CMD ["gunicorn", "myproj.wsgi:application", "--bind", "0.0.0.0:8000"]
