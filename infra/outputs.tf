output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "vpc_id" {
  value = module.vpc.vpc_id
} 