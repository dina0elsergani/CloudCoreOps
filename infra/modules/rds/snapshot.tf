# A snapshot is immutable once taken. The identifier therefore has to come from
# the caller -- deriving it from timestamp() here would make Terraform plan a
# replacement on every run.
resource "aws_db_snapshot" "this" {
  db_instance_identifier = var.db_instance_identifier
  db_snapshot_identifier = "${var.db_instance_identifier}-${var.snapshot_suffix}"
  tags                   = var.tags
}
