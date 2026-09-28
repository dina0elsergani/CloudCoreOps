output "snapshot_id" {
  value = aws_db_snapshot.this.db_snapshot_identifier
}

output "snapshot_arn" {
  value = aws_db_snapshot.this.db_snapshot_arn
}
