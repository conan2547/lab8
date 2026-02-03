FROM jenkins/jenkins:lts

USER root

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-full \
    python3-pip \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Install Robot Framework and SeleniumLibrary
# Using --break-system-packages as we are in a container and want these globally available
RUN pip3 install --no-cache-dir --break-system-packages \
    robotframework \
    robotframework-seleniumlibrary

# Verify installations
# Verification skipped during build

USER jenkins
