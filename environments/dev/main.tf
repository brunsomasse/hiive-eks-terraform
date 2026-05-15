terraform {
  required_version = ">= 1.5"
  backend "s3" {
    bucket         = "hiive-terraform-state-bucket"
    key            = "dev/eks/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hiive-terraform-state-lock"
  }
}

module "networking" {
  source = "../../modules/networking"

  environment     = "dev"
  region          = var.region
  project         = var.project
  vpc_cidr        = "10.10.0.0/16"
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]
  cluster_name    = "${var.project}-dev-cluster"
  eks_dependency  = module.eks
}

module "eks" {
  source = "../../modules/eks"

  environment     = "dev"
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnets
  node_min        = 2
  node_max        = 3
  node_desired    = 2
}

module "app" {
  source = "../../modules/app"
}
