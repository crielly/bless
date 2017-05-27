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

data "terraform_remote_state" "iam-global" {
    backend    = "s3"
    config {
        bucket = "${var.namespace}-tfstate.${data.aws_region.current.name}"
        key    = "iam-global/terraform.tfstate"
        region = "${data.aws_region.current.name}"
    }
}