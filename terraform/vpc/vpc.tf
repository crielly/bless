resource "aws_vpc" "rcdf" {
  cidr_block           = "172.16.0.0/18"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags {
    Name      = "rcdf"
    Terraform = "True"
  }
}

output "vpc-id" {
  value = "${aws_vpc.rcdf.id}"
}
