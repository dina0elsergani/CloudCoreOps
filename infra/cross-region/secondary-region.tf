provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

resource "aws_db_instance" "secondary" {
  provider = aws.secondary
  # ...replica config...
} 