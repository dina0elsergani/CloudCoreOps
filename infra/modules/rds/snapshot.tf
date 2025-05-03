resource "aws_db_snapshot" "daily" {
  db_instance_identifier = aws_db_instance.this.id
  db_snapshot_identifier = "${aws_db_instance.this.id}-snapshot-${timestamp()}"
} 