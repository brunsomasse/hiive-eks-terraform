variable "environment" {
  description = "Environment (dev, uat, prod)"
  type        = string
}

variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "hiive"
}
