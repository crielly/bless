resource "aws_network_acl" "infrastructure" {
  vpc_id     = "${aws_vpc.rcdf.id}"
  subnet_ids = ["${aws_subnet.infrastructure.id}"]

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name        = "infrastructure"
    Environment = "infrastructure"
    Terraform   = "True"
  }
}

resource "aws_network_acl" "prod" {
  vpc_id = "${aws_vpc.rcdf.id}"

  subnet_ids = [
    "${aws_subnet.prod-a.id}",
    "${aws_subnet.prod-b.id}",
    "${aws_subnet.prod-c.id}",
  ]

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.dev-b.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 110
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.dev-a.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 120
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.dev-c.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 300
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name        = "prod"
    Environment = "prod"
    Terraform   = "True"
  }
}

resource "aws_network_acl" "dev" {
  vpc_id = "${aws_vpc.rcdf.id}"

  subnet_ids = [
    "${aws_subnet.dev-a.id}",
    "${aws_subnet.dev-b.id}",
    "${aws_subnet.dev-c.id}",
  ]

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.prod-b.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 110
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.prod-a.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 120
    action     = "deny"
    protocol   = "-1"
    cidr_block = "${aws_subnet.prod-c.cidr_block}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 300
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name        = "dev"
    Environment = "dev"
    Terraform   = "True"
  }
}
