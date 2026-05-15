# Hiive SRE - Multi-Environment EKS Terraform

Terraform configuration to deploy a **private EKS cluster** across `dev`, `uat`, and `prod`.

## Key Features
- Fully private EKS cluster (no public endpoint)
- VPC with private subnets + NAT Gateway
- Different node sizing per environment
- Sample "Hello World" Nginx app
- Least-privilege security

## How to Deploy

```bash
# For Dev
cd environments/dev
terraform init
terraform plan
terraform apply

# For UAT
cd environments/uat
terraform init
terraform plan
terraform apply

# For Prod
cd environments/prod
terraform init
terraform plan
terraform apply
