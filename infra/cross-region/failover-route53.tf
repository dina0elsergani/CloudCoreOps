# Route 53 only fails over when the primary record has a health check attached;
# without one it is considered permanently healthy and traffic never moves.
resource "aws_route53_health_check" "primary" {
  fqdn              = var.primary_alb_dns_name
  type              = "HTTPS"
  resource_path     = var.health_check_path
  port              = 443
  failure_threshold = 3
  request_interval  = 30

  tags = var.tags
}

resource "aws_route53_record" "failover_primary" {
  zone_id         = var.zone_id
  name            = var.record_name
  type            = "CNAME"
  ttl             = var.ttl
  set_identifier  = "primary"
  health_check_id = aws_route53_health_check.primary.id
  records         = [var.primary_alb_dns_name]

  failover_routing_policy {
    type = "PRIMARY"
  }
}

resource "aws_route53_record" "failover_secondary" {
  zone_id        = var.zone_id
  name           = var.record_name
  type           = "CNAME"
  ttl            = var.ttl
  set_identifier = "secondary"
  records        = [var.secondary_alb_dns_name]

  failover_routing_policy {
    type = "SECONDARY"
  }
}
