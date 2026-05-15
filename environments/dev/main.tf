terraform {
  required_version = ">= 1.5"
}

module "vpc" {
  source = "../../modules/vpc"

  environment     = "dev"
  region          = var.region
  vpc_cidr        = "10.10.0.0/16"
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]
}

module "eks" {
  source = "../../modules/eks"

  environment     = "dev"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  node_min        = 2
  node_max        = 3
  node_desired    = 2
}

module "app" {
  source = "../../modules/app"
}

output "cluster_name" {
  value = module.eks.cluster_name
}
