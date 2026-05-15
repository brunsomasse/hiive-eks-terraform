terraform {
  required_version = ">= 1.5"
  backend "s3" {
    bucket         = "hiive-terraform-state-bucket"
    key            = "uat/eks/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hiive-terraform-state-lock"
  }
}

module "networking" {
  source = "../../modules/networking"

  environment     = "uat"
  region          = var.region
  project         = var.project
  vpc_cidr        = "10.20.0.0/16"
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24"]
  cluster_name    = "${var.project}-uat-cluster"
  eks_dependency  = module.eks
}

module "eks" {
  source = "../../modules/eks"

  environment     = "uat"
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnets
  node_min        = 2
  node_max        = 4
  node_desired    = 2
}

module "app" {
  source = "../../modules/app"
}
