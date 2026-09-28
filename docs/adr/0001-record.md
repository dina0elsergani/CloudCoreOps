# ADR 1: Run workloads on managed Kubernetes (EKS)

## Status

Accepted

## Context

The service is a single containerised web application that needs multiple
environments, horizontal scaling, and a delivery path that works the same way in
each environment.

## Options considered

**ECS Fargate.** Cheapest to operate and no node management. Rejected because the
delivery tooling this project is built to demonstrate — Kustomize overlays, Argo
CD, Gatekeeper policies, ServiceMonitors — is Kubernetes-native and has no ECS
equivalent.

**Self-managed Kubernetes on EC2.** Full control and no control-plane charge.
Rejected: etcd backups, control-plane upgrades, and certificate rotation are real
operational work, and none of it is what the project sets out to show.

**EKS.** Managed control plane, native IRSA for pod-level IAM, and the whole
Kubernetes ecosystem available.

## Decision

EKS, one cluster, one namespace per environment.

## Consequences

- Roughly $75/month for the control plane before any worker nodes.
- Namespace isolation is weaker than separate clusters; acceptable here, and the
  overlay structure means splitting into per-environment clusters later is a
  change to Argo CD destinations rather than a restructure.
- Cluster version upgrades become recurring maintenance.
