# Disaster Recovery Playbook

## 1. RDS Restore
- Use `scripts/restore-db.sh` with the latest snapshot.

## 2. EKS Cluster Recovery
- Re-run `scripts/setup.sh` to re-provision infra and redeploy.

## 3. App Rollback
- Use Argo CD to roll back to a previous commit.

## 4. DR Test
- Schedule quarterly DR drills: simulate RDS and pod failures, verify recovery time and data integrity. 