output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
output "aws_region" {
  description = "Region the stack is deployed in; scripts/setup.sh reads this"
  value       = var.aws_region
}
