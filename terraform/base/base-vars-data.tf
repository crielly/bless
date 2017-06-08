# The backend data is filled in dynamically by Terragrunt
terraform {
  backend "s3" {}
}

variable "REGION" {}

variable "namespace" {
  default = "rcdf"
}

variable "zones" {
  type = "map"

  default = {
    us-east-1 = ["us-east-1a", "us-east-1b", "us-east-1d"]
    us-west-2 = ["us-west-2a", "us-west-2b", "us-west-2c"]
  }
}

data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "iam-global" {
  backend = "s3"

  config {
    bucket = "${var.namespace}-tfstate.${var.REGION}"
    key    = "iam-global/terraform.tfstate"
    region = "${var.REGION}"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "${var.namespace}-tfstate.${var.REGION}"
    key    = "vpc/terraform.tfstate"
    region = "${var.REGION}"
  }
}
