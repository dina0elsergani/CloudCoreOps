# ADR 2: Deploy through Argo CD rather than from CI

## Status

Accepted

## Context

CI builds and publishes an image. Something has to get that image into the
cluster.

## Options considered

**Push-based deploys from CI** (`kubectl apply` in the pipeline). Simple and
obvious. Rejected as the default: it needs long-lived cluster credentials in the
CI provider, and cluster state drifts silently whenever someone applies something
by hand.

**Helm releases driven by CI.** Better templating than Kustomize for widely
redistributed charts, but adds a release-state layer and still leaves CI holding
cluster credentials.

**Argo CD pulling from git.** The cluster reconciles itself toward the repository.
No cluster credentials in CI, drift is corrected automatically, and the deployed
state of any environment is a git ref.

## Decision

Argo CD, one `Application` per environment, each tracking its overlay directory.
`deploy.yml` remains for manual `kubectl apply` when a cluster has no Argo CD.

## Consequences

- Argo CD itself must be installed and kept running — a new operational dependency.
- Rollback is `git revert`, which means recovery is as fast as the sync interval,
  not instant.
- Because Argo CD tracks directory paths, renaming or deleting an overlay breaks
  sync silently. CI checks that every `path:` exists to catch that.
