resource "aws_subnet" "infrastructure" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.0.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 1)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "infrastructure"
    Environment = "infrastructure"
    Terraform   = "True"
  }
}

resource "aws_subnet" "prod-a" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.6.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 0)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "prod-a"
    Environment = "prod"
    Terraform   = "True"
  }
}

resource "aws_subnet" "prod-b" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.8.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 1)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "prod-b"
    Environment = "prod"
    Terraform   = "True"
  }
}

resource "aws_subnet" "prod-c" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 2)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "prod-c"
    Environment = "prod"
    Terraform   = "True"
  }
}

resource "aws_subnet" "dev-a" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.12.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 0)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "dev-a"
    Environment = "dev"
    Terraform   = "True"
  }
}

resource "aws_subnet" "dev-b" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.14.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 1)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "dev-b"
    Environment = "dev"
    Terraform   = "True"
  }
}

resource "aws_subnet" "dev-c" {
  vpc_id                  = "${aws_vpc.rcdf.id}"
  cidr_block              = "172.16.16.0/24"
  availability_zone       = "${element(var.zones["${var.REGION}"], 2)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "dev-c"
    Environment = "dev"
    Terraform   = "True"
  }
}

resource "aws_db_subnet_group" "prod-rds-snetgroup" {
  name        = "prod-rds-snetgroup"
  description = "prod-rds-snetgroup"

  subnet_ids = [
    "${aws_subnet.prod-a.id}",
    "${aws_subnet.prod-b.id}",
    "${aws_subnet.prod-c.id}",
  ]

  tags {
    Name        = "prod-rds-snetgroup"
    Environment = "prod"
    Terraform   = "True"
  }
}

resource "aws_db_subnet_group" "dev-rds-snetgroup" {
  name        = "dev-rds-snetgroup"
  description = "dev-rds-snetgroup"

  subnet_ids = [
    "${aws_subnet.dev-a.id}",
    "${aws_subnet.dev-b.id}",
    "${aws_subnet.dev-c.id}",
  ]

  tags {
    Name        = "dev-rds-snetgroup"
    Environment = "dev"
    Terraform   = "True"
  }
}

output "infra-subnet" {
  value = "${aws_subnet.infrastructure.id}"
}

output "prod-rds-snetgroup" {
  value = "${aws_db_subnet_group.prod-rds-snetgroup.name}"
}

output "prod-subnet-a" {
  value = "${aws_subnet.prod-a.id}"
}

output "prod-subnet-b" {
  value = "${aws_subnet.prod-b.id}"
}

output "prod-subnet-c" {
  value = "${aws_subnet.prod-c.id}"
}

output "dev-rds-snetgroup" {
  value = "${aws_db_subnet_group.dev-rds-snetgroup.name}"
}

output "dev-subnet-a" {
  value = "${aws_subnet.dev-a.id}"
}

output "dev-subnet-b" {
  value = "${aws_subnet.dev-b.id}"
}

output "dev-subnet-c" {
  value = "${aws_subnet.dev-c.id}"
}
