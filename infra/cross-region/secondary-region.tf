provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

# Cross-region read replica. Promoting it is the recovery step described in
# docs/disaster-recovery.md.
resource "aws_db_instance" "secondary" {
  provider = aws.secondary

  identifier          = "${var.name_prefix}-replica"
  replicate_source_db = var.source_db_arn
  instance_class      = var.replica_instance_class
  skip_final_snapshot = true
  apply_immediately   = false

  tags = var.tags
}
