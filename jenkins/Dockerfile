FROM jenkins/jenkins:lts-jdk17

USER root

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    docker.io \
    python3 \
    python3-pip \
    python3-venv \
    awscli \
    kubectl \
    trivy \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Add jenkins user to docker group
RUN usermod -aG docker jenkins

# Switch back to jenkins user
USER jenkins

# Copy plugins file
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copy Jenkins configuration
COPY jenkins.yaml /usr/share/jenkins/ref/jenkins.yaml

# Set environment variables
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG="/usr/share/jenkins/ref/jenkins.yaml" 