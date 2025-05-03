resource "aws_route53_record" "staging" {
  zone_id = var.zone_id
  name    = "staging"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.ingress.dns_name]
} 