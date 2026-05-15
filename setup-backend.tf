# This file is used ONLY to create the backend resources (run once)
terraform {
  required_version = ">= 1.5"
}

module "backend" {
  source = "./modules/backend"

  state_bucket_name   = "hiive-terraform-state-bucket"
  dynamodb_table_name = "hiive-terraform-state-lock"
}
