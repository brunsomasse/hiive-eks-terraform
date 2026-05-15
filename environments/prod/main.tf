terraform {
  required_version = ">= 1.5"
  backend "s3" {
    bucket         = "hiive-terraform-state-bucket"
    key            = "prod/eks/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hiive-terraform-state-lock"
  }
}

module "networking" {
  source = "../../modules/networking"

  environment     = "prod"
  region          = var.region
  project         = var.project
  vpc_cidr        = "10.30.0.0/16"
  private_subnets = ["10.30.1.0/24", "10.30.2.0/24"]
  public_subnets  = ["10.30.101.0/24", "10.30.102.0/24"]
  cluster_name    = "${var.project}-prod-cluster"
  eks_dependency  = module.eks
}

module "eks" {
  source = "../../modules/eks"

  environment     = "prod"
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnets
  node_min        = 3
  node_max        = 6
  node_desired    = 3
}

module "app" {
  source = "../../modules/app"
}
