# Jenkins CI/CD Setup for CloudCoreOps

This directory contains the Jenkins configuration for the CloudCoreOps project, providing an alternative CI/CD pipeline to GitHub Actions.

## 🏗️ Architecture

- **Jenkinsfile**: Main pipeline definition with stages for testing, building, and deployment
- **Dockerfile**: Custom Jenkins image with all necessary tools
- **docker-compose.yml**: Easy deployment and management
- **jenkins.yaml**: Configuration as Code (CaC) setup
- **plugins.txt**: Required Jenkins plugins

## 🚀 Quick Start

### Prerequisites

1. Docker and Docker Compose installed
2. AWS credentials configured
3. DockerHub credentials (optional, for pushing images)

### Environment Variables

Create a `.env` file in the `jenkins/` directory:

```bash
# DockerHub credentials (optional)
DOCKERHUB_USERNAME=your-dockerhub-username
DOCKERHUB_PASSWORD=your-dockerhub-token

# AWS credentials
AWS_ACCESS_KEY_ID=your-aws-access-key
AWS_SECRET_ACCESS_KEY=your-aws-secret-key

# Jenkins admin password
JENKINS_ADMIN_PASSWORD=your-secure-password
```

### Deployment

1. **Build and start Jenkins:**
   ```bash
   cd jenkins
   docker-compose up -d --build
   ```

2. **Access Jenkins:**
   - URL: http://localhost:8080
   - Username: `admin`
   - Password: `admin123` (or your custom password)

3. **Initial Setup:**
   - Jenkins will automatically install plugins
   - Credentials will be configured from environment variables
   - The `cloudcoreops-pipeline` job will be created automatically

## 🔧 Pipeline Stages

The Jenkins pipeline includes the following stages:

1. **Checkout**: Clone the repository
2. **Setup Python**: Create virtual environment and install dependencies
3. **Run Tests**: Execute pytest with coverage
4. **Code Quality**: Run flake8 linting
5. **Build Docker Image**: Build and push Docker image
6. **Security Scan**: Run Trivy vulnerability scan
7. **Deploy to EKS**: Deploy to Kubernetes cluster
8. **Health Check**: Verify deployment health

## 🔐 Security Features

- **Credentials Management**: Secure storage of DockerHub and AWS credentials
- **Role-based Access**: Configurable user permissions
- **Security Scanning**: Integrated Trivy vulnerability scanning
- **Audit Logging**: Complete pipeline execution logs

## 📊 Monitoring and Notifications

- **Email Notifications**: Automatic email alerts on success/failure
- **Test Results**: JUnit test result publishing
- **Security Reports**: Trivy scan results integration
- **Build History**: Complete build and deployment history

## 🛠️ Customization

### Adding New Stages

Edit the `Jenkinsfile` to add new pipeline stages:

```groovy
stage('New Stage') {
    steps {
        sh 'echo "Your custom step here"'
    }
}
```

### Modifying Credentials

Update the `jenkins.yaml` file to add new credentials:

```yaml
credentials:
  system:
    domainCredentials:
      - credentials:
          - usernamePassword:
              scope: GLOBAL
              id: "new-credentials"
              username: "${NEW_USERNAME}"
              password: "${NEW_PASSWORD}"
```

## 🔄 Integration with Existing Workflow

This Jenkins setup complements your existing GitHub Actions workflow:

- **GitHub Actions**: Primary CI/CD for GitHub integration
- **Jenkins**: Alternative CI/CD for on-premise or custom deployments
- **Shared Resources**: Both use the same Docker images and Kubernetes manifests

## 🐛 Troubleshooting

### Common Issues

1. **Docker Permission Denied:**
   ```bash
   sudo usermod -aG docker $USER
   ```

2. **AWS Credentials Not Working:**
   - Verify AWS credentials in environment variables
   - Check IAM permissions for EKS access

3. **Jenkins Not Starting:**
   ```bash
   docker-compose logs jenkins
   ```

### Logs

View Jenkins logs:
```bash
docker-compose logs -f jenkins
```

## 📈 Scaling

For production use, consider:

1. **Persistent Storage**: Use AWS EBS or similar for Jenkins home
2. **Load Balancing**: Multiple Jenkins instances behind a load balancer
3. **Monitoring**: Integrate with Prometheus/Grafana
4. **Backup**: Regular backups of Jenkins configuration and data

## 📝 License

This Jenkins setup is part of the CloudCoreOps project and follows the same MIT license. 