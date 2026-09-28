# CloudCoreOps

[![CI](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/ci.yml/badge.svg)](https://github.com/dina0elsergani/CloudCoreOps/actions/workflows/ci.yml)

A reference implementation of a containerised service on AWS EKS, wired end to end:
Terraform for infrastructure, Kustomize overlays per environment, Argo CD for GitOps
delivery, and Prometheus for metrics.

It is built to be forked. Nothing in `k8s/base/` hardcodes a registry or an account,
CI runs green with no configured secrets, and container images publish to the fork
owner's own GitHub Container Registry namespace.

## Architecture

```
                      ┌───────────────────────────────┐
   git push ─────────▶│  GitHub Actions (CI)          │
                      │  test · kustomize · scan      │
                      │  build image ──▶ ghcr.io      │
                      └───────────────┬───────────────┘
                                      │ image tag
                                      ▼
   git commit ──▶ Argo CD ──▶ ┌──────────────────────┐
                              │  EKS cluster         │
   ALB / Ingress ────────────▶│  Flask app (HPA 2-10)│──▶ RDS PostgreSQL
                              │  ServiceMonitor      │──▶ Prometheus
                              └──────────────────────┘
```

## Layout

| Path | Contents |
|------|----------|
| `app/` | Flask service, Dockerfile, tests |
| `infra/` | Terraform (VPC, EKS, RDS), Ansible roles, policy samples |
| `k8s/base/` | Base manifests — no registry or environment baked in |
| `k8s/overlays/` | `dev`, `staging`, `prod` — namespace, replicas, image tag, TLS |
| `gitops/argo-cd/` | One Argo CD `Application` per environment |
| `monitoring/` | Prometheus SLOs, Grafana dashboard, alert rules |
| `jenkins/` | Equivalent pipeline for a Jenkins-based setup |
| `.github/workflows/` | `ci.yml` (automatic) and `deploy.yml` (manual) |

## Quick start

Run the service and its tests locally:

```sh
cd app
pip install -r requirements-dev.txt
pytest                      # 5 tests
python app.py               # http://localhost:5000
```

Endpoints: `/` · `/health` · `/api/info` · `/api/features` · `/metrics`

Render any environment without a cluster:

```sh
kustomize build k8s/overlays/dev
```

## Deploying

Provision infrastructure, then apply an overlay:

```sh
cd infra
terraform init
terraform apply             # requires AWS credentials

kubectl apply -k k8s/overlays/dev
```

Images are published by CI to `ghcr.io/<owner>/cloudcoreops`. To point an overlay
somewhere else, edit its `images:` block — base manifests stay untouched.

For GitOps, apply the Argo CD `Application` for the environment:

```sh
kubectl apply -f gitops/argo-cd/app-dev.yaml
```

## CI

`ci.yml` runs on every push and pull request and needs **no repository secrets**:

| Job | Checks |
|-----|--------|
| `test` | pytest with coverage, fails under 80% |
| `manifests` | every overlay renders; every Argo CD `path:` exists on disk |
| `security` | Trivy filesystem scan, Checkov IaC scan |
| `terraform` | `fmt -check`, TFLint |
| `image` | builds the container; pushes to GHCR only on `main` |

Pull requests build the image but never push, so forks need no credentials.

`deploy.yml` is `workflow_dispatch` only. It assumes an AWS role via OIDC rather
than storing long-lived keys, and fails fast with a readable message if the
environment's secrets are not configured.

## Scope and status

Honest accounting, because "it's in the repo" and "it's production-ready" are
different claims.

**Working and verified**

- Flask service with health, info, feature-flag and Prometheus `/metrics` endpoints
- Container image: non-root (UID 10001), gunicorn, `HEALTHCHECK`
- Every Terraform directory passes `validate` against a pinned AWS provider
  (`~> 5.60`), including the local modules -- CI checks each one, because a root
  module cannot validate code nothing calls
- All three Kustomize overlays render; CI enforces that they keep rendering and
  that every Argo CD `path:` resolves
- Deployment sets resource requests (without which the HPA cannot scale),
  liveness and readiness probes, and a hardened `securityContext`
- Prometheus rules and the Grafana dashboard query the metric names the exporter
  actually emits (`flask_http_request_*`)

**Reference material, not battle-tested**

Written and internally consistent, but never run against a live cluster:

- Argo Rollouts canary spec (`k8s/base/rollout.yaml`)
- Vault CSI `SecretProviderClass` (`k8s/base/secret-provider.yaml`)
- Jaeger sidecar (`monitoring/tracing/`)
- OPA/Gatekeeper constraint (`infra/policies/opa/`)
- LitmusChaos experiment (`scripts/chaos/`)
- Cross-region replica and Route 53 failover (`infra/cross-region/`)
- Terratest for the root module (`infra/tests/terratest/`) -- it applies real
  infrastructure, so it is deliberately outside CI

**Not implemented**

- Feature flags are a small in-process implementation (`app/feature_flags/`),
  not a managed service
- No cost analysis in CI
- `cert-manager.yaml` needs a real email address before it will issue certificates

## Secrets

No secrets are committed. `k8s/base/secret.example.yaml` is a template and is
deliberately excluded from every kustomization; real values belong in the Vault
CSI provider or your cloud's secret manager.

## License

MIT — see [LICENSE](LICENSE).
