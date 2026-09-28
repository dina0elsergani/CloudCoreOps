variable "name_prefix" {
  description = "Prefix for resources created in the secondary region"
  type        = string
  default     = "cloudcoreops"
}

variable "secondary_region" {
  description = "Region hosting the standby replica"
  type        = string
}

variable "source_db_arn" {
  description = "ARN of the primary RDS instance to replicate from"
  type        = string
}

variable "replica_instance_class" {
  description = "Instance class for the read replica"
  type        = string
  default     = "db.t3.micro"
}

variable "zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "Record name for the failover pair, relative to the zone"
  type        = string
  default     = "app"
}

variable "primary_alb_dns_name" {
  description = "DNS name of the load balancer in the primary region"
  type        = string
}

variable "secondary_alb_dns_name" {
  description = "DNS name of the load balancer in the secondary region"
  type        = string
}

variable "health_check_path" {
  description = "Path Route 53 probes to decide whether the primary is healthy"
  type        = string
  default     = "/health"
}

variable "ttl" {
  description = "TTL for the failover records; keep low so failover propagates quickly"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags applied to created resources"
  type        = map(string)
  default     = {}
}
