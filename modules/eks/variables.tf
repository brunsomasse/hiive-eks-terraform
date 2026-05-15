variable "environment"     { type = string }
variable "vpc_id"          { type = string }
variable "private_subnets" { type = list(string) }
variable "node_min"        { type = number }
variable "node_max"        { type = number }
variable "node_desired"    { type = number }
