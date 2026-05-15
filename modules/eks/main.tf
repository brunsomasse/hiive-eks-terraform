module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project}-${var.environment}-cluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_groups = {
    main = {
      min_size       = var.node_min
      max_size       = var.node_max
      desired_size   = var.node_desired
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = var.environment
  }
}

output "cluster_name"    { value = module.eks.cluster_name }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
