# ADR 3: Scan in CI, admit policy in the cluster

## Status

Accepted

## Context

Misconfigurations should be caught before they reach a cluster, and blocked if
they somehow arrive anyway.

## Options considered

**CI scanning only** (Checkov, Trivy, TFLint). Fast feedback on pull requests and
no runtime component. On its own it is advisory — anything applied directly to the
cluster bypasses it entirely.

**Admission control only** (Gatekeeper). Genuinely enforcing, because nothing
reaches the API server without passing. On its own, feedback arrives at deploy
time rather than review time.

**Both.** CI catches problems while they are cheap to fix; admission control
enforces the rules that actually matter.

## Decision

Both, with different severities. CI scanning is advisory — Checkov runs with
`soft_fail` so new rules in an upstream release cannot block unrelated work, while
Trivy fails the build on fixed CRITICAL and HIGH vulnerabilities, which are
actionable by definition. Gatekeeper constraints enforce at admission.

## Consequences

- Two policy definitions to maintain, in different languages.
- `soft_fail` on Checkov means its findings need someone to actually read them;
  they will not stop a merge.
- Gatekeeper constraints are written but not proven against a live cluster. They
  are listed as reference material in the README rather than as a working control.
