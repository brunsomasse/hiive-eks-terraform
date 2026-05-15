variable "environment"     { type = string }
variable "region"          { type = string }
variable "project"         { type = string }
variable "vpc_cidr"        { type = string }
variable "private_subnets" { type = list(string) }
variable "public_subnets"  { type = list(string) }
variable "cluster_name"    { type = string }

variable "eks_dependency" { type = any }
