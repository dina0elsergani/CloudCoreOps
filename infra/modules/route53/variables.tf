variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "Record name, relative to the zone (e.g. \"staging\")"
  type        = string
}

variable "target_dns_name" {
  description = "DNS name the record points at, typically a load balancer"
  type        = string
}

variable "ttl" {
  description = "Record TTL in seconds"
  type        = number
  default     = 300
}
