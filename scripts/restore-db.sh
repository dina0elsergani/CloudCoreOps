#!/bin/bash
# Usage: ./restore-db.sh SNAPSHOT_ID
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier cloudcoreops-db-restore \
  --db-snapshot-identifier "$1" 