variable "namespace" {
  default = "rcdf"
}

variable "region" {
  default = "us-west-2"
}

terraform {
  backend "s3" {}
}
