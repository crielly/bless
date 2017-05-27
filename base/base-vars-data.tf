# The backend data is filled in dynamically by Terragrunt
terraform {
  backend "s3" {}
}

variable "namespace" {
  default = "rcdf"
}

data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}
