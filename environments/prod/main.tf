terraform {
  required_version = ">= 1.5"
}

module "vpc" {
  source = "../../modules/vpc"

  environment     = "prod"
  region          = var.region
  vpc_cidr        = "10.30.0.0/16"
  private_subnets = ["10.30.1.0/24", "10.30.2.0/24"]
  public_subnets  = ["10.30.101.0/24", "10.30.102.0/24"]
}

module "eks" {
  source = "../../modules/eks"

  environment     = "prod"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  node_min        = 3
  node_max        = 6
  node_desired    = 3
}

module "app" {
  source = "../../modules/app"
}

output "cluster_name" {
  value = module.eks.cluster_name
}
