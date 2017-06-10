# The backend data is filled in dynamically by Terragrunt
terraform {
  backend "s3" {}
}

# This is fed in by export TF_VAR_REGION=us-east-1
variable "REGION" {}

variable "namespace" {
  default = "rcdf"
}

# You can alternatively use the TF Data Source "aws_availability_zones"
# https://www.terraform.io/docs/providers/aws/d/availability_zones.html
# We deliberately map to certain AZs basically because we want to reuse code
# between regions, but us-east-1c has horrific spot pricing
variable "zones" {
  type = "map"

  default = {
    us-east-1 = ["us-east-1a", "us-east-1b", "us-east-1d"]
    us-west-2 = ["us-west-2a", "us-west-2b", "us-west-2c"]
  }
}

# Get information about your current account and caller ID
# Mostly interpolated into IAM policies
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
