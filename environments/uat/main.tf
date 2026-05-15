terraform {
  required_version = ">= 1.5"
}

module "vpc" {
  source = "../../modules/vpc"

  environment     = "uat"
  region          = var.region
  vpc_cidr        = "10.20.0.0/16"
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]
}

module "eks" {
  source = "../../modules/eks"

  environment     = "uat"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  node_min        = 2
  node_max        = 4
  node_desired    = 2
}

module "app" {
  source = "../../modules/app"
}

output "cluster_name" {
  value = module.eks.cluster_name
}
