# ADR 3: Enforce Policy-as-Code with OPA/Gatekeeper

## Status
Accepted

## Context
We need to ensure compliance and resource governance in Kubernetes.

## Decision
We will use OPA/Gatekeeper to enforce resource limits and tag policies.

## Consequences
- Prevents non-compliant resources from being deployed.
- Improves security and cost control. 