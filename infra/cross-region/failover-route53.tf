resource "aws_route53_record" "failover" {
  zone_id = var.zone_id
  name    = "app"
  type    = "A"
  set_identifier = "primary"
  failover_routing_policy {
    type = "PRIMARY"
  }
  records = [aws_lb.primary.dns_name]
}

resource "aws_route53_record" "failover_secondary" {
  zone_id = var.zone_id
  name    = "app"
  type    = "A"
  set_identifier = "secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }
  records = [aws_lb.secondary.dns_name]
} 