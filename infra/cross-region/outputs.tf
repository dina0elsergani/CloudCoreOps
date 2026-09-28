output "replica_endpoint" {
  value = aws_db_instance.secondary.endpoint
}

output "primary_health_check_id" {
  value = aws_route53_health_check.primary.id
}
