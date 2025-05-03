provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
  name    = var.project_name
  cidr    = var.vpc_cidr
  azs     = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"
  cluster_name    = var.project_name
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.3.0"
  identifier = "${var.project_name}-db"
  engine     = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  name     = "cloudcoreops"
  username = var.db_username
  password = var.db_password
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_subnet_group_name   = module.vpc.database_subnet_group
  skip_final_snapshot    = true
} 