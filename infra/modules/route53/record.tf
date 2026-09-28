resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = var.ttl
  records = [var.target_dns_name]
}
