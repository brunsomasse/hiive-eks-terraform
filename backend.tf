terraform {
  backend "s3" {
    bucket         = "hiive-terraform-state-bucket"
    key            = "${var.environment}/eks/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "hiive-terraform-state-lock"
  }
}
