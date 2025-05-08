#!/bin/bash
set -e
cd ../infra
terraform init
terraform apply -auto-approve
aws eks update-kubeconfig --region $(terraform output -raw aws_region) --name $(terraform output -raw eks_cluster_name) 