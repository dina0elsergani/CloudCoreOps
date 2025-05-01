# CloudCoreOps: DevOps Portfolio Project

## About Me

Hi! I'm Dina Elsergani, a DevOps engineer passionate about automation, cloud-native infrastructure, and SRE best practices. This project is my hands-on showcase for employers—built, tested, and documented entirely by me.

- LinkedIn: [linkedin.com/in/dina0elsergani](https://linkedin.com/in/dina0elsergani)
- Email: dina0elsergani@gmail.com

## Why This Project?

I wanted to prove my ability to design, build, and operate a production-grade cloud platform from scratch. Every feature here—from GitOps to chaos engineering—was chosen to demonstrate job-ready skills. I built this project iteratively, learning from each failed deploy and CI error. See the commit history for my troubleshooting and improvements!

[![CI](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/github-actions.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)
[![Trivy](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/trivy.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)
[![TFLint](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/tflint.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)
[![Checkov](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/checkov.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)
[![Infracost](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/infracost.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)
[![Coverage](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/coverage.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions)

---

## Advanced Features
- Multi-environment IaC & Kustomize overlays (dev/staging/prod)
- GitOps with Argo CD (auto branch-based deploys)
- Terratest, TFLint, Checkov, Trivy, Infracost in CI
- OPA/Gatekeeper & Sentinel policies for compliance
- SLOs, Prometheus, Jaeger tracing, Alertmanager
- Vault CSI driver for secrets, least-privilege IAM
- Canary/Blue-Green with Argo Rollouts
- Feature flags (Unleash)
- Chaos engineering (LitmusChaos)
- Automated RDS backups & DR playbook
- MkDocs site & ADRs for architecture decisions
- Horizontal Pod Autoscaler (HPA) for auto-scaling microservices
- Ansible role for reusable, multi-environment app deployments
- Jenkins CI/CD pipeline with Docker and Kubernetes integration

---

## Overview
Deploy a containerized microservice to a managed Kubernetes cluster in AWS using Terraform, Docker, Kubernetes, CI/CD, and monitoring.

## Tech Stack
- Terraform (IaC)
- Docker
- Kubernetes (EKS)
- GitHub Actions (CI/CD)
- Jenkins (Alternative CI/CD)
- Prometheus & Grafana (Monitoring)
- AWS KMS (Secrets)
- Python (Flask)

## Folder Structure
```
CloudCoreOps/
│
├── app/                # Microservice source code (Python Flask)
├── infra/              # Terraform IaC for AWS resources
├── k8s/                # Kubernetes manifests (Kustomize)
├── ci/                 # CI/CD pipeline definitions (GitHub Actions)
├── jenkins/            # Jenkins CI/CD configuration
├── monitoring/         # Prometheus, Grafana, alerting configs
├── scripts/            # Helper scripts (setup, teardown, etc.)
├── docs/               # Documentation and ADRs
├── README.md           # Full documentation
└── .gitignore
```

## Prerequisites
- AWS CLI configured
- Terraform
- kubectl
- Docker
- Python 3.11+

## Setup

### 1. Provision Infrastructure
```sh
cd infra/
terraform init
terraform apply
```

### 2. Build & Push Docker Image
```sh
cd app/
docker build -t dina0elsergani/cloudcoreops:latest .
docker push dina0elsergani/cloudcoreops:latest
```

### 3. Deploy to Kubernetes
```sh
cd k8s/
kubectl apply -k base/
```

### 4. Set Up Monitoring
```sh
# Deploy Prometheus and Grafana using Helm or manifests in monitoring/
```

### 5. Access the App
- Find the LoadBalancer/Ingress endpoint via `kubectl get ingress` or AWS console.

## CI/CD Pipeline
- Automated via GitHub Actions: build → test → Dockerize → deploy → monitor.
- See `ci/github-actions.yml` for details.

## Security
- Secrets managed via AWS KMS or Vault (see k8s/base/secret.yaml for placeholder).
- IAM roles and service accounts follow least-privilege principle.

## Teardown
```sh
cd infra/
terraform destroy
```

## Diagrams

### Architecture
```
[User] -> [AWS ALB/Ingress] -> [EKS Cluster] -> [Flask App Pod]
                                 |-> [RDS]
                                 |-> [Prometheus/Grafana]
                                 |-> [AWS KMS]
```

### CI/CD Flow
```
[GitHub Push] -> [GitHub Actions: Build/Test] -> [Docker Build/Push] -> [Deploy to EKS] -> [Monitor]
```

## Getting Started

This project is configured for local testing using `localhost` as the domain in all relevant configs and tests. For production or cloud deployment, replace `localhost` with your real domain or public IP in the following files:

- `k8s/base/ingress-tls.yaml`
- `k6/loadtest.js`
- `monitoring/uptime/uptime-check.sh`
- `cypress/e2e/health.spec.js`

For Let's Encrypt TLS, also update your real email in `k8s/base/cert-manager.yaml`.

**Never commit real secrets or webhooks.** Use environment variables or secret managers for sensitive data.

## License
MIT